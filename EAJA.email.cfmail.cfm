<cfinclude template="MfaCookieCheck.cfm">
<CFINCLUDE TEMPLATE="Get_Bus_Serv_Contact.cfm">

<CFIF IsDefined("Sender_TrimEMailAddr") AND Sender_TrimEMailAddr NEQ "">
	<CFSET SendTo = Sender_TrimEMailAddr>

<CFELSE>
	<CFSET SendTo = ToList>

</cfif>

<CFIF OfficeScope EQ "OfficeOnly">

	<!---KS Test 1.22.26 --->
	<!---<CFMAIL
	    FROM='#This_EE_From_Line#'
	    TO="#SendTo#"
	    BCC="#Trim(QueryGetDisplayName.mail)#,gccontliab@usps.gov"
	    SUBJECT="#ThisReportEmailSubjDate# Report of EAJA Cases"
		TYPE="HTML">--->
	
	<CFMAIL
	    FROM='#This_EE_From_Line#'
	    TO="Kimsa.t.mac@usps.gov"
	    BCC="Kimsa.t.mac@usps.gov"
	    SUBJECT="#ThisReportEmailSubjDate# Report of EAJA Cases"
		TYPE="HTML">
	
		<div style="font-family:arial; font-size:10pt">
		
		
		<CFIF IsDefined("Sender_TrimEMailAddr") AND Sender_TrimEMailAddr EQ SendTo>
			<CFOUTPUT>
			<b>DRAFT Message</b>
			<p>
			TO="Kimsa.t.mac@usps.gov"
			<p>
			</CFOUTPUT>
		</cfif>
		
		
		Hello --
		<p>
		
		
		In conjunction with quarterly Contingent Liability reporting, and new Federal reporting requirements, we are required to collect information concerning cases with claims for Equal Access to Justice Act (EAJA) fees.  <b>This information is required for all cases where EAJA claims are made not just those reported for Contingent Liability purposes.</b>
		<p>
		
		Please send me an email message with the following information regarding
		
		<CFOUTPUT>
		#ThisReportEmailSubjDate#:
		</cfoutput>
		
		
		
		<ul>
		<li>The number of EAJA cases identified;
		
		<li>The number of EAJA cases concluded (initiated in this or a previous year);
		
		<li>For each concluded EAJA case:
		<ul>
		<li>The monetary amount recovered on the substantive matter, as well as the amount of attorneys' fees assessed; and
		<li>The case name and docket number.
		</ul>
		
		</ul>
		
		
		<p>
		For cases in which an EAJA award was made, please also provide the following information:
		<ul>
		<li>The name of the party to whom the award was made;
		<li>A description of the claim in the case;
		<li>The amount of the award;
		<li>A brief statement of the legal basis for the award.
		</ul>
		
		
		<p>
		
		<CFOUTPUT>
		If your office has <b>no EAJA cases</b> to report for #ThisReportEmailSubjDate#, 
		
		<a href="#URL_Scheme##This_Server##V1_URL_Path#EAJA.email.cfmail.nocases.cfm?From=#FromUser#&Office=#Trim_OFFICE_LDOFFICES#&Rpt=#ThisReportDate_CalQuarter#" target="_blank"><b>click here</b></a> 
		
		
		to send an automatic email message to let us know.
		</cfoutput>
		
		<p>
		Please respond no later than
		
		<CFOUTPUT>
		<!---
		#DateFormat(Form.EAJADeadline, "mmmmm d, yyyy")#.
		--->
		
		#DateFormat(Form.Deadline, "mmmmm d, yyyy")#.
		
		</cfoutput>
		
		<p>
		Thanks for your prompt attention!
		<p>
		
		
		<CFLOOP QUERY="Get_Bus_Serv_Contact">
		
			<i>
			#Trim_FIRSTNAME# #Trim_LASTNAME#
			<br>
			
			<!---
			#Trim_TITLE#,
			--->
			
			<!--- Truncate EAS level from job title: --->
			<CFIF Right(Trim_TITLE, 5) EQ " (21)"
			OR
			Right(Trim_TITLE, 5) EQ " (23)">
			
				#Left(Trim_TITLE, Len(Trim_TITLE) - 6)#,
			
			</CFIF>
			
			
			
			#Trim_OFFICE#
			<br>
			Law Department
			<br>
			#Trim_VOICE#
			</i>
		
		</cfloop>
		
		</div>
	
	</cfmail>

</cfif>



