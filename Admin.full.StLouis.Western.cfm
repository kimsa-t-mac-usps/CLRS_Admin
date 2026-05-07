<cfinclude template="MfaCookieCheck.cfm">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Law Department Contingent Liabilities: System Admin</title>

<!---
Style for "strong" necessary for marking Updated Text as bold and red with single-word tag, to avoid having to adjust word count (list length) to account for multi-word tag like "<span style= . . .". <strong> is inserted at StartCrx and EndCrx, start and end of each segment of updated text.
--->


<style>
/*
body {font-family:arial,sans-serif;font-size:10pt; background:khaki}
*/

body {font-family:arial,sans-serif; font-size:10pt; background:FFFFCC}

h3.SectionHead {page-break-before:always}
h4.SectionHead {page-break-before:always}
h5.SectionHead {page-break-before:always}



strong {color:red}

td {font-family:arial,sans-serif;font-size:10pt; vertical-align:top}
textarea {font-family:arial,sans-serif;font-size:10pt}
th {font-family:arial,sans-serif;font-size:10pt; font-weight:bold; width:30%; align:right}

A:hover {background:black; color:white; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}
A:active {background:yellow; color:black; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}

</style>

<script language="JavaScript" src="calendar5.js"></script>


<script language="JavaScript">

function checkDeadlineDate(thisForm) {


if (thisForm.name.substring(0,4) == "EAJA") deadlineLabel = "EAJA cases."
else deadlineLabel = "Contingent Liabilities report."


/*
deadlineLabel = "Contingent Liabilities report."
*/

if (thisForm.Deadline.value == "" || thisForm.Deadline.value == "[Enter date]") {
	alert("Please enter Deadline for Responses for " + deadlineLabel);
/*
	thisForm.Deadline.style.background = "maroon";
	thisForm.Deadline.style.color = "white";
	thisForm.Deadline.style.fontWeight = "bold";
*/
	thisForm.Deadline.value = "";
	thisForm.Deadline.focus();
	return false;
}

else thisForm.submit();

}

</script>

<!--- Maria Montalvo:
<cfset RespondingUser_Id = "F567M0">
--->



<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>








</head>

<CFSET EndOfYearFlag = "">

<CFQUERY NAME="Check_Auth_User_A" DATASOURCE="ContLiab">

SELECT USERPRMKEY
FROM BUSINESSSERVUSERS
WHERE CONTINGENT_LIAB_AUTH = 'A'
AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))

</cfquery>


<CFIF Check_Auth_User_A.RecordCount NEQ 1>

<script language="javascript">
location.href = "NotAuthorized.cfm"
</script>

</cfif>



<CFQUERY NAME="CONTINGENT_LIAB_GetLatestUpdate_Date" DATASOURCE="ContLiab">
SELECT MAX(DATE_LAST_UPDATE) AS DATE_LAST_UPDATE_LATEST
FROM CONTINGENT_LIAB_REPORT
</cfquery>

<CFQUERY NAME="Get_Latest_Update" DATASOURCE="ContLiab">
SELECT PRIMARYKEY, CASE_NAME, DATE_LAST_UPDATE
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_LAST_UPDATE >= to_date('#DateFormat(CONTINGENT_LIAB_GetLatestUpdate_Date.DATE_LAST_UPDATE_LATEST, "mm/dd/yyyy")#', 'mm/dd/yyyy')
ORDER BY PRIMARYKEY DESC
</cfquery>




<CFQUERY NAME="EeList" DATASOURCE="ContLiab">
SELECT a.PRIMARYKEY, trim(a.LASTNAME)||', '||trim(a.FIRSTNAME) FULL_NAME
FROM lawdepartment a, LDEXTRA b
WHERE a.PRIMARYKEY = b.PRIMARYKEY
AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')
AND b.AD_USERID IS NOT NULL
AND b.EENAME NOT LIKE 'Test User%'
ORDER BY FULL_NAME
</cfquery>

<CFQUERY NAME="Get_LatestReportDate" DATASOURCE="ContLiab">
SELECT MAX(DATE_REPORT) AS DATE_REPORT_LATEST
FROM CONTINGENT_LIAB_REPORT
</cfquery>


