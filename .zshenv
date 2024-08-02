export GOPATH=$HOME/go

export COCKROACH_ROOT="$GOPATH/src/github.com/cockroachdb/cockroach"
export CR_MANAGED_ROOT="$GOPATH/src/github.com/cockroachlabs/managed-service"
export GCEWORKER_ZONE="us-east4-b"
export CLUSTER="kevincao-test"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="${COCKROACH_ROOT}:$PATH"
export PATH="${COCKROACH_ROOT}/bin:$PATH"
export PATH="$PATH:${CR_MANAGED_ROOT}/bin"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="$PATH:$HOME/go/bin"

export NODE_PATH="${COCKROACH_ROOT}/pkg/ui/workspaces/cluster-ui/node_modules"

export VAULT_ADDR="https://127.0.0.1:8201"
export VAULT_CACERT="${CR_MANAGED_ROOT}/pkg/config/vault.staging.ca.crt.pem"

# Ensure you are logged into Vault first with `admin-cli vault login staging`
export VAULT_TOKEN="$(cat ~/.vault-token.staging)"

export PATH="$PATH:$HOME/scripts"
