#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Set variables
REPO_URL="https://github.com/GaiaNet-AI/gaianet-node/releases"
LATEST_VERSION="0.4.6"  # Set the latest version explicitly
BINARY_NAME="gaianet"     # Adjust if necessary

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install or upgrade Gaianet Node
install_or_upgrade_gaianet() {
    echo "Checking Gaianet installation..."

    # Check the current version
    if check_command "$BINARY_NAME"; then
        CURRENT_VERSION=$("$BINARY_NAME" version | grep version | awk '{print $2}')
        if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
            echo "Upgrading Gaianet from version $CURRENT_VERSION to $LATEST_VERSION..."
            download_and_install
        else
            echo "Gaianet is already up-to-date (version $CURRENT_VERSION)."
        fi
    else
        echo "Gaianet is not installed. Installing Gaianet..."
        download_and_install
    fi
}

# Function to download and install the latest version
download_and_install() {
    # Download the latest release tarball
    DOWNLOAD_URL="${REPO_URL}/download/${LATEST_VERSION}/${BINARY_NAME}_${LATEST_VERSION}_Linux_x86_64.tar.gz"
    echo "Downloading from $DOWNLOAD_URL..."
    
    curl -LO "$DOWNLOAD_URL"

    # Extract and install
    tar -xzf "${BINARY_NAME}_${LATEST_VERSION}_Linux_x86_64.tar.gz"
    sudo mv "$BINARY_NAME" /usr/local/bin/
    sudo chmod +x /usr/local/bin/"$BINARY_NAME"
}

# Install or upgrade Gaianet Node
install_or_upgrade_gaianet || { echo "Gaianet installation or upgrade failed."; exit 1; }

# Verify installation
echo "Verifying Gaianet installation..."
echo "gaianet --version: $($BINARY_NAME version | grep version | awk '{print $2}')"

echo "Gaianet installation or upgrade completed successfully!"
