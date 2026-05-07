<cfinclude template="MfaCookieCheck.cfm">
<CFINCLUDE TEMPLATE="Get_Bus_Serv_Contact.cfm">


<CFIF EndOfYearFlag NEQ "EOY">
	<CFSET EmailSubjLine = ThisReportEmailSubjDate & " Contingent Liability Report - Request for Updates">
	<CFSET EmailCCLine = "">

<!---
Change 11/28/11: CCLine to Front Office for EOY report deleted at request of P. McMahon, R. Meyers:
--->
<!---
<CFELSE>
	<CFSET EmailSubjLine = "Action Required - " & ThisReportEmailSubjDate & " Contingent Liability Report">
	<CFSET EmailCCLine = "mary.anne.gibbons@usps.gov,thomas.j.marshall@usps.gov,charles.f.kappler@usps.gov">
--->

</cfif>


<CFIF IsDefined("Sender_TrimEMailAddr") AND Sender_TrimEMailAddr NEQ "">
	<CFSET SendTo = Sender_TrimEMailAddr>
	<CFSET EmailCCLine = Sender_TrimEMailAddr>
<CFELSE>
	<CFSET SendTo = ToList>
</cfif>



<CFIF OfficeScope EQ "OfficeOnly">


<CFIF CONTINGENT_LIAB_GetRecord_Current.RecordCount GT 0>

<CFMAIL
    FROM='#This_EE_From_Line#'
    TO="#SendTo#"
	CC="#EmailCCLine#"
    BCC="#Trim(QueryGetDisplayName.mail)#,gccontliab@usps.gov"
    SUBJECT="#EmailSubjLine#"
	TYPE="HTML">

<CFMAILPARAM NAME="Importance" VALUE="High">

<div style="font-family:arial; font-size:10pt">


<CFIF IsDefined("Sender_TrimEMailAddr") AND Sender_TrimEMailAddr EQ SendTo>
<CFOUTPUT>
<b>DRAFT Message</b>
<p>
TO="#ToList#"
<p>
</CFOUTPUT>
</cfif>


Hello --
<p>

<CFIF EndOfYearFlag NEQ "EOY">

It�s time for

<CFOUTPUT>
#ThisReportEmailSubjDate#
</cfoutput>

Contingent Liability/Receivable reporting.



<CFIF IsDefined("Form.IntroNote") AND Form.IntroNote NEQ "">
<p>
<CFOUTPUT>
#Form.IntroNote#
</cfoutput>
<p>
</cfif>






Please use the online system to report all updates and new cases via the following links:
<ul>

<CFOUTPUT>
<!---
<li>Review Tom Marshall�s <a href="https://#This_Server#/#Form.MAGRequest_FileFolder#/#Form.MAGRequest_FileName#" target="_blank"><b>memo</b></a> requesting updates for #ThisReportEmailSubjDate#.
--->

<li>Review Tom Marshall�s <a href="https://#This_Server#/InHouse/ContingentLiabilities/Request.for.Submissions/#Form.MAGRequest_FileName#" target="_blank"><b>memo</b></a> requesting updates for #ThisReportEmailSubjDate#.

</cfoutput>


<p>

<CFOUTPUT>

<!---
GAC - 09/09/2013 - Changed to new server location
<li>Update your cases in the Law Department�s <a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a>.  <b>Updates need to 
--->

<li>Update your cases in the Law Department�s <a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a>.  <b>Updates need to 
be completed, reviewed, and approved no later than #DateFormat(Form.Deadline, "dddd, mmmm d, yyyy")#.</b>

</cfoutput>

Thank you for timely responses. We are under extremely tight deadlines and appreciate your understanding.



<p>

<CFOUTPUT>

<!---
GAC - 09/09/2013 - Changed to new server location
<li>The online <a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/InsertRecord.cfm" target="_blank"><b>Case Evaluation Checklist</b></a> is the only method for adding new cases (including newly reported 
--->
<li>The online <a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/InsertRecord.cfm" target="_blank"><b>Case Evaluation Checklist</b></a> 

</cfoutput>

is the only method for adding new cases (including newly reported 
field Casuals-In-Lieu-Of matters) to the Law Department�s Report.  The checklist needs to be completed for all newly identified cases where

damages may equal or exceed $1 million.

Cases meeting this reporting threshold

will automatically be added to the report.  Cases not meeting the reporting threshold will be maintained in the system for future updating.

</ul>

Regarding other related reporting matters:
<ul>
<li>We are sending separate messages to all offices about Equal Access to Justice Act (EAJA) fees, and to field offices reporting casuals-in-lieu-of cases.
<p>
<li>Before providing concurrence, ensure that all Vice President (VP) Reports are consistent with your Law Department submission.

</ul>

<!--- From <CFIF EndOfYearFlag NEQ "EOY"> --->
<CFELSE>


<CFIF IsDefined("Form.IntroNote_EOY") AND Form.IntroNote_EOY NEQ "">
<p>
<CFOUTPUT>
#Form.IntroNote_EOY#
</cfoutput>
<p>
</cfif>


So that this can be reported in a timely fashion, we ask that you <b>please do this no later than
<CFOUTPUT>
#DateFormat(Form.Deadline, "dddd, mmmm d, yyyy")#</b>.
</cfoutput>

<!--- Close <CFIF EndOfYearFlag NEQ "EOY"> --->
</cfif>

