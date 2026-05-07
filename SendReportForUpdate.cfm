<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!---
Change 11/15/11:
EOY Report e-mail ToList now includes individual attorneys as well as managers, just like Quarterly reports.
--->


<html>
<head>
<title>Law Department Contingent Liabilities: Send E-mail Notice</title>
</head>

<body>

<CFSET EndOfYearFlag = "">

<!---
<CFIF IsDefined("Form.MAGRequest_FileName")>

<!---
GAC - 09/03/2013 - Changing location of Request for Submissions PDF
<CFSET MAGFilePathFilename = "D:\Inetpub\wwwroot\InHouse\ContingentLiabilities\Request.for.Submissions\" & Form.MAGRequest_FileName>
--->

<CFSET MAGFilePathFilename = "D:\Inetpub\wwwroot\InHouse\ContingLiabAdmin\Request.for.Submissions\" & Form.MAGRequest_FileName>

</cfif>
--->

<!---
<CFIF IsDefined("Form.MAGRequest_FileName") AND NOT FileExists(MAGFilePathFilename)>

<script language="javascript">
//alert("<cfoutput>#MAGFilePathFilename#</cfoutput>");
alert("Sorry, I can't find the specified file for Tom Marshall's Request." + "\r\n \r\n" + "Please verify filename and make sure file is saved in the specified Folder.");
history.back();
</script>

<CFELSE>
--->

