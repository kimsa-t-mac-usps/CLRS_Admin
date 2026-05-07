<cfinclude template="MfaCookieCheck.cfm">
<CFQUERY NAME="Get_Bus_Serv_Contact" DATASOURCE="ContLiab">
SELECT Trim(a.LASTNAME) AS Trim_LASTNAME,
Trim(a.FIRSTNAME) AS Trim_FIRSTNAME,
Trim(a.TITLE) AS Trim_TITLE,
Trim(a.OFFICE) AS Trim_OFFICE,
Trim(a.VOICE) AS Trim_VOICE,
b.EMPLOYEE_ID

FROM lawdepartment a, 
ldextra b,
BUSINESSSERVUSERS c

WHERE a.PRIMARYKEY = b.PRIMARYKEY

AND
(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

<!---
AND a.LASTNAME LIKE 'Valentin%'
AND a.FIRSTNAME LIKE 'Maria%'
--->

<!---
AND a.LASTNAME LIKE 'Whitehead%'
AND a.FIRSTNAME LIKE 'Nia%'
--->

AND
b.AD_USERID = c.AD_USERID

AND
c.SURNAME = 'Contingent Liabilities Contact'


</cfquery>


<CFQUERY NAME="Get_Bus_Serv_Mgr" DATASOURCE="ContLiab">
SELECT Trim(a.LASTNAME) AS Trim_LASTNAME, Trim(a.FIRSTNAME) AS Trim_FIRSTNAME, Trim(a.TITLE) AS Trim_TITLE, Trim(a.VOICE) AS Trim_VOICE
FROM lawdepartment a, ldextra b
WHERE a.PRIMARYKEY = b.PRIMARYKEY
AND
(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

AND a.TITLE LIKE 'Manager, Integration and Support%'

</cfquery>