<p>

<CFOUTPUT>

<!---
GAC - 09/09/2013 - Changed to new server location
You can access the Contingent Liabilities system at this link: <a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a>.
--->

You can access the Contingent Liabilities system at this link: <a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a>.
</cfoutput>
<p>
If you have any questions about contingent liability matters or procedures, please contact me.

If you have any trouble accessing the report, please e-mail or call Bob Sindermann, 202-268-3043.

<p>
Thanks for your prompt attention!
<p>



<CFLOOP QUERY="Get_Bus_Serv_Contact">

<CFOUTPUT>

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

</cfoutput>

</cfloop>

</div>

</CFMAIL>


<CFELSEIF CONTINGENT_LIAB_GetRecord_Current.RecordCount EQ 0 AND EndOfYearFlag NEQ "EOY">

<CFMAIL
    FROM='#This_EE_From_Line#'
    TO="#SendTo#"
    BCC="#Trim(QueryGetDisplayName.mail)#,gccontliab@usps.gov"
    SUBJECT="#EmailSubjLine#"
	TYPE="HTML">

<CFMAILPARAM NAME="Importance" VALUE="High">

<div style="font-family:arial; font-size:10pt">


<CFIF IsDefined("Sender_TrimEMailAddr") AND Sender_TrimEMailAddr EQ SendTo>
<CFOUTPUT>
<b>DRAFT Message</b>
<p>
TO="#ToList#"
<p>
</CFOUTPUT>
</cfif>


Hello --
<p>

It�s time for

<CFOUTPUT>
#ThisReportEmailSubjDate#
</cfoutput>

Contingent Liability/Receivable reporting.  Please use the online system to report all updates and new cases via the following links:
<ul>

<CFOUTPUT>
<li>Review Tom Marshall�s <a href="https://#This_Server#/InHouse/ContingentLiabilities/Request.for.Submissions/#Form.MAGRequest_FileName#" target="_blank"><b>memo</b></a> requesting updates for #ThisReportEmailSubjDate#.
</cfoutput>

<p>
<li>Currently, your office has no cases on the report.  Nevertheless, you will want to bookmark the site of the Law Department�s 

<CFOUTPUT>

<!---
GAC - 09/09/2013 - Changed to new server location
<a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a> for future use and reference.
--->
<a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/Report.cfm" target="_blank"><b>Contingent Liabilities and Receivables Report</b></a> for future use and reference.

<p>
<!---
GAC - 09/09/2013 - Changed to new server location
<li>The online <a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/InsertRecord.cfm" target="_blank"><b>Case Evaluation Checklist</b></a> is the only method for adding new cases (including newly reported 
--->
<li>The online <a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/InsertRecord.cfm" target="_blank"><b>Case Evaluation Checklist</b></a> is the only method for adding new cases (including newly reported 
field Casuals-In-Lieu-Of matters) to the Law Department�s Report.

</cfoutput>

The checklist needs to be completed for all newly identified cases where

damages may equal or exceed $1 million.

Cases meeting this reporting threshold

will automatically be added to the report.  Cases not meeting the reporting threshold will be maintained in the system for future updating.


<p>

<CFOUTPUT>
<li>Please submit any new matters <b>no later than #DateFormat(Form.Deadline, "dddd, mmmm d, yyyy")#</b>, or 
<!---
GAC - 09/09/2013 - Changed to new server location
<a href="https://#This_Server#/InHouse/ContingentLiabilities/V1.0/CFINCLUDEs/email.cfmail.nocases.cfm?From=#FromUser#&Office=#Trim_OFFICE_LDOFFICES#&Rpt=#ThisReportDate_CalQuarter#" target="_blank"><b>click here</b></a>
--->

<a href="https://#This_Server#/ClientService/ContingentLiabilities/V1.0/CFINCLUDEs/email.cfmail.nocases.cfm?From=#FromUser#&Office=#Trim_OFFICE_LDOFFICES#&Rpt=#ThisReportDate_CalQuarter#" target="_blank"><b>click here</b></a>
 to send an automatic e-mail message to let us know your office has no new matters to report for #ThisReportEmailSubjDate#.
</cfoutput>

</ul>

Regarding other related reporting matters:
<ul>
<li>We are sending separate messages to all offices about Equal Access to Justice Act (EAJA) fees, and to field offices reporting casuals-in-lieu-of cases.
<p>
<li>Before providing concurrence, ensure that all Vice President (VP) Reports are consistent with your Law Department submission.  Please e-mail a copy of all VP Reports to me no later than

<CFOUTPUT>
<b>#DateFormat(Form.Deadline, "dddd, mmmm d, yyyy")#</b>.
</cfoutput>

</ul>


If you have any questions about contingent liability matters or procedures, please contact me.

If you have any trouble accessing the Case Evaluation Checklist, please e-mail or call Bob Sindermann, 202-268-3043.

<p>
Thanks for your prompt attention!
<p>


<CFLOOP QUERY="Get_Bus_Serv_Contact">

<CFOUTPUT>
<i>
#Trim_FIRSTNAME# #Trim_LASTNAME#
<br>
#Trim_TITLE#,
#Trim_OFFICE#
<br>
Law Department
<br>
#Trim_VOICE#
</i>

</cfoutput>

</cfloop>

</div>

</cfmail>

</cfif>

</cfif>


