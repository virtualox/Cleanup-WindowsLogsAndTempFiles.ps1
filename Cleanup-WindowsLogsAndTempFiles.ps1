<#
.SYNOPSIS
This script is designed to clean up various system and user folders to free up disk space on a Windows system.

.DESCRIPTION
The script will first verify if it is running with administrative privileges. If not, it will attempt to restart itself with the required privileges.
Then, it systematically cleans up several predefined system folders, including various Temp, Log, and Cache folders.
Finally, the script iterates through all the user folders on the system and cleans the Temp and INetCache folders within each.

.PARAMETER None

.EXAMPLE
To run the script, navigate to the directory containing the script in a PowerShell window, then type:
.\Cleanup-WindowsLogsAndTempFiles.ps1

#>

# Ensure the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.InvocationName)`"" -Verb RunAs
    exit
}

# Function to clean a specific folder
function Clean-Folder($folderPath) {
    if (Test-Path -Path $folderPath) {
        Write-Host "Cleaning up $folderPath"
        Get-ChildItem -Path $folderPath -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    }
}

# Clean up system log and temp folders
$systemFolders = @(
    "$Env:SystemRoot\Temp",
    "$Env:SystemRoot\Logs",
    "$Env:LOCALAPPDATA\Temp",
    "$Env:WINDIR\SoftwareDistribution\Download",
    "$Env:WINDIR\System32\LogFiles",
    "$Env:WINDIR\System32\Winevt\Logs",
    "$Env:PUBLIC\Documents\Windows Error Reporting"
)

foreach ($folder in $systemFolders) {
    Clean-Folder $folder
}

# Clean up user temp and internet cache folders
$users = Get-ChildItem -Path "C:\Users\" -Directory -Force -ErrorAction SilentlyContinue

foreach ($user in $users) {
    $userTempFolder = Join-Path $user.FullName "AppData\Local\Temp"
    $userCacheFolder = Join-Path $user.FullName "AppData\Local\Microsoft\Windows\INetCache"

    Clean-Folder $userTempFolder
    Clean-Folder $userCacheFolder
}

Write-Host "Cleanup complete!"
