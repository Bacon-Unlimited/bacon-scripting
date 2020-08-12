$INSTALL_FILE = $args[0]
$DEPLOY_LOCATION = $args[1]

Write-Output "The file to copy: " $INSTALL_FILE
Write-Output "The destination location: " $DEPLOY_LOCATION
$Filename = [System.IO.Path]::GetFileName("$INSTALL_FILE")
$FileExt = [System.IO.Path]::GetExtension("$INSTALL_FILE")
$NEW_FILE_PATH = "$($DEPLOY_LOCATION)\$($Filename)"



#Check File Extensoin and make sure it's exe of msi
if ($FileExt -ne ".EXE" -And $FileExt -ne ".exe" -And $FileExt -ne ".MSI" -And $FileExt -ne ".msi") {
	Write-Output "Incorrect File Type: $($FileExt)"
	exit 5
}




#Check Pathing
$SRC_FILE_EXISTS = Test-Path -Path $INSTALL_FILE
If ($SRC_FILE_EXISTS) {
	Write-Output "The Source file exists: " $INSTALL_FILE
} else {
	Write-Output "Source file does not exist. Exiting now... " $INSTALL_FILE
	exit 1
}

$DST_DIRECTORY_EXISTS = Test-Path -Path $DEPLOY_LOCATION
If ($DST_DIRECTORY_EXISTS) {
	Write-Output "The Destination directory exists: " $DEPLOY_LOCATION
} else {
	Write-Output "Destination directory does not exist. Exiting now... " $DEPLOY_LOCATION
	exit 2
}

$NEW_FILE_EXISTS = Test-Path -Path $NEW_FILE_PATH
If ($NEW_FILE_EXISTS) {
	Write-Output "$($NEW_FILE_PATH) already exists. It will be copied over."
} else {
	Write-Output "$($NEW_FILE_PATH) does not exist. It will be created."
}




# Copy File
Write-Output "Copy $($INSTALL_FILE) $($NEW_FILE_PATH)"
Copy-Item -Path $INSTALL_FILE -Destination $NEW_FILE_PATH
Write-Output "Copy exit code: $($?)"
$NEW_FILE_EXISTS = Test-Path -Path $NEW_FILE_PATH
if ($? -ne "True") {
	Write-Output "Copying failed. Exiting."
	exit 4
}

If ($NEW_FILE_EXISTS) {
	Write-Output "Copying worked. $($NEW_FILE_PATH) exists."
} else {
	Write-Output "Error:: $($NEW_FILE_PATH) does not exist.exiting now."
	exit 3
}




# Run Installer
Write-Output "Running application with: cmd /c $($NEW_FILE_PATH)"
cmd /c $NEW_FILE_PATH

if ($? -ne "True") {
	Write-Output "Running the application ($($NEW_FILE_PATH)) failed. Exiting."
	exit 30
} else {
	Write-Output "Running the application succeeded!!!"
}




Write-Output "Process succeeded. Now exiting... with grace."
exit 0
