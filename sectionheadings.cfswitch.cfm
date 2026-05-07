<cfinclude template="MfaCookieCheck.cfm">
<CFSWITCH EXPRESSION="#CASE_TYPE#">

<CFCASE VALUE="1">
	<CFSET CASE_TYPE_Label = "I. Contingent Liabilities">
</cfcase>

<CFCASE VALUE="2">
	<CFSET CASE_TYPE_Label = "II. Contingent Receivables">
</cfcase>

<CFCASE VALUE="11">
	<CFSET CASE_TYPE_Label = "III. Cases To Be Removed">
</cfcase>

<CFCASE VALUE="12">
	<CFSET CASE_TYPE_Label = "III. Cases To Be Removed">
</cfcase>

</cfswitch>


<CFSWITCH EXPRESSION="#ASSESSMENT_PROBABILITY#">

<CFCASE VALUE="1">
	<CFSET ASSESSMENT_PROBABILITY_Label = "A. Probable">
</cfcase>

<CFCASE VALUE="2">
	<CFSET ASSESSMENT_PROBABILITY_Label = "B. Reasonably Possible">
</cfcase>

<CFCASE VALUE="3">
	<CFSET ASSESSMENT_PROBABILITY_Label = "C. Remote">
</cfcase>

</cfswitch>


<CFSWITCH EXPRESSION="#CLAIM_CATEGORY#">

<CFCASE VALUE="1">
	<CFSET CLAIM_CATEGORY_Label = "1. Business Claims">
</cfcase>

<CFCASE VALUE="2">
	<CFSET CLAIM_CATEGORY_Label = "2. Labor Claims">
</cfcase>

<CFCASE VALUE="3">
	<CFSET CLAIM_CATEGORY_Label = "3. Tort Claims">
</cfcase>

</cfswitch>


