#!/bin/bash
{ # This ensures the entire script is downloaded #

  declare -r GGC_REPO="https://github.com/envpcamille/Glamorous-Git-Commits.git"

  declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
  declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
  declare -r BIN_INSTALL_PATH="$HOME/.local/bin"

  declare -r GGC_BASE_DIR="${GGC_BASE_DIR:-"$XDG_DATA_HOME/ggc"}"
  declare -r GGC_COMMIT_FILE="$GGC_BASE_DIR/commit.sh"
  declare -r GGC_CONFIG_DIR="${GGC_CONFIG_DIR:-"$XDG_CONFIG_HOME/ggc"}"
  declare -r GGC_CONFIG_FILE="$GGC_CONFIG_DIR/commit_types.conf"

  function msg() {
    local format="\n\t%s\n\n"
    local title="$1"
    local text="$2"

    printf "$title$format" "$text"
  }

  function conflict_check() {
     if [ -f "$BIN_INSTALL_PATH/ggc" ]; then
       msg "A program with the name 'ggc' already exists at this path:" "$BIN_INSTALL_PATH/ggc"
       echo "Installation aborted."
       exit 1
     fi

     if command -v ggc &>/dev/null; then
       echo "A program that uses command 'ggc' already exists."
       echo "Installation aborted."
       exit 1
     fi
   }

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
    msg "Cloning repository:" "https://github.com/envpcamille/Glamorous-Git-Commits"
  
    if [ -d "$GGC_BASE_DIR" ]; then
      msg "Directory already exists:" "$GGC_BASE_DIR"
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
       msg "Backing up:" "$GGC_CONFIG_FILE"
       msg "to:" "$GGC_CONFIG_FILE.bak"

       mv "$GGC_CONFIG_FILE" "$GGC_CONFIG_FILE.bak"
     fi

     [ ! -d "$GGC_CONFIG_DIR" ] && mkdir -p "$GGC_CONFIG_DIR"

     cp "$GGC_BASE_DIR/commit_types.conf" "$GGC_CONFIG_DIR"
   }

   # Add symlink pointing to commit.sh in /local/bin/
   function add_symlink() {
     [ ! -d "$BIN_INSTALL_PATH" ] && mkdir -p "$BIN_INSTALL_PATH" 

     chmod u+x "$GGC_COMMIT_FILE"

     ln -s "$GGC_COMMIT_FILE" "$BIN_INSTALL_PATH/ggc"
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

     if [ ! -f "$BIN_INSTALL_PATH/ggc" ]; then
      echo "Couldn't find $BIN_INSTALL_PATH/ggc"
      exit 1
     fi

     echo "Installation verified."
   }

   function print_cat() {
     echo ""
     echo "            __..--''\`\`---....___   _..._    __"
     echo " /// //_.-'    .-/\";  \`        \`\`<._  \`\`.''_ \`. / // /"
     echo "///_.-' _..--.'_    \                    \`( ) ) // //"
     echo "/ (_..-' // (< _     ;_..__               ; \`' / ///"
     echo " / // // //  \`-._,_)' // / \`\`--...____..-' /// / //"
     echo ""
  }

   function main() {
     echo "Beginning Glamorous Git Commits installation..."
     conflict_check
     check_system_dependencies
     clone_ggc
     copy_config
     add_symlink
     verify_installation
     print_cat

     msg "Program installed at:" "$BIN_INSTALL_PATH/ggc"

     echo "Installation complete."
   }

   main
} # This ensures the entire script is downloaded # 
