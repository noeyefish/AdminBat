iwr "https://raw.githubusercontent.com/noeyefish/AdminBat/refs/heads/main/Admin_Menu_All_In_One.bat" -OutFile "$env:TEMP\\tmp.bat"; Start-Process "$env:TEMP\\tmp.bat" -Verb RunAs
