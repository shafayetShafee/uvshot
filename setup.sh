#!/bin/bash

VENV_PYTHON_VERSION=${1:-"3.9.6"}

ROOT_PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$ROOT_PROJECT_DIR"

DOT_ENV_FILE=$ROOT_PROJECT_DIR/.env

UV_PYTHON_INSTALL_DIR=$ROOT_PROJECT_DIR/python
UV_CACHE_DIR=$ROOT_PROJECT_DIR/uv-cache

function log() {
    echo -e "$(date +"%Y-%m-%d T%H:%M:%S%z") INFO $@"
}

function warn() {
    echo -e "$(date +"%Y-%m-%d T%H:%M:%S%z") WARNING $@"
}

function error() {
    echo -e "$(date +"%Y-%m-%d T%H:%M:%S%z") ERROR $@"
    exit 1
}


function create_python_venv() {
    log "Checking whether uv is installed or not"
    if command -v uv >/dev/null 2>&1; then
        log "uv is installed"
    else
        error "uv is not installed"
    fi

    log "Checking if Python $VENV_PYTHON_VERSION is already installed by uv"
    UV_PYTHON_VERSION_INSTALLED=$(uv python find $VENV_PYTHON_VERSION --managed-python --show-version 2>/dev/null || true)

    if [[ "$UV_PYTHON_VERSION_INSTALLED" == "$VENV_PYTHON_VERSION" ]]; then
        log "Python $VENV_PYTHON_VERSION already installed by uv in $UV_PYTHON_INSTALL_DIR"
    else
        log "Installing Python $VENV_PYTHON_VERSION using uv"
        uv python install "$VENV_PYTHON_VERSION" \
                        --color auto \
                        --managed-python \
                        --install-dir "$UV_PYTHON_INSTALL_DIR" || {
            error "Failed to install Python $VENV_PYTHON_VERSION using uv"
        }
        log "Python $VENV_PYTHON_VERSION installed successfully"
    fi

    if [ -d "$ROOT_PROJECT_DIR/venv" ]; then
        log "Directory $ROOT_PROJECT_DIR/venv exists."
    else
        uv venv venv --python "$VENV_PYTHON_VERSION" \
                     --cache-dir "$UV_CACHE_DIR" \
                     --color auto \
                     --managed-python || {
            error "Failed to create virtual environment"
        }
        log "Virtual environment created"
    fi

    log "Activating virtual environment"
    source venv/bin/activate

    log "Virtual environment activated successfully, now installing requirements..."
    if [[ -f "requirements.txt" ]]; then
        uv pip install -r requirements.txt --color auto && 
        log "Requirements installed successfully" || {
            error "Failed to install requirements"
        }
    else
        warn "No 'requirements.txt' file found, so not installing any dependencies"
    fi

    log "Using Python: $(command -v python)"
}


function create_dot_env() {
  if [ -f "$DOT_ENV_FILE" ]
    then
      warn "$DOT_ENV_FILE file already exists."
      warn "Overwriting the existing $DOT_ENV_FILE file."
  fi
  (
      echo "ROOT_PROJECT_DIR=$ROOT_PROJECT_DIR"
      echo "UV_PYTHON_INSTALL_DIR=$UV_PYTHON_INSTALL_DIR"
      echo "UV_CACHE_DIR=$UV_CACHE_DIR"
  ) > "$DOT_ENV_FILE"
  log "$DOT_ENV_FILE file created"
}


create_dot_env && {
    if [ -f "$DOT_ENV_FILE" ]
        then
        set -a
        # shellcheck disable=SC1090
        source "$DOT_ENV_FILE"
        set +a
        log "Exported below mentioned environment variables.\n\n$(cat "$DOT_ENV_FILE")"
    else
        error "Failed to export environment variables. $DOT_ENV_FILE file does not exist."
    fi
} &&
create_python_venv &&
log "Congratulations, setup process completed."