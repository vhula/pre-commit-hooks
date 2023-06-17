#!/usr/bin/env bash

if ! command -v wget &> /dev/null
then
    echo "wget is required for this script to run"
    exit 1
fi

if ! command -v tar &> /dev/null
then
    echo "tar is required for this script to run"
    exit 1
fi

GITLEAKS_INSTALLED="yes"
if ! command -v gitleaks &> /dev/null
then
    echo "gitleaks could not be found"
    GITLEAKS_INSTALLED="no"
fi

GITHOOKS_DIR=~/.git-hooks
GITLEAKS_URL="https://github.com/gitleaks/gitleaks/releases/download"
GITLEAKS_VERSION="8.17.0"
GITLEAKS_ENABLED=$(git config --bool gitleaks.enabled)

function resolve_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "darwin"
    elif [[ "$OSTYPE" == "win32" ]]; then
        echo "windows"
    else
        echo "ERROR. Unsupported OS: $OSTYPE"
        exit 1
    fi
}

function resolve_arch() {
    arch=$(uname -i)
    if [[ $arch == x86_64* ]]; then
        echo "x64"
    elif [[ $arch == i*86 ]]; then
        echo "x32"
    elif  [[ $arch == arm* ]]; then
        echo "arm64"
    else
        echo "ERROR. Unsupported architecture: $arch"
        exit 1
    fi
}

if [ "$GITLEAKS_INSTALLED" == "no" ]; then
    echo "installing gitleaks..."

    arch=$(resolve_arch)
    os=$(resolve_os)
    GITLEAKS_FILE="gitleaks_${GITLEAKS_VERSION}_${os}_${arch}.tar.gz"
    GITLEAKS_DOWNLOAD_URL="${GITLEAKS_URL}/v${GITLEAKS_VERSION}/${GITLEAKS_FILE}"

    mkdir -p ${GITHOOKS_DIR}/gitleaks_${GITLEAKS_VERSION}

    wget -q $GITLEAKS_DOWNLOAD_URL -O ${GITHOOKS_DIR}/$GITLEAKS_FILE

    tar -xf ${GITHOOKS_DIR}/gitleaks_${GITLEAKS_VERSION}_${os}_${arch}.tar.gz -C ${GITHOOKS_DIR}/gitleaks_${GITLEAKS_VERSION}

    echo "gitleaks ${GITLEAKS_VERSION} has been installed."
fi

${GITHOOKS_DIR}/gitleaks_${GITLEAKS_VERSION}/gitleaks detect --source . -v