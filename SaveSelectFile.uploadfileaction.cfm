<cfinclude template="MfaCookieCheck.cfm">
<!---
Action file for attaching a spreadsheet for a case report: new spreadsheet or updated replacement of previously saved spreadsheet.
Uploads file to Web server directory (CFFILE_Destination_Dir, etc., in application.cfm
Updates CONTINGENT_LIAB_REPORT table for current case report.
Calling file: AttachFile.cfm
--->

<html xmlns="https://www.w3.org/1999/xhtml">
<head>

<title>Upload File</title>

<style>

th {text-align:left; font-size:7pt}

</style>

</head>

<body style="font-family:verdana; font-size:8pt">

<!---
<CFIF IsDefined("Form.FileReplace")
AND
Form.FileReplace EQ "yes">

	Form.FileReplace = 
    
    <cfoutput>
    #Form.FileReplace#
    </cfoutput>

	<cfabort>

</CFIF>
--->



<!---
<CFINCLUDE TEMPLATE="AttachFile.CFSETDestination_Dir.cfm">
--->


<CFIF NOT DirectoryExists(CFFILE_RFS_Destination_Dir)>

	<cfdirectory action = "create" directory = "#CFFILE_RFS_Destination_Dir#">

</CFIF>




<!---
<CFIF IsDefined("Form.FileReplace")
AND
Form.FileReplace EQ "yes">

	<CFSET FileToDelete = CFFILE_RFS_Destination_Dir & "CL.Case." & Form.CaseRecIDSeq & ".GC.xls">

	<cffile action="delete"
    	    file="#FileToDelete#">

</CFIF>
--->


<cffile action="upload"
        destination="#CFFILE_RFS_Destination_Dir#"
        nameConflict="overwrite"
        fileField="Form.FiletoUpload">

<!---
<CFSET FileName_Ext = cffile.ClientFileName & "." & cffile.ClientFileExt>


<CFSET Rename_Source = CFFILE_Destination_Dir & FileName_Ext>
<CFSET Rename_Destination = CFFILE_Destination_Dir & "CL.Case." & Form.CaseRecIDSeq & ".GC.xls">

<cffile action="rename"
	source = "#Rename_Source#"  
    destination = "#Rename_Destination#">
--->


<!---

spreadsheet_flag              CHAR(1),
  spreadsheet_by_userid         VARCHAR2(10),
  spreadsheet_by_displayname    VARCHAR2(512),
  spreadsheet_saved_date        DATE,
  spreadsheet_by_dept           VARCHAR2(10),
  submitted_by_dept             VARCHAR2(50)
  
--->


<!---
<CFOUTPUT>
--->


<!---

<CFQUERY NAME="CONTINGENT_LIAB_Update_Spsheet" DATASOURCE="ContLiab">


UPDATE CONTINGENT_LIAB_REPORT

SET

spreadsheet_flag = 'S',
spreadsheet_by_userid = '#RespondingUser_Id#',
spreadsheet_by_displayname = '#Replace(QueryGetDisplayName.displayName, "'", "''", "ALL")#',
spreadsheet_saved_date = SYSDATE,
spreadsheet_by_dept = 'GC'

WHERE PRIMARYKEY = #Form.RecID#


</CFQUERY>

--->


<!---
</CFOUTPUT>

<cfabort>
--->


<form name="ReturnForm" method="post">


</form>


<script language="javascript">

ReturnForm.action = "SaveSelectFile.cfm";

ReturnForm.submit();

</script>



</body>
</html>

