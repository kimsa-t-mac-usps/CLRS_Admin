<cfinclude template="MfaCookieCheck.cfm">
<!---
For attaching a spreadsheet for a case report: new spreadsheet or updated replacement of previously saved spreadsheet.
Action file: AttachFile.uploadfileaction.cfm
--->


<script language="javascript">

function checkFileSelected(thisForm) {

if (thisForm.FiletoUpload.value == "") return false;

}

</script>


<!---
width:40%; 
--->



<body style="background:FFFFCC; line-height:150%; font-family:Verdana; font-size:9pt; color:maroon; width:80%; padding:10pt; padding-top:5pt">


<!---
<cfdirectory action="list" 
name="dirQuery" 
directory="#CFFILE_RFS_Destination_Dir#"
sort="name, datelastmodified">


<CFSET FileReplace = "no">



    <CFLOOP QUERY="dirQuery">
   
   			<CFSET savedEasternTime = DateAdd("h", 1, DateLastModified)>

    		<CFOUTPUT>

			<a href="#CFFILE_RFS_Uploads_Dir_Link##name#" class="formlink" target="_blank" style="font-weight:bold">#name#</a>
        
	        <span style="font-family:verdana; font-size:8pt; font-style:italic">(saved #DateFormat(DateLastModified, "m/d/yy")# #TimeFormat(savedEasternTime, "h:mm:ss tt")# Eastern)</span>

		    </CFOUTPUT>


    </CFLOOP>
--->



<!---
sort="name, datelastmodified desc">
--->

<cfdirectory action="list" 
name="dirQuery" 
directory="#CFFILE_RFS_Destination_Dir#"
sort="datelastmodified desc">


<CFLOOP QUERY="dirQuery" STARTROW="1" ENDROW="1">
   
	Most recently saved file:
    <br>
   
   	<CFSET savedEasternTime = DateAdd("h", 1, DateLastModified)>

	<CFOUTPUT>

	<a href="#CFFILE_RFS_Uploads_Dir_Link##name#" class="formlink" target="_blank" style="font-weight:bold">#name#</a>
        
	<br>
    <span style="font-family:verdana; font-size:8pt; font-style:italic">(saved #DateFormat(DateLastModified, "m/d/yy")# #TimeFormat(savedEasternTime, "h:mm:ss tt")# Eastern)</span>

	</CFOUTPUT>
            
            

	<script>
	
	<CFOUTPUT>
	parent.document.SendEmailForm_Latest.GCRequest_FileName.value = "#CFFILE_RFS_Uploads_Dir_Link##name#";
	</cfoutput>
	
<!---
	alert("parent.document.SendEmailForm_Latest.GCRequest_FileName.value = '" + parent.document.SendEmailForm_Latest.GCRequest_FileName.value + "'");
--->	
	
	</script>            

            

</CFLOOP>





<!---
<CFOUTPUT>
<p>
FileReplace = #FileReplace#
<p>
</CFOUTPUT>
--->


<!---
width:100%
--->




<div id="FileSelectDiv" style="width:125%; height:100%; margin-top:10pt">

To save a new file:
<br>

<div id="ClickBrowseDiv" style="margin-bottom:0">

&nbsp;&nbsp;<b>1.</b>&nbsp; Click <b>Browse</b> and select the file from your directory folder&nbsp;.&nbsp;.&nbsp;.

</div>


<!---
style="margin-top:0; margin-left:16pt"
--->



<form name="UploadFile_Form" action="SaveSelectFile.uploadfileaction.cfm" 
enctype="multipart/form-data" method="post" >


<input type="hidden" 

<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "yes">

	<cfoutput>
	name="FileReplace" value="#FileReplace#">
	</cfoutput>
    
<cfelse>

	name="FileReplace"> 

</cfif>




<!--- Initial display: Div hides remnant of text field in FiletoUpload input field: --->

<!---
background:FFFFCC
--->

<!---
<div id="HideLineDiv" style="position:absolute; z-index:10; background:FFFFCC; width:3px; height:21px; left:43px"></div>
--->


<div id="HideLineDiv" style="position:absolute; z-index:10; background:FFFFCC; width:7px; height:22px; left:40px"></div>




<!---
<div id="HideLineDiv" style="position:absolute; z-index:10; background:linen; width:7px; height:22px; left:26px"></div>
--->




<!---
margin-left:16pt; 
--->


<!---
<input id="FiletoUpload_Button" type="file" name="FiletoUpload" size="160" style="width:0px; border-width:1px; font-size:10pt" onClick="this.style.width='500px'; this.style.marginLeft='0px'; HideLineDiv.style.display = 'none'; AttachButtonDiv.style.display = 'inline'">
--->


<!---
width:90px; border-width:1px; margin-left:-4px; 

this.style.marginLeft='-0px'; 

margin-left:30px; 

--->

<input id="FiletoUpload_Button" type="file" name="FiletoUpload" size="160" style="width:90px; margin-left:27px; font-size:10pt" onClick="this.style.width='475px'; this.style.marginLeft='-0px'; ClickBrowseDiv.style.color='gray'; HideLineDiv.style.display = 'none'; AttachButtonDiv.style.display = 'inline'">






<div style="margin-top:0">


<div id="AttachButtonDiv" style="display:none; margin-top:0; margin-bottom:2pt; color:red; font-weight:bold; font-family:Verdana">

<span style="font-size:25pt; font-weight:bold; color:red; position:relative; top:+4px">&rarr;</span> 

<!---
<li>
--->


<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "no">

	&nbsp;&nbsp;<b>4.</b>&nbsp; 

<cfelse>

	&nbsp;&nbsp;<b>2.</b>&nbsp; 

</CFIF>







Then click&nbsp;&nbsp;<input id="AttachButton" type="submit" value="Save File" onClick="return checkFileSelected(this.form)" style="width:150pt; border-width:1px; background:maroon; color:white; font-weight:bold">

</div>



</div>


<!---
<CFINCLUDE TEMPLATE="AttachFile.ReturnFormFields.cfm">
--->

</form>


</div id="FileSelectDiv">



<!---
<p>
<a href="../Spreadsheets/CL.Case.template.xls" target="_blank" style="font-weight:bold">Spreadsheet Template</a>
--->

</body>
