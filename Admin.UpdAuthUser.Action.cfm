<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<CFIF IsDefined("Form.Update_UserAuth") AND Form.Update_UserAuth EQ "Submit Update">


	<CFQUERY NAME="Upd_Auth_User" DATASOURCE="ContLiab">
	
	UPDATE BUSINESSSERVUSERS
	SET CONTINGENT_LIAB_AUTH = '#Form.AuthOption#',
	
	
	<CFIF IsDefined("Form.MCUpdConcur") AND Form.MCUpdConcur NEQ "" AND Form.AuthOption NEQ "A">
	
		<CFIF Form.MCUpdConcur GT 0>
			CONTINGENT_LIAB_CONCUR = #Form.MCUpdConcur#
		<CFELSE>
			CONTINGENT_LIAB_CONCUR = 9
		</CFIF>
	
	<CFELSE>
	
		<CFIF Form.AuthOption EQ "A">
			CONTINGENT_LIAB_CONCUR = NULL
		<CFELSE>
	    	CONTINGENT_LIAB_CONCUR = 9
		</CFIF>
	
	</cfif>
	
	
	WHERE USERPRMKEY = #Form.USERPRMKEY#
	
	</cfquery>


	<script language="javascript">
	location.href = "Admin.UpdAuthUser.cfm"
	</script>


<CFELSEIF IsDefined("Form.DeleteFlag") AND Form.DeleteFlag EQ "Delete">

	<CFQUERY NAME="Upd_Auth_User" DATASOURCE="ContLiab">
	
	UPDATE BUSINESSSERVUSERS
	SET CONTINGENT_LIAB_AUTH = NULL
	WHERE USERPRMKEY = #Form.USERPRMKEY#
	
	</cfquery>
	
	<script language="javascript">
	location.href = "Admin.UpdAuthUser.cfm"
	</script>
	

