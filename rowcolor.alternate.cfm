<cfinclude template="MfaCookieCheck.cfm">

<CFSET RowNum = RowNum + 1>

<CFSET Remainder = RowNum MOD 2>

<CFIF Remainder GT 0>
<!---
	<CFSET RowColor = "khaki">
--->
	<CFSET RowColor = "FFFFCC">
	
<CFELSE>
<!---
	<CFSET RowColor = "lightgrey">
--->
	<CFSET RowColor = "lightcyan">
</cfif>


