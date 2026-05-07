<cfinclude template="MfaCookieCheck.cfm">
<CFLOOP CONDITION="(CLAIM_CATEGORY_Label_Count NEQ CLAIM_CATEGORY) AND (CLAIM_CATEGORY_Label_Count LE CLAIM_CATEGORY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">


<p>

<CFIF HeaderParm EQ "TopIndex">
	<CFSET CheckFlag = "no">
	<h5 style="color:gray; position:relative; left:15pt">
<CFELSE>
	<h5 style="color:gray">
</cfif>

<CFOUTPUT>
[#ListGetAt(CLAIM_CATEGORY_Label_List, CLAIM_CATEGORY_Label_Count)#]</h5>
</cfoutput>

<!--- Omitting <p> below; causes inconsistent display of following Category Label if non-gray:
--->
<!---
<p>
--->


<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 

</cfloop>
