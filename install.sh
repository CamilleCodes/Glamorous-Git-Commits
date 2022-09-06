#!/bin/bash
{ # This ensures the entire script is downloaded #

  echo "Hello, world"

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
} # This ensures the entire script is downloaded # 
