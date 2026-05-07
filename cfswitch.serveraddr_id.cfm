
<CFIF IsDefined("cgi.local_addr")>


	<CFSWITCH EXPRESSION="#cgi.local_addr#">
	
	<!---
	<CFCASE VALUE="56.207.69.229">
		<CFSET ServerID = "d2f">
	</CFCASE>
	
	<CFCASE VALUE="56.207.69.228">
		<CFSET ServerID = "d08">
	</CFCASE>
	
	<CFCASE VALUE="56.207.31.151">
		<CFSET ServerID = "ba0">
	</CFCASE>
	--->
	
	
	<!--- DEV server --->
	<CFCASE VALUE="56.76.26.42">
		<CFSET ServerID = "SS0B6">
	</CFCASE>
	
	
	<!--- CAT server --->
	<CFCASE VALUE="56.76.150.22">
		<CFSET ServerID = "SS00C">
	</CFCASE>
	
	
	<!--- PROD servers --->
	<CFCASE VALUE="56.201.73.72">
		<CFSET ServerID = "TWE1860">
	</CFCASE>
	
	<CFCASE VALUE="56.201.73.73">
		<CFSET ServerID = "TWE1861">
	</CFCASE>
	
	
	<CFDEFAULTCASE>
		<CFSET ServerID = cgi.local_addr>
	</CFDEFAULTCASE>
	
	</CFSWITCH>
	
	
	<CFSET ServerID_NoBrackets = ServerID>
	
	<CFSET ServerID = "[" & ServerID & "]">


<CFELSE>

	<CFSET ServerID_NoBrackets = "">
	
	<CFSET ServerID = "">


</CFIF>


