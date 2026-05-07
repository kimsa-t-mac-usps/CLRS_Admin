<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department Contingent Liabilities: Load Records for Next Report</title>

<style>

body {font-family:arial,sans-serif; font-size:10pt}

</style>

</head>



<!---
<CFQUERY NAME="Get_PrevReportDate" DATASOURCE="ContLiab">

SELECT MAX(DATE_REPORT) AS DATE_REPORT_PREV

FROM CONTINGENT_LIAB_REPORT

</cfquery>
--->


<CFINCLUDE TEMPLATE="Query.Get_PrevReportDate.cfm">


<CFSET PrevReportDate = DateFormat(Get_PrevReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")>

<CFSET NextReportDate = Form.ReportDate>




<body>

<h2>
<small><small><small>U.S. Postal Service Law Department
<br>
<a href="Admin.cfm">System Administrator Functions</a>
</small></small></small>
<br>

<CFOUTPUT>
Load Records for Next Report
<br>
(Report Date: #DateFormat(NextReportDate, "mm/dd/yyyy")#)
</CFOUTPUT>

</h2>


Loading on:

<CFSET displayEasternTime = DateAdd("h", 1, now())>


<CFOUTPUT>
#DateFormat(now(), "mm/dd/yyyy")#, #TimeFormat(displayEasternTime, "HH:mm:ss")# Eastern
</CFOUTPUT>

<div style="background:maroon; color:white; font-size:12pt; font-weight:bold; margin-top:25pt; margin-bottom:20pt">
Please print this page (as PDF) for your records when the loading is complete.
</div>

<!---
SELECT with CASE_TYPE < 10 excludes Removed Cases:
--->


<!---
<CFQUERY NAME="CONTINGENT_LIAB_REPORT_GetRecords_All" DATASOURCE="ContLiab">

SELECT *

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
AND CASE_TYPE < 10


AND DELETED_FLAG IS NULL


ORDER BY CASE_NAME, CASE_NUMBER

</cfquery>
--->


<CFINCLUDE TEMPLATE="Query.CONTINGENT_LIAB_REPORT_GetRecords_All.cfm">



<CFOUTPUT>
<br style="height:20pt">
<b>Case Records to be loaded = #CONTINGENT_LIAB_REPORT_GetRecords_All.RecordCount#</b>
<p>
</CFOUTPUT>


<CFLOOP QUERY="CONTINGENT_LIAB_REPORT_GetRecords_All">


<br style="height:15pt">
<CFOUTPUT>
<b>Record #CONTINGENT_LIAB_REPORT_GetRecords_All.CurrentRow#</b>:

#CASE_NAME#, Case No. #CASE_NUMBER#

<br>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="CONTINGENT_LIAB_REPORT_Insert.cfm">


<CFOUTPUT>

<b>Record #CONTINGENT_LIAB_REPORT_GetRecords_All.CurrentRow#</b> loaded
<p>

</cfoutput>


</cfloop>


<!---

<script language="javascript">
location.href = "Admin.cfm";
</script>

--->


</body>
</html>

