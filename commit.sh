#!/bin/bash
PROGRAM_NAME="gcm"

# Commit types key pairings
declare -A commit_types

COMMIT_CONFIG_FILE="$HOME/.config/$PROGRAM_NAME/commit_types.conf"

if [ -f "$COMMIT_CONFIG_FILE" ]; then 
  IFS="="
  while read key value
  do
    # do something
    commit_types["$key"]="$value"
  done < "$COMMIT_CONFIG_FILE"
fi


NL=$'\n'

# Ask for the commit type
COMMIT_TYPE_KEY=$(gum choose "${!commit_types[@]}") || exit 1
echo "$COMMIT_TYPE_KEY"
COMMIT_TYPE=${commit_types[$COMMIT_TYPE_KEY]}

# Example scope: feat(lang): add Japanese language
# See https://www.conventionalcommits.org/en/v1.0.0/ for more examples / references
SCOPE=$(gum input --placeholder "$COMMIT_TYPE (optional - enter a scope)") || exit 1

# Scope is optional - if it exists, wrap it in parentheses
test -n "$SCOPE" && SCOPE=" ($SCOPE):"

# Pre-populate the input with the commit type and scope
SUMMARY=$(gum input --prompt "> $COMMIT_TYPE$SCOPE " --placeholder "Summary of this change") || exit 1
while [ -z $SUMMARY ]; do
  SUMMARY=$(gum input --prompt "> $COMMIT_TYPE$SCOPE " --placeholder "Seriously, what is the summary of this change?") || exit 1
done
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)") || exit 1

# Commit the changes
gum confirm "Commit changes?" && git commit -m "$COMMIT_TYPE$SCOPE $SUMMARY" -m "$DESCRIPTION"

