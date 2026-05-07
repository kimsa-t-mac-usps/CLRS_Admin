<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department EAJA Cases: Send E-mail Notice</title>
</head>

<body>


<CFIF IsDefined("Form.Sender")
AND 
Form.Sender NEQ "">

	<CFQUERY NAME="Check_Sender_Auth_User_A" DATASOURCE="ContLiab">
    
<!---    
	SELECT lawdepartment.LASTNAME, lawdepartment.FIRSTNAME, lawdepartment.LONGEMAIL
	FROM lawdepartment
	WHERE lawdepartment.PRIMARYKEY = (SELECT USERPRMKEY
	FROM BUSINESSSERVUSERS
	WHERE CONTINGENT_LIAB_AUTH = 'A'
	AND (UPPER(AD_USERID) LIKE UPPER('#Form.Sender#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#Form.Sender#%')))
--->

	SELECT DISTINCT a.LASTNAME, a.FIRSTNAME, a.LONGEMAIL, a.PRIMARYKEY
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
	
	</cfif>


</cfif>


<CFSET ThisReportDate = Form.ReportDate>


<CFSET EMailSuffix = "usps.gov">


<CFSET ThisReportDate_CalYear = DatePart("yyyy", ThisReportDate)>

<CFIF ThisReportDate LT "10/1/#ThisReportDate_CalYear#">
	<CFSET ThisReportDate_FY = ThisReportDate_CalYear>
<CFELSE>
	<CFSET ThisReportDate_FY = ThisReportDate_CalYear + 1>
</cfif>


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

<CFSET OfficeScope = "OfficeOnly">

<CFQUERY NAME="GetAll_Offices" DATASOURCE="ContLiab">

SELECT DISTINCT

<!---
OFFICE_PRM_KEY, trim(OFFICE) AS OFFICE_LDOFFICES
--->


OFFICE_PRM_KEY, OFFICE AS OFFICE_LDOFFICES


FROM LDOFFICES

<!---
WHERE OFFICE != ' '
AND OFFICE NOT LIKE 'Deputy%'
AND OFFICE NOT LIKE 'Directories%'
AND OFFICE NOT LIKE '%Ethics%'
AND OFFICE NOT LIKE 'Field%'
AND OFFICE NOT LIKE 'General%'
AND OFFICE NOT LIKE 'Headquarters%'
AND OFFICE NOT LIKE 'HQ Business%'
AND OFFICE NOT LIKE 'HQ Environ%'
AND OFFICE NOT LIKE 'HQ Facilities%'
AND OFFICE NOT LIKE 'HQ Integration%'
AND OFFICE NOT LIKE 'National%'
AND OFFICE NOT LIKE 'NC%'
AND OFFICE NOT LIKE 'Privacy%'
AND OFFICE NOT LIKE 'Revenue%'
AND OFFICE NOT LIKE 'Select%'
AND OFFICE NOT LIKE '%Atlanta%'
--->


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
	


AND
DELETE_FLAG IS NULL

ORDER BY OFFICE

</cfquery>


<CFOUTPUT>
GetAll_Offices.RecordCount = #GetAll_Offices.RecordCount#
<p>
</cfoutput>



<CFLOOP QUERY="GetAll_Offices">

	<CFSET Trim_OFFICE_LDOFFICES = OFFICE_LDOFFICES>
	
	<CFIF Left(Trim_OFFICE_LDOFFICES, 9) EQ "Southeast">
		<CFSET Trim_OFFICE_LDOFFICES = "Southeast">
	</cfif>
	
	
	<CFOUTPUT>
    <br>
<br>
<br>

	OFFICE = "#Trim_OFFICE_LDOFFICES#"
	<p>
	</cfoutput>
	
	
	<CFQUERY NAME="GetAll_Auth_Users_Office" DATASOURCE="ContLiab">
	
<!---    
	SELECT DISTINCT 
    lawdepartment.LASTNAME, 
    lawdepartment.FIRSTNAME, 
    lawdepartment.OFFICE, 
    lawdepartment.LONGEMAIL, 
    lawdepartment.PRIMARYKEY, 
    BUSINESSSERVUSERS.AD_USERID, 
    BUSINESSSERVUSERS.AD_MAILNICKNAME, 
    BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH, 
    LDOFFICES.OFFICE_PRM_KEY, 
    LDPOSITIONSORT.SORTORDER
	
	FROM 
    lawdepartment, 
    BUSINESSSERVUSERS, 
    LDOFFICES, 
    LDPOSITIONSORT
	
	WHERE 
    lawdepartment.PRIMARYKEY = BUSINESSSERVUSERS.USERPRMKEY
	
	AND 
    trim(LAWDEPARTMENT.OFFICE) = trim(LDOFFICES.OFFICE)
	
	AND
	LDOFFICES.DELETE_FLAG IS NULL
	
<!---    
	AND 
    (BUSINESSSERVUSERS.AREA LIKE '#Trim_OFFICE_LDOFFICES#%'
	OR 
    LAWDEPARTMENT.OFFICE LIKE '#Trim_OFFICE_LDOFFICES#%')
--->




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









	AND 
    Trim(LAWDEPARTMENT.TITLE) = Trim(LDPOSITIONSORT.POSITION)
	
	AND (lawdepartment.SEPARATFLG != 'S' OR lawdepartment.SEPARATFLG IS NULL)
	
	AND (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
	
	ORDER BY LDPOSITIONSORT.SORTORDER, lawdepartment.LASTNAME
--->	
    
    
    
    		
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
	
    <CFSET FromUser = "">
    
    
	<CFLOOP QUERY="GetAll_Auth_Users_Office">
	
		<CFINCLUDE TEMPLATE="email.setToList.cfm">
	
	<!--- Capture first user as potential "From" user for "No Cases" e-mail reply to Admin email:
	--->
		<CFIF GetAll_Auth_Users_Office.CurrentRow EQ 1>
			<CFSET FromUser = AD_USERID>
		</cfif>

	</cfloop>


	<CFOUTPUT>


	<p>

	EAJA.SendForUpdate.cfm at 389:
    
    <br>
   
    ToList = "#ToList#"
    <br>


	<CFIF IsDefined("FromUser")>
    
    	<CFOUTPUT>
		
        FromUser = "#FromUser#"
    	
        </CFOUTPUT>
        
	<CFELSE>

		FromUser NOT DEFINED        
        
	</CFIF>        
        

	<p>
        
    </CFOUTPUT>

<!---
	<cfabort>
--->


	<CFIF GetAll_Auth_Users_Office.RecordCount GT 0
	AND
	Trim_OFFICE_LDOFFICES DOES NOT CONTAIN "National Tort Center">

		<CFINCLUDE TEMPLATE="EAJA.email.cfmail.cfm">

	</CFIF>
    

</cfloop>

</body>
</html>

