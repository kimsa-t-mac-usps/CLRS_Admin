<cfinclude template="MfaCookieCheck.cfm">
<CFAPPLICATION NAME="ContingLiab"
SESSIONTIMEOUT=#CreateTimeSpan(0,0,10,0)#
SESSIONMANAGEMENT="Yes">



<CFSET This_Server = #CGI.SERVER_NAME#>

<!---
<CFSET CFFILE_Destination_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">

<CFSET CFFILE_Uploads_Dir_Link = "../Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">
--->


<!---
<CFSET CFFILE_RFS_Destination_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\RequestForSubmissions\">

<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://lawdept1.usps.gov/ClientService/ContingentLiabilities/RequestForSubmissions/">
--->




<CFSET CFFILE_RFS_Destination_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\RequestForSubmissions\">

<!---
<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://eagnmntwe1860:7443/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">
--->

<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://#This_Server#/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">





<!--- For production, Comment out Test_Email_Addr, Test_Server, Test_Server_Folder: --->

<!---
<CFSET Test_Email_Addr = "robert.p.sindermann@usps.gov">

<!---
<CFSET Test_Server = "eagnmntwe1860:7443">

<CFSET Test_Server = CGI.SERVER_NAME & ":8182">
--->


<CFSET Test_Server = CGI.SERVER_NAME>
--->



<CFSET ThisTemplatePath = GetDirectoryFromPath(GetBaseTemplatePath())>

<CFSET ThisTemplatePath = RemoveChars(ThisTemplatePath, Len(ThisTemplatePath), 1)>




<CFSET BackslashIndex = 1>


<CFLOOP CONDITION="BackslashIndex GT 0">

	<CFSET LastBackslash = BackslashIndex>

	<CFSET BackslashIndex = Find("\", ThisTemplatePath, LastBackslash + 1)>

</cfloop>


<CFSET ThisTemplateFolder = Right(ThisTemplatePath, Len(ThisTemplatePath) - LastBackslash)>


<!---
<CFSET Test_Server_Folder = ThisTemplateFolder & "/">
--->


<CFIF IsDefined("Test_Server")>
	<CFSET This_Server = Test_Server>
<CFELSE>

<!---
	<CFSET This_Server = CGI.SERVER_NAME & ":7443">
--->	

	<CFSET This_Server = CGI.SERVER_NAME>

</cfif>




<CFSET CFMAIL_Dir_Link = "https://#This_Server#/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">


