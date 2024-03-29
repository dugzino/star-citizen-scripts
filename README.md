# Star Citizen Scripts

## Hot to use

This script requires for it to be in Star Citizen's root folder (Default: "C:\Program Files\Roberts Space Industries\StarCitizen").  
I will add a prompt to set the path later.

To run it, simply right click on it and choose "Run with PowerShell".  
Or open a PowerShell prompt (CMD, Terminal, or whatever you like) and run the script from it: `.\ultimate_script.ps1`

## Notice

Use this at your own risks.  
The script is tested by me, myself, and I, AND it's working plenty fine,  
but you should always be careful when using such methods.

Also the script shouldn't need admin rights to run it.

## Scripts

Script written in PowerShell will prompt this question:
```
"Which script do you want to run?
  - 0: to run everything
  - 1: to save files
  - 2: to save screenshots
  - 3: to clean USER and shader folders
  - 4: to push your saved settings to installation folders
So which one will it be?"
```

### Choice 0: Run everything

1. It will ask you from which installation do you want your settings to be saved from and from there on copy them into the root "Star Citizen" folder; in a folder named "_Settings".
2. It will take every screenshot from every installation and copy them into the root "Star Citizen" folder; in a folder named "_Screenshots".
3. It will delete the USER folder in every installation and the shader folders hidden in "%AppData%/Local/Star Citizen".
4. It will push back the previously saved settings into every installation.

### Choice 1: Save Files

It will ask you from which installation do you want to save your settings from and there on copy them into the root "Star Citizen" folder; in a folder named "_Settings".

### Choice 2: Save Screenshots

It will take every screenshot from every installation and copy them into the root "Star Citizen" folder; in a folder named "_Screenshots".

### Choice 3: Clean USER & shader folders

It will delete the USER folder in every installation and the shader folders hidden in "%AppData%/Local/Star Citizen".

### Choice 4: Push saved settings to installations

It will push back the previously saved settings into every installation.

## Setting files

The current setting files this script copying are everything located in these folders:
- "USER\Client\0\Controls\Mappings"; Your exported key mappings
- "USER\Client\0\Profiles\default"; actionmaps.xml, attributes.xml, hintstatus.xml, profile.xml

## Screenshots

Screenshots copied from LIVE will are copied in the root of the "_Screenshots" folder,
while those from other installations will be copied into a folder named "TestBranded".  
The reason for that is because screenshots taken from test servers come with a text hardtyped on the bottom of the screen,
as you probably noticed when playing in PTU; EPTU; or even TECH-PREVIEW servers.

## Known errors

### "Scripts" cannot be loaded because running scripts is disabled on this system.

This is a most probable encountering issue you might face.  
It's simply a way for Microsoft to make it safer,  
as in to not let you run wild and run random unknown scripts.

1. Open PowerShell with Run as Administrator.
2. Run this command in PowerShell `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
3. Type Y and press Enter.

And now you should be able to run the script again.

### Bunch or red messages when running the script

When running on a fresh install, it'll spam that it didn't find any files it's trying to save or delete.  
So, it's a pretty normal behaviour, which I'll try to soften later.
