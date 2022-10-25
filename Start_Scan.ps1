# This script is written by jrocia for checking Log4J (CVE-2021-44228).
# Modified by Kevin Chia for scanning multiple URLs with AppScan Standard by reading URL in text file and excute scan in sequence. 
# Requirements:
# - AppScan Standard version 10.0.6 build 28111
#
# How to run:
# 1 - Add all web sites to be checked in URLs.txt file. One by line.
# 2 - Open a PowerShell terminal
# 3 - Open directory where is located Start_Scan.ps1
# 4 - Run .\Start_Scan.ps1

$counter = 0
$randomNumber=$(Get-Random)

# Get AppScan Standard Install folder
$appscanDir=(Get-CimInstance -ClassName Win32_Product | Where-Object Name -like "*AppScan Standard*").InstallLocation

# Check last Result_Analysis.log file. If exist rename, if not create.
if (Test-Path Result_Analysis.txt){
	write-host "Backing up old scan result log file."
	ren Result_Analysis.txt Result_Analysis_$randomNumber.txt
}else{
	write-host "Creating scan result log file."
	New-Item -Path Result_Analysis.txt -ItemType File
}

# Backup scan and report folder.
if((Get-ChildItem scan -force | Select-Object -First 1 | Measure-Object).Count -eq 0)
{
   write-host "Scan folder is empty"
}
else {
	write-host "Backing up old Scan folder"
	Rename-Item -Path "scan" -NewName scan$randomNumber
	New-Item -Path 'scan' -ItemType Directory
	
}

if((Get-ChildItem report -force | Select-Object -First 1 | Measure-Object).Count -eq 0)
{
   write-host "Report folder is empty"
}
else {
	write-host "Backing up old Report folder"
	Rename-Item -Path "report" -NewName report$randomNumber
	New-Item -Path 'report' -ItemType Directory
	
}

#Clean scan and report folder.
#del scan\*.scan
#del report\*.xml

# Get each line in URLs.txt file, run AppScan, generate scan file in scan folder, generate xml file in report folder, read xml result and write in result_Analysis.txt.
#Full Command List https://help.hcltechsw.com/appscan/Standard/10.0.8/r_Commands001.html
Get-Content .\URLs.txt | ForEach-Object {
	$(++$counter)
	#Create Detailed Report PDF
	#/v Include progress lines in the output.
	#/sl Display the scan log during the scan.
	& $appscanDir\AppScanCMD.exe /su $_ /pf policy\scan.policy /d scan\$counter.scan /rtm DetailedReport /report_type pdf /rf report\$counter /v
	#Create Second Report (XML Report)
	& $appscanDir\AppScanCMD.exe report /b scan\$counter.scan /rt xml_report  /rf report\$counter.xml
	Select-Xml -path report\$counter.xml "//starting-url" | ForEach-Object { $_.Node.InnerXML }  >> Result_Analysis.txt
	$log4jVuln = Select-Xml -path report\$counter.xml "//num-issues-found" | ForEach-Object { $_.Node.InnerXML }  
	$string1 = "Found "
	$string2 = " vulnerability." 
	$string1+$log4jVuln+$string2 >> Result_Analysis.txt
	$string3 = "For more details check "
	$string4 = ".scan in scan folder."
	$string3+$counter+$string4 >> Result_Analysis.txt
	echo "" >> Result_Analysis.txt
}

# Finish scans.
echo "Scan finished." >> Result_Analysis.txt
write-host "Scan finished." >> Result_Analysis.txt