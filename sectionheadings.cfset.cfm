<cfinclude template="MfaCookieCheck.cfm">
<CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label>

	
	<CFIF NOT (Old_CASE_TYPE_Label EQ "" AND HeaderParm EQ "TopIndex")>
		<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
		<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">
	</cfif>
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '"'>
	</cfif>
	
	<CFOUTPUT>

	<CFIF HeaderParm EQ "TopIndex">

		<CFIF CASE_TYPE NEQ 1>
			<br>
			<hr style="width:350pt; color:lightgrey">
		</cfif>
		
        <a #AParm#><h3>#CASE_TYPE_Label#</h3></a>

	<CFELSE>

		<CFIF CASE_TYPE NEQ 1>
			<hr>
		</cfif>
	
    	<a #AParm#><h3 class="SectionHead">#CASE_TYPE_Label#</h3></a>

	</cfif>

	</cfoutput>
	

	<CFSET Old_CASE_TYPE_Label = CASE_TYPE_Label>
	
	<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
	
	
	<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
	</cfif>
	
	<CFOUTPUT>
	<a #AParm#><h4>#ASSESSMENT_PROBABILITY_Label#</h4></a>
	</cfoutput>
	
	<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 
	
	<CFSET Old_ASSESSMENT_PROBABILITY_Label = ASSESSMENT_PROBABILITY_Label>
	
	<CFSET CLAIM_CATEGORY_Label_Count = 1> 
	
	<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>
	
	
	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	</cfif>
	
	<CFOUTPUT>
	<a #AParm#>
	</cfoutput>
	
	<CFIF HeaderParm EQ "TopIndex">
	
		<CFSET CheckFlag = "no">
		<h5 style="position:relative; left:15pt">

	<CFELSE>

		<h5>
	
	</cfif>
	
    
	<CFOUTPUT>
	#CLAIM_CATEGORY_Label#</h5></a>
	</cfoutput>
	
	<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>
	
	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	
    
<!--- From <CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label> --->
<CFELSEIF ASSESSMENT_PROBABILITY_Label NEQ Old_ASSESSMENT_PROBABILITY_Label>
	
	
	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">
	
	<CFIF HeaderParm NEQ "TopIndex">
		<hr>
	</cfif>
	
	<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
	
	
	<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">
	
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
	</cfif>
	
	<CFOUTPUT>
    
	<CFIF HeaderParm EQ "TopIndex">
		<a #AParm#><h4>#ASSESSMENT_PROBABILITY_Label#</h4></a>
	<CFELSE>
		<a #AParm#><h4 class="SectionHead">#ASSESSMENT_PROBABILITY_Label#</h4></a>
	</cfif>
    
	</cfoutput>
	
	<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 
	
	<CFSET Old_ASSESSMENT_PROBABILITY_Label = ASSESSMENT_PROBABILITY_Label>
	
	<CFSET CLAIM_CATEGORY_Label_Count = 1> 
	
	<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>
	
	
	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	
	</cfif>
	
	<CFOUTPUT>
	<a #AParm#>
	</cfoutput>
	
	<CFIF HeaderParm EQ "TopIndex">
	
		<CFSET CheckFlag = "no">
		<h5 style="position:relative; left:15pt">
        
	<CFELSE>
    
		<h5>
        
	</cfif>
	
    
	<CFOUTPUT>
	#CLAIM_CATEGORY_Label#</h5></a>
	</cfoutput>
	
	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	
	<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>
	
		
<CFELSEIF CLAIM_CATEGORY_Label NEQ Old_CLAIM_CATEGORY_Label>
	
	<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>
	
	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">
	
	<CFIF HeaderParm NEQ "TopIndex" 
	AND 
	ThisCLAIM_CATEGORY GT 1>
    
		<hr>
		<CFOUTPUT>
		<h4 class="SectionHead">#ASSESSMENT_PROBABILITY_Label# <small>[cont'd]</small></h4>
		</cfoutput>

	</cfif>
	
	<CFIF HeaderParm EQ "TopIndex">
	<!---
		<CFSET AParm = "href = '##" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	<CFELSE>
		<CFSET AParm = "name = '" & CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "'">
	--->
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	
	</cfif>
	
	<CFOUTPUT>
	<a #AParm#>
	</cfoutput>
	
	<CFIF HeaderParm EQ "TopIndex">
	
		<CFSET CheckFlag = "no">
		<h5 style="position: relative; left:15pt">
        
	<CFELSE>
	
    	<h5>
	
	</cfif>
	
	<CFOUTPUT>
	#CLAIM_CATEGORY_Label#</h5></a>
	</cfoutput>
	
	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	
	<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>

</cfif>



