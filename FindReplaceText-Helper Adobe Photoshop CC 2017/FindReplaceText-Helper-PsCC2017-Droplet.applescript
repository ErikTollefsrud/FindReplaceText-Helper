use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

property extension_list : {"psd"} -- eg: {"txt", "text", "jpg", "jpeg"}, NOT: {".txt", ".text", ".jpg", ".jpeg"}
property layerList : missing value
property layersContainingStringList : {}
property searchString : missing value
property newString : missing value

-- This droplet processes files dropped onto the applet 
on open these_items
	set searchString to missing value
	set newString to missing value
	tell application "Finder"
		repeat with anItem in these_items
			try
				set this_extension to the name extension of anItem
			on error errMsg
				display dialog "Error: " & errMsg
				set this_extension to ""
			end try
			if (this_extension is in the extension_list) then
				try
					my processDocument(anItem)
				on error errMsg
					display dialog errMsg
				end try
			end if
		end repeat
	end tell
end open

on processDocument(theDocument)
	tell application "Adobe Photoshop CC 2017"
		activate
		open theDocument as Photoshop format
		-- Get all layers in current document.
		set layerList to every layer in current document
		
		-- Only ask the user for search string once.
		if searchString is missing value then
			-- Get search string from user, store value in variable.
			set searchString to my searchStringDialog()
		end if
		
		-- Find out how many instances match.
		if my totalCountForString(searchString) is less than 1 then
			display dialog "Document does not contain text layers with the text: " & searchString buttons {"OK", "Cancel"}
		else
			if newString is missing value then
				set newString to text returned of (display dialog "Replace \"" & searchString & "\" with: " default answer "" buttons {"Replace", "Cancel"} default button 2)
			end if
			my changeStringWithString(searchString, newString)
		end if
	end tell
end processDocument


-- searchStringDialog()
-- Displays dialog asking the user to enter a
-- string they want to search for. Method
-- returns search string variable.
on searchStringDialog()
	set userResponse to text returned of (display dialog "Search String" default answer "" buttons {"Search", "Cancel"} default button 1)
	return userResponse
end searchStringDialog

-- totalCountForString(aString) 
-- Searches the current document for 'aString'
-- Returns number of times the string is found
-- as a number.
on totalCountForString(aString)
	set total to 0
	tell application "Adobe Photoshop CC 2017"
		set layersContainingStringList to {}
		repeat with aLayer in layerList
			try
				considering case
					if aLayer's text object's contents contains aString then
						set total to total + 1
						set end of layersContainingStringList to aLayer
					end if
				end considering
			end try
		end repeat
	end tell
	return total as number
end totalCountForString

on changeStringWithString(oldString, newString)
	tell application "Adobe Photoshop CC 2017"
		repeat with aLayer in layersContainingStringList
			try
				set originalString to aLayer's text object's contents as string
				set replacedString to my replace_text(originalString, oldString, newString)
				set aLayer's text object's contents to replacedString
			end try
		end repeat
	end tell
end changeStringWithString

-- Found on https://github.com/abbeycode/AppleScripts/blob/master/Scripts/Libraries/Strings.applescript
on replace_text(this_text, search_string, replacement_string)
	set prevTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to prevTIDs
	return this_text
end replace_text
