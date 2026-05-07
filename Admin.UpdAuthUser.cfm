<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department Contingent Liabilities: Update User Access List</title>

<style>
body {font-family:arial,sans-serif;font-size:9pt; background:CCFFCC}

div.updOptions {font-family:arial,sans-serif;font-size:8pt}

td {font-family:arial,sans-serif;font-size:9pt; vertical-align:top}
td.updCell {font-family:arial,sans-serif;font-size:7pt}
td.updOptions {font-family:arial,sans-serif;font-size:8pt}
textarea {font-family:arial,sans-serif;font-size:9pt}
th.auth {font-family:arial,sans-serif;font-size:8pt; font-weight:bold; width:80pt; text-align:left}
th.name {font-family:arial,sans-serif;font-size:8pt; font-weight:bold; width:150pt; text-align:left}

A:hover {background:black; color:white; text-decoration:none; font-family:arial; font-size:9pt; font-weight:bold}
A:active {background:yellow; color:black; text-decoration:none; font-family:arial; font-size:9pt; font-weight:bold}
</style>

<script language="javascript">

function checkedMCUpdConcur(thisForm) {
/*
alert("In checkedMCUpdConcur()");
*/

if (thisForm.MCUpdConcur[0].checked == true || thisForm.MCUpdConcur[1].checked == true) {
	thisForm.AuthOption[1].checked = true
}

}


function checkedAuthOption(thisForm) {
/*
alert("In checkedAuthOption()");
*/

if (thisForm.AuthOption[0].checked == true) {
/*
	alert("thisForm.AuthOption[0].checked true");
*/

	thisForm.MCUpdConcur[0].checked = false;
	thisForm.MCUpdConcur[1].checked = false;
}

}


function showNewUserRows() {

NewUserRow.style.display = 'inline';
/*
NewUserUserIDRow.style.display = 'inline';
NewUserLogonNameRow.style.display = 'inline';
*/

}

function showUpdOptions(recordNum) {

	thisupdOptions = "updOptions_" + recordNum;
	if (document.getElementById(thisupdOptions)) eval(thisupdOptions).style.display = "inline";

<!---
	thisconcurCheckmark = "concurCheckmark_" + recordNum;
	if (document.getElementById(thisconcurCheckmark)) eval(thisconcurCheckmark).style.display = "none";
--->

	thisconcurCheckmark = "concurCheckmark_" + recordNum;
	if (document.getElementById(thisconcurCheckmark)) eval(thisconcurCheckmark).style.display = "inline";

	thisconcurCheckmark_Update = "concurCheckmark_Update_" + recordNum;
	if (document.getElementById(thisconcurCheckmark_Update)) eval(thisconcurCheckmark_Update).style.display = "inline";


}

function showUpdButton(recordNum) {

	thisupdSpan = "updSpan_" + recordNum;
	if (document.getElementById(thisupdSpan)) eval(thisupdSpan).innerHTML = '<input type="button" value="Submit Update" style="font-size: 7pt; width: 60pt" onClick="submitUpdForm(' + recordNum + ')">';

}


function submitUpdForm(recordNum) {

	var form = document.getElementById('hiddenUpdForm');
	var userprmkey = document.getElementById('hid_USERPRMKEY_' + recordNum).value;
	var title = document.getElementById('hid_TITLE_' + recordNum).value;

	document.getElementById('hid_USERPRMKEY').value = userprmkey;
	document.getElementById('hid_TITLE').value = title;
	document.getElementById('hid_DeleteFlag').value = '';
	document.getElementById('hid_Update_UserAuth').value = 'Submit Update';

	var authRadios = document.getElementsByName('AuthOption_' + recordNum);
	for (var i = 0; i < authRadios.length; i++) {
		if (authRadios[i].checked) {
			document.getElementById('hid_AuthOption').value = authRadios[i].value;
			break;
		}
	}

	var mcRadios = document.getElementsByName('MCUpdConcur_' + recordNum);
	var mcVal = '';
	for (var i = 0; i < mcRadios.length; i++) {
		if (mcRadios[i].checked) {
			mcVal = mcRadios[i].value;
			break;
		}
	}
	document.getElementById('hid_MCUpdConcur').value = mcVal;

	form.submit();

}


