#!/usr/bin/env bash
set -euo pipefail

FILES=("config/settings_data.json" "config/settings_schema.json")

echo "Fetching latest branches (origin/uk, origin/us) if available..."
git fetch origin uk us --quiet || true

echo "Checking you're on main (recommended)..."
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" != "main" ]]; then
  echo "You're on '$BRANCH', not 'main'. This is intended for use on main."
fi

echo "Loading UK settings into working tree..."
git checkout uk -- "${FILES[@]}"

echo "Applying skip-worktree safety buffer (prevents accidental commits from main)..."
git update-index --skip-worktree "${FILES[@]}"

echo "UK settings loaded:"
printf " - %s\n" "${FILES[@]}"
echo "Tip: run 'git status' (should not show these files changing due to skip-worktree)."