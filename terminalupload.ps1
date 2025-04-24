#!/usr/bin/env pwsh
# --- terminalupload.ps1 ---
# Created by Dashiell Benton
# Converted to PowerShell

# Default values
$BIN_NAME = ""
$OUTPUT_FILE = ""
$INPUT_FILE = ""
$HELP = $false

# Function to display help message
function Print-Help {
    Write-Host @"

terminalupload - Created by Dashiell Benton

--help, -h     Prints this help message and exits.
--file, -f        Selects an input file.
--output-file, -o        Selects an output file, the filename it will be when uploaded. If none is specified, will default to the name of the input file. 
--bin, -b       Selects a bin, the part before the filename. If none is specified, it randomly generates one. Custom bin names must be 10-15 characters.

Credits:
Filebin, for the amazing cloud storage and API - https://filebin.net

GitHub repo: https://github.com/cwrayne/terminalupload

"@
}

# Parse command-line arguments
$i = 0
while ($i -lt $args.Count) {
    switch ($args[$i]) {
        { $_ -eq "--help" -or $_ -eq "-h" } {
            $HELP = $true
            $i++
            break
        }
        { $_ -eq "--file" -or $_ -eq "-f" } {
            $INPUT_FILE = $args[$i+1]
            $i += 2
            break
        }
        { $_ -eq "--output-file" -or $_ -eq "-o" } {
            $OUTPUT_FILE = $args[$i+1]
            $i += 2
            break 
        }
        { $_ -eq "--bin" -or $_ -eq "-b" } {
            $BIN_NAME = $args[$i+1]
            $i += 2
            break
        }
        default {
            Write-Host "Unknown option: $($args[$i])"
            $HELP = $true
            $i++
            break
        }
    }
}

# Show help if requested or if no arguments are provided
if ($HELP -or [string]::IsNullOrEmpty($INPUT_FILE)) {
    Print-Help
    exit 0
}

# Validate input file
if (-not (Test-Path -Path $INPUT_FILE -PathType Leaf)) {
    Write-Host "Error: Input file '$INPUT_FILE' not found."
    exit 1
}

# Generate a random bin name if not provided
if ([string]::IsNullOrEmpty($BIN_NAME)) {
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    $random = New-Object System.Random
    $BIN_NAME = -join (1..16 | ForEach-Object { $chars[$random.Next(0, $chars.Length)] })
}

# Use the input file name as the output file name if not specified
if ([string]::IsNullOrEmpty($OUTPUT_FILE)) {
    $OUTPUT_FILE = Split-Path -Leaf $INPUT_FILE
}

# Perform the upload using Invoke-WebRequest (PowerShell's version of curl)
try {
    $fileContent = [System.IO.File]::ReadAllBytes($INPUT_FILE)
    $url = "https://filebin.net/$BIN_NAME/$OUTPUT_FILE"
    
    Write-Host "Uploading to $url..."
    
    $response = Invoke-WebRequest -Uri $url `
                                  -Method Post `
                                  -Headers @{
                                      'accept' = 'application/json'
                                      'Content-Type' = 'application/octet-stream'
                                  } `
                                  -Body $fileContent `
                                  -ErrorAction Stop

    # Handle successful response
    Write-Host "Your file has been stored at https://filebin.net/$BIN_NAME/$OUTPUT_FILE."
    Write-Host "The file will automatically be deleted in 6 days."
    Write-Host "You can access the browser interface at https://filebin.net/$BIN_NAME."
}
catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    
    # Handle the response based on the status code
    switch ($statusCode) {
        400 { Write-Host "Error: Invalid input, typically invalid bin or filename specified." }
        403 { Write-Host "Error: The storage limitation was reached. (More than 30GB)" }
        405 { Write-Host "Error: The bin is locked and cannot be written to." }
        default {
            Write-Host "Unexpected response: HTTP $statusCode"
            if ($_.Exception.Response) {
                try {
                    $responseBody = $_.Exception.Response.GetResponseStream()
                    $reader = New-Object System.IO.StreamReader($responseBody)
                    $body = $reader.ReadToEnd()
                    Write-Host "Response body: $body"
                }
                catch {
                    Write-Host "Unable to read response body."
                }
            }
        }
    }
    exit 1
}