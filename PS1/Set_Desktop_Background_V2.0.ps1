#Set image name of the background image being set. Background should be a .jpg or .bmp file.
$ImageName = "tempbackground.jpg"

# Get each folder under "Users"
$drive = (Get-Location).Drive.Root
$users = Get-ChildItem "$($drive)Users"

#Copy desktop background to final location
$CheckForImage = Test-Path "$($drive)Users\Public\Pictures\$($ImageName)"
#If image is not found, copy it to public pictures directory, if it is found do nothing.
if (!$CheckForImage) {
    if (test-path "$($drive)temp\$($ImageName)") {
        Copy-Item -Path "$($drive)temp\$($ImageName)" -Destination "$($drive)Users\Public\Pictures\$($ImageName)"
    }
    #path to $imagename was not found or name is incorrect
    else {
        write-host "Background image not found, please confirm the ImageName parameter in the script is set correctly."
    }
}

$GetCurrentUserHives = Get-ChildItem -Path "Registry::HKEY_USERS\"
$GetCurrentUserHives = $GetCurrentUserHives.Name.Replace(".Name", "")

# For each user, load and edit their registry
foreach ( $user in $users ) {
    $username = $user.Name
    #Attempt to load ntuser.dat file to set Desktop background.
    #setting via ntuser.dat ensures all users in c:\ that are not logged in get the background set.
    #If a user is logged in the file will be locked and the script will be unable to load it. In this case we check registry path HKEY_USERS

    #load registry hive from c:\users\username\ntuser.dat file
    $loadhive = reg.exe LOAD HKU\TempHive "$($drive)Users\$($username)\NTUSER.DAT" 2>$null

    if (($loadhive -like "*completed successfully.") -and ($username -notlike "Public")) {
       # write-host "Successfully loaded ntuser.dat file from $($drive)Users\$($user.name)"
        $dir = "Registry::HKEY_USERS\TempHive\Control Panel\Desktop"
        $CheckforWallPaper = Get-ItemProperty -Path $dir -Name "WallPaper" -ErrorAction SilentlyContinue
        # skips checking hives that do not contain Control Panel\Desktop directory
        if ( (Test-Path $dir) -and ($CheckforWallPaper.WallPaper -notlike "$($drive)Users\Public\Pictures\$($ImageName)") ) {

            # Set the image
            $null = Set-ItemProperty -Path $dir -Name "WallPaper" -value "$($drive)Users\Public\Pictures\$($ImageName)"

            # Set the style to Fill
            $null = Set-ItemProperty -Path $dir -Name "WallpaperStyle" -value 10

            # Set to 0 since Fill is used as the style
            $null = Set-ItemProperty -Path $dir -Name "TileWallpaper" -value 0

            write-host "Background set via registry for $($username)"
        }
    }
    #Cleanup registry and unload hive
    [gc]::Collect()
    reg.exe UNLOAD HKU\TempHive 2>&1 | Out-Null
    #Set Background for accounts that failed to open ntuser.dat
    if (!$loadhive) {
       # Write-Host "Failed to load ntuser.dat for $($user.name)(User account logged in or file is locked).`nSetting background via registry"
        foreach ($hive in $GetCurrentUserHives) {
            $dir = "Registry::$($Hive)\Control Panel\Desktop\"
            $CheckforWallPaper = Get-ItemProperty -Path $dir -Name "WallPaper" -ErrorAction SilentlyContinue
            if ( (Test-Path $dir) -and ($CheckforWallPaper.WallPaper -notlike "$($drive)Users\Public\Pictures\$($ImageName)") ) {

                # Set the image
                $null = Set-ItemProperty -Path $dir -Name "WallPaper" -value "$($drive)Users\Public\Pictures\$($ImageName)"
            
                # Set the style to Fill
                $null = Set-ItemProperty -Path $dir -Name "WallpaperStyle" -value 10
            
                # Set to 0 since Fill is used as the style
                $null = Set-ItemProperty -Path $dir -Name "TileWallpaper" -value 0

                write-host "Background set via registry for $($username). For background to apply, log off the user account and back in or reboot the endpoint."

            }
        }
    }
}
