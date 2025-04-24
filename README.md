# terminalupload
Upload files to Filebin from the terminal.
## Quick install
(Windows and macOS will be supported soon)
### Linux
Simply run this command:
```
curl -fsSL https://dashiellbenton.com/tu/install-linux.sh | bash
```

## Manual way
First, download the binary:
```
wget https://dashiellbenton.com/tu/terminalupload
```
Then, get jq and move it to `/usr/local/bin`:
ARM64: `wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-arm64 -O jq && mv jq /usr/local/bin`
AMD64: `wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 -O jq && mv jq /usr/local/bin`
Finally, move the binary to `/usr/local/bin`:
```
mv terminalupload /usr/local/bin
```
