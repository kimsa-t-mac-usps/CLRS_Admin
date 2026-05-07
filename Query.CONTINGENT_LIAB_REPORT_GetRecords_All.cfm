<cfinclude template="MfaCookieCheck.cfm">


<!--- 6/22/10 Added copy for Status Code 15 (Reassessed; No Longer Meets Threshold) --->

<CFQUERY NAME="CONTINGENT_LIAB_REPORT_GetRecords_All" DATASOURCE="ContLiab">

SELECT *

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
AND
(

<!---
CASE_TYPE < 10 excludes Removed Cases:
--->

CASE_TYPE < 10
OR

<!--- Crx 8/27/10:
CASE_TYPE = 15
--->

<!--- STATUS_CODE = 15: [Removed] Reassessed; No Longer Meets Threshold --->

STATUS_CODE = 15

)

AND DELETED_FLAG IS NULL


<!---
AND
CASE_NAME LIKE 'Z%'
--->



ORDER BY upper(CASE_NAME), CASE_NUMBER

</cfquery>