function setDelete(recordNum) {

DeleteConfirm();

if (DelConf==false) return false

else {

	var form = document.getElementById('hiddenUpdForm');
	var userprmkey = document.getElementById('hid_USERPRMKEY_' + recordNum).value;
	document.getElementById('hid_USERPRMKEY').value = userprmkey;
	document.getElementById('hid_DeleteFlag').value = 'Delete';
	document.getElementById('hid_Update_UserAuth').value = '';
	form.submit();

}

}

function DeleteConfirm() {

if (confirm("Are you sure you want to delete this User from the Contingent Liabilities Access List?")) { DelConf=true; }
else { DelConf=false; }

}


</script>

</head>



<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT")>
<body onLoad="NewUserForm.NewUserCustomAttrib13.focus()">
<CFELSE>
<body>
</cfif>


<h2>
<small><small><small>U.S. Postal Service Law Department
<br>
Contingent Liabilities and Receivables
</small></small>
<br>
User Access List
</h2>

<div id="TopRightLinks" style="position: absolute; top: 15; right: 60; background:ffd5aa; padding:5pt; padding-bottom:0pt; text-align:left; font-size:9pt; font-weight:bold">
&middot;&nbsp;<a href="Admin.cfm">Back to Admin Functions</a>
<p style="margin-top:6pt">
&middot;&nbsp;<a href="" onClick="showNewUserRows(); return false">Add New User</a>
</div>

<CFQUERY NAME="Get_Auth_User_PRMKEY" DATASOURCE="ContLiab">

<!--- d.sortorder --->

SELECT DISTINCT
a.USERPRMKEY, a.CONTINGENT_LIAB_AUTH, a.CONTINGENT_LIAB_CONCUR, b.EENAME, c.OFFICE, c.TITLE, e.sortorder


FROM BUSINESSSERVUSERS a, LDEXTRA b, LAWDEPARTMENT c, ldpositionsort d, ldoffices e

WHERE a.USERPRMKEY = b.PRIMARYKEY

AND c.PRIMARYKEY = b.PRIMARYKEY

AND
Trim(c.title) = Trim(d.position)

and
trim(c.OFFICE) = trim(e.OFFICE)

AND
(a.CONTINGENT_LIAB_AUTH = 'A' 
OR 
a.CONTINGENT_LIAB_AUTH = 'O' 
OR 
a.CONTINGENT_LIAB_AUTH = 'B' 
OR 
a.CONTINGENT_LIAB_AUTH = 'T')

AND
(c.SEPARATFLG != 'S'
OR
c.SEPARATFLG IS NULL
OR
c.SEPARATFLG = '0')


<CFIF IsDefined("Sort") AND Sort EQ "Authorization">

<!--- e.sortorder --->
<!--- d.sortorder --->

ORDER BY a.CONTINGENT_LIAB_AUTH, e.sortorder, c.OFFICE, a.CONTINGENT_LIAB_CONCUR, b.EENAME

<CFELSE>

ORDER BY b.EENAME

</CFIF>


</cfquery>


<CFQUERY NAME="EeList" DATASOURCE="ContLiab">
SELECT PRIMARYKEY, LASTNAME, FIRSTNAME
FROM lawdepartment
WHERE (SEPARATFLG != 'S' OR SEPARATFLG IS NULL OR SEPARATFLG = '0')

AND
lastname not like 'Select%'

