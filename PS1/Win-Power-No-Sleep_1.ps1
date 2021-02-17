$PowerSchemeGUID = powercfg /getactivescheme #Gets Power Scheme GUID
$PowerSchemeGUID = $PowerSchemeGUID.trim("Power Scheme GUID: (Balanced)") #Trim Scheme down to just numbers
$PowerSubGUID = "4f971e89-eebd-4455-a8de-9e59040e7347" #Sets Power Sub GUID (Power buttons and Lid)
$LidAction = "5ca83367-6e45-459f-a27b-476b1d01c936" #Sets Lid Action GUID
Powercfg -hibernate off #Disable Hibernate
powercfg /change monitor-timeout-ac 20 #Screen on AC
powercfg /change standby-timeout-ac 0 #Sleep on AC
powercfg /change monitor-timeout-dc 10 #Screen on Battery (Laptop Only)
powercfg /change standby-timeout-dc 30 #Sleep on Battery (Laptop Only)
powercfg -SetACvalueindex $PowerSchemeGUID $PowerSubGUID $LidAction 0x00000000