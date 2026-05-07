<CFAPPLICATION NAME="ContingLiabAdmin"
SESSIONTIMEOUT=#CreateTimeSpan(0,0,10,0)#
SESSIONMANAGEMENT="Yes"
SEARCHIMPLICITSCOPES="Yes">



<CFSET This_Server = #CGI.SERVER_NAME#>

<CFSET Dev_Server_Name = "lawdept1-dev.usps.gov">

<!--- Local/Dev domain detection for paths and URLs --->
<CFIF CGI.SERVER_NAME EQ "127.0.0.1" OR CGI.SERVER_NAME EQ "localhost" OR CGI.SERVER_NAME EQ Dev_Server_Name>
	<CFSET IsLocalDev = true>
	<CFSET URL_Scheme = "http://">
	<CFSET This_Server_Port = CGI.SERVER_NAME & ":" & CGI.SERVER_PORT>
	<CFSET V1_URL_Path = "/V1.0/">
<CFELSE>
	<CFSET IsLocalDev = false>
	<CFSET URL_Scheme = "https://">
	<CFSET This_Server_Port = CGI.SERVER_NAME>
	<CFSET V1_URL_Path = "/ClientService/ContingentLiabilities/V1.0/">
</CFIF>

<!---
<CFSET CFFILE_Destination_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">

<CFSET CFFILE_Uploads_Dir_Link = "../Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">
--->


<!---
<CFSET CFFILE_RFS_Destination_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\RequestForSubmissions\">

<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://lawdept1.usps.gov/ClientService/ContingentLiabilities/RequestForSubmissions/">
--->



<!---
<CFSET CFFILE_RFS_Destination_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\RequestForSubmissions\">
--->

<CFIF IsLocalDev>
	<CFSET CFFILE_RFS_Destination_Dir = GetDirectoryFromPath(GetBaseTemplatePath()) & "RequestForSubmissions\">
<CFELSE>
	<CFSET CFFILE_RFS_Destination_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\RequestForSubmissions\">
</CFIF>



<!---
<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://eagnmntwe1860:7443/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">
--->

<CFIF IsLocalDev>
	<CFSET CFFILE_RFS_Uploads_Dir_Link = "#URL_Scheme##This_Server_Port#/contingliabadmin/RequestForSubmissions/">
<CFELSE>
	<CFSET CFFILE_RFS_Uploads_Dir_Link = "https://#This_Server#/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">
</CFIF>





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

	<CFSET This_Server = This_Server_Port>

</cfif>




<CFIF IsLocalDev>
	<CFSET CFMAIL_Dir_Link = "#URL_Scheme##This_Server#/contingliabadmin/RequestForSubmissions/">
<CFELSE>
	<CFSET CFMAIL_Dir_Link = "https://#This_Server#/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/RequestForSubmissions/">
</CFIF>

