# Scanning multiple URLs with AppScan Standard in sequence. 
This script is written by jrocia for checking Log4J (CVE-2021-44228).<br>
Modified by Kevin Chia for scanning multiple URLs with AppScan Standard by reading URL in text file and excute scan in sequence. <br>
<br>
This Powershell script run AppScan Standard scans against a list of web sites (URLs.txt) and scan the URLs in sequence.<br>

Structure of project:<br>
Policy - You can export the policy settings from AppScan Standard, name the current active policy as scan.policy.<br>
Report - XML and PDF reports will be saved here. If you wish to generate report in different language, please change your AppScan GUI language first.<br>
Scan - the Scan file will be saved here.<br>
Start_Scan.ps - Main Script.<br>
URLs - URLs to be scaned.<br>
<br>
If you wish to edit scanning properties, edit Line 61.<br>
If you wish to export other kinds of report, edit Line 63.<br>
<br>

# How to excute the powershell script
1.Open Windows PowerShell<br>
2.Go to the script location<br>
```
cd "C:\Users\username\Desktop\AppScanSTD_scan_by_sequence"
```
3. Run Script<br>
```
.\Start_Scan.ps1
```