AND PRIMARYKEY NOT IN
(SELECT USERPRMKEY
FROM BUSINESSSERVUSERS
WHERE (CONTINGENT_LIAB_AUTH = 'A' OR CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
AND USERPRMKEY IS NOT NULL)


ORDER BY LASTNAME, FIRSTNAME
</CFQUERY>

<table cellspacing="3" cellpadding="3">

<!--- Hidden form for submitting user auth updates --->
<form name="hiddenUpdForm" id="hiddenUpdForm" METHOD="POST" action="Admin.UpdAuthUser.Action.cfm" style="display:none">
<input type="hidden" name="USERPRMKEY" id="hid_USERPRMKEY" value="">
<input type="hidden" name="TITLE" id="hid_TITLE" value="">
<input type="hidden" name="DeleteFlag" id="hid_DeleteFlag" value="">
<input type="hidden" name="Update_UserAuth" id="hid_Update_UserAuth" value="">
<input type="hidden" name="AuthOption" id="hid_AuthOption" value="">
<input type="hidden" name="MCUpdConcur" id="hid_MCUpdConcur" value="">
</form>

<tr>
<td>&nbsp;

</td>
<th class="name">
<a href="Admin.UpdAuthUser.cfm">User</a>
</th>
<th class="auth">
<a href="Admin.UpdAuthUser.cfm?Sort=Authorization">Authorization</a>
</th>
<th class="auth">
Update Concurrence
</th>
</tr>

<CFSET RowNum = 0>

<!--- AuthOptionList =

A All
O Office
B Business Claims
T Tort Claims

--->

<CFSET AuthOptionList = "A,O,B,T">

<CFSET AuthOptionLabels = "Full&nbsp;Access&nbsp;&nbsp;,Office&nbsp;Only&nbsp;&nbsp;,Office&nbsp;/&nbsp;Business&nbsp;&nbsp;,Office&nbsp;/&nbsp;Tort">

<CFSET MCUpdConcurList = "1,2">

<CFSET MCUpdConcurLabels = "MC&nbsp;&nbsp;,Update Concurrence">


<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT")>
	<tr id="NewUserRow" style="display:inline; background:ffd5aa">
<CFELSE>
	<tr id="NewUserRow" style="display:none; background:ffd5aa">
</cfif>

<form name="NewUserForm" METHOD="POST" action="Admin.UpdAuthUser.Action.cfm">

<td>
<input type="submit" name="Insert_UserAuth" value="Submit" style="font-size: 7pt; width: 40pt">
</td>
<td>

<!---
<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT")>
<CFOUTPUT>
Form.ReturnForm_NewUser_LAW_DEPT = #Form.ReturnForm_NewUser_LAW_DEPT#
</cfoutput>
<p>
</cfif>
--->

<SELECT NAME="NewUser_LAW_DEPT" style="font-family:arial; font-size:9pt; padding-bottom:1; background:BFDFFF" SIZE="1">

<option value="" style="color:white; background:chocolate">Select an employee . . .

<CFOUTPUT QUERY="EeList">

	<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT") AND PRIMARYKEY EQ Form.ReturnForm_NewUser_LAW_DEPT>
		<option value="#PRIMARYKEY#" SELECTED>#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
	<CFELSE>
		<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
	</cfif>

</cfoutput>

</select>

</td>
<td class="updOptions">

<CFSET AuthOptionLabels_Count = 0>

<CFLOOP INDEX="AuthOptionList_Index" LIST="#AuthOptionList#">

	<CFSET AuthOptionLabels_Count = AuthOptionLabels_Count + 1>
	
	<CFIF IsDefined("Form.ReturnForm_SelectedAuthOption") AND Form.ReturnForm_SelectedAuthOption EQ AuthOptionList_Index>
		<CFSET AuthCheckedWord = "Checked">
	<CFELSE>
		<CFSET AuthCheckedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" onClick="checkedAuthOption(this.form)" name="AuthOption" value="#AuthOptionList_Index#" #AuthCheckedWord#>#ListGetAt(AuthOptionLabels, AuthOptionLabels_Count)#
	</cfoutput>
	
</cfloop>

<br>

<CFSET MCUpdConcurLabels_Count = 0>

<CFLOOP INDEX="MCUpdConcurList_Index" LIST="#MCUpdConcurList#">

	<CFSET MCUpdConcurLabels_Count = MCUpdConcurLabels_Count + 1>
	
	<CFIF IsDefined("Form.ReturnForm_SelectedMCUpdConcurOption") 
	AND 
	Form.ReturnForm_SelectedMCUpdConcurOption EQ MCUpdConcurList_Index>
    
		<CFSET MCUpdConcurCheckedWord = "Checked">

	<CFELSE>

		<CFSET MCUpdConcurCheckedWord = "">

	</cfif>
	
	<CFOUTPUT>
	<input type="radio" onClick="checkedMCUpdConcur(this.form)" name="MCUpdConcur" value="#MCUpdConcurList_Index#" #MCUpdConcurCheckedWord#>#ListGetAt(MCUpdConcurLabels, MCUpdConcurLabels_Count)#
	</cfoutput>

</cfloop>


</td>
<!---
</form>
--->
</tr>

<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT")>

	<tr id="NewUserUserIDRow" style="display:inline; background:ffd5aa">
	
	<td>&nbsp;
	
	</td>
	
	<td>&nbsp;
	
	</td>
	
	<td class="updOptions">
	<input type="text" name="NewUserCustomAttrib13" size="10" maxlength="10">
	User ID (Custom Attrib 13)
	</td>
	
	</tr>

</cfif>


<CFIF IsDefined("Form.ReturnForm_NewUser_LAW_DEPT")>

	<tr id="NewUserLogonNameRow" style="display:inline; background:ffd5aa">
	
	<td>&nbsp;
	
	</td>
	
	<td>&nbsp;
	
	</td>
	
	<td class="updOptions">
	<input type="text" name="NewUserLogonName" size="10" maxlength="10">
	Logon Name
	</td>
	
	</tr>

</cfif>


</form>


<CFLOOP QUERY="Get_Auth_User_PRMKEY">

	
	<CFIF OFFICE CONTAINS "St. Louis">
		<CFSET AuthOptionLabels = "Full&nbsp;Access&nbsp;&nbsp;,Office&nbsp;Only&nbsp;&nbsp;,Office&nbsp;/&nbsp;Business&nbsp;&nbsp;,Office&nbsp;/&nbsp;Tort">
		<CFSET AuthOptionList = "A,O,B,T">
	<CFELSE>
		<CFSET AuthOptionLabels = "Full&nbsp;Access&nbsp;&nbsp;,Office&nbsp;Only&nbsp;&nbsp;">
		<CFSET AuthOptionList = "A,O">
	</cfif>
	
	<CFSWITCH EXPRESSION="#CONTINGENT_LIAB_AUTH#">
	
	<CFCASE VALUE="A">
		<CFSET AuthText = "Full Access">
	</cfcase>
	
	<CFCASE VALUE="O">
	
		<CFIF OFFICE CONTAINS "Southeast">
			<CFSET AuthText = "Southeast">
		<CFELSE>
			<CFSET AuthText = Trim(OFFICE)>
		</cfif>
	
	</cfcase>
	
	<CFCASE VALUE="B">
		<CFSET AuthText = Trim(OFFICE) & " / Business Claims">
	</cfcase>
	
	<CFCASE VALUE="T">
		<CFSET AuthText = Trim(OFFICE) & " / Tort Claims">
	</cfcase>
	
	</cfswitch>
	
	<CFINCLUDE TEMPLATE="rowcolor.alternate.cfm">
	
	<CFOUTPUT>
	<tr style="background:#RowColor#">
	</cfoutput>
	
	<CFOUTPUT>
	
	<td class="updCell">
	<input type="hidden" id="hid_USERPRMKEY_#Get_Auth_User_PRMKEY.CurrentRow#" value="#USERPRMKEY#">
	<input type="hidden" id="hid_TITLE_#Get_Auth_User_PRMKEY.CurrentRow#" value="#TITLE#">
	
	</cfoutput>
	
	<CFOUTPUT>
	<span id="updSpan_#Get_Auth_User_PRMKEY.CurrentRow#">[<a href="" onClick="showUpdOptions(#Get_Auth_User_PRMKEY.CurrentRow#); return false">Update</a>]&nbsp;&nbsp;[<a href="" onClick="setDelete(#Get_Auth_User_PRMKEY.CurrentRow#); return false">Delete</a>]</span>
	</cfoutput>
	</td>
	
	
	<td>
	<CFOUTPUT>
	#Trim(EENAME)#
	</cfoutput>
	</td>
	<td>
	
	
	<CFOUTPUT>
	#AuthText#
	</cfoutput>
	
	
	<CFOUTPUT>
	<div class="updOptions" id="updOptions_#Get_Auth_User_PRMKEY.CurrentRow#" style="display:none">
	</cfoutput>
	
	<br>
	
	
	<CFSET AuthOptionLabels_Count = 0>
	
	<CFLOOP INDEX="AuthOptionList_Index" LIST="#AuthOptionList#">
	
		<CFSET AuthOptionLabels_Count = AuthOptionLabels_Count + 1>
		
		<CFIF CONTINGENT_LIAB_AUTH EQ AuthOptionList_Index>
			<CFSET AuthCheckedWord = "CHECKED">
		<CFELSE>
			<CFSET AuthCheckedWord = "">
		</cfif>
		
		<CFOUTPUT>
		<input type="radio" name="AuthOption_#Get_Auth_User_PRMKEY.CurrentRow#" value="#AuthOptionList_Index#" onClick="showUpdButton(#Get_Auth_User_PRMKEY.CurrentRow#)" #AuthCheckedWord#>#ListGetAt(AuthOptionLabels, AuthOptionLabels_Count)#
		</cfoutput>
		
	</cfloop>
	
	
	<br>
	
	<CFSET MCUpdConcurLabels_Count = 0>
	
	<CFLOOP INDEX="MCUpdConcurList_Index" LIST="#MCUpdConcurList#">
	
		<CFSET MCUpdConcurLabels_Count = MCUpdConcurLabels_Count + 1>
		
		<CFIF CONTINGENT_LIAB_CONCUR EQ MCUpdConcurList_Index>
			<CFSET MCUpdConcurCheckedWord = "CHECKED">
		<CFELSE>
			<CFSET MCUpdConcurCheckedWord = "">
		</cfif>
		
		<CFOUTPUT>
		<input type="radio" name="MCUpdConcur_#Get_Auth_User_PRMKEY.CurrentRow#" value="#MCUpdConcurList_Index#" onClick="showUpdButton(#Get_Auth_User_PRMKEY.CurrentRow#)" #MCUpdConcurCheckedWord#>#ListGetAt(MCUpdConcurLabels, MCUpdConcurLabels_Count)#
		</cfoutput>
		
	</cfloop>
	
	
	</div>
	
	</td>
	
	<td align="center">
	
	<CFIF 
	(
	Get_Auth_User_PRMKEY.CONTINGENT_LIAB_AUTH EQ "O" 
	AND 
	Left(Get_Auth_User_PRMKEY.TITLE, 8) EQ "Managing"
	)
	OR
	Get_Auth_User_PRMKEY.CONTINGENT_LIAB_CONCUR EQ 1>
	
		<b>MC</b>
	
	<CFELSE>
	
		<CFIF Get_Auth_User_PRMKEY.CONTINGENT_LIAB_CONCUR GT 1 
		AND 
		Get_Auth_User_PRMKEY.CONTINGENT_LIAB_CONCUR LT 9>
        
		<CFOUTPUT>
		<div id="concurCheckmark_#Get_Auth_User_PRMKEY.CurrentRow#">
		<span style="font-size:14pt; font-weight:bold">&##10004;</span>
		</div>
		</cfoutput>
		
        </cfif>
	
	</cfif>
	
	</td>
	
	</tr>

<!--- Close <CFLOOP QUERY="Get_Auth_User_PRMKEY"> --->
</cfloop>


</table>

</body>
</html>