<CFELSEIF IsDefined("Form.Insert_UserAuth") AND Form.Insert_UserAuth EQ "Submit">


	<CFQUERY NAME="Find_Auth_User" DATASOURCE="ContLiab">
	
	SELECT USERPRMKEY
	FROM BUSINESSSERVUSERS
	WHERE USERPRMKEY = #Form.NewUser_LAW_DEPT#
	
	</cfquery>
	
	
	<CFIF Find_Auth_User.RecordCount EQ 1>
	
		<CFQUERY NAME="Upd_Auth_User" DATASOURCE="ContLiab">
		
		UPDATE BUSINESSSERVUSERS
		SET CONTINGENT_LIAB_AUTH = '#Form.AuthOption#',
	
	
		<CFIF IsDefined("Form.MCUpdConcur") AND Form.AuthOption NEQ "A">
		
			<CFIF Form.MCUpdConcur GT 0>
				CONTINGENT_LIAB_CONCUR = #Form.MCUpdConcur#
			<CFELSE>
				CONTINGENT_LIAB_CONCUR = 9
			</CFIF>
		
		<CFELSE>
			CONTINGENT_LIAB_CONCUR = 9
		</cfif>
	
	
		WHERE USERPRMKEY = #Form.NewUser_LAW_DEPT#
		
		</cfquery>
		
		<script language="javascript">
		location.href = "Admin.UpdAuthUser.cfm"
		</script>
		
	
	<CFELSE>

		<CFQUERY NAME="Find_Auth_User_Lastname" DATASOURCE="ContLiab">
		
		SELECT EENAME, LASTNAME, EMPLOYEE_ID
		FROM LDEXTRA
		WHERE PRIMARYKEY = #Form.NewUser_LAW_DEPT#
		
		</cfquery>
		
		
		<CFQUERY NAME="Get_PW" DATASOURCE="ContLiab">
		SELECT PW, AD_MAILNICKNAME
		FROM BUSINESSSERVUSERS
		WHERE USERPRMKEY = 361
		</cfquery>
		
	
		<CFSET TrimEENAME = Trim(Find_Auth_User_Lastname.EENAME)>
		<CFSET TrimEENAME = Left(TrimEENAME, Len(TrimEENAME) - 1)>
		
		
		<!--- For Jung, Joe [name=Jung, Uk J. (Joe)] -- omit nickname, parentheses --->
		
		<CFIF TrimEENAME CONTAINS "Jung">
			<CFSET TrimEENAME = "Jung, Uk J">
		</CFIF>


		<CFIF Find_Auth_User_Lastname.EMPLOYEE_ID NEQ "">
			<CFSET FilterString = "employeeID=" & NumberFormat(Find_Auth_User_Lastname.EMPLOYEE_ID, "00000000")>
		<CFELSE>
			<CFSET FilterString = "name=" & TrimEENAME>
		</CFIF>
		
		
		<CFSET AttributeList = "extensionAttribute13, mailNickName, name, givenname, initials, sn, title, description, mail">
		<cfset startstr = "dc=usa,dc=dce,dc=usps,dc=gov">
		
		
		<CFINCLUDE TEMPLATE="LDAPServerName.cfm">

		<cftry>
		<cfldap action="QUERY"
		    name="UserInfo"
		    attributes="#AttributeList#"
		    start="#startstr#"
			filter="(& (objectClass=user) (#FilterString#) )"
			scope="subtree"
			sort="extensionAttribute13"
		    server = '#LDAPServerName#'
			port='#ldap_port#'
			secure='#ldap_secure#'
		    username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
		    password="#trim(Get_PW.PW)#">
			<cfcatch type="any">
				<cflog text="UserInfo Error: #cfcatch.message#" type="error" file="clrs-admin-ldap">
			</cfcatch>
			<cffinally>
				<cfif isdefined("UserInfo")>
				<cflog text="LDAP UserInfo Result: #serializeJSON(UserInfo)#" type="information" file="clrs-admin-ldap">
			</cfif>
			</cffinally>
		</cftry>
		
		<CFIF UserInfo.RecordCount EQ 1 
		OR 
		(
		IsDefined("Form.NewUserCustomAttrib13") 
		AND 
		IsDefined("Form.NewUserLogonName")
		)>
		
			<CFQUERY NAME="Insert_Auth_User" DATASOURCE="ContLiab">
			
			INSERT INTO BUSINESSSERVUSERS
			(USERPRMKEY,
			SURNAME,
			AD_USERID,
			AD_MAILNICKNAME,
			
			CONTINGENT_LIAB_CONCUR,
			
			CONTINGENT_LIAB_AUTH)
			
			VALUES
			(#Form.NewUser_LAW_DEPT#,
			'#Trim(Find_Auth_User_Lastname.LASTNAME)#',
			
			<CFIF IsDefined("Form.NewUserCustomAttrib13")>
			'#Form.NewUserCustomAttrib13#',
			<CFELSE>
			'#Trim(UserInfo.extensionAttribute13)#',
			</cfif>
			
			<CFIF IsDefined("Form.NewUserLogonName")>
			'#Form.NewUserLogonName#',
			<CFELSE>
			'#Trim(UserInfo.mailNickName)#',
			</cfif>
			
			<CFIF IsDefined("Form.MCUpdConcur") AND Form.MCUpdConcur LT 9>
			#Form.MCUpdConcur#,
			<CFELSE>
			9,
			</cfif>
			
			'#Form.AuthOption#')
			
			</cfquery>
			
			<script language="javascript">
			location.href = "Admin.UpdAuthUser.cfm"
			</script>
	
		<CFELSE>

			<form name="ReturnForm" action="Admin.UpdAuthUser.cfm" method="post">
			<CFOUTPUT>
			<input type="hidden" name="ReturnForm_NewUser_LAW_DEPT" value="#Form.NewUser_LAW_DEPT#">
			<input type="hidden" name="ReturnForm_SelectedAuthOption" value="#Form.AuthOption#">
			</cfoutput>
			</form>
			
			<script language="javascript">
			alert("Unable to find User ID / Logon Name for this User. Please find in Active Directory and enter them.");
			ReturnForm.submit();
			</script>
			
		</cfif>

	</cfif>

</cfif>

</body>
</html>

