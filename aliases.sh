################
# GIT
############################################################
# git submodule foreach --recursive 'git {command}'

alias gf="git fetch"
alias grom="gf; git rebase origin/master"
alias grot="gf; git rebase origin/testing"
alias gcan="git commit --amend --no-edit"
alias gacan="git add .; gcan"
alias gpf="git push --force-with-lease"
alias wam!="gacan;gpf"
alias pull="git pull"
alias gpom="git pull origin master"
alias gpot="git pull origin testing"
alias cb="git rev-parse --abbrev-ref HEAD"
alias branch="git branch"
alias gfp="git fetch; git pull"
alias set-remote="git remote set-url origin"
alias checkout="git checkout"

clone () {
  git clone $1;
}

nb () {
  git checkout -b $1;
}

gacp () {
  git add .; git commit -m "$1"; gpf;
}



################################################
# Python
############################################################
__debug () {
  pip install pytest
  pip install debugpy
}

# Create, activate, deactivate python venv
venvc () {
  python3 -m venv ./${1}
}
venva () {
  source ./${1}/bin/activate
}
alias venvd="deactivate"

pyproj () {
  # Create project dir
  mkdir $1;
  cd $1;

  # Create venv
  venvc ${1}_env
  #venva ${1}_env

  # Install emacs dap-debugger deps to venv
  __debug

  # Create app dir
  mkdir app
  touch app/__init__.py
  touch app/app.py
  printf "import traceback\n" > app/app.py

  # Create test dir
  mkdir tests
  touch tests/__init__.py
  touch tests/test_app.py

  # Requirements
  touch requirements.txt;
  printf "requests==2.31.0" > requirements.txt # defaults
  #pip install -r requirements.txt
}



####################################################
# Golang
############################################################
goproj () {
  # Create project dir
  cd ~/code;
  mkdir $1;
  cd $1;

  touch main.go
  touch service.go

  # Create app dir
  mkdir app
  touch app/__init__.py
  touch app/app.py
  printf "import traceback\n" > app/app.py

  # Create test dir
  mkdir tests
  touch tests/__init__.py
  touch tests/test_app.py

  # Requirements
  touch requirements.txt;
  printf "six==1.12.0\nrequests==2.22.0" > requirements.txt # defaults
  pip install -r requirements.txt
}



####################################################
# NAVIGATION
############################################################
alias config="cd ~/code/config-files"
alias nc="cd ~/code"
alias nconfig="nc; cd config-files"
alias nh="cd ~"
alias ..="cd .."
alias ...="cd ../.."



####################################################
# SYSTEM
############################################################
alias sys="neofetch"
alias doom="~/.emacs.d/bin/doom"
#alias emacs="/usr/local/Cellar/emacs-plus@26/26.3/bin/emacs"
#alias emacs="emacsclient"
alias e="emacs"

install () {
  brew install $1;
}

uninstall () {
  brew uninstall $1;
}

i () {
  install $1;
}



####################################################
# DATADOG General
############################################################
# Project nav
alias nsha="cd ~/dd/dd-source/domains/cloud-security-platform/apps/apis/siem-historical-api"
alias ndd="cd ~/dd"
alias nlbe="cd ~/dd/logs-backend"

alias k="kubectl"

# https://github.com/DataDog/cloud-inventory/blob/master/organizations/aws/sso/README.md
alias aws-docker="aws-vault exec sso-build-stable-developer -- aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 486234852809.dkr.ecr.us-east-1.amazonaws.com"

# s3 command example
alias s3-ls="aws-vault exec sso-sandbox-account-admin -- aws s3 ls"

# navigate to dd home
alias ndd="cd $DATADOG_ROOT"

# orgstore migration shell
migration-shell () {
  cd ~/dd/k8s-resources/k8s/postgres_alembic_cdk/postgres_alembic;
  poetry install;
  poetry shell;
}

