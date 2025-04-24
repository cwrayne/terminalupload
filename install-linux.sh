#!/bin/bash
echo "Downloading and installing terminalupload..."
wget https://dashiellbenton.com/tu/terminalupload -O /tmp/terminalupload
mv /tmp/terminalupload /usr/local/bin/terminalupload
echo "terminalupload installed! Downloading dependencies..."

# Detect if running in WSL
if grep -qi "microsoft" /proc/version || grep -qi "WSL2" /proc/version; then
    echo "Detected WSL environment. Fixing DNS resolution..."

    # Check if /etc/resolv.conf exists, and add nameservers if missing
    if [ -f /etc/resolv.conf ]; then
        echo "Updating /etc/resolv.conf with Google DNS..."

        # Backup current resolv.conf
        sudo cp /etc/resolv.conf /etc/resolv.conf.bak

        # Update resolv.conf with Google's DNS (8.8.8.8 and 8.8.4.4)
        sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
        sudo bash -c 'echo "nameserver 8.8.4.4" >> /etc/resolv.conf'
        
        echo "DNS resolution updated in /etc/resolv.conf."

        # Prevent WSL from overwriting resolv.conf on reboot
        if ! grep -q "generateResolvConf = false" /etc/wsl.conf; then
            echo "Disabling automatic resolv.conf generation in WSL..."
            sudo bash -c 'echo -e "[network]\ngenerateResolvConf = false" >> /etc/wsl.conf'
        fi

    else
        echo "Error: /etc/resolv.conf not found. Unable to fix DNS resolution."
        exit 1
    fi
fi

# Detect architecture
ARCH=$(uname -m)

# Set download URL based on architecture
if [[ "$ARCH" == "x86_64" ]]; then
    JQ_URL="https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
    JQ_URL="https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download jq binary
echo "Downloading jq for $ARCH..."
curl -L -o /tmp/jq "$JQ_URL"

# Make it executable
echo "Making jq executable..."
sudo chmod +x /tmp/jq

# Move jq to /usr/local/bin
echo "Moving jq to /usr/local/bin..."
sudo mv /tmp/jq /usr/local/bin/jq

# Verify installation
echo "Verifying jq installation..."
jq --version


echo "Installed terminalupload and its dependencies!"
echo "Test it out with:"
echo " "
echo "terminalupload"
