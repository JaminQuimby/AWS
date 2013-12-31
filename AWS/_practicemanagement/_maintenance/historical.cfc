<cfcomponent output="true">
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
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
<cfcase value="group1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT [cas_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[cas_duedate], 101)AS[cas_duedate]
,[cas_priority]
,[cas_status]
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc] 
FROM[v_clientadministrativetasks]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_PRIORITY":"'&CAS_PRIORITY&'"
								,"CAS_STATUS":"'&CAS_STATUS&'"
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
<cfcase value="group2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,[bf_activity]
,[bf_status]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_fees]
,[bf_paid]
FROM[v_businessformation]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[bf_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ACTIVITY":"'&BF_ACTIVITY&'"
								,"BF_STATUS":"'&BF_STATUS&'"
								,"BF_DUEDATE":"'&BF_DUEDATE&'"
								,"BF_FEES":"'&BF_FEES&'"
								,"BF_PAID":"'&BF_PAID&'"
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

<!--- LOOKUP Communications --->
<cfcase value="group3">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[client_name]
,[client_id]
,[co_caller]
,[co_credithold]
,[co_fees]
,[co_paid]
,CONVERT(CHAR(10),[co_date], 101)+' '+RIGHT(CONVERT(VARCHAR,co_date, 100),7)AS[co_date]
,[co_telephone]
,[co_ext]
,[co_emailaddress]
,[co_responseneeded]
,[co_returncall]
,[co_briefmessage]
FROM[v_communications]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_CREDITHOLD":"'&CO_CREDITHOLD&'"
								,"CO_FEES":"'&CO_FEES&'"
								,"CO_PAID":"'&CO_PAID&'"
								,"CO_DATE":"'&CO_DATE&'"
								,"CO_TELEPHONE":"'&CO_TELEPHONE&'"
								,"CO_EXT":"'&CO_EXT&'"
								,"CO_EMAILADDRESS":"'&CO_EMAILADDRESS&'"
								,"CO_RESPONSENEEDED":"'&CO_RESPONSENEEDED&'"
								,"CO_RETURNCALL":"'&CO_RETURNCALL&'"
								,"CO_BRIEFMESSAGE":"'&CO_BRIEFMESSAGE&'"								
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

<!--- LOOKUP Client Maintenance --->
<cfcase value="group4">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[client_id]
,[client_name]
,[client_type]
,[client_trade_name]
,[client_active]
,[client_salutation]
,[client_spouse]
,[client_credit_hold]
,[client_schedule_c]
,[client_schedule_e]
,[client_disregard]
,[client_personal_property]
FROM[v_client_listing]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CLIENT_TYPE":"'&CLIENT_TYPE&'"
								,"CLIENT_TRADE_NAME":"'&CLIENT_TRADE_NAME&'"
								,"CLIENT_ACTIVE":"'&CLIENT_ACTIVE&'"
								,"CLIENT_SALUTATION":"'&CLIENT_SALUTATION&'"
								,"CLIENT_SPOUSE":"'&CLIENT_SPOUSE&'"
								,"CLIENT_CREDIT_HOLD":"'&CLIENT_CREDIT_HOLD&'"
								,"CLIENT_SCHEDULE_C":"'&CLIENT_SCHEDULE_C&'"
								,"CLIENT_SCHEDULE_E":"'&CLIENT_SCHEDULE_E&'"
								,"CLIENT_DISREGARD":"'&CLIENT_DISREGARD&'"
								,"CLIENT_PERSONAL_PROPERTY":"'&CLIENT_PERSONAL_PROPERTY&'"
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

<!--- LOOKUP Financial Tax Planning --->
<cfcase value="group5">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[ftp_id]
,[client_name]
,[client_id]
,[ftp_category]
,CONVERT(VARCHAR(10),[ftp_requestservice], 101)AS[ftp_requestservice]
,CONVERT(VARCHAR(10),[ftp_duedate], 101)AS[ftp_duedate]
,CONVERT(VARCHAR(10),[ftp_inforeceived], 101)AS[ftp_inforeceived]
,[ftp_missinginfo]
,[ftp_status]
FROM[v_financialtaxplanning]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
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
								,"FTP_CATEGORY":"'&FTP_CATEGORY&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_STATUS":"'&FTP_STATUS&'"
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
<cfcase value="group6">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]
,[fds_missinginfo]
,CONVERT(VARCHAR(10),[fds_missinginforeceived], 101)AS[fds_missinginforeceived]
,[fds_compilemi]
,CONVERT(VARCHAR(10),[fds_cmireceived], 101)AS[fds_cmireceived]
,CONVERT(VARCHAR(10),[fds_duedate], 101)AS[fds_duedate]
FROM[v_financialDataStatus]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif></cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_MISSINGINFORECEIVED":"'&FDS_MISSINGINFORECEIVED&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_CMIRECEIVED":"'&FDS_CMIRECEIVED&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
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
<cfcase value="group7">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,[mc_categorytext]
,[mc_description]
,[mc_status]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
FROM[v_managementconsulting]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_STATUS":"'&MC_STATUS&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
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
<cfcase value="group8">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[nm_name]
,[nm_status]
,[client_name]
FROM[v_noticematter]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"NM_NAME":"'&NM_NAME&'"
								,"NM_STATUS":"'&NM_STATUS&'"
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
<cfcase value="group9">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[of_id]
,[of_taxyear]
,[of_state]
,[of_task]
,[of_form]
,[of_status]
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_missinginfo]
,[client_name]
FROM[v_otherfilings]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"
								,"OF_STATE":"'&OF_STATE&'"
								,"OF_TASK":"'&OF_TASK&'"
								,"OF_FORM":"'&OF_FORM&'"
								,"OF_STATUS":"'&OF_STATUS&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
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
<cfcase value="group10">
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,CONVERT(VARCHAR(10),[pc_missinginforeceived], 101)AS[pc_missinginforeceived]
,[pc_missinginfo]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PC_YEAR":"'&PC_YEAR&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
								,"PC_MISSINGINFORECEIVED":"'&PC_MISSINGINFORECEIVED&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group11">
<cfquery datasource="AWS" name="fquery">
SELECT[pt_id]
,[pt_year]
,[pt_month]
,[pt_type]
,[pt_paid]
,CONVERT(VARCHAR(10),[pt_lastpay], 101)AS[pt_lastpay]
,CONVERT(VARCHAR(10),[pt_duedate], 101)AS[pt_duedate]
,CONVERT(VARCHAR(10),[pt_delivery_datecompleted], 101)AS[pt_delivery_datecompleted]
,[client_name]
,[client_id]
FROM[v_payrolltaxes]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTH":"'&PT_MONTH&'"
								,"PT_TYPE":"'&PT_TYPE&'"
								,"PT_PAID":"'&PT_PAID&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
								,"PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group12">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_2_informationreceived]
,[tr_priorfees]
,CONVERT(VARCHAR(10),[tr_1_dropoffappointment], 101)AS[tr_1_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_1_pickupappointment], 101)AS[tr_1_pickupappointment]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate]
,CONVERT(VARCHAR(10),[tr_2_reviewedwithnotes], 101)AS[tr_2_reviewedwithnotes]
FROM[v_taxreturns]
<cfif ARGUMENTS.search neq "">
WHERE [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_1_DROPOFFAPPOINTMENT":"'&TR_1_DROPOFFAPPOINTMENT&'"
								,"TR_1_PICKUPAPPOINTMENT":"'&TR_1_PICKUPAPPOINTMENT&'"
								,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"}'>
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