# TODO: Convert to elisp
# It would be very nice if this was just an emacs script
# I could run, something like ~"M-x gen-ticket".
# That could then take the args, and in the future it could
# be expanded to work on other types of org-gen stuff.
#
# TODO: Allow for optional sprint inclusion
# How do we track current sprint? Env var with export set by script?
# Easier way to do that is just use constant as file name for
# currently active sprint. This can also be done largely
# manually until automated
#
# create ticket org file
org-ticket () {
  touch ~/org/tickets/${1}.org;

  TICKET="xxxx"
  if [ $# -eq 2 ]
    then
      TICKET=$2
  fi

  printf "#+TITLE: SEC-%s: %s\n
* Jira 󰌃
[[https://datadoghq.atlassian.net/browse/SEC-%s][SEC-%s]]\n
* Git 󰊢
**  matthew.saucedo/SEC-%s_%s
**  PR\n
* Related \n
* Overview \n
* Docs \n
* Slack \n
* Notes 
" $TICKET $1 $TICKET $TICKET $TICKET $1 > ~/org/tickets/${1}.org

  echo " ~/org/tickets/${1}.org"
  echo "󰊢 matthew.saucedo/SEC-${TICKET}_${1}"
}



################################################
# DATADOG Workspaces
############################################################
make-workspace() {
  local repo="${1:?Usage: make-workspace <repo_name>}"
  workspaces create "matthew-saucedo-${repo}" --repo "${repo}" --dotfiles DataDog/workspaces-dotfiles
}
alias make-wksp=make-workspace

# Derive a stable port (8300–8499) from workspace name + role.
# Same hash is used on the workspace side to set PEON_RELAY_PORT.
_ws_port() {
  python3 -c "
import hashlib
h = int(hashlib.md5(('$1$2').encode()).hexdigest(), 16)
print(8300 + h % 200)
"
}

workspace() {
  local repo="${1:?Usage: workspace <repo_name>}"
  local ws_name="matthew-saucedo-${repo}"
  local mcp_port peon_port
  mcp_port=$(_ws_port "$ws_name" "mcp")
  peon_port=$(_ws_port "$ws_name" "peon")

  # Wait for the workspace to be PROVISIONED before attempting SSH.
  # Without this, SSH hangs indefinitely when the workspace is still creating
  # or doesn't exist — no timeout, no error, just silence.
  local ws_status
  while true; do
    ws_status=$(workspaces list --no-color 2>/dev/null \
      | grep -v '^\[' | grep -v '^A new' \
      | awk -v ws="$ws_name" 'NR>1 && $1==ws {print $3}')

    if [[ -z "$ws_status" ]]; then
      printf '\033[1;31m  ✗ Workspace "%s" not found. Create it with: make-wksp %s\033[0m\n' \
        "$ws_name" "$repo"
      return 1
    fi

    [[ "$ws_status" == "PROVISIONED" ]] && break
    printf '\033[0;90m  ↻ Workspace status: %-14s (waiting...)\033[0m\r' "$ws_status"
    sleep 5
  done

  printf '\033[0;90m  → MCP   localhost:%-5s (workspace:8257)\033[0m\n'  "$mcp_port"
  printf '\033[0;90m  → Peon  workspace:%-5s (Mac relay :19998)\033[0m\n' "$peon_port"

  # -L: local forward  — Mac:mcp_port  → workspace:8257  (MCP auth callback)
  # -R: remote forward — workspace:peon_port → Mac:19998  (peon audio relay)
  # Each workspace gets unique ports so N sessions can run in parallel.
  ssh -A \
    -L "${mcp_port}:localhost:8257" \
    -R "${peon_port}:localhost:19998" \
    -o ExitOnForwardFailure=no \
    -o ConnectTimeout=30 \
    "workspace-matthew-saucedo-${repo}"

  # Post-connect: warn if either port didn't actually bind
  local yellow='\033[1;33m' reset='\033[0m'
  nc -z localhost "$mcp_port" 2>/dev/null \
    || printf "${yellow}  ⚠ MCP port %s not forwarded (conflict?) — MCP auth may not work${reset}\n" "$mcp_port"
  nc -z localhost "$peon_port" 2>/dev/null \
    || printf "${yellow}  ⚠ Peon port %s not forwarded (conflict?) — sounds will be silent${reset}\n" "$peon_port"
}
alias wksp=workspace

auth-help() {
  cat <<'EOF'
Workspace MCP Auth (Confluence / Datadog MCP)
─────────────────────────────────────────────
FIRST TIME in a new workspace:
  1. wksp <repo>          — SSH in (port 8257 is auto-forwarded)
  2. claude               — starts, detects MCP needs auth
  3. click the URL it prints → browser opens → click Allow
  4. done, tokens cached (until they expire ~months)

EVERY TIME AFTER (same workspace):
  1. wksp <repo>
  2. claude               — works immediately, no prompts

TWO WORKSPACES OPEN + one needs fresh auth:
  1. close the other session temporarily
  2. auth the new one (steps above)
  3. reopen the other session

NEW WORKSPACE: repeat "first time" once for that workspace
EOF
}

delete-workspace() {
  workspaces delete "${1:?Usage: delete-workspace <workspace_name>}"
}
alias delete-wksp=delete-workspace



################################################
# DATADOG dd-source
############################################################
# Project nav
alias nsha="cd ~/dd/dd-source/domains/cloud-security-platform/apps/apis/siem-historical-api"
alias nspa="cd ~/dd/dd-source/domains/cloud-security-platform/apps/apis/secmon-public-api"

# TODO: Update for new rapid cli
# Run tests
alias tsha="bzl run //:rapid -- test --domain=cloud-security-platform --name=siem-historical-api"

# run apis
alias rsha="export DD_ENV=dev && rapid run -d cloud-security-platform -s siem-historical-api"
alias rspa="export DD_ENV=dev && rapid run -d cloud-security-platform -s secmon-public-api"

# access app db
alias shadb="kubectl exec --context gizmo.us1.staging.dog --namespace orgstore-cloud-siem -it deployments/orgstore-cloud-siem-toolbox -- pg-wrap -o cloud-siem psql"

# port forward secmon & postgres
alias pfsecmon="kubectl port-forward --namespace security-analytics --context stripe.us1.staging.dog service/security-monitoring-api 9091:9091"
alias pfpg="kubectl port-forward --namespace orgstore-cloud-siem --context gizmo.us1.staging.dog service/orgstore-cloud-siem-pg-proxy 5432:5432"

# migrations
sham () {
  cd ~/dd/k8s-resources/k8s/postgres_alembic_cdk/postgres_alembic/migrations/db_clusters/orgstore-cloud-siem;
}

# tap manager, for shadowing
#  USAGE:
#  * python -m utils.reader -d staging/us1/us3/us5/ap1/ap2/eu1 -r {endpoint_id_from_route_manager} -c > ~/route_shadowing/{env}_{endpoint_name}_diffs.txt -s "YYYY-MM-DDT:HH:MM:SSZ"
#    * or a less specific time like 2025-04-28 instead of 2025-04-28T19:01:28Z
tap-manager () {
  cd ~/dd/dd-source/domains/api_platform/apps/tap-mgr
  source ~/tap-mgr-venv/bin/activate
}


################################################
# DATADOG DogWeb
############################################################
# run a local postgres service using the docker-compose
pg-start() {
  cd ~/dd/dd-source/domains/cloud-security-platform/apps/apis/siem-historical-api;
  docker-compose up -d --build;
  cd -;
}

# dogweb postgres docker
dwpg () {
  # Remember to login to ECR
  aws-vault exec sso-build-stable-developer -- aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 486234852809.dkr.ecr.us-east-1.amazonaws.com
  docker run --pull=always -d -p 15433:15433 --name dogweb_postgres 486234852809.dkr.ecr.us-east-1.amazonaws.com/ci/dogweb/postgres-testdata:latest
}
alias fe-start="yarn run dev"



################################################
# MISC
############################################################
alias please='sudo $(history -p !!)'

alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

alias hack="say -r 30 -v Yuri 'Your social security number has been compromised. Press 1 to speak to an officer.'"



################################################
# WORKSPACE PROMPT BANNER
############################################################
# Prints a purple bordered banner before every prompt when inside a workspace.
# Strips the "matthew-saucedo-" prefix so it shows just the meaningful label,
# e.g.  matthew-saucedo-logs-backend-a  →  󰒋 logs-backend-a
#
_workspace_banner() {
    [[ "$USER" != "bits" ]] && return
    local host label icon color reset prefix cols bar_len bar
    host=$(hostname -s 2>/dev/null)
    label="${host#matthew-saucedo-}"
    icon='󰒋'
    color=$'\033[1;35m'   # bright purple
    reset=$'\033[0m'
    prefix=" ${icon} ${label} "
    # tput cols is reliable over SSH; fall back to COLUMNS, then 80
    # -1 extra accounts for the nerd font icon rendering as 2 cells wide
    cols=$(tput cols 2>/dev/null || echo "${COLUMNS:-80}")
    bar_len=$(( cols - ${#prefix} - 4 ))
    (( bar_len < 1 )) && bar_len=1
    bar=$(printf '─%.0s' $(seq 1 $bar_len))
    printf "${color}╭─${prefix}${bar}╮${reset}\n"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _workspace_banner

################################################
# EMACS vterm integration
############################################################
# When SSH'd into a workspace from Emacs vterm, these two hooks wire up the
# local Emacs as a "remote IDE":
#
#   _vterm_set_workspace  — fires on every prompt; tells Emacs which workspace
#                           this shell belongs to so TRAMP paths are built correctly
#
#   edit <file>           — open any file from the workspace shell directly in
#                           your local Emacs buffer (full LSP, syntax highlighting, etc.)
#
if [[ -n "$VTERM" ]]; then

    _vterm_set_workspace() {
        # workspace hostname: <name>.workspace.infra.dog  ->  hostname -s: <name>
        # Set EMACS_WORKSPACE_NAME manually if the short hostname doesn't match
        # the name you gave the workspace (e.g. 'workspaces create my-ws').
        local ws="${EMACS_WORKSPACE_NAME:-$(hostname -s 2>/dev/null)}"
        printf '\e]51;["call","set-workspace","%s"]\e\\' "$ws"

        # Export PEON_RELAY_PORT matching the port the wksp alias forwarded.
        # Must use the same hash as _ws_port on the Mac side.
        export PEON_RELAY_PORT=$(python3 -c "
import hashlib
h = int(hashlib.md5(('matthew-saucedo-${ws}peon').encode()).hexdigest(), 16)
print(8300 + h % 200)
" 2>/dev/null)
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _vterm_set_workspace

    edit() {
        (( $# )) || { echo "usage: edit <file>" >&2; return 1 }
        printf '\e]51;["call","ws-find-file","%s"]\e\\' "${1:A}"
    }

fi
