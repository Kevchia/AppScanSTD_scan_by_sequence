# Search log4J vuln using AppScan Standard and a list of websites
This Powershell script run AppScan Standard scans against a list of web sites (URLs.txt) checking just for Log4J (CVE-2021-44228) vulnerability.

Structure of project:<br>
![image](https://user-images.githubusercontent.com/69405400/149555665-a4659326-b3a2-491b-b7d7-30c52769071f.png)

After run the script, it will read each line in URLs.txt and start scanning for Log4J (CVE-2021-44228) vulnerability.<br>
![image](https://user-images.githubusercontent.com/69405400/149555808-75893e5e-9ef1-48cf-8321-c6386ecbfa04.png)

After finish each scan write in Log4J_Result_Analysis.txt the result.<br>
![image](https://user-images.githubusercontent.com/69405400/149556423-135ce165-b636-4586-a594-71c2454aff12.png)
