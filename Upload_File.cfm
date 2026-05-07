<cfinclude template="MfaCookieCheck.cfm">
<cfif isDefined("fileUpload")>
  <cffile action="upload"
     fileField="fileUpload"
	<!---
     destination="d:\inetpub\wwwroot\InHouse\ContingLiabAdmin\Request.for.Submissions">
     destination="\\eagnmntwe17d2\shr_LDIS_D\inetpub\wwwroot\InHouse\ContingentLiabilities\Request.for.Submissions">
	--->
	
    destination="#CFFILE_RFS_Destination_Dir#">
    
     <p>Thankyou, your file has been uploaded.</p>
</cfif>
<form enctype="multipart/form-data" method="post">
<input type="file" name="fileUpload" /><br />
<input type="submit" value="Upload File" />
</form>
