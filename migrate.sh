#!/bin/bash

# Set the base directory containing repositories (defaults to the current directory)
BASE_DIR="$PWD"

# Get the authenticated GitHub username
GITHUB_USER=$(gh api user | jq -r .login)

if [[ -z "$GITHUB_USER" ]]; then
    echo "Error: GitHub authentication failed."
    exit 1
fi

echo "Using GitHub account: $GITHUB_USER"

# Iterate over subdirectories
for dir in "$BASE_DIR"/*/; do
    # Remove trailing slash and get the repo name
    REPO_NAME=$(basename "$dir")

    echo "Processing repository: $REPO_NAME"

    # Check if it's a Git repository
    if [[ -d "$dir/.git" ]]; then
        cd "$dir" || continue

        # Check if repository already exists on GitHub
        REPO_EXISTS=$(gh repo view "$GITHUB_USER/$REPO_NAME" --json name -q .name 2>/dev/null)

        if [[ -z "$REPO_EXISTS" ]]; then
            echo "Creating repository $REPO_NAME on GitHub..."
            gh repo create "$GITHUB_USER/$REPO_NAME" --private
        else
            echo "Repository $REPO_NAME already exists. Using the existing repository."
        fi

        # Set up the new remote
        git remote remove origin 2>/dev/null
        git remote add origin "git@github.com:$GITHUB_USER/$REPO_NAME.git"

        echo "Pushing repository $REPO_NAME to GitHub..."
        if git push --set-upstream origin --all; then
            echo "Successfully migrated $REPO_NAME with full history."
        else
            echo "Failed to push history. Resetting repository..."
            rm -rf .git
            git init
            git add .
            git commit -m "Initial commit after migration"
            git branch -M main
            git remote add origin "git@github.com:$GITHUB_USER/$REPO_NAME.git"
            git push -u origin main
        fi

        cd "$BASE_DIR" || exit
    else
        echo "Skipping $REPO_NAME: Not a Git repository."
    fi
done

echo "Migration completed!"
