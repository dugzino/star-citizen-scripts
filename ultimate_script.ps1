$INITIAL_PROMPT = "Which script do you want to run?
  - 0: to run everything
  - 1: to save files
  - 2: to save screenshots
  - 3: to clean USER and shader folders
  - 4: to push your saved settings to installation folders
So which one will it be?"

$SAVE_SETTINGS_FROM = "From which installation folder do you wish to save from?
  - 0: from LIVE (default If left empty)
  - 1: from PTU
  - 2: from EPTU
  - 3: from TECH-PREVIEW
So which one will it be?"

$INSTALLATION_FOLDERS = "LIVE", "PTU", "EPTU", "TECH-PREVIEW"
$USER_PATH = "USER\Client\0"
$SETTINGS_PATHS = "Controls\Mappings", "Profiles\default"
$_SCREENSHOTS_FOLDERS = "_Screenshots", "_Screenshots\TestBranded"
$_SETTINGS_FOLDER = "_Settings"


function CopyFiles ($fromFolder, $toFolder) {
  Copy-Item -Force -Path ".\$fromFolder\*" -Destination ".\$toFolder"
  Write-Output "Copied files from '$fromFolder' to '$toFolder'"
}

function CreatePath ($path) {
  If (!(test-path -PathType container ".\$path")) {
    New-Item -ItemType Directory -Path ".\$path"
    Write-Output "Path '$path' created. (101)"
  } Else {
    Write-Output "Path '$path' already exists. (100)"
  }
}


function SaveSettings {
  $ResInstallChoice = Read-Host $SAVE_SETTINGS_FROM

  $InstallFolderNumber = If ($ResInstallChoice) { $ResInstallChoice } Else { 0 }

  foreach ($path in $SETTINGS_PATHS) {
    $from = "$($INSTALLATION_FOLDERS[$InstallFolderNumber])\$USER_PATH\$path"
    $to = "$_SETTINGS_FOLDER\$USER_PATH\$path"

    CreatePath $to
    CopyFiles $from $to
  }

  Write-Output "Settings from '$INSTALLATION_FOLDERS[$InstallFolderNumber]' folder were saved to '$_SETTINGS_FOLDER'"
}

function SaveScreenshots {
  CreatePath $_SCREENSHOTS_FOLDERS[1]

  foreach ($INSTALL_PATH in $INSTALLATION_FOLDERS) {
    If ((test-path -PathType container ".\$INSTALL_PATH\ScreenShots")) {
      # Because test server have text at the bottom of the screen reminding us it's a test build
      $foo = If ($INSTALL_PATH -eq "LIVE") { 0 } Else { 1 }
      CopyFiles "$INSTALL_PATH\ScreenShots" "$($_SCREENSHOTS_FOLDERS[$foo])"
    }
  }

  Write-Output "All screenshots from installation folders were saved to '$_SCREENSHOTS_FOLDERS[0]'"
}

function CleanFolders {
  # delete USER folder in every install
  foreach ($INSTALL_PATH in $INSTALLATION_FOLDERS) {
    # Copy USER folder only if install folder exists
    If ((test-path -PathType container ".\$INSTALL_PATH")) {
      Remove-Item -Recurse -Path ".\$INSTALL_PATH\USER"
      Write-Output "USER folder in '$INSTALL_PATH' got deleted"
    }
  }

  # Clear shaders
  Remove-Item -Recurse -Path "$env:LOCALAPPDATA\Star Citizen\*"
  Write-Output "Shader folders in '%localappdata%\Star Citizen' got deleted"
}

function PushSavesToInstalls {
  foreach ($INSTALL_PATH in $INSTALLATION_FOLDERS) {
    # Copy USER folder only if install folder exists
    If ((test-path -PathType container ".\$INSTALL_PATH")) {
      Copy-Item -Force -Recurse -Path ".$_SETTINGS_FOLDER\*" -Destination ".\$INSTALL_PATH"
      Write-Output "Settings have been copied to '$INSTALL_PATH' folder"
    }
  }
}

$ResInitialPrompt = Read-Host $INITIAL_PROMPT

If ($ResInitialPrompt -eq 1) {
  Write-Output "You've chosen to save your settings"
  SaveSettings
} ElseIf ($ResInitialPrompt -eq 2) {
  Write-Output "You've chosen to save your screenshots"
  SaveScreenshots
} ElseIf ($ResInitialPrompt -eq 3) {
  Write-Output "You've chosen to clean the USER & shader folders"
  CleanFolders
} ElseIf ($ResInitialPrompt -eq 4) {
  Write-Output "You've chosen to push your saved settings to installation folders"
  PushSavesToInstalls
} ElseIf ($ResInitialPrompt -eq 0) {
  Write-Output "You've chosen to run everything"
  SaveSettings
  SaveScreenshots
  CleanFolders
  PushSavesToInstalls
} Else {
  throw "Invalid input"
}

If ($ResInitialPrompt -eq 5) {
  Write-Output "Scripts have run their course"
} Else {
  Write-Output "Script has run its course"
}