<CFSET LatestReportDate = DateFormat(Get_LatestReportDate.DATE_REPORT_LATEST, "mm/dd/yyyy")>
<CFSET LatestReportDate_CalYear = DatePart("yyyy", LatestReportDate)>

<CFIF LatestReportDate GT "10/1/#LatestReportDate_CalYear#" AND LatestReportDate LT "12/1/#LatestReportDate_CalYear#">
	<!--- For End of Year report: --->
	<CFSET EndOfYearFlag = "EOY">
	<CFSET ThisRptDate = LatestReportDate>

<CFQUERY NAME="Get_PrevLatestReportDate" DATASOURCE="ContLiab">
SELECT MAX(DATE_REPORT) AS DATE_REPORT_PREV
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT < to_date('#DateFormat(Get_LatestReportDate.DATE_REPORT_LATEST, "mm/dd/yyyy")#', 'mm/dd/yyyy')
</cfquery>

<!---
<CFOUTPUT>
PrevRptDate = #DateFormat(Get_PrevLatestReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")#
</cfoutput>
--->

<CFSET LatestReportDate = DateFormat(Get_PrevLatestReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")>

</cfif>

<!---
<CFOUTPUT>
LatestReportDate = #DateFormat(LatestReportDate, "mm/dd/yyyy")#
<p>
</cfoutput>
--->

<CFSET LatestReportDate_PlusQ = DateAdd("q", 1, LatestReportDate)>

<CFSET LatestReportDate_PlusQPlusM = DateAdd("m", 1, LatestReportDate_PlusQ)>

<CFSET LatestReportDate_PlusQPlusMDay1 = DatePart("m", LatestReportDate_PlusQPlusM) & "/1/" & DatePart("yyyy", LatestReportDate_PlusQPlusM)>

<CFSET NextReportDate = DateAdd("d", -1, LatestReportDate_PlusQPlusMDay1)>


<!---
Check for records for LatestReportDate:
--->

<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_LatestReportDate" DATASOURCE="ContLiab">

SELECT CASE_REC_ID_SEQUENCE

FROM CONTINGENT_LIAB_REPORT

WHERE

DATE_REPORT = to_date('#DateFormat(LatestReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

</cfquery>

<!---
Check for records for NextReportDate:
--->

<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_NextReportDate" DATASOURCE="ContLiab">

SELECT CASE_REC_ID_SEQUENCE

FROM CONTINGENT_LIAB_REPORT

WHERE

DATE_REPORT = to_date('#DateFormat(NextReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

</cfquery>


<body id="DocBody">


<h2>
<small><small><small>U.S. Postal Service Law Department
<br>
<a href="/InHouse/ContingentLiabilities/Report.cfm" target="_blank">Contingent Liabilities and Receivables</a>
</small></small></small>
<br>
System Administrator Functions
</h2>



<div style="background:bfdfff; height:30pt; font-family:arial; font-size:9pt; padding:2pt">


<iframe id="ThisIFrame" src="/ClientService/LitigationHold/setTestUser.cfm" width="70%" height="30pt" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" style="padding:3pt">
</iframe>

</div>

<div style="border:thin solid bfdfff; padding:10pt; padding-bottom:20pt; margin-bottom:10pt">

<p style="margin-top:10pt">

<li><a href="Admin.UpdAuthUser.cfm"><b>Update User Access List</b></a>


<CFQUERY NAME="Check_CONTINGENT_LIAB_BLOCK_NEW" DATASOURCE="ContLiab">

SELECT CONTINGENT_LIAB_BLOCK_NEW

FROM BUSINESSSERVUSERS

WHERE USERPRMKEY = 13

AND
CONTINGENT_LIAB_BLOCK_NEW IS NOT NULL

</cfquery>



<CFIF Check_CONTINGENT_LIAB_BLOCK_NEW.RecordCount EQ 1
AND
Check_CONTINGENT_LIAB_BLOCK_NEW.CONTINGENT_LIAB_BLOCK_NEW EQ "Y">

	<CFSET BlockedNote = "<b>Blocked</b>">
	<CFSET BlockedWord = "Un-Block">
	<CFSET BlockedParm = "UnBlock">

<CFELSE>

	<CFSET BlockedNote = "<b>Not Blocked</b>">
	<CFSET BlockedWord = "Block">
	<CFSET BlockedParm = "Block">

</CFIF>


<p style="margin-top:15pt">

<CFOUTPUT>
<li><a href="Admin.BlockNewCases.cfm?Block=#BlockedParm#"><b>#BlockedWord# New Cases</b></a>
</CFOUTPUT>

<span style="margin-left:5pt; font-family:Verdana, Arial, Helvetica, sans-serif; font-style:italic">

[Currently: New Cases

<CFOUTPUT>
#BlockedNote#]
</CFOUTPUT>

</span>


</div>


<CFIF Get_Latest_Update.RecordCount GT 0>

<div style="font-family:verdana; font-style:italic">

<CFSET displayDATE_LAST_UPDATE = DateAdd("h", 1, Get_Latest_Update.DATE_LAST_UPDATE)>

Most recent update:

<CFOUTPUT>
<a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/Report.cfm###Get_Latest_Update.PRIMARYKEY#" target="_blank">#Get_Latest_Update.CASE_NAME#</a>

<span style="font-size:8pt">
[#DateFormat(displayDATE_LAST_UPDATE, "m/d/yy")#, #LCase(LSTimeFormat(displayDATE_LAST_UPDATE, 'h:mm tt'))# Eastern]
</span>

</CFOUTPUT>

</div>

</cfif>


<p>
<div style="border:thin solid orange; padding:5pt; margin-bottom:10pt">
<!---
For Current Report:
--->




<CFIF EndOfYearFlag EQ "EOY">
	<!--- For End of Year report: --->
	<CFSET LatestReportDate_FY = LatestReportDate_CalYear>
<CFELSEIF LatestReportDate LT "10/1/#LatestReportDate_CalYear#">
	<CFSET LatestReportDate_FY = LatestReportDate_CalYear>
<CFELSE>
	<CFSET LatestReportDate_FY = LatestReportDate_CalYear + 1>
</cfif>

<!---
<CFIF EndOfYearFlag NEQ "EOY">
--->
<CFSET LatestReportDate_CalQuarter = DatePart("q", LatestReportDate)>

<CFSET LatestReportDate_CalQuarter_Num = LSParseNumber(LatestReportDate_CalQuarter)>

<CFIF LatestReportDate_CalQuarter_Num EQ 4>
	<CFSET LatestReportDate_CalQuarter_Num = 0>
</cfif>

<CFSET LatestReportDate_FYQuarter = LatestReportDate_CalQuarter_Num + 1>

<CFSWITCH EXPRESSION="#LatestReportDate_FYQuarter#">

<CFCASE VALUE="1">
	<CFSET LatestReportDate_FYQuarter_Roman = "I">
</cfcase>

<CFCASE VALUE="2">
	<CFSET LatestReportDate_FYQuarter_Roman = "II">
</cfcase>

<CFCASE VALUE="3">
	<CFSET LatestReportDate_FYQuarter_Roman = "III">
</cfcase>

<CFCASE VALUE="4">
	<CFSET LatestReportDate_FYQuarter_Roman = "IV">
</cfcase>

</cfswitch>
<!---
</cfif>
--->


<CFSET LatestReportDate_FY_TwoDigit = Right(LatestReportDate_FY, 2)>


<CFSET Default_MAGFilePathFilename = "D:\Inetpub\wwwroot\InHouse\ContingentLiabilities\Request.for.Submissions\" &
LatestReportDate_FY_TwoDigit & "-Q" & LatestReportDate_FYQuarter & " Request for Submissions - Complete Package.pdf">

<CFSET Default_MAGFilename = LatestReportDate_FY_TwoDigit & "-Q" & LatestReportDate_FYQuarter & " Request for Submissions - Complete Package.pdf">


<!---
<CFIF NOT FileExists(Default_MAGFilePathFilename)>

<script language="javascript">

alert("Filename for Mary Anne Gibbons's Request Package does not exist." + "\r\n \r\n" + "Please verify filename and make sure file is saved in the specified Folder.");

</script>

</cfif>
--->



<CFINCLUDE TEMPLATE="Get_Bus_Serv_Contact.cfm">


<CFIF EndOfYearFlag NEQ "EOY">

<big><b>For Current Quarterly Report:</b></big>

<CFOUTPUT>
<b>FY #LatestReportDate_FY#, Quarter #LatestReportDate_FYQuarter_Roman#</b>
</cfoutput>


<p>

<ol>

<CFIF CONTINGENT_LIAB_GetRecord_LatestReportDate.RecordCount EQ 0>
<li><a href="LoadRecords.NextQuarter.cfm"><b>Load Case Records</b></a>
<CFELSE>
<li><b style="color:gray">[Case Records Already Loaded]</b>
</cfif>

<p>
<li><b>E-mail Notice to All Offices</b></a>
<p>
<ol type="a">

<CFIF LatestReportDate_FYQuarter_Roman EQ "IV">
<!---
	<CFSET DefaultRespDeadline = "10/13/2006">
--->

	<CFSET DefaultRespDeadline = "[Enter date]">

<CFELSE>

	<CFSET DefaultRespDeadline = DateAdd("d", -11, LatestReportDate)>

   	<CFSET DefaultRespDeadline = DateFormat(DefaultRespDeadline, 'mm/dd/yyyy')>

</cfif>


<form name="SendEmailForm_Latest" METHOD="POST" action="SendReportForUpdate.StLouis.Western.cfm">

<input type="hidden" name="Sender" value="">

<CFOUTPUT>
<input type="hidden" name="ReportDate" value="#DateFormat(LatestReportDate, 'mm/dd/yyyy')#">
</cfoutput>

<li><b>Deadline</b> for Responses:

<CFOUTPUT>
<input type="text" name="Deadline" size="10" maxlength="10"

<CFIF DefaultRespDeadline EQ "[Enter date]">
	style="width:60pt; height:14pt; background:maroon; color:white; font-weight:bold" onClick="this.value = ''" value="#DefaultRespDeadline#">
<CFELSE>
	style="width:60pt; height:14pt" value="#DateFormat(DefaultRespDeadline, 'mm/dd/yyyy')#">
</cfif>


</cfoutput>

<img src="cal.gif" alt="Display Calendar" onClick="SendEmailForm_Latest.Deadline.value = ''; javascript:cal1.popup();">

<small><i>(mm/dd/yyyy)</i></small>

<p>

<li><b>Mary Anne Gibbons's</b> Request Package:
<p><ol type="1">
<li><b>Folder</b>:
<br>
<CFOUTPUT>
<input type="text" name="MAGRequest_FileFolder" size="60" maxlength="70" value="InHouse/ContingentLiabilities/Request.for.Submissions">
</cfoutput>

<p>



<li><b>Filename</b>:
<br>
<CFOUTPUT>
<input type="text" name="MAGRequest_FileName" size="70" maxlength="80"

<CFIF NOT FileExists(Default_MAGFilePathFilename)>
style="color:maroon; font-weight:bold; font-family:verdana; font-size:8pt"
</cfif>

value="#Default_MAGFilename#" onClick="getElementById('DivMAGFileWarning').style.display = 'none'">
</cfoutput>

<CFIF NOT FileExists(Default_MAGFilePathFilename)>

<div id="DivMAGFileWarning" style="color:maroon; font-weight:bold; font-family:verdana; font-size:8pt; width:300pt">
NOTE: Filename above does not exist.
<br>
Before sending e-mail notices, please verify filename and make sure file is saved in the Folder specified above.
</div>

</cfif>



</ol>







<p>

<li><b>E-mail Notices</b>

&nbsp;

<i>[NOTE -- Sender on "From" line:

<CFOUTPUT>
<b>#Get_Bus_Serv_Contact.Trim_LASTNAME#, #Get_Bus_Serv_Contact.Trim_FIRSTNAME#</b>]</i>
</CFOUTPUT>


<p>


<ul>

<!---
<CFOUTPUT>
<li><a href="" onClick="SendEmailForm_Latest.Sender.value = '#RespondingUser_Id#'; SendEmailForm_Latest.submit(); return false"><b>Send Draft</b></a> <i>(messages go to Sender only)</i>
</cfoutput>
<p>
<li><a href="" onClick="SendEmailForm_Latest.Sender.value = ''; SendEmailForm_Latest.submit(); return false"><b>Send E-mail</b> Notices to All Offices</a>
--->



<CFQUERY NAME="Get_Intro_Note" DATASOURCE="ContLiab">

SELECT CONTING_LIAB_INTRO_NOTE
FROM BUSINESSSERVUSERS

WHERE USERPRMKEY = #Check_Auth_User_A.USERPRMKEY#

</cfquery>


<CFIF Get_Intro_Note.CONTING_LIAB_INTRO_NOTE NEQ "">
	<CFSET This_Intro_Note = Get_Intro_Note.CONTING_LIAB_INTRO_NOTE>
<CFELSE>
	<CFSET This_Intro_Note = "">
</cfif>





<li><b>Introductory Note</b> [added at beginning of standard message]
<br>
<textarea id="IntroNote" NAME="IntroNote" ROWS="6" COLS="75" style="font-family:arial"><CFOUTPUT>#This_Intro_Note#</CFOUTPUT></textarea>

</form>
<p>

<CFOUTPUT>
<li><a href="" onClick="SendEmailForm_Latest.Sender.value = '#RespondingUser_Id#'; checkDeadlineDate(SendEmailForm_Latest); return false"><b>Send Draft</b></a> <i>(messages go only to user clicking this link)</i>
</cfoutput>

<p>
<li><a href="" onClick="SendEmailForm_Latest.Sender.value = ''; checkDeadlineDate(SendEmailForm_Latest); return false"><b>Send E-mail Notices</b> to All Offices</a>



<!---
<p>
<li><a href="" onClick="SendEmailForm_Latest.Sender.value = ''; SendEmailForm_Latest.action = 'SendReportForUpdate.tst20070521.a.cfm'; SendEmailForm_Latest.submit(); return false"><b>Send E-mail</b> Test</a>
--->

</ul>

<CFELSE>

<div style="border:thin solid orange; padding:5pt">
<big><b>For End-of-Year Report:</b></big>
<CFOUTPUT>
[Report Date: #DateFormat(ThisRptDate, 'mm/dd/yyyy')#]
</cfoutput>


<ol>

<CFIF CONTINGENT_LIAB_GetRecord_LatestReportDate.RecordCount EQ 0>
<li><a href="LoadRecords.EOY.cfm"><b>Load Case Records</b></a>
<CFELSE>
<li><b style="color:gray">[Case Records Already Loaded]</b>
</cfif>


<p>
<li><b>E-mail Notice to All Offices</b></a>
<p>
<ol type="a">

<CFSET DefaultRespDeadline = DateAdd("d", -11, LatestReportDate)>

<form name="SendEmailForm_EOY" METHOD="POST" action="SendReportForUpdate.cfm">

<input type="hidden" name="Sender" value="">


<CFSET DefaultRespDeadline = DateAdd("d", -2, ThisRptDate)>


<CFSET DefaultRespDeadline = DateFormat(DefaultRespDeadline, 'mm/dd/yyyy')>


<CFOUTPUT>
<input type="hidden" name="ReportDate" value="#DateFormat(ThisRptDate, 'mm/dd/yyyy')#">
</cfoutput>


<!---
<img src="cal.gif" alt="Display Calendar" onClick="javascript:cal3.popup();">
<small><i>(mm/dd/yyyy)</i></small>
--->

<li><b>Deadline</b> for Responses:

<CFOUTPUT>
<input type="text" name="Deadline" size="10" maxlength="10" style="width:60pt;height:14pt" value="#DefaultRespDeadline#">
</cfoutput>

<img src="cal.gif" alt="Display Calendar" onClick="SendEmailForm_EOY.Deadline.value = ''; javascript:cal4.popup();">

<small><i>(mm/dd/yyyy)</i></small>


<CFQUERY NAME="Get_Intro_Note_EOY" DATASOURCE="ContLiab">

SELECT CONTING_LIAB_INTR_EOY
FROM BUSINESSSERVUSERS

WHERE USERPRMKEY = #Check_Auth_User_A.USERPRMKEY#

</cfquery>


<CFIF Get_Intro_Note_EOY.CONTING_LIAB_INTR_EOY NEQ "">
	<CFSET This_Intro_Note_EOY = Get_Intro_Note_EOY.CONTING_LIAB_INTR_EOY>
<CFELSE>
	<CFSET This_Intro_Note_EOY = "">
</cfif>





<li><b>E-mail Notices</b>


&nbsp;

<i>[NOTE -- Sender on "From" line:

<CFOUTPUT>
<b>#Get_Bus_Serv_Contact.Trim_LASTNAME#, #Get_Bus_Serv_Contact.Trim_FIRSTNAME#</b>]</i>
</CFOUTPUT>


<p>
<ul>


<li><b>Introductory Note</b> [added at beginning of standard message]
<br>
<textarea id="IntroNote_EOY" NAME="IntroNote_EOY" ROWS="6" COLS="75" style="font-family:arial"><CFOUTPUT>#This_Intro_Note_EOY#</CFOUTPUT></textarea>

</form>
<p>


<CFOUTPUT>
<li><a href="" onClick="SendEmailForm_EOY.Sender.value = '#RespondingUser_Id#'; checkDeadlineDate(SendEmailForm_EOY); return false"><b>Send Draft</b></a> <i>(messages go only to user clicking this link)</i>
</cfoutput>
<p>
<li><a href="" onClick="SendEmailForm_EOY.Sender.value = ''; SendEmailForm_EOY.submit(); return false"><b>Send E-mail Notices</b> to All Offices</a>




</ul>

</ol>


</ol>


</div>


</cfif>

</ol>


</ol>
</div>


<div style="border:thin solid #6495ed; padding:5pt; margin-bottom:10pt">

<big><b>EAJA Cases For Current Quarter:</b></big>

<CFOUTPUT>
<b>FY #LatestReportDate_FY#, Quarter #LatestReportDate_FYQuarter_Roman#</b>
</cfoutput>


<form name="EAJA_SendEmailForm_Latest" METHOD="POST" action="EAJA.SendForUpdate.cfm">

<input type="hidden" name="Sender" value="">

<CFOUTPUT>
<input type="hidden" name="ReportDate" value="#DateFormat(LatestReportDate, 'mm/dd/yyyy')#">
</cfoutput>

<li><b>Deadline</b> for Responses:

<CFOUTPUT>
<!---
<input type="text" name="EAJADeadline" size="10" maxlength="10" style="width:60pt;height:14pt" value="#DateFormat(DefaultRespDeadline, 'mm/dd/yyyy')#">
--->

<input type="text" name="Deadline" size="10" maxlength="10" style="width:60pt;height:14pt"

<CFIF DefaultRespDeadline EQ "[Enter date]">
	style="width:60pt; height:14pt; background:maroon; color:white; font-weight:bold" onClick="this.value = ''"
<CFELSE>
	style="width:60pt; height:14pt"
</cfif>

value="#DefaultRespDeadline#">

</cfoutput>

<img src="cal.gif" alt="Display Calendar" onClick="EAJA_SendEmailForm_Latest.Deadline.value = ''; javascript:cal2.popup();">

<small><i>(mm/dd/yyyy)</i></small>

</form>

<li><b>E-mail Notices</b>

&nbsp;

<i>[NOTE -- Sender on "From" line:

<CFOUTPUT>
<b>#Get_Bus_Serv_Contact.Trim_LASTNAME#, #Get_Bus_Serv_Contact.Trim_FIRSTNAME#</b>]</i>
</CFOUTPUT>


<p>
<ul>
<CFOUTPUT>
<li><a href="" onClick="EAJA_SendEmailForm_Latest.Sender.value = '#RespondingUser_Id#'; checkDeadlineDate(EAJA_SendEmailForm_Latest); return false"><b>Send Draft</b></a> <i>(messages go only to user clicking this link)</i>
</cfoutput>
<p>
<li><a href="" onClick="EAJA_SendEmailForm_Latest.Sender.value = ''; checkDeadlineDate(EAJA_SendEmailForm_Latest); return false"><b>Send E-mail Notices</b> to All Offices</a>

</ul>


</div>


<div style="border:thin solid green; padding:5pt; margin-bottom:10pt">
<!---
For Next Report:
--->

<CFSET NextReportDate_CalYear = DatePart("yyyy", NextReportDate)>

<CFIF NextReportDate LT "10/1/#NextReportDate_CalYear#">
	<CFSET NextReportDate_FY = NextReportDate_CalYear>
<CFELSE>
	<CFSET NextReportDate_FY = NextReportDate_CalYear + 1>
</cfif>

<CFSET NextReportDate_CalQuarter = DatePart("q", NextReportDate)>

<CFSET NextReportDate_CalQuarter_Num = LSParseNumber(NextReportDate_CalQuarter)>

<CFIF NextReportDate_CalQuarter_Num EQ 4>
	<CFSET NextReportDate_CalQuarter_Num = 0>
</cfif>

<CFSET NextReportDate_FYQuarter = NextReportDate_CalQuarter_Num + 1>

<CFSWITCH EXPRESSION="#NextReportDate_FYQuarter#">

<CFCASE VALUE="1">
	<CFSET NextReportDate_FYQuarter_Roman = "I">
</cfcase>

<CFCASE VALUE="2">
	<CFSET NextReportDate_FYQuarter_Roman = "II">
</cfcase>

<CFCASE VALUE="3">
	<CFSET NextReportDate_FYQuarter_Roman = "III">
</cfcase>

<CFCASE VALUE="4">
	<CFSET NextReportDate_FYQuarter_Roman = "IV">
</cfcase>

</cfswitch>


<CFSET NextReportDate_FY_TwoDigit = Right(NextReportDate_FY, 2)>

<!---
#ThisReportDate_FY_TwoDigit#-Q#ThisReportDate_FYQuarter# Request for Submissions - Complete Package.pdf
--->

<big><b>For Next Quarterly Report:</b></big>

<CFOUTPUT>
<b>FY #NextReportDate_FY#, Quarter #NextReportDate_FYQuarter_Roman#</b>
</cfoutput>

<p>

<ol>

<CFIF CONTINGENT_LIAB_GetRecord_NextReportDate.RecordCount EQ 0>
<li><a href="LoadRecords.NextQuarter.cfm"><b>Load Case Records</b></a>
<CFELSE>
[<li>Case Records Already Loaded]
</cfif>



</ol>
</div>

<CFIF EndOfYearFlag NEQ "EOY">

<div style="border:thin solid orange; padding:5pt">
<big><b>For End-of-Year Report:</b></big>

<form name="LoadRecordsEOY" method="post" action="LoadRecords.EOY.cfm">

<li><b>Date of Report:

<!--- Assuming Q4 date is 9/30, add 1 month, 2 days = 11/1 --->

<!---
<CFSET DefaultEOYRptDate = DateAdd("m", 1, LatestReportDate)>
<CFSET DefaultEOYRptDate = DateAdd("d", 2, DefaultEOYRptDate)>
--->

<CFOUTPUT>
<CFSET DefaultEOYRptDate = DateFormat("11/1/#LatestReportDate_CalYear#", "mm/dd/yyyy")>

<CFIF LatestReportDate GT "10/1/#LatestReportDate_CalYear#">
	<CFSET DefaultEOYRptDate = DateAdd("yyyy", 1, DefaultEOYRptDate)>
</cfif>

</cfoutput>

<CFOUTPUT>
<input type="text" name="ReportDate" size="10" maxlength="10" style="width:60pt;height:14pt" value="#DateFormat(DefaultEOYRptDate, 'mm/dd/yyyy')#">
</cfoutput>

<img src="cal.gif" alt="Display Calendar" onClick="LoadRecordsEOY.Deadline.value = ''; javascript:cal5.popup();">

<small><i>(mm/dd/yyyy)</i></small>

<ol>

<li><a href="" onClick="LoadRecordsEOY.submit(); return false"><b>Load Case Records</b></a>

</ol>

</form>

</div>

</cfif>

<p>

<script language="JavaScript">

var cal2 = new calendar5(document.EAJA_SendEmailForm_Latest.Deadline);

<CFIF EndOfYearFlag EQ "EOY">

var cal4 = new calendar5(document.SendEmailForm_EOY.Deadline);

<CFELSE>

var cal1 = new calendar5(document.SendEmailForm_Latest.Deadline);
var cal5 = new calendar5(document.LoadRecordsEOY.ReportDate);

</cfif>

</script>


</body>


</html>

