<cfinclude template="MfaCookieCheck.cfm">

<CFIF IsDefined("Block")>


<CFQUERY NAME="Upd_CONTINGENT_LIAB_BLOCK_NEW" DATASOURCE="ContLiab">

UPDATE BUSINESSSERVUSERS
SET CONTINGENT_LIAB_BLOCK_NEW =

<CFIF Block EQ "Block">

	'Y'

<CFELSEIF Block EQ "UnBlock">

	'N'

</CFIF>

WHERE USERPRMKEY = 13

</CFQUERY>


</CFIF>


<script language="JavaScript">

location.href = "Admin.full.cfm";

</script>

