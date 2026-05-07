<cfinclude template="MfaCookieCheck.cfm">
<cfif cgi.SERVER_NAME eq "127.0.0.1">
	<cfset This_User_Id = "K6GVN0"> 
<cfelseif cgi.SERVER_NAME eq Dev_Server_Name>
	<cfset This_User_Id = "YSRJ00">
<cfelseif isdefined("cookie._mfa.nameid_clrsadmin")>
	<cfset This_User_Id = cookie._mfa.nameid_clrsadmin>
<cfelse>
	<cfset This_User_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>
</cfif>



<!---
<!--- 9/10/2020 Added check for session.Warning_Accepted for use in Lit Hold --->

<!--- Initialize session.Warning_Accepted when Test User changes --->
<CFSET session.Warning_Accepted = "">
--->

<CFQUERY NAME="Get_ThisUser_Pkey" DATASOURCE="contliab">

<!---
SELECT PRIMARYKEY
FROM LDDB.LDEXTRA
WHERE
(UPPER(AD_USERID) LIKE UPPER('#This_User_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#This_User_Id#%'))
--->


SELECT b.PRIMARYKEY

FROM LAWDEPARTMENT a, LDEXTRA b

WHERE a.PRIMARYKEY = b.PRIMARYKEY

AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

AND
(
UPPER(b.AD_USERID) LIKE UPPER('#This_User_Id#%')
OR
UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#This_User_Id#%')
)

</cfquery>

<CFIF IsDefined("Form.TestUser")>

<CFIF Form.TestUser EQ "Clear">
	<CFSET TestUser_Pkey = Get_ThisUser_Pkey.PRIMARYKEY>
<CFELSE>
	<CFSET TestUser_Pkey = Form.TestUser>
</cfif>

</cfif>

<CFQUERY NAME="Get_ThisUser_In_TEST_USER" DATASOURCE="contliab">
SELECT SETTINGUSER_PKEY
FROM TEST_USER
WHERE SETTINGUSER_PKEY = #Get_ThisUser_Pkey.PRIMARYKEY#
</cfquery>

<CFIF Get_ThisUser_In_TEST_USER.RecordCount EQ 0>


<CFQUERY NAME="AddNew_TestUser" DATASOURCE="contliab">
INSERT INTO TEST_USER (TESTUSER_PKEY, SETTINGUSER_PKEY, DATE_SET)
VALUES ( #TestUser_Pkey#, #Get_ThisUser_Pkey.PRIMARYKEY#, SYSDATE)
</cfquery>

<CFELSE>

<CFQUERY NAME="Upd_TestUser" DATASOURCE="contliab">
UPDATE TEST_USER
SET TESTUSER_PKEY = #TestUser_Pkey#,
DATE_SET = SYSDATE
WHERE SETTINGUSER_PKEY = #Get_ThisUser_Pkey.PRIMARYKEY#
</cfquery>

</cfif>
<cfcookie name="testuserpkey" value="#testUser_pkey#">
<cfcookie name="settinguserpkey" value="#get_thisuser_Pkey.primarykey#">

<!---
<form name="ReturnForm" METHOD="POST" action="setTestUser.iframe.cfm">
--->
<form name="ReturnForm" METHOD="POST" action="setTestUser.cfm">
<CFOUTPUT>
<input type="hidden" name="TestUser" value="#TestUser_Pkey#">
</cfoutput>
</form>

<script language="javascript">

if (parent.SendEmailForm_Latest) {
/*
alert("On Conting Liab Admin page");
*/
ReturnForm.action = "setTestUser.cfm";
}

ReturnForm.submit();

</script>


