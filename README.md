# Windows Disk Cleanup PowerShell Script

This PowerShell script helps in freeing up disk space on a Windows system by cleaning various system and user folders.

## Description

The script first checks if it is running with administrative privileges. If not, it attempts to restart itself with the required privileges. It then systematically cleans up several predefined system folders, including Temp, Log, and Cache folders. Finally, it iterates through all the user folders on the system and cleans the Temp and INetCache folders within each.

## Getting Started

### Dependencies

* This script is designed for Windows operating systems with PowerShell installed.

### Installing

* No specific installation is required. Simply download the `Cleanup-WindowsLogsAndTempFiles.ps1` file.

### Executing program

* Open a PowerShell window, navigate to the directory containing the script, and type: 
  ```powershell
  .\Cleanup-WindowsLogsAndTempFiles.ps1
  ```
## Requirements

- Windows Server or Windows operating system with PowerShell installed
- Administrative privileges to run the script

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements, bug fixes, or feature additions.
