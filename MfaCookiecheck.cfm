<cfif cgi.SERVER_NAME neq "127.0.0.1" and cgi.SERVER_NAME neq Dev_Server_Name>
<cfif not isdefined("cookie._mfa.authenticated_clrsAdmin")>
    <cfinvoke component="components/saml" method="doMfaInit">
        <cfinvokeargument name="relayPage" value="#getFileFromPath(getBaseTemplatePath())#">
        <cfinvokeargument name="queryString" value="#cgi.QUERY_STRING#">
    </cfinvoke>
</cfif>
</cfif>