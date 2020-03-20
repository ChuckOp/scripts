# PowerShell script to collect information about machine
# Written by Charles Oppermann (chuckop@malwarebytes.com) March 16, 2020

# Trying to discover:
# Exact Windows version information including SKU and release branch
# Server roles if enabled
# Number of user profiles
# Version information of Malwarebytes components
# Presence of any files in %programdata%\Malwarebytes\MBAMService\TMP

# Secondary goals
# Clean up TMP folder
# Clean up any orphaned users
# Run MSINFO32 and save file

# Get Windows Version, type, and SKU information
$Win32OS = Get-WmiObject Win32_OperatingSystem

$Win32OS | Select-Object Version, Caption, BuildType, NumberOfUsers, OSProductSuite, SuiteMask, OperatingSystemSKU, OSType

if ($Win32OS.OSProductSuite -band 16) { "Terminal Server detected" } else { "Terminal Server not detected" }

# Malwarebytes Version Information
$MBBinaryPath = ($env:ProgramFiles+"Malwarebytes\Anti-Malware")
Get-ChildItem -Path $MBBinaryPath\* -Include *.exe,*.dll | ForEach-Object VersionInfo

# User profile information
Get-WmiObject win32_userprofile | Select-Object SID, LocalPath, LastUseTime, Loaded

Get-ChildItem ($env:HOMEDRIVE+"\Users") -hidden | Format-Table

# TODO: Go through Windows System log to find user profile problems

# Get Microsoft-Windows-User Profile Service/Operational Log
Get-WinEvent "Microsoft-Windows-User Profile Service/Operational" | Format-Table -AutoSize

# List out files in the service folder
# Some modules that use OffineUAManager use TMP others don't
$MBDataPath = ($env:ProgramData+"Malwarebytes\MBAMService")
Get-ChildItem -Path $MBDataPath -Recurse




