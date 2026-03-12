#!/usr/bin/env bash
set -euo pipefail

FILES=("config/settings_data.json" "config/settings_schema.json")

echo "Checking you're on main (recommended)..."
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" != "main" ]]; then
  echo "You're on '$BRANCH', not 'main'. This is intended for use on main."
fi

echo "Removing skip-worktree safety buffer..."
git update-index --no-skip-worktree "${FILES[@]}" || true

echo "Restoring settings from main..."
git checkout -- "${FILES[@]}"

echo "Reset complete:"
printf " - %s\n" "${FILES[@]}"