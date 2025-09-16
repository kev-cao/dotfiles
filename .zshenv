
export _PROFILE="cockroachlabs"

export GOPATH=$HOME/go
export GOROOT=/usr/local/go

MAC_OS=0
if [[ "$OSTYPE" == "darwin"* ]]; then
  MAC_OS=1
fi

export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"

if [ "$MAC_OS" = true ]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
  export PATH="/opt/homebrew/opt/coreutils/bin":$PATH
  export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.11/bin"
fi

if [ "$_PROFILE" = "cockroachlabs" ]; then
  export COCKROACH_ROOT="$GOPATH/src/github.com/cockroachdb/cockroach"
  export CR_MANAGED_ROOT="$GOPATH/src/github.com/cockroachlabs/managed-service"
  export MSO_REPO_DIR="$GOPATH/src/github.com/cockroachlabs/managed-service"

  export PATH="$COCKROACH_ROOT:$PATH"
  export PATH="$COCKROACH_ROOT/bin:$PATH"
  export PATH="$PATH:$CR_MANAGED_ROOT/bin"
  export PATH="$PATH:$CR_MANAGED_ROOT/console/migrations"
  export PATH="$PATH:$HOME/playground/scripts/replication/bin"
  export NODE_PATH="${COCKROACH_ROOT}/pkg/ui/workspaces/cluster-ui/node_modules"
  export PNPM_HOME="/Users/kevin/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac

  export GCEWORKER_ZONE="us-east4-b"
  export CLUSTER="kevincao-test"
  export AWS_PROFILE="CRLStagingAdmin"

  export VAULT_ADDR="https://127.0.0.1:8201"
  export VAULT_CACERT="${CR_MANAGED_ROOT}/pkg/config/vault.staging.ca.crt.pem"
  if [ -f ~/.vault-token.staging ]; then
    export VAULT_TOKEN="$(cat ~/.vault-token.staging)"
  fi
  # Claude code setup
  export CLAUDE_CODE_USE_VERTEX=1
  export CLOUD_ML_REGION=us-east5
  export ANTHROPIC_VERTEX_PROJECT_ID=vertex-model-runners
fi


if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

if [ -f "$HOME/.zshenv_secure" ]; then
  source "$HOME/.zshenv_secure"
fi
