#!/usr/bin/env bash

if ! command -v curl &> /dev/null
then
    echo "curl is required for this script to run"
    exit 1
fi

echo "Installing gitleaks pre-commit hook..."

git config --local --bool --add gitleaks.enabled true

curl --silent https://raw.githubusercontent.com/vhula/pre-commit-hooks/main/gitleaks.sh > .git/hooks/pre-commit

chmod a+x .git/hooks/pre-commit

echo "Gitleaks pre-commit hook has been installed and enabled."