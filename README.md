# FindReplaceText-Helper

## FindReplaceText-Helper-Script

A script for Adobe Photoshop that aids in finding and replacing text in text layers.

### Recommended installation instructions

1. Enable the Scripts menu by opening _/Applications/Utilities/Script Editor.app_
2. From the menubar, select _Script Editor > Preferences_.
3. Enable the *Show Script menu in menu bar* check box. Then quick Script Editor.
4. Create a new folder called "Photoshop" in _~/Library/Scripts/_ folder.
5. Copy the *FindReplaceText-Helper-PsCC2017-Script.applescript* file to _~/Library/Scripts/Photoshop/_ folder.

### How to use

1. Open a Photoshop document.
2. From the menu bar, select the Script menu (should be located in the upper right near the system clock).
3. Choose the *FindReplaceText-Helper-PsCC2017-Script* item.

## FindReplaceText-Helper-Droplet

An application to drag and drop Photoshop files onto to aid in the finding and replacing of text in text layers.

### Recommended installation instructions

1. Download the repository.
2. Open the Terminal application from _/Applications/Utilities/Terminal.app_ 
3. Navigate to the repository folder's "FindReplaceText-Helper Adobe Photoshop CC 2017" folder.
4. Type `make` and press return.
5. This will compile the applescript into a ".app" (which is called a droplet) and place it into a new "build" folder. You can move the droplet application anywhere you prefer.

### How to use

1. Drag one or more Photoshop documents and drop it onto the droplet application.