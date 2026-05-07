<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department Contingent Liabilities: Case Records List for Current Quarter</title>

<!---
NOTE: When changing DB schema, adding or deleting DB table fields, must also change INSERT query in CONTINGENT_LIAB_REPORT_Insert.cfm.
--->


<style>

body {font-family:arial,sans-serif; font-size:10pt}

</style>

</head>




<CFQUERY NAME="Get_CurrentReportDate" DATASOURCE="ContLiab">

SELECT MAX(DATE_REPORT) AS DATE_REPORT_CURRENT

FROM CONTINGENT_LIAB_REPORT

</cfquery>



<CFSET CurrentReportDate = DateFormat(Get_CurrentReportDate.DATE_REPORT_CURRENT, "mm/dd/yyyy")>


<body>

<h2>
<small><small><small>U.S. Postal Service Law Department
<br>
<a href="Admin.cfm">System Administrator Functions</a>
</small></small></small>
<br>

<CFOUTPUT>
Case Records List for Current Quarter
<br>
(Report Date: #DateFormat(CurrentReportDate, "mm/dd/yyyy")#)
</CFOUTPUT>

</h2>



<CFQUERY NAME="Current_CONTINGENT_LIAB_REPORT_GetRecords_All" DATASOURCE="ContLiab">

SELECT *

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT = to_date('#DateFormat(CurrentReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

AND 
DELETED_FLAG IS NULL

ORDER BY upper(CASE_NAME), CASE_NUMBER

</cfquery>



<CFOUTPUT>

<br style="height:20pt">
<b>#Current_CONTINGENT_LIAB_REPORT_GetRecords_All.RecordCount# Case Records listed</b>

</CFOUTPUT>


<div style="font-style:italic; font-size:9pt; margin-top:5pt; margin-bottom:20pt">

List generated on:

<CFSET displayEasternTime = DateAdd("h", 1, now())>

<CFOUTPUT>
#DateFormat(now(), "mm/dd/yyyy")#, #TimeFormat(displayEasternTime, "HH:mm:ss tt")# Eastern
</CFOUTPUT>

</div>




<CFLOOP QUERY="Current_CONTINGENT_LIAB_REPORT_GetRecords_All">

<p style="margin-top:15pt">

<CFOUTPUT>

<b>#Current_CONTINGENT_LIAB_REPORT_GetRecords_All.CurrentRow#</b>.
#CASE_NAME#, Case No. #CASE_NUMBER#

</CFOUTPUT>


</cfloop>


</body>
</html>