<CFIF IsDefined("Form.Sender") AND Form.Sender NEQ "">


	<CFQUERY NAME="Check_Sender_Auth_User_A" DATASOURCE="ContLiab">
	SELECT a.LASTNAME, a.FIRSTNAME, a.LONGEMAIL, a.PRIMARYKEY
	FROM lawdepartment a
	WHERE
	(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')
	AND
	a.PRIMARYKEY = (SELECT USERPRMKEY
	FROM BUSINESSSERVUSERS
	WHERE CONTINGENT_LIAB_AUTH = 'A'
	AND (UPPER(AD_USERID) LIKE UPPER('#Form.Sender#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#Form.Sender#%')))
	</cfquery>
	
	<CFIF Check_Sender_Auth_User_A.RecordCount EQ 1>
	
		<CFSET TrimLastName = Trim(Check_Sender_Auth_User_A.LASTNAME)>
		<CFSET TrimFirstName = Trim(Check_Sender_Auth_User_A.FIRSTNAME)>
		<CFSET TrimEMailAddr = Trim(Check_Sender_Auth_User_A.LONGEMAIL)>
		
		<CFIF TrimEMailAddr EQ "">

			<CFSET DefaultLongEmailFirstName = Replace(TrimFIRSTNAME, " ", ".", "ALL")>
			<CFSET DefaultLongEmailFirstName = Replace(DefaultLongEmailFirstName, "..", "", "ALL")>
		
			<CFIF Right(DefaultLongEmailFirstName, 1) NEQ ".">
				<CFSET DefaultLongEmailFirstName = DefaultLongEmailFirstName & ".">
			</cfif>
            
			<CFSET TrimEMailAddr = DefaultLongEmailFirstName & TrimLASTNAME>

		</cfif>
		
		<CFSET Sender_TrimEMailAddr = TrimEMailAddr & "@usps.gov">
	

		<CFQUERY NAME="Update_Intro_Note" DATASOURCE="ContLiab">
		
		UPDATE BUSINESSSERVUSERS
		SET
		
		CONTING_LIAB_INTRO_NOTE =
		
		<CFIF IsDefined("Form.IntroNote") AND Trim(Form.IntroNote) NEQ "">
		
			<CFSET TrimIntro_Note = JSStringFormat(Form.IntroNote)>
			<CFSET TrimIntro_Note = Replace(TrimIntro_Note, "\r\n", "<br>", "ALL")>
			<CFSET TrimIntro_Note = Replace(TrimIntro_Note, '\"', '"', 'ALL')>
			<CFSET TrimIntro_Note = Replace(TrimIntro_Note, "\'", "'", "ALL")>
			
			<CFSET Orig_String = TrimIntro_Note>
			<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
			<CFSET TrimIntro_Note = Result_String>
			
			'#TrimIntro_Note#',
			
		<CFELSE>
			
			NULL,
		
		</CFIF>
		
		
		CONTING_LIAB_INTR_EOY =
		
		
		<CFIF IsDefined("Form.IntroNote_EOY") AND Form.IntroNote_EOY NEQ "">
		
			<CFSET TrimIntro_Note_EOY = JSStringFormat(Form.IntroNote_EOY)>
			<CFSET TrimIntro_Note_EOY = Replace(TrimIntro_Note_EOY, "\r\n", "<br>", "ALL")>
			<CFSET TrimIntro_Note_EOY = Replace(TrimIntro_Note_EOY, '\"', '"', 'ALL')>
			<CFSET TrimIntro_Note_EOY = Replace(TrimIntro_Note_EOY, "\'", "'", "ALL")>
			
			<CFSET Orig_String = TrimIntro_Note_EOY>
			<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
			<CFSET TrimIntro_Note_EOY = Result_String>
			
			'#TrimIntro_Note_EOY#'
			
		<CFELSE>
		
			NULL
		
		</CFIF>


		WHERE USERPRMKEY = #Check_Sender_Auth_User_A.PRIMARYKEY#

		</cfquery>

<!--- Close 	<CFIF Check_Sender_Auth_User_A.RecordCount EQ 1> --->
	</cfif>


<!--- Close <CFIF IsDefined("Form.Sender") AND Form.Sender NEQ ""> --->
</cfif>


<CFSET ThisReportDate = Form.ReportDate>

<!---
Check for records for ThisReportDate:
--->

<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_ThisReportDate" DATASOURCE="ContLiab">

SELECT CASE_REC_ID_SEQUENCE

FROM CONTINGENT_LIAB_REPORT

WHERE

DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

</cfquery>


<CFIF CONTINGENT_LIAB_GetRecord_ThisReportDate.RecordCount EQ 0>

	<script language="javascript">
	alert("Sorry, Case Records have not yet been loaded for this report.");
	history.back();
	</script>

<CFELSE>

	<CFSET EMailSuffix = "usps.gov">

	<CFSET ThisReportDate_CalYear = DatePart("yyyy", ThisReportDate)>

	<CFIF ThisReportDate GT "10/1/#ThisReportDate_CalYear#" 
	AND 
	ThisReportDate LT "12/1/#ThisReportDate_CalYear#">
    
		<!--- For End of Year report: --->
		<CFSET ThisReportDate_FY = ThisReportDate_CalYear>
		<CFSET EndOfYearFlag = "EOY">
	
	<CFELSEIF ThisReportDate LT "10/1/#ThisReportDate_CalYear#">
	
    	<CFSET ThisReportDate_FY = ThisReportDate_CalYear>
	
    <CFELSE>
	
    	<CFSET ThisReportDate_FY = ThisReportDate_CalYear + 1>
	
    </cfif>


	<CFIF EndOfYearFlag EQ "EOY">
	
		<CFSET ThisReportEmailSubjDate = "End of Year">
	
	<CFELSE>
	
		<CFSET ThisReportDate_CalQuarter = DatePart("q", ThisReportDate)>
		
		<CFSET ThisReportDate_CalQuarter_Num = LSParseNumber(ThisReportDate_CalQuarter)>
		
		<CFIF ThisReportDate_CalQuarter_Num EQ 4>
			<CFSET ThisReportDate_CalQuarter_Num = 0>
		</cfif>
		
		<CFSET ThisReportDate_FYQuarter = ThisReportDate_CalQuarter_Num + 1>
		
		<CFSWITCH EXPRESSION="#ThisReportDate_FYQuarter#">
		
			<CFCASE VALUE="1">
				<CFSET ThisReportDate_FYQuarter_Roman = "I">
			</cfcase>
			
			<CFCASE VALUE="2">
				<CFSET ThisReportDate_FYQuarter_Roman = "II">
			</cfcase>
			
			<CFCASE VALUE="3">
				<CFSET ThisReportDate_FYQuarter_Roman = "III">
			</cfcase>
			
			<CFCASE VALUE="4">
				<CFSET ThisReportDate_FYQuarter_Roman = "IV">
			</cfcase>
		
		</cfswitch>
	
	
		<CFSET ThisReportDate_CalQuarter = "FY " & ThisReportDate_FY & ", Quarter " & ThisReportDate_FYQuarter_Roman>
	
		<CFSET ThisReportEmailSubjDate = "Quarter " & ThisReportDate_FYQuarter>
	
	</cfif>


	<CFQUERY NAME="GetAll_Auth_User_A" DATASOURCE="ContLiab">
	
	SELECT lawdepartment.LASTNAME, lawdepartment.FIRSTNAME, lawdepartment.OFFICE, lawdepartment.LONGEMAIL, 
    
    BUSINESSSERVUSERS.AD_MAILNICKNAME, 
    BUSINESSSERVUSERS.AD_USERID
	
	FROM BUSINESSSERVUSERS, lawdepartment
	
	WHERE BUSINESSSERVUSERS.USERPRMKEY = lawdepartment.PRIMARYKEY
	
	AND BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH = 'A'
	
	AND (lawdepartment.SEPARATFLG != 'S' OR lawdepartment.SEPARATFLG IS NULL)
	
	ORDER BY lawdepartment.LASTNAME
	
	</cfquery>
	
	
	<CFSET OfficeScope = "All">
	
	<CFSET ToList = "">
	
	<CFLOOP QUERY="GetAll_Auth_User_A">
	
		<CFINCLUDE TEMPLATE="email.setToList.cfm">


    	<!--- Capture first user as potential "From" user for "No Cases" e-mail reply to Business Services:
	--->
			<CFIF GetAll_Auth_User_A.CurrentRow EQ 1>
				<CFSET FromUser = AD_USERID>
			</cfif>

	
	</CFLOOP>
	
    
    

    
    
    
    
    

	<CFINCLUDE TEMPLATE="email.cfmail.cfm">


	<CFSET OfficeScope = "OfficeOnly">
	
	<CFQUERY NAME="GetAll_Offices" DATASOURCE="ContLiab">
	
	SELECT DISTINCT
    
    OFFICE_PRM_KEY, OFFICE AS OFFICE_LDOFFICES
	FROM LDOFFICES
	
	WHERE OFFICE != ' '
	AND OFFICE NOT LIKE 'Deputy%'
	AND OFFICE NOT LIKE 'Directories%'
	AND OFFICE NOT LIKE '%Ethics%'
	AND OFFICE NOT LIKE 'Field%'
    
<!---    
	AND OFFICE NOT LIKE 'General%'
--->	

	AND OFFICE NOT LIKE 'General Counsel%'
	
	AND OFFICE NOT LIKE 'Headquarters%'
	AND OFFICE NOT LIKE 'HQ Business%'
	AND OFFICE NOT LIKE 'HQ Environ%'
	AND OFFICE NOT LIKE 'HQ Facilities%'
	AND OFFICE NOT LIKE 'HQ Integration%'
    
<!---    
	AND OFFICE NOT LIKE 'National%'
--->	
	
	AND OFFICE NOT LIKE 'NC%'
	AND OFFICE NOT LIKE 'Privacy%'
	AND OFFICE NOT LIKE 'Revenue%'
	AND OFFICE NOT LIKE 'Select%'
	AND OFFICE NOT LIKE '%Atlanta%'

<!--- Elim Tort to avoid duplication with Gen Law Service Ctr --->
	AND OFFICE NOT LIKE '%Tort%'
	
	AND
	DELETE_FLAG IS NULL
	
	ORDER BY OFFICE
	
	</cfquery>
	
	
	<CFOUTPUT>
	GetAll_Offices.RecordCount = #GetAll_Offices.RecordCount#
	<p>
	</cfoutput>
	
	
	
	<CFLOOP QUERY="GetAll_Offices">
	
		<CFSET Trim_OFFICE_LDOFFICES = Trim(OFFICE_LDOFFICES)>
		
		<CFIF Left(Trim_OFFICE_LDOFFICES, 9) EQ "Southeast">
			<CFSET Trim_OFFICE_LDOFFICES = "Southeast">
		</cfif>
		
		
		<CFOUTPUT>
		OFFICE = #Trim_OFFICE_LDOFFICES#
		<p>
		</cfoutput>
		
		
		<CFQUERY NAME="GetAll_Auth_Users_Office" DATASOURCE="ContLiab">

		
		SELECT DISTINCT 
        lawdepartment.LASTNAME, lawdepartment.FIRSTNAME, lawdepartment.OFFICE, lawdepartment.LONGEMAIL, lawdepartment.PRIMARYKEY, BUSINESSSERVUSERS.AD_USERID, BUSINESSSERVUSERS.AD_MAILNICKNAME, BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH, LDOFFICES.OFFICE_PRM_KEY, LDPOSITIONSORT.SORTORDER
		
		FROM lawdepartment, BUSINESSSERVUSERS, LDOFFICES, LDPOSITIONSORT
		
		WHERE lawdepartment.PRIMARYKEY = BUSINESSSERVUSERS.USERPRMKEY
		
		AND LAWDEPARTMENT.OFFICE = LDOFFICES.OFFICE
		
		AND
		LDOFFICES.DELETE_FLAG IS NULL
		
		AND 
        
        (
        
        (
        BUSINESSSERVUSERS.AREA LIKE '#Trim_OFFICE_LDOFFICES#%'
		OR 
        LAWDEPARTMENT.OFFICE LIKE '#Trim_OFFICE_LDOFFICES#%'
        )


		<CFIF Trim_OFFICE_LDOFFICES CONTAINS "General Law"
		OR
		Trim_OFFICE_LDOFFICES CONTAINS "Tort">
        
        OR
        
        (
        BUSINESSSERVUSERS.AREA LIKE 'St. Louis%'
		OR 
        LAWDEPARTMENT.OFFICE LIKE 'General Law%'
        )
        
        
        
        
        </CFIF>
        
        )
        

		
		AND Trim(LAWDEPARTMENT.TITLE) = Trim(LDPOSITIONSORT.POSITION)
		
		AND (lawdepartment.SEPARATFLG != 'S' OR lawdepartment.SEPARATFLG IS NULL)
		
		AND (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
		
		ORDER BY LDPOSITIONSORT.SORTORDER, lawdepartment.LASTNAME
		
		</cfquery>
		
		
		<CFOUTPUT>
		GetAll_Auth_Users_Office.RecordCount = #GetAll_Auth_Users_Office.RecordCount#
		<p>
		</cfoutput>
		
		
		<CFSET ToList = "">
		
		<CFLOOP QUERY="GetAll_Auth_Users_Office">
		
			<CFINCLUDE TEMPLATE="email.setToList.cfm">
	
	<!--- Capture first user as potential "From" user for "No Cases" e-mail reply to Business Services:
	--->
			<CFIF GetAll_Auth_Users_Office.CurrentRow EQ 1>
				<CFSET FromUser = AD_USERID>
			</cfif>
	
		</cfloop>
	
	<!---
	<CFOUTPUT>
	After GetAll_Auth_Users_Office, ToList = "#ToList#"
	<p>
	</cfoutput>
	--->
	

<!---
	<CFINCLUDE TEMPLATE="email.cfmail.cfm">
--->






	
		<CFQUERY NAME="GetAll_AssignedCounsel_Office" DATASOURCE="ContLiab">
		
		SELECT DISTINCT lawdepartment.LASTNAME, lawdepartment.FIRSTNAME, lawdepartment.LONGEMAIL
		
		FROM lawdepartment, LDOFFICES, CONTINGENT_LIAB_REPORT
		
		WHERE (lawdepartment.PRIMARYKEY = CONTINGENT_LIAB_REPORT.COUNSEL_LAW_DEPT
		
		OR lawdepartment.PRIMARYKEY = CONTINGENT_LIAB_REPORT.COCOUNSEL_LAW_DEPT)
		
		AND LAWDEPARTMENT.OFFICE = LDOFFICES.OFFICE
		
		AND
		LDOFFICES.DELETE_FLAG IS NULL
		
		AND LAWDEPARTMENT.OFFICE LIKE '#Trim_OFFICE_LDOFFICES#%'
		
		AND (lawdepartment.SEPARATFLG != 'S' OR lawdepartment.SEPARATFLG IS NULL)
		
		AND CONTINGENT_LIAB_REPORT.DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
		
		<!--- Eliminate duplicate addressees:
		--->
		
		<CFIF IsDefined("GetAll_Auth_Users_Office.RecordCount")
		AND
		GetAll_Auth_Users_Office.RecordCount GT 0>
		
			AND lawdepartment.PRIMARYKEY NOT IN (#ValueList(GetAll_Auth_Users_Office.PRIMARYKEY)#)
		
		</CFIF>
		
		
		ORDER BY lawdepartment.LASTNAME
		
		</cfquery>
		
		
		<CFLOOP QUERY="GetAll_AssignedCounsel_Office">
		
			<CFINCLUDE TEMPLATE="email.setToList.cfm">
		
		</cfloop>
	

<!---
<CFOUTPUT>
After GetAll_AssignedCounsel_Office, ToList = "#ToList#"
<p>
</cfoutput>
--->

		<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_Current" DATASOURCE="ContLiab">
		
		SELECT CASE_REC_ID_SEQUENCE
		
		FROM CONTINGENT_LIAB_REPORT
		
		WHERE DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
	
<!---    
    	
		<!---
		Check for HQ Corporate and Postal Business Law (45). If yes, include Corporate (23) and HQ Pricing and Product Development (25).
		--->
		
		<CFIF OFFICE_PRM_KEY EQ 45>
        
			AND LAW_DEPT_OFFICE IN (23, 25, #OFFICE_PRM_KEY#)
		
		<!---
		Check for HQ Legal Strategy (55). If yes, include HQ Civil Practice (22) and HQ Pricing and Product Development (25).
		--->
		
		<CFELSEIF OFFICE_PRM_KEY EQ 55>
        
			AND LAW_DEPT_OFFICE IN (22, 25, #OFFICE_PRM_KEY#)
		
		<!---
		Check for HQ Procurement and Property Law (50). If yes, include HQ Civil Practice (22).
		--->
		
		<CFELSEIF OFFICE_PRM_KEY EQ 50>
        
			AND LAW_DEPT_OFFICE IN (22, #OFFICE_PRM_KEY#)
		
		<CFELSE>
        
			AND LAW_DEPT_OFFICE = #OFFICE_PRM_KEY#
		
		</cfif>
--->		


			AND LAW_DEPT_OFFICE = #OFFICE_PRM_KEY#



		
		</cfquery>
		
		
		<CFINCLUDE TEMPLATE="email.cfmail.cfm">
	
	</cfloop>

<!---
Close <CFIF CONTINGENT_LIAB_GetRecord_ThisReportDate.RecordCount EQ 0>:
--->
</cfif>

</body>
</html>

