#!/bin/bash

# Step 1: Download the terminalupload binary
echo "Downloading terminalupload binary..."
curl -O https://dashiellbenton.com/tu/terminalupload

# Step 2: Make the binary executable
echo "Making terminalupload executable..."
chmod +x terminalupload

# Step 3: Check if Homebrew is installed, install it if not
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Step 4: Install jq using Homebrew
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing jq..."
# Step 3: Check if Homebrew is installed, install it if not
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            echo "Homebrew is already installed."
fi

    brew install jq
else
    echo "jq is already installed."
fi

# Step 5: Move terminalupload to /usr/local/bin
echo "Moving terminalupload to /usr/local/bin/..."
sudo mv terminalupload /usr/local/bin/

echo "Setup complete!"
