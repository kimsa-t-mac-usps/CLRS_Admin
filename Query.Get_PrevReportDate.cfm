<cfinclude template="MfaCookieCheck.cfm">
<CFQUERY NAME="Get_PrevReportDate" DATASOURCE="ContLiab">

SELECT MAX(DATE_REPORT) AS DATE_REPORT_PREV

FROM CONTINGENT_LIAB_REPORT

</cfquery>

