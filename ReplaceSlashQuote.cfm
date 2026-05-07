<cfinclude template="MfaCookieCheck.cfm">


<CFSET Result_String = Replace(Orig_String, "\", "", "ALL")>
<CFSET Result_String = Replace(Result_String, "''''", "'", "ALL")>
<CFSET Result_String = Replace(Result_String, "''", "'", "ALL")>

