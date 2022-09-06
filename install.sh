#!/bin/bash
{ # This ensures the entire script is downloaded #


  declare -r GGC_REPO="https://github.com/envpcamille/Glamorous-Git-Commits.git"


  declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
  declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

  declare -r GGC_BASE_DIR="${GGC_BASE_DIR:-"$XDG_DATA_HOME/ggc"}"
  declare -r GGC_CONFIG_DIR="${GGC_CONFIG_DIR:-"$XDG_CONFIG_HOME/ggc"}"

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

    if ! git clone "$GGC_REPO" "$GGC_BASE_DIR"; then
      echo "Failed to clone repository. Installation failed."
      exit 1
    fi
   }

   function main() {
     echo "Hello, world"
     check_system_dependencies
     clone_ggc
   }

   main
} # This ensures the entire script is downloaded # 
