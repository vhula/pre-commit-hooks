# Gitleaks pre-commit hook

## Demo

![Image](./src/pre-commit-hook-demo.gif)

## Installation

```bash
cd YOUR_GIT_REPO
curl --silent https://raw.githubusercontent.com/vhula/pre-commit-hooks/main/install-pre-commit-hook.sh | bash
```

## Uninstallation

```bash
cd YOUR_GIT_REPO
rm -f .git/hooks/pre-commit
```

## Disabling gitleaks in Git repository

```bash
cd YOUR_GIT_REPO
git config --local --bool --add gitleaks.enabled false
```

## Enabling gitleaks in Git repository

```bash
cd YOUR_GIT_REPO
git config --local --bool --add gitleaks.enabled true
```
