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


# Ask for the commit type
COMMIT_TYPE=$(gum choose "${!commit_types[@]}")

# Example scope: feat(lang): add Japanese language
# See https://www.conventionalcommits.org/en/v1.0.0/ for more examples / references
SCOPE=$(gum input --placeholder "$COMMIT_TYPE(scope)")

# Scope is optional - if it exists, wrap it in parentheses
test -n "$SCOPE" && SCOPE="($SCOPE)"

# Pre-populate the input with the commit type and scope
SUMMARY=$(gum input --prompt "> $COMMIT_TYPE$SCOPE: " --placeholder "Summary of this change")
while [ -z $SUMMARY ]; do
  SUMMARY=$(gum input --prompt "> $COMMIT_TYPE$SCOPE: " --placeholder "Seriously, what is the summary of this change?")
done
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

# Commit the changes
gum confirm "Commit changes?" && git commit -m "$COMMIT_TYPE$SCOPE: $SUMMARY" -m "$DESCRIPTION"

