<cfinclude template="MfaCookieCheck.cfm">
<!---
<CFOUTPUT>
OldList = "#OldList#"
<p>
NewList = "#NewList#"
<p>
</cfoutput>
--->


<CFSET ThisOldList = REReplace(OldList, "&quot;", """", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "   ", " ", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "  ", " ", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList,"\", "", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''''", "'", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>

<CFSET ThisNewList = NewList>
<CFSET ThisNewList = Replace(ThisNewList, "   ", " ", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "  ", " ", "ALL")>

<CFSET ThisNewList = Replace(ThisNewList,"\", "", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>

<CFIF Compare(ThisOldList, ThisNewList) NEQ 0>

<CFSET ThisOldList = JSStringFormat(ThisOldList)>

<CFSET ThisOldList = Replace(ThisOldList, "\r\n", "<br>", "ALL")>
<!---
<CFSET ThisOldList = Replace(ThisOldList, "<br>", "<br> ", "ALL")>
--->
<CFSET ThisOldList = Replace(ThisOldList, "<br><br>", "<br><br> ", "ALL")>

<CFSET ThisOldList = Replace(ThisOldList,"\", "", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''''", "'", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>
<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>

<CFSET OldArray = ListToArray(ThisOldList, " ")>

<CFSET ThisNewList = JSStringFormat(ThisNewList)>

<CFSET ThisNewList = Replace(ThisNewList, "\r\n", "<br>", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "<br><br>", "<br><br> ", "ALL")>

<CFSET ThisNewList = Replace(ThisNewList,"\", "", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>

<CFSET NewArray = ListToArray(ThisNewList, " ")>

<CFSET NewListExtraLength = 0>

<CFSET CrxList = "">

<CFSET OldArrayLen = ArrayLen(OldArray)>
<CFSET NewArrayLen = ArrayLen(NewArray)>

<!---
<CFOUTPUT>
OldArrayLen = #OldArrayLen#
<p>
NewArrayLen = #NewArrayLen#
<p>
</cfoutput>
--->

<CFSET StartCrx = 0>
<CFSET EndCrx = 0>
<CFSET NewArrayIndex = 0>

<CFLOOP INDEX="OldArrayIndex" FROM="1" TO="#OldArrayLen#">

<!---
<CFOUTPUT>
<script language="javascript">
alert("Outer Loop: StartCrx = #StartCrx#; EndCrx = #EndCrx#; NewArrayIndex = #NewArrayIndex#")
</script>
</cfoutput>
--->

<CFIF NewArrayIndex EQ 0>
	<CFSET NewArrayComparIndex = OldArrayIndex>
<CFELSE>

	<CFIF NewArrayIndex LT NewArrayLen>
		<CFSET NewArrayIndex = NewArrayIndex + 1>
	</cfif>
	
	<CFSET NewArrayComparIndex = NewArrayIndex> 
</cfif>

<!---
<CFOUTPUT>
<script language="javascript">
alert("OldArray[#OldArrayIndex#] = #OldArray[OldArrayIndex]#; NewArray[#NewArrayComparIndex#] = #NewArray[NewArrayComparIndex]#")
</script>
</cfoutput>
--->

<CFSET PhraseFlag = "">

<CFIF OldArray[OldArrayIndex] NEQ NewArray[NewArrayComparIndex]>

<!---
<CFIF (NewArray[NewArrayComparIndex] CONTAINS "<br>")>

<CFOUTPUT>
<script language="javascript">
alert("NewArray[#NewArrayComparIndex#] = '#NewArray[NewArrayComparIndex]#'")
</script>
</cfoutput>

</cfif>
--->

<CFIF NewArray[NewArrayComparIndex] NEQ (OldArray[OldArrayIndex] & "<br><br>") AND NewArray[NewArrayComparIndex] NEQ (OldArray[OldArrayIndex] & ".") AND NewArray[NewArrayComparIndex] NEQ (OldArray[OldArrayIndex] & ",") AND NewArray[NewArrayComparIndex] NEQ (OldArray[OldArrayIndex] & ";")>


<CFIF StartCrx EQ 0>
<CFSET StartCrx = NewArrayComparIndex>

<!---
<CFOUTPUT>
<script language="javascript">
alert("StartCrx = #StartCrx#")
</script>
</cfoutput>
--->

</cfif>

<!---
<CFSET NewArrayIndexStart = NewArrayComparIndex + 1>
--->

<CFLOOP INDEX="NewArrayIndex" FROM="#(NewArrayComparIndex + 1)#" TO="#NewArrayLen#">

<CFIF OldArray[OldArrayIndex] NEQ NewArray[NewArrayIndex]>
	<CFSET EndCrx = NewArrayIndex>

<!---
<CFOUTPUT>
<script language="javascript">
alert("Inner Loop: EndCrx = #EndCrx#")
</script>
</cfoutput>
--->


<CFELSE>

<!---
<CFOUTPUT>
<script language="javascript">
alert("Inner Loop: Match; EndCrx = #EndCrx#")
</script>
</cfoutput>
--->

	<CFLOOP INDEX="PhraseWordIndex" FROM="1" TO="2">
	
	<CFSET OldArrayIndexLookAhead = OldArrayIndex + PhraseWordIndex>
	<CFSET NewArrayIndexLookAhead = NewArrayIndex + PhraseWordIndex>
	
	<CFIF OldArrayIndexLookAhead LE OldArrayLen AND NewArrayIndexLookAhead LE NewArrayLen>
	
		<CFIF OldArray[OldArrayIndexLookAhead] EQ NewArray[NewArrayIndexLookAhead]>
		
			<CFSET PhraseFlag = "PhraseMatch">
		
		</cfif>
	
	<CFELSE>
	
		<CFSET PhraseFlag = "PhraseMatch">
	
	</cfif>
	
	</cfloop>



	<CFIF IsDefined("PhraseFlag") AND PhraseFlag EQ "PhraseMatch">

	<CFIF EndCrx EQ 0>
		<CFSET EndCrx = NewArrayIndex - 1>
	</cfif>
	
	<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>

<!---
<CFOUTPUT>
<script language="javascript">
alert("CrxList = #CrxList#")
</script>
</cfoutput>
--->

	<CFSET StartCrx = 0>
	<CFSET EndCrx = 0>

<!---
<CFOUTPUT>
<script language="javascript">
alert("StartCrx = #StartCrx#; EndCrx = #EndCrx#")
</script>
</cfoutput>
--->


	<CFBREAK>
	
	</cfif>
	
</cfif>

</cfloop>

<CFIF NewArrayIndex GT NewArrayLen>
	<CFSET NewArrayIndex = StartCrx>
</cfif>


</cfif>


<!---
<CFOUTPUT>
<script language="javascript">
alert("After Inner Loop: NewArrayIndex = #NewArrayIndex#")
</script>
</cfoutput>
--->

<CFELSEIF StartCrx GT 0>
	<CFSET EndCrx = NewArrayIndex - 1>

	<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>

<!---
	<CFOUTPUT>
	<script language="javascript">
	alert("CrxList = #CrxList#")
	</script>
	</cfoutput>
--->

	<CFSET StartCrx = 0>
	<CFSET EndCrx = 0>

<!---
	<CFOUTPUT>
	<script language="javascript">
	alert("StartCrx = #StartCrx#; EndCrx = #EndCrx#")
	</script>
	</cfoutput>
--->

</cfif>

</cfloop>

<!--- If text was completely replaced:
--->
<CFIF CrxList EQ "" AND EndCrx EQ NewArrayLen>
	<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>
</cfif>

<!---
<CFOUTPUT>
<b>CrxList = "#CrxList#"</b>
<p>
</cfoutput>
--->

<CFIF CrxList NEQ "">

<!---
<CFOUTPUT>
<b>CrxList = "#CrxList#"</b>
<p>
</cfoutput>
--->

<CFSET CrxArray = ListToArray(CrxList, ";")>
<CFSET CrxArrayLen = ArrayLen(CrxArray)>

<CFLOOP INDEX="CrxArrayIndex" FROM="1" TO="#CrxArrayLen#">

<CFSET StartCrx = ListGetAt(CrxArray[CrxArrayIndex], 1)>

<!---
<CFOUTPUT>
StartCrx = #StartCrx#
<br>
</cfoutput>
--->

<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, StartCrx, " ")>


<CFSET ThisNewList = ListSetAt(ThisNewList, StartCrx, "#NewStartCrxVal#", " ")>

<CFSET EndCrx = ListGetAt(CrxArray[CrxArrayIndex], 2)>

<!---
<CFOUTPUT>
EndCrx = #EndCrx#
<p>
</cfoutput>
--->

<CFSET NewEndCrxVal = ListGetAt(ThisNewList, EndCrx, " ") & "</strong>">


<CFSET ThisNewList = ListSetAt(ThisNewList, EndCrx, "#NewEndCrxVal#", " ")>

<CFSET NewListExtraLength = NewListExtraLength + (EndCrx - StartCrx) + 1>

</cfloop>

<CFIF ListLen(ThisNewList, " ") GT (ListLen(ThisOldList, " ") + NewListExtraLength)>


<CFSET NewStartCrxPos = ListLen(ThisOldList, " ") + NewListExtraLength + 1>

<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, NewStartCrxPos, " ")>

<CFSET ThisNewList = ListSetAt(ThisNewList, NewStartCrxPos, "#NewStartCrxVal#", " ")>

<!---
<CFSET NewEndCrxVal = ListLast(NewList, " ") & "</strong>">
<CFSET NewList = ListSetAt(NewList, NewEndCrxPos, "#NewEndCrxVal#", " ")>
--->

<CFSET ThisNewList = ThisNewList & "</strong>">



</cfif>


<CFELSE>
<!--- If new text not equal to old, but no changes found within old version, assume new text added at end: --->

<CFIF NewArrayLen GT 1>
	<CFSET NewStartCrxPos = ListLen(ThisOldList, " ") + 1>
<CFELSE>
	<CFSET NewStartCrxPos = 1>
</cfif>

<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, NewStartCrxPos, " ")>

<CFSET ThisNewList = ListSetAt(ThisNewList, NewStartCrxPos, "#NewStartCrxVal#", " ")>

<!---
<CFSET NewEndCrxVal = ListLast(NewList, " ") & "</strong>">
<CFSET NewList = ListSetAt(NewList, NewEndCrxPos, "#NewEndCrxVal#", " ")>
--->

<CFSET ThisNewList = ThisNewList & "</strong>">

</cfif>


<!---
<CFSET ThisNewList = Replace(ThisNewList, "\r\n", "<br>", "ALL")>
--->

<CFOUTPUT>
#ThisNewList#
</cfoutput>


<CFELSE>

<!---
<CFSET ThisOldList = Replace(ThisOldList, "\r\n", "<br>", "ALL")>
--->

<CFOUTPUT>
#ThisOldList# 
</cfoutput>

<!---
<br>
[No Changes]
--->

</cfif>


