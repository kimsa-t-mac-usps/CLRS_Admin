<cfinclude template="MfaCookieCheck.cfm">
<CFSET TrimLastName = Trim(LASTNAME)>
<CFSET TrimFirstName = Trim(FIRSTNAME)>
<CFSET TrimEMailAddr = Trim(LONGEMAIL)>

<CFIF TrimEMailAddr EQ "">
	<CFSET DefaultLongEmailFirstName = Replace(TrimFIRSTNAME, " ", ".", "ALL")>
	<CFSET DefaultLongEmailFirstName = Replace(DefaultLongEmailFirstName, "..", "", "ALL")>

	<CFIF Right(DefaultLongEmailFirstName, 1) NEQ ".">
		<CFSET DefaultLongEmailFirstName = DefaultLongEmailFirstName & ".">
	</cfif>
	<CFSET TrimEMailAddr = DefaultLongEmailFirstName & TrimLASTNAME>
</cfif>

<CFSET TrimEMailAddr = TrimEMailAddr & "@" & EMailSuffix>

<CFSET ToList = ListAppend(ToList, TrimEMailAddr)>

