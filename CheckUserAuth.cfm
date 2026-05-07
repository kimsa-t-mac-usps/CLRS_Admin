<cfinclude template="MfaCookieCheck.cfm">
<CFSET AuthorizedFlag = "No">


<CFQUERY NAME="Check_Auth_User_A" DATASOURCE="ContLiab">
SELECT USERPRMKEY
FROM BUSINESSSERVUSERS
WHERE CONTINGENT_LIAB_AUTH = 'A'
AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
</cfquery>


<CFIF Check_Auth_User_A.RecordCount EQ 1>

	<CFSET AuthorizedFlag = "Yes">
	<CFSET OfficeScope = "All Offices">

<CFELSE>

	
	<CFQUERY NAME="Get_Auth_User_PRMKEY" DATASOURCE="ContLiab">
	
	SELECT USERPRMKEY, CONTINGENT_LIAB_AUTH
	
	FROM BUSINESSSERVUSERS
	
	WHERE (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
	
	AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	
	</cfquery>
	
	
	<CFIF Get_Auth_User_PRMKEY.RecordCount EQ 1>
	
		<CFSET AuthorizedFlag = "Yes">
		
		<CFSET ThisCONTINGENT_LIAB_AUTH = Get_Auth_User_PRMKEY.CONTINGENT_LIAB_AUTH>
		
		
		<CFQUERY NAME="Get_Auth_User_Office" DATASOURCE="ContLiab">
		
		SELECT LDOFFICES.OFFICE_PRM_KEY, LDOFFICES.OFFICE
		
		FROM LAWDEPARTMENT, LDOFFICES
		
		WHERE LAWDEPARTMENT.OFFICE = LDOFFICES.OFFICE
		
		AND LAWDEPARTMENT.PRIMARYKEY = (SELECT USERPRMKEY
		
		FROM BUSINESSSERVUSERS
		
		WHERE (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
		
		AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')))
		
		</cfquery>
		
		<CFIF Get_Auth_User_Office.RecordCount EQ 1>

			<CFSET OfficeScope = Trim(Get_Auth_User_Office.OFFICE)>
			<CFSET DefaultOffice = Get_Auth_User_Office.OFFICE_PRM_KEY>
		
			<CFIF Left(OfficeScope, 9) EQ "Southeast">
				<CFSET OfficeScope = "Southeast">
			</cfif>
		
		</cfif>
		
		
	<CFELSE>
		
		<CFQUERY NAME="Get_Indiv_User" DATASOURCE="ContLiab">
		SELECT LAWDEPARTMENT.PRIMARYKEY
		FROM LAWDEPARTMENT, LDEXTRA
		WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
		AND (TITLE LIKE 'Managing Counsel%'
		OR TITLE LIKE 'Deputy Managing%'
		OR title LIKE 'Attorney%'
		OR title LIKE 'Chief%'
		OR title LIKE 'Senior Counsel%'
		OR title LIKE 'Senior Litigation%'
		OR title LIKE 'Program Manager%'
		OR title LIKE 'Executive Program%')
		
		AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
		
		</cfquery>
		
		<CFIF Get_Indiv_User.RecordCount EQ 1>
		
			<CFQUERY NAME="Get_ReportDate" DATASOURCE="ContLiab">
			SELECT MAX(DATE_REPORT) AS REPORT_DATE
			FROM CONTINGENT_LIAB_REPORT			
            </cfquery>
			
			<CFSET ThisReportDate = DateFormat(Get_ReportDate.REPORT_DATE, "mm/dd/yyyy")>
			
			<CFQUERY NAME="Get_Indiv_User_Cases" DATASOURCE="ContLiab">
			SELECT ROWID
			FROM CONTINGENT_LIAB_REPORT			
            WHERE DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
			AND (COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
			OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
			</cfquery>
			
			<CFIF Get_Indiv_User_Cases.RecordCount GT 0>
				<CFSET AuthorizedFlag = "Yes">
			<CFELSE>
				<CFSET AuthorizedFlag = "No">
			</cfif>
			
		</cfif>
	
	</cfif>
	
	
	<CFIF NOT 
	(
	IsDefined("ThisPage") 
	AND 
	ThisPage EQ "InsertRecord"
	) 
	OR 
	(
	IsDefined("ThisPage") 
	AND 
	ThisPage EQ "InsertRecord" 
	AND 
	IsDefined("Get_Indiv_User.RecordCount") 
	AND 
	Get_Indiv_User.RecordCount NEQ 1
	)>
	
		<CFIF AuthorizedFlag EQ "No">
		<script language="javascript">
		location.href = "NotAuthorized.cfm"
		</script>
		</cfif>
	
	</cfif>

<!--- Close <CFIF Check_Auth_User_A.RecordCount EQ 1> --->
</cfif>


