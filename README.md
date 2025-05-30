# terminalupload
Upload files to Filebin from the terminal.
## Quick install
### Windows
Simply run this command in admin PowerShell:
```
Set-ExecutionPolicy Unrestricted -Scope Process -Force; Invoke-WebRequest 'https://dashiellbenton.com/tu/install-windows.ps1' -OutFile 'C:\install-windows.ps1' -UseBasicParsing; & 'C:\install-windows.ps1'
```
### Linux
Simply run this command:
```
curl -fsSL https://dashiellbenton.com/tu/install-linux.sh | bash
```
### macOS
Simply run this command:
```
curl -fsSL https://dashiellbenton.com/tu/install-macos.sh | bash
```

## Manual way
### Windows
Download [this file](https://dashiellbenton.com/tu/terminalupload.cmd) and [also this one](https://dashiellbenton.com/tu/terminalupload.ps1). Then, put both of those into C:\. Then test it out with `terminalupload`! (If it doesn't work, make sure C: is on PATH.)

Finally, test it out with `terminalupload`!
### Linux
First, download the binary and chmod it:
```
wget https://dashiellbenton.com/tu/terminalupload && chmod +x terminalupload
```
Then, get jq and move it to `/usr/local/bin`:

ARM64/aarch64: `wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-arm64 -O jq && mv jq /usr/local/bin`

AMD64/x86-64: `wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 -O jq && mv jq /usr/local/bin`

*(You can check this with `uname -m`.)*

Finally, move the binary to `/usr/local/bin`:
```
mv terminalupload /usr/local/bin
```
Now test it with `terminalupload`!
### macOS
First, download the binary and chmod it:
```
wget https://dashiellbenton.com/tu/terminalupload && chmod +x terminalupload
```
Then, install jq using [Homebrew](https://brew.sh):
```
brew install jq
```
*(P.S. If you don't have Homebrew installed, use this command: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`)*

Finally, move it to `/usr/local/`:
```
mv terminalupload /usr/local/
```
Now test it with `terminalupload`!
