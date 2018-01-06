all: FindReplaceText-Helper-PsCC2017-Droplet.applescript
	# Create build directory (will create if it doesn't already exist)
	mkdir -p build	
	# Remove the old .app
	rm -R -f build/FindReplaceText-Helper-PsCC2017.app
	# Compile applescript to app and place into build folder.
	osacompile -o build/FindReplaceText-Helper-PsCC2017.app FindReplaceText-Helper-PsCC2017-Droplet.applescript
setup: PSTestDocumentsSetup.applescript
	# Remove old Photoshop files
	rm -f FindReplaceTestDoc*
	# Run setup script
	osascript PSTestDocumentsSetup.applescript
clean: 
	# Remove Photoshop test files
	rm -f FindReplaceTestDoc*
	# Remove build folder and contents
	rm -R -f build
