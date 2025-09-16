#!/bin/bash

set -euo pipefail

# --------- Require sudo (editing inside /Applications) ----------
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script modifies files under /Applications; please run with: sudo $0" >&2
  exit 1
fi

# --------- Sanity checks for tools ----------
for tool in perl find cp mkdir rm; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Error: required program '$tool' not found in PATH." >&2
    exit 1
  fi
done

# --------- Paths ----------
VIVALDI_HTML="/Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions/Current/Resources/vivaldi/window.html"
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
JS_DIR="${SCRIPT_DIR}/js"                 # your source JS folder (next to this script)
# custom_hooks lives alongside window.html
VIVALDI_DIR="$(dirname "$VIVALDI_HTML")"  # .../Resources/vivaldi
HOOKS_DIR="${VIVALDI_DIR}/custom_hooks"   # .../Resources/vivaldi/custom_hooks

# --------- Safety checks ----------
if [[ ! -f "$VIVALDI_HTML" ]]; then
  echo "Error: window.html not found at expected location:"
  echo "  $VIVALDI_HTML" >&2
  exit 1
fi
if [[ ! -d "$JS_DIR" ]]; then
  echo "Error: 'js' directory not found next to this script:"
  echo "  $JS_DIR" >&2
  exit 1
fi
if [[ ! -f "${JS_DIR}/main.js" ]]; then
  echo "Error: 'js/main.js' is required but was not found:" >&2
  echo "  ${JS_DIR}/main.js" >&2
  exit 1
fi

# --------- Backup once ----------
if [[ ! -f "${VIVALDI_HTML}.bak" ]]; then
  echo "Creating backup: ${VIVALDI_HTML}.bak"
  cp -p "$VIVALDI_HTML" "${VIVALDI_HTML}.bak"
fi

# --------- Prepare custom_hooks directory inside the app bundle ----------
echo "Syncing hooks into: $HOOKS_DIR"
# Create folder if missing; clear previous contents to avoid stale files.
mkdir -p "$HOOKS_DIR"
# Remove existing contents (but keep folder)
rm -rf "${HOOKS_DIR:?}/"* 2>/dev/null || true
# Copy all .js from your local js/ into custom_hooks/
# (copy everything so main.js can import others by relative path)
cp -p "${JS_DIR}/"*.js "$HOOKS_DIR"/

# --------- Build injection block (single tag to custom_hooks/main.js) ----------
# Use a RELATIVE path so it resolves from window.html: "custom_hooks/main.js"
INJECT_BLOCK='    <script class="custom-vivaldi-hooks" type="module" src="custom_hooks/main.js"></script>'

# --------- In-place edit with Perl (-i) ----------
#   1) Remove any <script ... class="custom-vivaldi-hooks" ...>...</script> (and surrounding blank lines)
#   2) Remove any self-closing <script ... class="custom-vivaldi-hooks" ... /> (and surrounding blank lines)
#   3) Insert our single tag immediately before </body> (with a single leading newline)
PERL_SCRIPT=$(cat <<'PERL'
  my $changed = 0;

  # Remove paired <script> ... </script> with our class, plus surrounding blank lines
  s{
    (?:[ \t]*\R)*
    <\s*script
      (?=[^>]*\bclass\s*=\s*(["\'])custom-vivaldi-hooks\1)
      [^>]*>
      .*?
    <\s*/\s*script\s*>
    (?:[ \t]*\R)*
  }{}gimsx and $changed=1;

  # Remove self-closing variant, plus surrounding blank lines
  s{
    (?:[ \t]*\R)*
    <\s*script
      (?=[^>]*\bclass\s*=\s*(["\'])custom-vivaldi-hooks\1)
      [^>]*
    />
    (?:[ \t]*\R)*
  }{}gimsx and $changed=1;

  # Normalize any extra whitespace immediately before </body>
  s{[ \t]*(?:\R[ \t]*)*(?=</\s*body\s*>)}{}gimsx;

  # Insert our single tag with exactly one leading newline
  if (index($_, "</body>") != -1) {
    my $blk = $ENV{INJECT_BLOCK} // "";
    $blk = "\n$blk" if $blk ne "" && $blk !~ /\A\R/;
    s{</\s*body\s*>}{$blk</body>}i;
    $changed=1;
  } else {
    warn "Warning: No </body> found; no injection performed\n";
  }
PERL
)

INJECT_BLOCK="$INJECT_BLOCK" perl -0777 -i -pe "$PERL_SCRIPT" -- "$VIVALDI_HTML"

echo "Updated : $VIVALDI_HTML"
echo "Backup  : ${VIVALDI_HTML}.bak"
echo "Hooks   : $(ls -1 "$HOOKS_DIR" | wc -l | tr -d ' ') file(s) in custom_hooks/"
echo "Injected: <script class=\"custom-vivaldi-hooks\" src=\"custom_hooks/main.js\"></script>"
