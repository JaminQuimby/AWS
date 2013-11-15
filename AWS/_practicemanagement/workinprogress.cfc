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
<cfquery datasource="AWS" name="fQuery">
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
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="userid" type="string" required="no">

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Administrative Tasks --->
<cfcase value="group2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT [cas_id]
,[client_id]
,[client_name]
<!--- missing variable: Initiated --->
,CONVERT(VARCHAR(10),[cas_completed], 101)AS[cas_completed]
,[cas_status]
,[cas_priority]
,[cas_assignedto]
,CONVERT(VARCHAR(10),[cas_duedate], 101)AS[cas_duedate]
,[cas_esttime]
,[cas_category]
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc] 
FROM[v_clientadministrativetasks]
WHERE([cas_status] !=3 OR [cas_status] !=6 OR [cas_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
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
								,"CAS_STATUS":"'&CAS_STATUS&'"
								,"CAS_PRIORITY":"'&CAS_PRIORITY&'"
								,"CAS_ASSIGNEDTO":"'&CAS_ASSIGNEDTO&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_ESTTIME":"'&CAS_ESTTIME&'"
								,"CAS_CATEGORY":"'&CAS_CATEGORY&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[bf_dateinitiated], 101)AS[bf_dateinitiated]
,[bf_status]
,[bf_priority]
,[bf_assignedto]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_esttime]
,[bf_activity]
FROM[v_businessformation]
WHERE([bf_status] !=3 OR [bf_status] !=6 OR [bf_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
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
								,"BF_STATUS":"'&BF_STATUS&'"
								,"BF_PRIORITY":"'&BF_PRIORITY&'"
								,"BF_ASSIGNEDTO":"'&BF_ASSIGNEDTO&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[ftp_id]
,[client_name]
,[client_id]
,CONVERT(VARCHAR(10),[ftp_requestservice], 101)AS[ftp_requestservice]
,CONVERT(VARCHAR(10),[ftp_reportcompleted], 101)AS[ftp_reportcompleted]
,[ftp_missinginfo]
,[ftp_status]
,[ftp_priority]
,[ftp_assignedto]
,CONVERT(VARCHAR(10),[ftp_duedate], 101)AS[ftp_duedate]
,[ftp_esttime]
,[ftp_category]
FROM[v_financialtaxplanning]
WHERE([ftp_status] !=3 OR [ftp_status] !=6 OR [ftp_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
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
								,"FTP_STATUS":"'&FTP_STATUS&'"
								,"FTP_PRIORITY":"'&FTP_PRIORITY&'"
								,"FTP_ASSIGNEDTO":"'&FTP_ASSIGNEDTO&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_ESTTIME":"'&FTP_ESTTIME&'"
								,"FTP_CATEGORY":"'&FTP_CATEGORY&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[fds_periodend], 101)AS[fds_periodend]
,[fds_missinginfo]
,[fds_compilemi]
,[fds_status]     
,[fds_priority]
,[fds_entry_assignedto]
,CONVERT(VARCHAR(10),[fds_duedate], 101)AS[fds_duedate]      
,[fds_esttime]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]
FROM[v_financialDataStatus]
WHERE([fds_status] !=3 OR [fds_status] !=6 OR [fds_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif></cfquery>
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
								,"FDS_STATUS":"'&FDS_STATUS&'"
								,"FDS_PRIORITY":"'&FDS_PRIORITY&'"
								,"FDS_ENTRY_ASSIGNEDTO":"'&FDS_ENTRY_ASSIGNEDTO&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[mc_requestforservice], 101)AS[mc_requestforservice]
,CONVERT(VARCHAR(10),[mc_projectcompleted], 101)AS[mc_projectcompleted]
,[mc_status]
,[mc_priority]
,[mc_assignedto]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
,[mc_esttime]
,[mc_category]
,[mc_categorytext]
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
								,"MC_STATUS":"'&MC_STATUS&'"
								,"MC_PRIORITY":"'&MC_PRIORITY&'"
								,"MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[client_name]
,[nm_name]
,CONVERT(VARCHAR(10),[n_1_noticedate], 101)AS[n_1_noticedate]
,[n_3_missinginfo]
,[nm_status]
,[n_priority]
,[n_assignedto]
,CONVERT(VARCHAR(10),[n_2_resduedate], 101)AS[n_2_resduedate]
,[n_esttime]
,[n_2_revrequired]
,[n_2_revassignedto]
FROM[v_notice]
WHERE([nm_status] !=3 OR [nm_status] !=6 OR [nm_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"NM_NAME":"'&NM_NAME&'"
								,"N_1_NOTICEDATE":"'&N_1_NOTICEDATE&'"
								,"N_3_MISSINGINFO":"'&N_3_MISSINGINFO&'"
								,"NM_STATUS":"'&NM_STATUS&'"
								,"N_PRIORITY":"'&N_PRIORITY&'"
								,"N_ASSIGNEDTO":"'&N_ASSIGNEDTO&'"
								,"N_2_RESDUEDATE":"'&N_2_RESDUEDATE&'"
								,"N_ESTTIME":"'&N_ESTTIME&'"
								,"N_2_REVREQUIRED":"'&N_2_REVREQUIRED&'"
								,"N_2_REVASSIGNEDTO":"'&N_2_REVASSIGNEDTO&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[of_id]
,[client_name]
,[of_task]
,[of_form]
,[of_missinginfo]
,[of_status]
,[of_priority]
<!--- nonspecfic assigned to --->
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_esttime]
,[of_taxyear]
,[of_period]
FROM[v_otherfilings]
WHERE([of_status] !=3 OR [of_status] !=6 OR [of_status] IS NULL)
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TASK":"'&OF_TASK&'"
								,"OF_FORM":"'&OF_FORM&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
								,"OF_STATUS":"'&OF_STATUS&'"
								,"OF_PRIORITY":"'&OF_PRIORITY&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_ESTTIME":"'&OF_ESTTIME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"
								,"OF_PERIOD":"'&OF_PERIOD&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[client_name]
,[client_id]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_assembly_datecompleted], 101)AS[pc_assembly_datecompleted]  <!---Unsure if this is the correct completed to use. --->
,[pc_missinginfo]
,[pc_preparation_assignedto]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_esttime]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate]
FROM[v_payrollcheckstatus]
WHERE[pc_delivery_datecompleted] IS NULL
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
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
								,"PC_PREPARATION_ASSIGNEDTO":"'&PC_PREPARATION_ASSIGNEDTO&'"
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[pt_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[pt_lastpay], 101)AS[pt_lastpay]
,[pt_missinginfo]
<!---Variable Status does not exist --->
,[pt_priority]
<!--- Doesn't specify which Assigned To --->
,CONVERT(VARCHAR(10),[pt_duedate], 101)AS[pt_duedate]
,[pt_esttime]
,[pt_year]
,[pt_month]
,[pt_type]
FROM[v_payrolltaxes]
WHERE[pt_delivery_datecompleted] IS NULL
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
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
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[tr_1_informationreceived], 101)AS[tr_1_informationreceived]
,CONVERT(VARCHAR(10),[tr_1_completed], 101)AS[tr_1_completed]
,[tr_1_missinginfo]
,[tr_taxyear]
,[tr_taxform]
,[tr_priority]
,[tr_1_assignedto]
,CONVERT(VARCHAR(10),[tr_1_duedate], 101)AS[tr_1_duedate]
,[tr_esttime]
,[tr_3_required]
,CONVERT(VARCHAR(10),[tr_3_rfr], 101)AS[tr_3_rfr]
,[tr_3_assignedto] 
FROM[v_taxreturns]
WHERE[tr_1_informationreceived] IS NOT NULL
 AND [tr_2_delivered] IS NULL
<cfif ARGUMENTS.search neq "">
AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_1_INFORMATIONRECEIVED":"'&TR_1_INFORMATIONRECEIVED&'"
								,"TR_1_COMPLETED":"'&TR_1_COMPLETED&'"
								,"TR_1_MISSINGINFO":"'&TR_1_MISSINGINFO&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_PRIORITY":"'&TR_PRIORITY&'"
								,"TR_1_ASSIGNEDTO":"'&TR_1_ASSIGNEDTO&'"
								,"TR_1_DUEDATE":"'&TR_1_DUEDATE&'"
								,"TR_ESTTIME":"'&TR_ESTTIME&'"
								,"TR_3_REQUIRED":"'&TR_3_REQUIRED&'"
								,"TR_3_RFR":"'&TR_3_RFR&'"
								,"TR_3_ASSIGNEDTO":"'&TR_3_ASSIGNEDTO&'"
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
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[tr_3_extended], 101)AS[tr_3_extended]
,CONVERT(VARCHAR(10),[tr_3_completed], 101)AS[tr_3_completed]
,[tr_taxyear]
,[tr_taxform]
,[tr_priority]
,[tr_3_assignedto]
,[tr_3_pptresttime]
,CONVERT(VARCHAR(10),[tr_3_rfr], 101)AS[tr_3_rfr]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
FROM[v_taxreturns]
WHERE datepart(year,[tr_1_informationreceived]) = datepart(year, getdate())
AND [tr_taxyear] = DATEADD(year,-1,getdate())
AND[tr_3_required] = '1'
AND [tr_2_delivered] IS NULL
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
								,"TR_3_EXTENDED":"'&TR_3_EXTENDED&'"
								,"TR_3_COMPLETED":"'&TR_3_COMPLETED&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_PRIORITY":"'&TR_PRIORITY&'"
								,"TR_3_ASSIGNEDTO":"'&TR_3_ASSIGNEDTO&'"
								,"TR_3_PPTRESTTIME":"'&TR_3_PPTRESTTIME&'"
								,"TR_3_RFR":"'&TR_3_RFR&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
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