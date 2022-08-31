#!/bin/sh

# Ask for the commit type
COMMIT_TYPE=$(gum choose "add new feature" "add piece of code" "refactor" "remove something"\
  "move or rename something" "documentation" "bug fix" "checks / compliance" "improve UI / add assets" \
  "improve performance" "merge a branch")

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

