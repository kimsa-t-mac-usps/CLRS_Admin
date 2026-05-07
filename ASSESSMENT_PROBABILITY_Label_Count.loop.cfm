<cfinclude template="MfaCookieCheck.cfm">
<CFLOOP CONDITION="(ASSESSMENT_PROBABILITY_Label_Count NEQ ThisASSESSMENT_PROBABILITY) AND (ASSESSMENT_PROBABILITY_Label_Count LE ASSESSMENT_PROBABILITY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">

<p>

<CFOUTPUT>
<h4 style="color:gray">[#ListGetAt(ASSESSMENT_PROBABILITY_Label_List, ASSESSMENT_PROBABILITY_Label_Count)#]</h4>
</cfoutput>

<CFIF HeaderParm NEQ "TopIndex">
<hr>
<p>
</cfif>

<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 

</cfloop>

