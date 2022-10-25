# Scanning multiple URLs with AppScan Standard in sequence. 
This script is written by jrocia for checking Log4J (CVE-2021-44228).
Modified by Kevin Chia for scanning multiple URLs with AppScan Standard by reading URL in text file and excute scan in sequence. 

This Powershell script run AppScan Standard scans against a list of web sites (URLs.txt) and scan the URLs in sequence.

Structure of project:<br>
Policy - You can export the policy settings from AppScan Standard, name the current active policy as scan.policy.
Report - XML and PDF reports will be saved here. If you wish to generate report in different language, please change your AppScan GUI language first.
Scan - the Scan file will be saved here.
Start_Scan.ps - Main Script.
URLs - URLs to be scaned.

If you wish to edit scanning properties, edit Line 61.
If you wish to export other kinds of report, edit Line 63.

# How to excute the powershell script
1.Open Windows PowerShell
2.Go to the script location
```
cd "C:\Users\username\Desktop\AppScanSTD_scan_by_sequence"
```
3. Run Script
```
.\Start_Scan.ps1
```