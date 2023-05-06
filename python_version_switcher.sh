#!/bin/bash

# Create a log file
LOG_FILE="python_version_switcher.log"
touch $LOG_FILE

# Log function
log() {
  echo "$(date): $1" | tee -a $LOG_FILE
}

# Find Python installations
log "Searching for Python installations..."
SYSTEM_PYTHON="/usr/bin/python3"
HOMEBREW_PYTHON="$(brew --prefix)/bin/python3"
XCODE_PYTHON="/Applications/Xcode.app/Contents/Developer/usr/bin/python3"
PYTHON_INSTALLS=("$SYSTEM_PYTHON" "$HOMEBREW_PYTHON" "$XCODE_PYTHON")

# Determine the most up-to-date Python installation
log "Determining the most up-to-date Python installation..."
latest_version=""
latest_python=""

for python in "${PYTHON_INSTALLS[@]}"; do
  if [ -x "$python" ]; then
    current_version="$($python --version 2>&1 | cut -d' ' -f2)"
    log "Found Python installation: $python (Python $current_version)"
    if [[ "$(echo -e "${current_version}\n${latest_version}" | sort -V | tail -n1)" == "${current_version}" ]]; then
      latest_version="$current_version"
      latest_python="$python"
    fi
  fi
done

if [ -z "$latest_python" ]; then
  log "No Python installations found. Exiting."
  exit 1
fi

log "Latest Python installation: $latest_python (Python $latest_version)"

# Make the latest Python installation the default in terminal
log "Making the latest Python installation the default in terminal..."

# For bash
BASH_PROFILE="$HOME/.bash_profile"
if [ -L "$BASH_PROFILE" ]; then
  BASH_PROFILE=$(readlink -f "$BASH_PROFILE")
fi
if [ -f "$BASH_PROFILE" ]; then
  log "Updating $BASH_PROFILE"
  sed -i.bak '/export PATH=.*python3/d' "$BASH_PROFILE"
  echo "export PATH=\"$latest_python:\$PATH\"" >> "$BASH_PROFILE"
else
  log "$BASH_PROFILE not found, skipping."
fi

# For zsh
ZSH_PROFILE="$HOME/.zshrc"
if [ -L "$ZSH_PROFILE" ]; then
  ZSH_PROFILE=$(readlink -f "$ZSH_PROFILE")
fi
if [ -f "$ZSH_PROFILE" ]; then
  log "Updating $ZSH_PROFILE"
  sed -i.bak '/export PATH=.*python3/d' "$ZSH_PROFILE"
  echo "export PATH=\"$latest_python:\$PATH\"" >> "$ZSH_PROFILE"
else
  log "$ZSH_PROFILE not found, skipping."
fi

log "Script completed successfully. Restart your terminal to apply changes."
