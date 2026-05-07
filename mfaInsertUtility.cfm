<!---
    This file hopefully will loop through the directory and check for existence of 
    "<cfinclude template="MfaCookieCheck.cfm">" at the top of the file
    if this line of code does not exist, it will be inserted and the file saved
--->
<!---
    1. get list of files with .cfm extension but not this file and not application.cfm, MfaCookieCheck.cfm, or mfaInsertUtility.cfm 
    2. read the contents of the file into a string
    3. search the contents string for the <cfinclude above 
    4. if the result is zero, create a new file cffile=write with the cfinclude then append the contents string 
    5. save as the original path/file
--->
<cftry>
<cfset fileList = directoryList(path="D:\web\cf\cfusion\wwwroot\inhouse\contingliabadmin", recurse="false" ,listInfo="path" ,filter="*.cfm" ,type="all")>
<cfdump var="#fileList#" >
<cfset doNotIncludeList = "application.cfm,MfaCookieCheck.cfm,mfaInsertUtility.cfm,cfswitch.serveraddr_id.cfm,serverName.cfm">
<cfset writeContent = '<cfinclude template="MfaCookieCheck.cfm">'>
<cfloop from="1" to="#arraylen(fileList)#" index="i">
   
    <cfif listfindNocase(doNotIncludeList,getFileFromPath(fileList[i])) eq 0>
        <cffile action="read" file="#fileList[i]#" variable="fileContents">
        <cfif findNoCase('<cfinclude template="MfaCookieCheck.cfm">',fileContents) eq 0>
            <cffile action="write" file="#fileList[i]#" output="#writeContent#">
            <cffile action="append" file="#fileList[i]#" output="#fileContents#"> 
            <cfoutput><p>#i# #fileList[i]#</p></cfoutput>
        </cfif>
    </cfif>
</cfloop>    
    <cfcatch type="any">
        <cfdump var="#cfcatch#">
    </cfcatch>
</cftry>