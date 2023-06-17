#!/usr/bin/env bash

git config --local --bool --add gitleaks.enabled true

curl --silent https://raw.githubusercontent.com/vhula/pre-commit-hooks/main/gitleaks.sh > .git/hooks/pre-commit

chmod a+x .git/hooks/pre-commit

