<cfinclude template="MfaCookieCheck.cfm">

<CFSET SelectedTestUser = "">


<CFQUERY NAME="This_EeList" DATASOURCE="LitigHold">

SELECT PRIMARYKEY, Trim(LASTNAME) || ', ' || Trim(FIRSTNAME) AS FULLNAME
FROM LDDB.LAWDEPARTMENT
WHERE (SEPARATFLG != 'S' OR SEPARATFLG IS NULL OR SEPARATFLG = '0')

AND LASTNAME NOT LIKE 'Select%'

<!---
AND (title LIKE 'Attorney%'
OR title LIKE 'Chief%'
OR title LIKE 'Deputy Managing%'
OR title LIKE 'Managing%'
OR title LIKE 'Program Manager%'
OR title LIKE 'Senior Counsel%'
OR title LIKE 'Senior Litigation%')
--->

ORDER BY LASTNAME, FIRSTNAME

</CFQUERY>


<CFIF IsDefined("Form.TestUser") AND Form.TestUser NEQ "Clear">

	<CFSET SelectedTestUser = Form.TestUser>

<CFELSE>

	<cfset This_User_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>
	
	<CFQUERY NAME="Get_ThisUser_Pkey" DATASOURCE="LitigHold">
	SELECT b.PRIMARYKEY
	
	FROM LDDB.LAWDEPARTMENT a, LDDB.LDEXTRA b
	
	WHERE a.PRIMARYKEY = b.PRIMARYKEY
	
	AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')
	
	AND
	(
	UPPER(b.AD_USERID) LIKE UPPER('#This_User_Id#%')
	OR
	UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#This_User_Id#%')
	)
	</cfquery>
	
	
	<CFQUERY NAME="Get_TestUser_Pkey" DATASOURCE="LitigHold">
	SELECT TESTUSER_PKEY
	FROM LDDB.TEST_USER
	WHERE SETTINGUSER_PKEY = #Get_ThisUser_Pkey.PRIMARYKEY#
	</cfquery>
	
	<CFIF Get_TestUser_Pkey.RecordCount EQ 1>
	
		<CFIF Get_TestUser_Pkey.TESTUSER_PKEY EQ 0>
			<CFSET SelectedTestUser = Get_ThisUser_Pkey.PRIMARYKEY>
		<CFELSE>
			<CFSET SelectedTestUser = Get_TestUser_Pkey.TESTUSER_PKEY>
		</cfif>
	
	</cfif>

</cfif>


<!---
<CFOUTPUT>
SelectedTestUser = "#SelectedTestUser#"
<p>
</cfoutput>
--->


<!---
<div style="padding:3pt; height:10pt; margin-top:0pt; margin-bottom:10pt; font-family:arial; font-size:8pt; background-color:white">
--->


<div style="padding:3pt; height:15pt; margin-top:0pt; margin-bottom:10pt; font-family:arial; font-size:8pt; ">


<!---
width:250pt; 
--->


<table border="0" style="width:400pt; background-color:white; padding:5pt">

<tr>

<td style="vertical-align:middle">

<b>Test User</b>

<td style="padding-left:10pt; padding-top:0pt; vertical-align:middle">

<!---
<form name="Set_TestUser" METHOD="POST" action="UpdateTestUser.Action.cfm" style="position:relative; left:60; top:-35; margin-bottom:-30">
--->


<form name="Set_TestUser" METHOD="POST" action="UpdateTestUser.Action.cfm" style="margin-bottom:-10pt">


<!---
<CFOUTPUT>
<input type="hidden" name="SelectedTestUser" value="#SelectedTestUser#">
</cfoutput>
--->

<SELECT NAME="TestUser" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:ccffcc" SIZE="1" onChange="Set_TestUser.submit()">

<option value="" style="color:white; background:green">Select a Test User . . .

<option value="Clear" style="color:black; background:yellow">CLEAR Test User

<CFOUTPUT QUERY="This_EeList">

<CFIF PRIMARYKEY EQ SelectedTestUser>
	<option value="#PRIMARYKEY#" SELECTED>#FULLNAME#
<CFELSE>
	<option value="#PRIMARYKEY#">#FULLNAME#
</cfif>

</cfoutput>

</select>
</form>







</table>

</div>


