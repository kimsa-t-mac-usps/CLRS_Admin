<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department Contingent Liabilities: Load Records for Next Report</title>

<!---
NOTE: When changing DB schema, adding or deleting DB table fields, must also change INSERT query in CONTINGENT_LIAB_REPORT_Insert.cfm.
--->

<!---
5/16/14: Reworked record loading report in order to send e-mail with same report
--->

<style>

body {font-family:arial,sans-serif; font-size:10pt}

</style>

</head>




<CFINCLUDE TEMPLATE="Query.Get_PrevReportDate.cfm">


<CFSET PrevReportDate = DateFormat(Get_PrevReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")>

<!--- Get Prev Quarter date where Prev Report was EOY (Report Date Oct (10) or Nov (11)):
--->
<CFIF DatePart("m", PrevReportDate) EQ 10 OR DatePart("m", PrevReportDate) EQ 11>

<CFQUERY NAME="Get_PrevQuarterReportDate" DATASOURCE="ContLiab">
SELECT MAX(DATE_REPORT) AS DATE_REPORT_PREV
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT < to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
</cfquery>


<CFSET PrevReportDate_QRpt = DateFormat(Get_PrevQuarterReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")>

<CFELSE>

<CFSET PrevReportDate_QRpt = PrevReportDate>

</cfif>



<CFSET PrevReportDate_PlusQ = DateAdd("q", 1, PrevReportDate_QRpt)>


<CFSET PrevReportDate_PlusQPlusM = DateAdd("m", 1, PrevReportDate_PlusQ)>

<CFSET PrevReportDate_PlusQPlusMDay1 = DatePart("m", PrevReportDate_PlusQPlusM) & "/1/" & DatePart("yyyy", PrevReportDate_PlusQPlusM)>

<CFSET NextReportDate = DateAdd("d", -1, PrevReportDate_PlusQPlusMDay1)>


<CFSET LoadRptText = "">

<CFSET LoadRptText = LoadRptText & "<body>">

<CFSET LoadRptText = LoadRptText & "<h2>">
<CFSET LoadRptText = LoadRptText & "<small><small><small>U.S. Postal Service Law Department">
<CFSET LoadRptText = LoadRptText & "<br>">
<CFSET LoadRptText = LoadRptText & "<a href=""https://#This_Server#/Inhouse/ContingLiabAdmin/Admin.full.cfm"">System Administrator Functions</a>">
<CFSET LoadRptText = LoadRptText & "</small></small></small>">
<CFSET LoadRptText = LoadRptText & "<br>">

<CFSET LoadRptText = LoadRptText & "Load Records for Next Report">
<CFSET LoadRptText = LoadRptText & "<br>">


<CFSET LoadRptText = LoadRptText & "(Report Date: " & DateFormat(NextReportDate, "mm/dd/yyyy") & ")">


<CFSET LoadRptText = LoadRptText & "</h2>">


<CFSET displayEasternTime = DateAdd("h", 1, now())>


<CFSET LoadRptText = LoadRptText & "Loading on: " & DateFormat(now(), "mm/dd/yyyy") & ", " & TimeFormat(displayEasternTime, "HH:mm:ss") & " Eastern">


<CFINCLUDE TEMPLATE="Query.CONTINGENT_LIAB_REPORT_GetRecords_All.cfm">


<CFSET LoadRptText = LoadRptText & "<br style=""height:20pt"">">
<CFSET LoadRptText = LoadRptText & "<b>Case Records to be loaded = " & CONTINGENT_LIAB_REPORT_GetRecords_All.RecordCount & "</b>">
<CFSET LoadRptText = LoadRptText & "<p>">


<CFLOOP QUERY="CONTINGENT_LIAB_REPORT_GetRecords_All">

	<CFSET LoadRptText = LoadRptText & "<br style=""height:15pt"">">
	<CFSET LoadRptText = LoadRptText & "<b>Record " & CONTINGENT_LIAB_REPORT_GetRecords_All.CurrentRow & "</b>: " & CASE_NAME & ", Case No. " & CASE_NUMBER>
	<CFSET LoadRptText = LoadRptText & "<br>">


	<CFINCLUDE TEMPLATE="CONTINGENT_LIAB_REPORT_Insert.cfm">


	<CFSET LoadRptText = LoadRptText & "<b>Record " & CONTINGENT_LIAB_REPORT_GetRecords_All.CurrentRow & "</b> loaded">
	<CFSET LoadRptText = LoadRptText & "<p>">

</cfloop>



<CFOUTPUT>
#LoadRptText#
</cfoutput>




<CFINCLUDE TEMPLATE="Get_Bus_Serv_Contact.cfm">

<!---
<CFSET This_EE_From_Line = "robert.p.sindermann@usps.gov">
--->



<CFMAIL
    FROM='#This_EE_From_Line#'
    TO="#This_EE_From_Line#"
    BCC="gccontliab@usps.gov"
    SUBJECT="Contingent Liabilities Records Loaded for Report Date: #DateFormat(NextReportDate, 'mm/dd/yyyy')#"
	TYPE="HTML">

<CFMAILPARAM NAME="Importance" VALUE="High">

<div style="font-family:arial; font-size:10pt">

<CFOUTPUT>
#LoadRptText#
</cfoutput>

</div>

</cfmail>



</body>
</html>

