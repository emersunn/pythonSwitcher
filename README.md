# Python Version Switcher

`python_version_switcher.sh` is a BASH script that finds all installations of Python on your macOS system (default OS install, Homebrew install, and Xcode install), determines which one is the most up-to-date, and makes it the default in the terminal for both bash and zsh. It also logs everything in a file called `python_version_switcher.log`.

## Usage

1. Save the script as `python_version_switcher.sh`.
2. Grant execution permissions to the script using `chmod +x python_version_switcher.sh`.
3. Run the script with `bash python_version_switcher.sh`.

After running the script, restart your terminal to apply the changes.

## Available Modifications

### Log File Name

To change the log file name, edit the `LOG_FILE` variable:

```bash
LOG_FILE="new_log_file_name.log"
```

### Python Installations

To add, remove, or modify Python installations to be searched, edit the `PYTHON_INSTALLS` array:

```bash
PYTHON_INSTALLS=("path/to/python1" "path/to/python2" "path/to/python3")
```

### Configuration Files

To update different configuration files, modify the `BASH_PROFILE` and/or `ZSH_PROFILE` variables:

```bash
BASH_PROFILE="$HOME/path/to/your/bash_profile"
ZSH_PROFILE="$HOME/path/to/your/zshrc"
```

## Requirements

This script requires a macOS system with bash installed. It assumes you have Homebrew and Xcode installed.
