use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

property layerLIst : missing value
property layersContainingStringList : {}

tell application "Adobe Photoshop CC 2017"
	
	-- Get all layers in current document.
	set layerLIst to every layer in current document
	-- Get search string from user, store value in variabl.
	set searchString to my searchStringDialog()
	-- Find out how many instances match.
	if my totalCountForString(searchString) is less than 1 then
		display dialog "Document does not contain text layers with the text: " & searchString buttons {"OK"}
	else
		set newString to text returned of (display dialog "Found " & my totalCountForString(searchString) & " text layers  with \"" & searchString & "\"." & return & return & "Replace with: " default answer "" buttons {"Replace", "Cancel"} default button 2)
		my changeStringWithString(searchString, newString)
	end if
end tell

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
		repeat with aLayer in layerLIst
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
