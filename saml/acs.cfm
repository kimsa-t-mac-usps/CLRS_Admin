<!--- <cflog text="starting SAML response" type="information" file="empDB_samlResp"> --->

    <cfset samlResponse = "#ProcessSAMLResponse("ContLiabAdmin_idp","ContLiabAdmin_sp")#">
    <cfdump var="#samlResponse#">
    <cfcookie name="_mfa.authenticated_clrsAdmin" value="#samlResponse.AUTHENTICATED#"  expires="#dateAdd('h',2,now())#">
    <cfcookie name="_mfa.nameid_clrsAdmin" value="#samlResponse.NAMEID#"  expires="#dateAdd('h',2,now())#">
    <cfcookie name="_mfa.nameidformat_clrsAdmin" value="#samlResponse.NAMEIDFORMAT#"  expires="#dateAdd('h',2,now())#">
    <cfcookie name="_mfa.sessionindex_clrsAdmin" value="#samlResponse.SESSIONINDEX#"  expires="#dateAdd('h',2,now())#">
    <cfcookie name="_mfa.relaystate_clrsAdmin" value="#samlResponse.RELAYSTATE#"  expires="#dateAdd('h',2,now())#">
    <cfinvoke component="appLog" method="createAppLogRecord" returnvariable="applogResult">
        <cfinvokeargument name="authName" value="#samlResponse.NAMEID#">
        <cfinvokeargument name="authSessionId" value="#samlResponse.SESSIONINDEX#">
        <cfinvokeargument name="templatePath" value="#samlResponse.RELAYSTATE#">
        <cfinvokeargument name="appName" value="#application.applicationname#">
      </cfinvoke>
    <cflocation url="../#urldecode(cookie._mfa.relaystate_clrsAdmin)#">
    