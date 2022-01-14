# This script run scans against a list of web sites (URLs.txt) checking for Log4J (CVE-2021-44228) vulnerability and generate a log file summary (Log4J_Result_Analysis.txt). You can run as many times as you want, it renames Log4J_Result_Analysis.txt and delete the content in report (.xml file) and scan (.scan file) folders.
#
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

# Check last Log4J_Result_Analysis.log file. If exist rename, if not create.
if (Test-Path Log4J_Result_Analysis.txt){
	write-host "Backing up old scan result log file."
	ren Log4J_Result_Analysis.txt Log4J_Result_Analysis_$randomNumber.txt
}else{
	write-host "Creating scan result log file."
	New-Item -Path Log4J_Result_Analysis.txt -ItemType File
}

# Clean scan and report folder.
del scan\*.scan
del report\*.xml

# Get each line in URLs.txt file, run AppScan, generate scan file in scan folder, generate xml file in report folder, read xml result and write in Log4J_Result_Analysis.txt.
Get-Content .\URLs.txt | ForEach-Object {
	$(++$counter)
	& $appscanDir\AppScanCMD.exe /su $_ /pf policy\Log4J.policy /d scan\$counter.scan /rt xml_report  /rf report\$counter.xml
	Select-Xml -path report\$counter.xml "//starting-url" | ForEach-Object { $_.Node.InnerXML }  >> Log4J_Result_Analysis.txt
	$log4jVuln = Select-Xml -path report\$counter.xml "//num-issues-found" | ForEach-Object { $_.Node.InnerXML }  
	$string1 = "Found "
	$string2 = " Log4J (CVE-2021-44228) vulnerability." 
	$string1+$log4jVuln+$string2 >> Log4J_Result_Analysis.txt
	$string3 = "For more details check "
	$string4 = ".scan in scan folder."
	$string3+$counter+$string4 >> Log4J_Result_Analysis.txt
	echo "" >> Log4J_Result_Analysis.txt
}

# Finish scans.
echo "Scan finished." >> Log4J_Result_Analysis.txt
write-host "Scan finished." >> Log4J_Result_Analysis.txt