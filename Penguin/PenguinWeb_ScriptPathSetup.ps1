#######################################################################################################
# This Script Sets up the Development environemt for Penguin Web, Creating Script File Folders with the 
# provided version in the ScriptVersionChangeTo parameter from the Config
#
# NOTE Change the Version in the Config.Json File before you begin
#######################################################################################################

#Script variable
$configuration      =  Get-Content -Path '..\config.json' | ConvertFrom-Json
$scriptVersion      = $configuration.ScriptVersionChangeTo
$penguinBasePath    = $configuration.PenguinPath
$baseVersion        = $configuration.BaseVersion

$availableScriptPaths = $configuration.PenguinWebScriptFiles

Write-Output "Setting PeguinWeb with :$scriptVersion version"

foreach($scriptPath in $availableScriptPaths) 
{
    #Create The Absolute Path
    $destinationPath = $penguinBasePath + $scriptPath + "\TTTT_$scriptVersion"
    $sourcePath = $penguinBasePath + $scriptPath + "\$baseVersion"

    #STAGE 1: Create The Required Folders
    #Delete Destination Folder & Contents If Exist
    if ((Test-Path $destinationPath)) 
    {
        Remove-Item $destinationPath -Recurse
    }
    
    # If The Destination Folder DOES NOT Exists
    if (!(Test-Path $destinationPath)) 
    {
        # Create the Destination Folder
        New-Item -ItemType Directory -Force -Path $destinationPath
    }
    
    #STAGE 2: Copy The Contents From The Source To Destination
    Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -recurse -Force
}