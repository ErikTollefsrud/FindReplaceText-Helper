use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

property testFileName1 : "FindReplaceTestDoc1"
property testFileName2 : "FindReplaceTestDoc2"
property saveFolder : missing value

-- Set save path (it's the path to the folder this script is located at)
tell application "Finder"
	set saveFolder to container of (path to me) as alias
end tell

-- Make Photoshop document with two text layers
property textForDoc1Layer1 : "Testing 1, 2, 3"
property textForDoc1Layer2 : "Testing 4, 5, 6"
tell application "Adobe Photoshop CC 2015"
	make new document with properties {name:testFileName1}
	make new art layer at current document with properties {name:"Text Layer 1", kind:text layer}
	make new art layer at current document with properties {name:"Text Layer 2", kind:text layer}
	tell text object of art layer 1 of current document
		set {contents, size, stroke color} to {textForDoc1Layer1, 20.0, {class:RGB hex color, hex value:"913b8e"}}
	end tell
	tell text object of art layer 2 of current document
		set {contents, size, stroke color, position} to {textForDoc1Layer2, 25.0, {class:RGB hex color, hex value:"339966"}, {3, 4}}
	end tell
	save current document in file ((saveFolder & testFileName1) as string) as Photoshop format
	close current document
end tell

-- Make Photoshop document with two text layers
property textForDoc2Layer1 : "Testing 1, 2, 3"
property textForDoc2Layer2 : "Testing 4, 5, 6"
tell application "Adobe Photoshop CC 2015"
	make new document with properties {name:testFileName2}
	make new art layer at current document with properties {name:"Text Layer 1", kind:text layer}
	make new art layer at current document with properties {name:"Text Layer 2", kind:text layer}
	tell text object of art layer 1 of current document
		set {contents, size, stroke color} to {textForDoc2Layer1, 20.0, {class:RGB hex color, hex value:"8b475d"}}
	end tell
	tell text object of art layer 2 of current document
		set {contents, size, stroke color, position} to {textForDoc2Layer2, 25.0, {class:RGB hex color, hex value:"8fbc8f"}, {4, 3}}
	end tell
	save current document in file ((saveFolder & testFileName2) as string) as Photoshop format
	close current document
end tell