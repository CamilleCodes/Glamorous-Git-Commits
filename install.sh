#!/bin/bash
{ # This ensures the entire script is downloaded #


  declare -r GGC_REPO="https://github.com/envpcamille/Glamorous-Git-Commits.git"

  declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
  declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

  declare -r GGC_BASE_DIR="${GGC_BASE_DIR:-"$XDG_DATA_HOME/ggc"}"
  declare -r GGC_COMMIT_FILE="$GGC_BASE_DIR/commit.sh"
  declare -r GGC_CONFIG_DIR="${GGC_CONFIG_DIR:-"$XDG_CONFIG_HOME/ggc"}"
  declare -r GGC_CONFIG_FILE="$GGC_CONFIG_DIR/commit_types.conf"

  # Check for required dependencies
  function check_system_dependencies() {
    # Git & Gum
    if ! command -v git &>/dev/null; then
      echo "Missing required dependency: Git"
      exit 1
    fi
    if ! command -v gum &>/dev/null; then
      echo "Missing required dependency: Gum"
      exit 1
    fi
  }

  # Clone repository
  function clone_ggc() {
    echo "Cloning repository: https://github.com/envpcamille/Glamorous-Git-Commits"

    if [ -d "$GGC_BASE_DIR" ]; then
      echo "$GGC_BASE_DIR already exists."
      return
    fi

    if ! git clone "$GGC_REPO" "$GGC_BASE_DIR"; then
      echo "Failed to clone repository. Installation failed."
      exit 1
    fi
   }
   
   # Copy commit types default configuration
   function copy_config() {
     if [ -f "$GGC_CONFIG_FILE" ]; then
       # Backup the existing file
       echo "Backing up: $GGC_CONFIG_FILE to $GGC_CONFIG_FILE.bak"
       mv "$GGC_CONFIG_FILE" "$GGC_CONFIG_FILE.bak"
     fi

     mkdir -p "$GGC_CONFIG_DIR" && cp "$GGC_BASE_DIR/commit_types.conf" "$GGC_CONFIG_DIR"
   }

   function verify_installation() {
     echo "Verifying installation..."

     if [ ! -f "$GGC_CONFIG_FILE" ]; then
       echo "Couldn't find $GGC_CONFIG_FILE"
       exit 1
     fi

     
     if [ ! -f "$GGC_COMMIT_FILE" ]; then
      echo "Couldn't find $GGC_COMMIT_FILE"
      exit 1
     fi

     echo "Installation verified."
     
   }

   function main() {
     echo "Hello, world"
     check_system_dependencies
     clone_ggc
     copy_config
     verify_installation
   }

   main
} # This ensures the entire script is downloaded # 
