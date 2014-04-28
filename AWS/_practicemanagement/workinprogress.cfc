<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[]


FROM[]
WHERE[]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>

<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="userid" type="string" required="no">
<cfargument name="duedate" type="string" required="no" default="">
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- TOTAL TIME --->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="aquery">
SELECT'Administrative Tasks'AS[name]
,SUM(cas_esttime)AS[total_time]
,COUNT(cas_assignedto)AS[count_assigned]
,'1'AS[orderit]
FROM[v_clientadministrativetasks]
WHERE[cas_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([cas_duedate]IS NULL AND[cas_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[cas_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

UNION
SELECT'Business Formation'AS[name],SUM(bf_esttime)AS[total_time],COUNT(bf_assignedto)AS[count_assigned],'1'AS[orderit]
FROM[v_businessformation]
WHERE[bf_status]!='2'
<cfif ARGUMENTS.userid neq "">AND[bf_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

UNION
SELECT'Financial & Tax Planning'AS[name],SUM(ftp_esttime)AS[total_time],COUNT(ftp_assignedto)AS[count_assigned],'1'AS[orderit]
FROM[v_financialtaxplanning]
WHERE[ftp_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL AND[ftp_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[ftp_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

UNION
SELECT'Financial Statements'AS[name],SUM(fds_esttime)AS[total_time]
,COUNT(fds_obtaininfo_assignedto)+COUNT(fds_sort_assignedto)+COUNT(fds_checks_assignedto)+COUNT(fds_sales_assignedto)+COUNT(fds_entry_assignedto)+COUNT(fds_reconcile_assignedto)+COUNT(fds_compile_assignedto)+COUNT(fds_review_assignedto)+COUNT(fds_assembly_assignedto)+COUNT(fds_delivery_assignedto)AS[count_assigned]
,'1'AS[orderit]
FROM[v_financialdatastatus] 
WHERE[fds_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL AND[fds_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND([fds_status]!='3'OR[fds_status] IS NULL)
AND[fds_delivery_datecompleted] IS NULL
AND([fds_obtaininfo_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#">AND[fds_obtaininfo_datecompleted]IS NULL)
OR([fds_sort_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#">AND[fds_obtaininfo_datecompleted]IS NOT NULL AND[fds_sort_datecompleted] IS NULL)
OR([fds_checks_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_sort_datecompleted] IS NOT NULL AND [fds_checks_datecompleted] IS NULL)
OR([fds_sales_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_checks_datecompleted] IS NOT NULL AND [fds_sales_datecompleted] IS NULL)
OR([fds_entry_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_sales_datecompleted] IS NOT NULL AND [fds_entry_datecompleted] IS NULL)
OR([fds_reconcile_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_entry_datecompleted] IS NOT NULL AND [fds_reconcile_datecompleted] IS NULL)
OR([fds_compile_assignedto]= <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_reconcile_datecompleted] IS NOT NULL AND [fds_compile_datecompleted] IS NULL)
OR([fds_review_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_compile_datecompleted] IS NOT NULL AND [fds_review_datecompleted] IS NULL)
OR([fds_assembly_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_review_datecompleted] IS NOT NULL AND [fds_assembly_datecompleted]  IS NULL)
OR([fds_delivery_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_assembly_datecompleted] IS NOT NULL)
</cfif>

UNION
SELECT'Accounting and Consulting'AS[name], SUM(mc_esttime)AS[total_time],COUNT(mc_assignedto)AS[count_assigned],'1'AS[orderit]
FROM[v_managementconsulting]
WHERE[mc_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL AND[mc_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[mc_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

UNION
SELECT'Notices'AS[name], SUM(nst_esttime)AS[total_time],COUNT(nst_assignedto)AS[count_assigned],'1'AS[orderit]
FROM[v_notice_subtask]
WHERE[nst_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL AND[nst_1_resduedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[nst_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

UNION
SELECT'Other Filings'AS[name], SUM(of_esttime)AS[total_time]
,COUNT(of_obtaininfo_assignedto)
+COUNT(of_preparation_assignedto)
+COUNT(of_review_assignedto)
+COUNT(of_assembly_assignedto)
+COUNT(of_delivery_assignedto)AS[count_assigned]
,'1'AS[orderit]
FROM[v_otherfilings]
WHERE[of_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND(([of_status]!='3')OR([of_status]IS NULL))
AND([of_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL)
</cfif>

UNION
SELECT'Payroll Checks'AS[name], SUM(pc_esttime)AS[total_time]
,COUNT(pc_delivery_datecompleted)
+COUNT(pc_obtaininfo_datecompleted)
+COUNT(pc_review_datecompleted)
+COUNT(pc_assembly_datecompleted)AS[count_assigned]
,'1'AS[orderit]
FROM[v_payrollcheckstatus]
WHERE[pc_delivery_completedby]IS NOT NULL 
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL AND[pc_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[pc_delivery_datecompleted]IS NULL AND([pc_obtaininfo_datecompleted]IS NULL AND[pc_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_obtaininfo_datecompleted]IS NOT NULL AND[pc_preparation_datecompleted]IS NULL AND[pc_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_preparation_datecompleted]IS NOT NULL AND[pc_review_datecompleted]IS NULL AND[pc_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_review_datecompleted]IS NOT NULL AND[pc_assembly_datecompleted]IS NULL AND[pc_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_assembly_datecompleted]IS NOT NULL AND[pc_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
</cfif>

UNION
SELECT'Payroll Taxes'AS[name], SUM(pt_esttime)AS[total_time]
,COUNT(pt_obtaininfo_assignedto)
+COUNT(pt_entry_assignedto)
+COUNT(pt_rec_assignedto)
+COUNT(pt_review_assignedto)
+COUNT(pt_assembly_assignedto)
+COUNT(pt_delivery_assignedto)AS[count_assigned]
,'1'AS[orderit]
FROM[v_payrolltaxes] 
WHERE([pt_delivery_completedby]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL AND[pt_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND([pt_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_obtaininfo_datecompleted]IS NULL)
OR([pt_entry_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR([pt_rec_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR([pt_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR([pt_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR([pt_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_assembly_datecompleted]IS NOT NULL)
</cfif>

UNION
SELECT'Tax Returns'AS[name], SUM(tr_esttime)AS[total_time]
,COUNT(tr_2_assignedto)AS[count_assigned]
,'1'AS[orderit]
FROM[v_taxreturns]
WHERE[tr_2_informationreceived]IS NOT NULL 
<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL AND[tr_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND[tr_3_delivered]IS NULL
AND[tr_2_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">
</cfif>


UNION
SELECT'Personal Property Tax Returns'AS[name], SUM(tr_esttime)AS[total_time]
,COUNT(tr_4_assignedto)AS[count_assigned]
,'2'AS[orderit]
FROM[v_taxreturns]
WHERE[tr_4_required]='TRUE'
AND[tr_4_required]IS NULL
<cfif ARGUMENTS.userid neq "">
AND[tr_4_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">
</cfif>
AND(
([tr_taxyear]=Year(getdate())-1)
OR(Year([tr_2_informationreceived])=Year(getdate()))
)

</cfquery>



<cfquery dbtype="query" name="fquery">
SELECT[name],[total_time],[count_assigned],[orderit]FROM[aquery]
UNION
SELECT'<b style=''font-weight: bold;''>Total</b>'AS[name],SUM(total_time)AS[total_time],SUM(count_assigned)[count_assigned],'999'AS[orderit]
FROM[aquery]

ORDER BY[orderit]

</cfquery>


<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{
								"NAME":"'&NAME&'"
								,"TOTAL_TIME":"'&TOTAL_TIME&'"
								,"COUNT_ASSIGNED":"'&COUNT_ASSIGNED&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Administrative Tasks --->
<cfcase value="group2">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT [cas_id]
,[client_id]
,[client_name]
,[cas_completed]=FORMAT(cas_completed,'d','#Session.localization.language#') 
,[cas_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[cas_status]=[optionvalue_id])
,[cas_priority]
,[cas_assignedtoTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))FOR XML PATH('')),3,1000)
,[cas_duedate]=FORMAT(cas_duedate,'d','#Session.localization.language#') 
,[cas_esttime]
,[cas_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[cas_category]=[optionvalue_id])
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc] 
FROM[v_clientadministrativetasks]
WHERE[cas_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([cas_duedate]IS NULL AND[cas_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[cas_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>


</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_COMPLETED":"'&CAS_COMPLETED&'"
								,"CAS_STATUSTEXT":"'&CAS_STATUSTEXT&'"
								,"CAS_PRIORITY":"'&CAS_PRIORITY&'"
								,"CAS_ASSIGNEDTOTEXT":"'&CAS_ASSIGNEDTOTEXT&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_ESTTIME":"'&CAS_ESTTIME&'"
								,"CAS_CATEGORYTEXT":"'&CAS_CATEGORYTEXT&'"
								,"CAS_TASKDESC":"'&CAS_TASKDESC&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Business Formation --->
<cfcase value="group3">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,[bf_dateinitiated]=FORMAT(bf_dateinitiated,'d','#Session.localization.language#') 
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_priority]
,[bf_assignedtoTEXT]
,[bf_duedate]=FORMAT(bf_duedate,'d','#Session.localization.language#') 
,[bf_esttime]
,[bf_activity]
FROM[v_businessformation]
WHERE[bf_status]!='2'
<cfif ARGUMENTS.userid neq "">AND[bf_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_DATEINITIATED":"'&BF_DATEINITIATED&'"
								,"BF_STATUSTEXT":"'&BF_STATUSTEXT&'"
								,"BF_PRIORITY":"'&BF_PRIORITY&'"
								,"BF_ASSIGNEDTOTEXT":"'&BF_ASSIGNEDTOTEXT&'"
								,"BF_DUEDATE":"'&BF_DUEDATE&'"
								,"BF_ESTTIME":"'&BF_ESTTIME&'"
								,"BF_ACTIVITY":"'&BF_ACTIVITY&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Financial Tax Planning --->
<cfcase value="group4">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[ftp_id]
,[client_name]
,[client_id]
,[ftp_requestservice]=FORMAT(ftp_requestservice,'d','#Session.localization.language#') 
,[ftp_reportcompleted]=FORMAT(ftp_reportcompleted,'d','#Session.localization.language#') 
,[ftp_missinginfo]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id]
)AS[ftp_categoryTEXT]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id]
)AS[ftp_statusTEXT]
,[ftp_priority]
,[ftp_assignedtoTEXT]
,[ftp_duedate]=FORMAT(ftp_duedate,'d','#Session.localization.language#') 
,[ftp_esttime]
FROM[v_financialtaxplanning]
WHERE[ftp_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL AND[ftp_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[ftp_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_REPORTCOMPLETED":"'&FTP_REPORTCOMPLETED&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_STATUSTEXT":"'&FTP_STATUSTEXT&'"
								,"FTP_PRIORITY":"'&FTP_PRIORITY&'"
								,"FTP_ASSIGNEDTOTEXT":"'&FTP_ASSIGNEDTOTEXT&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_ESTTIME":"'&FTP_ESTTIME&'"
								,"FTP_CATEGORYTEXT":"'&FTP_CATEGORYTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Financial Statements --->
<cfcase value="group5">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,[fds_periodend]=FORMAT(fds_periodend,'d','#Session.localization.language#') 
,[fds_missinginfo]
,[fds_compilemi]
,[fds_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id])
,[fds_priority]
,[fds_duedate]=FORMAT(fds_duedate,'d','#Session.localization.language#')    
,[fds_esttime]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='5'OR[form_id]='0')AND([optionGroup]='5'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
FROM[v_financialDataStatus]
WHERE[fds_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL AND[fds_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND([fds_status]!='3'OR[fds_status] IS NULL)
AND[fds_delivery_datecompleted] IS NULL
AND([fds_obtaininfo_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#">AND[fds_obtaininfo_datecompleted]IS NULL)
OR([fds_sort_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#">AND[fds_obtaininfo_datecompleted]IS NOT NULL AND[fds_sort_datecompleted] IS NULL)
OR([fds_checks_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_sort_datecompleted] IS NOT NULL AND [fds_checks_datecompleted] IS NULL)
OR([fds_sales_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_checks_datecompleted] IS NOT NULL AND [fds_sales_datecompleted] IS NULL)
OR([fds_entry_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_sales_datecompleted] IS NOT NULL AND [fds_entry_datecompleted] IS NULL)
OR([fds_reconcile_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_entry_datecompleted] IS NOT NULL AND [fds_reconcile_datecompleted] IS NULL)
OR([fds_compile_assignedto]= <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_reconcile_datecompleted] IS NOT NULL AND [fds_compile_datecompleted] IS NULL)
OR([fds_review_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_compile_datecompleted] IS NOT NULL AND [fds_review_datecompleted] IS NULL)
OR([fds_assembly_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_review_datecompleted] IS NOT NULL AND [fds_assembly_datecompleted]  IS NULL)
OR([fds_delivery_assignedto] = <cfqueryparam value="#ARGUMENTS.userid#"> AND [fds_assembly_datecompleted] IS NOT NULL)
</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_PERIODEND":"'&FDS_PERIODEND&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_STATUSTEXT":"'&FDS_STATUSTEXT&'"
								,"FDS_PRIORITY":"'&FDS_PRIORITY&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_ESTTIME":"'&FDS_ESTTIME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group6">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,[mc_requestforservice]=FORMAT(mc_requestforservice,'d','#Session.localization.language#') 
,[mc_projectcompleted]=FORMAT(mc_projectcompleted,'d','#Session.localization.language#') 
,[mc_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,[mc_priority]
,[mc_assignedtoTEXT]
,[mc_duedate]=FORMAT(mc_duedate,'d','#Session.localization.language#') 
,[mc_esttime]
,[mc_category]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='2'OR[form_id]='0')AND([optionGroup]='2'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
FROM[v_managementconsulting]
WHERE([mc_status] !=3 OR [mc_status] !=6 OR [mc_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_REQUESTFORSERVICE":"'&MC_REQUESTFORSERVICE&'"
								,"MC_PROJECTCOMPLETED":"'&MC_PROJECTCOMPLETED&'"
								,"MC_STATUSTEXT":"'&MC_STATUSTEXT&'"
								,"MC_PRIORITY":"'&MC_PRIORITY&'"
								,"MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_ESTTIME":"'&MC_ESTTIME&'"
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- Grid Notice  --->
<cfcase value="group7">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[n_id]
,[client_name]
,[n_name]
,[nst_1_noticedate]=FORMAT(nst_1_noticedate,'d','#Session.localization.language#') 
,[nst_missinginfo]
,[nst_priority]
,[nst_assignedtoTEXT]
,[nst_1_resduedate]=FORMAT(nst_1_resduedate,'d','#Session.localization.language#') 
,[nst_esttime]
,[nst_2_revrequired]
,[nst_2_revassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(nst_2_revassignedto=user_id))

FROM[v_notice_subtask]
WHERE[nst_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL AND[nst_1_resduedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[nst_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&N_NAME&'"
								,"NST_1_NOTICEDATE":"'&NST_1_NOTICEDATE&'"
								,"NST_MISSINGINFO":"'&NST_MISSINGINFO&'"
								,"NST_PRIORITY":"'&NST_PRIORITY&'"
								,"NST_ASSIGNEDTOTEXT":"'&NST_ASSIGNEDTOTEXT&'"
								,"NST_1_RESDUEDATE":"'&NST_1_RESDUEDATE&'"
								,"NST_ESTTIME":"'&NST_ESTTIME&'"
								,"NST_2_REVREQUIRED":"'&NST_2_REVREQUIRED&'"
								,"NST_2_REVASSIGNEDTOTEXT":"'&NST_2_REVASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Other Filings --->
<cfcase value="group8">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[of_id]
,[client_name]
,[of_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_type]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_missinginfo]
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])
,[of_priority]
,[of_duedate]=FORMAT(of_duedate,'d','#Session.localization.language#') 
,[of_esttime]
,[of_taxyear]
,[of_periodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])
FROM[v_otherfilings]
WHERE[of_status]!='2'
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND(([of_status]!='3')OR([of_status]IS NULL))
AND([of_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL)
</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TYPETEXT":"'&OF_TYPETEXT&'"
								,"OF_FORMTEXT":"'&OF_FORMTEXT&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
								,"OF_STATUSTEXT":"'&OF_STATUSTEXT&'"
								,"OF_PRIORITY":"'&OF_PRIORITY&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_ESTTIME":"'&OF_ESTTIME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"
								,"OF_PERIODTEXT":"'&OF_PERIODTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Checks --->
<cfcase value="group9">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pc_id]
,[client_name]
,[client_id]
,[pc_payenddate]=FORMAT(pc_payenddate,'d','#Session.localization.language#') 
,[pc_assembly_datecompleted]=FORMAT(pc_assembly_datecompleted,'d','#Session.localization.language#') 
,[pc_missinginfo]
,[pc_duedate]=FORMAT(pc_duedate,'d','#Session.localization.language#') 
,[pc_esttime]
,[pc_paydate]=FORMAT(pc_paydate,'d','#Session.localization.language#') 
FROM[v_payrollcheckstatus]
WHERE[pc_delivery_completedby]IS NOT NULL 
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL AND[pc_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">AND[pc_delivery_datecompleted]IS NULL AND([pc_obtaininfo_datecompleted]IS NULL AND[pc_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_obtaininfo_datecompleted]IS NOT NULL AND[pc_preparation_datecompleted]IS NULL AND[pc_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_preparation_datecompleted]IS NOT NULL AND[pc_review_datecompleted]IS NULL AND[pc_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_review_datecompleted]IS NOT NULL AND[pc_assembly_datecompleted]IS NULL AND[pc_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
OR([pc_assembly_datecompleted]IS NOT NULL AND[pc_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">)
</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
 								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_ASSEMBLY_DATECOMPLETED":"'&PC_ASSEMBLY_DATECOMPLETED&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_DUEDATE":"'&PC_DUEDATE&'"
								,"PC_ESTTIME":"'&PC_ESTTIME&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group10">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pt_id]
,[client_id]
,[client_name]
,[pt_lastpay]=FORMAT(pt_lastpay,'d','#Session.localization.language#') 
,[pt_missinginfo]
,[pt_priority]
,[pt_duedate]=FORMAT(pt_duedate,'d','#Session.localization.language#') 
,[pt_esttime]
,[pt_year]
,[pt_month]
,[pt_type]
FROM[v_payrolltaxes]
WHERE([pt_delivery_completedby]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL AND[pt_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND([pt_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_obtaininfo_datecompleted]IS NULL)
OR([pt_entry_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR([pt_rec_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR([pt_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR([pt_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR([pt_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"> AND[pt_assembly_datecompleted]IS NOT NULL)
</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
								,"PT_PRIORITY":"'&PT_PRIORITY&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
								,"PT_ESTTIME":"'&PT_ESTTIME&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTH":"'&PT_MONTH&'"
								,"PT_TYPE":"'&PT_TYPE&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group11">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'d','#Session.localization.language#') 
,[tr_2_completed]=FORMAT(tr_2_completed,'d','#Session.localization.language#') 
,[tr_missinginfo]
,[tr_taxyear]
,[tr_taxform]
,[tr_priority]
,[tr_2_assignedtoTEXT]
,[tr_duedate]=FORMAT(tr_duedate,'d','#Session.localization.language#') 
,[tr_esttime]
,[tr_4_required]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'d','#Session.localization.language#') 
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
FROM[v_taxreturns]
WHERE[tr_2_informationreceived]IS NOT NULL 
<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL AND[tr_duedate]><cfqueryparam value="#ARGUMENTS.duedate#">)</cfif>
<cfif ARGUMENTS.userid neq "">
AND[tr_3_delivered]IS NULL
AND[tr_2_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#">
</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_PRIORITY":"'&TR_PRIORITY&'"
								,"TR_2_ASSIGNEDTOTEXT":"'&TR_2_ASSIGNEDTOTEXT&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_ESTTIME":"'&TR_ESTTIME&'"
								,"TR_4_REQUIRED":"'&TR_4_REQUIRED&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group12">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_4_extended]=FORMAT(tr_4_extended,'d','#Session.localization.language#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'d','#Session.localization.language#') 
,[tr_taxyear]
,[tr_taxform]
,[tr_priority]
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[tr_4_pptresttime]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'d','#Session.localization.language#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'d','#Session.localization.language#') 
FROM[v_taxreturns]
WHERE datepart(year,[tr_2_informationreceived]) = datepart(year, getdate())
AND [tr_taxyear] = DATEADD(year,-1,getdate())
AND[tr_4_required] = '1'
AND [tr_3_delivered] IS NULL
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_4_EXTENDED":"'&TR_4_EXTENDED&'"
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_PRIORITY":"'&TR_PRIORITY&'"
								,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
								,"TR_4_PPTRESTTIME":"'&TR_4_PPTRESTTIME&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>
</cfswitch>
</cffunction>
</cfcomponent>