<cfinclude template="MfaCookieCheck.cfm">
<CFQUERY NAME="Get_PW" DATASOURCE="ContLiab">
SELECT PW, AD_MAILNICKNAME
FROM BUSINESSSERVUSERS
WHERE USERPRMKEY = 361
<!---WHERE USERPRMKEY = 336--->
</cfquery>

<cfset startstr = "dc=usa,dc=dce,dc=usps,dc=gov">


<CFINCLUDE TEMPLATE="Query.Get_Bus_Serv_Contact.cfm">

<!---
<CFQUERY NAME="Get_Bus_Serv_Contact" DATASOURCE="ContLiab">
SELECT Trim(a.LASTNAME) AS Trim_LASTNAME, Trim(a.FIRSTNAME) AS Trim_FIRSTNAME, Trim(a.TITLE) AS Trim_TITLE, Trim(a.OFFICE) AS Trim_OFFICE, Trim(a.VOICE) AS Trim_VOICE, b.EMPLOYEE_ID
FROM lawdepartment a, ldextra b
WHERE a.PRIMARYKEY = b.PRIMARYKEY
AND
(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

AND a.LASTNAME LIKE 'Montalvo%'
AND a.FIRSTNAME LIKE 'Maria%'

</cfquery>
--->


<!---
    server="eagandcs.usa.dce.usps.gov"
--->


<CFINCLUDE TEMPLATE="LDAPServerName.cfm">

<!--- Skip LDAP on local/dev since the server is unreachable --->
<CFIF IsLocalDev>
    <CFSET This_EE_From_Line = '"' & Get_Bus_Serv_Contact.Trim_FIRSTNAME & ' ' & Get_Bus_Serv_Contact.Trim_LASTNAME & '"' & ' <' & LCase(Replace(Get_Bus_Serv_Contact.Trim_FIRSTNAME, " ", ".", "ALL")) & '.' & LCase(Get_Bus_Serv_Contact.Trim_LASTNAME) & '@usps.gov>'>
<CFELSE>
<cftry>
<cfldap action="QUERY"
    name="QueryGetDisplayName"
    attributes="displayName, mail"
	maxrows="10000"
	timeout="9000"
    start="#startstr#"
	filter="(&(objectClass=user)(employeeID=#NumberFormat(Get_Bus_Serv_Contact.EMPLOYEE_ID, '00000000')#))"
	scope="subtree"
	sort="name"
    server = '#LDAPServerName#'
	port='#ldap_port#'
	secure='#ldap_secure#'
	username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
	password="#trim(Get_PW.PW)#">
<cfcatch type="any">
    <cflog text="QueryGetDisplayName Error: #cfcatch.message#" type="error" file="clrs-admin-ldap">
</cfcatch>
<cffinally>
    <cfif IsDefined("QueryGetDisplayName.displayname") AND QueryGetDisplayName.RecordCount GT 0>
        <cflog text="LDAP QueryGetDisplayName Result: displayName #QueryGetDisplayName.displayname# | mail #QueryGetDisplayName.mail#" type="information" file="clrs-admin-ldap">
    <cfelse>
        <cflog text="LDAP QueryGetDisplayName: No results returned or query undefined" type="warning" file="clrs-admin-ldap">
    </cfif>
</cffinally>
</cftry>

<CFIF IsDefined("QueryGetDisplayName.displayname") AND QueryGetDisplayName.RecordCount GT 0>
    <CFSET This_EE_From_Line = '"' & Trim(QueryGetDisplayName.displayName) & '"' & ' <' & Trim(QueryGetDisplayName.mail) & '>'>
<CFELSE>
    <CFSET This_EE_From_Line = '"' & Get_Bus_Serv_Contact.Trim_FIRSTNAME & ' ' & Get_Bus_Serv_Contact.Trim_LASTNAME & '"' & ' <' & LCase(Replace(Get_Bus_Serv_Contact.Trim_FIRSTNAME, " ", ".", "ALL")) & '.' & LCase(Get_Bus_Serv_Contact.Trim_LASTNAME) & '@usps.gov>'>
</CFIF>
</CFIF>



