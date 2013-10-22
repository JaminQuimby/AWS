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


<!--- LOOKUP Payroll Checks --->
<cfcase value="group1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate] 
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_missinginfo] 
,CONVERT(VARCHAR(10),[pc_obtaininfo_datecompleted], 101)AS[pc_obtaininfo_datecompleted]
,CONVERT(VARCHAR(10),[pc_assembly_datecompleted], 101)AS[pc_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pc_delivery_datecompleted], 101)AS[pc_delivery_datecompleted]
,[pc_fees]
,[pc_paymentstatus]      
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE ([pc_delivery_datecompleted] IS NULL)
AND ([pc_paymentstatus] = '6' OR [pc_paymentstatus] IS NULL OR [pc_paymentstatus] = '0' )
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[pc_datedue]
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
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_OBTAININFO_DATECOMPLETED":"'&PC_OBTAININFO_DATECOMPLETED&'"
								,"PC_ASSEMBLY_DATECOMPLETED":"'&PC_ASSEMBLY_DATECOMPLETED&'"
								,"PC_DELIVERY_DATECOMPLETED":"'&PC_DELIVERY_DATECOMPLETED&'"
								,"PC_FEES":"'&PC_FEES&'"
								,"PC_PAYMENTSTATUS":"'&PC_PAYMENTSTATUS&'"
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


<!--- Grid 2 Entrance --->
<cfcase value="group2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[pt_id]
,CONVERT(VARCHAR(10),[pt_duedate], 101)AS[pt_duedate]
,[pt_type]
,[pt_year]
,[pt_month]
,CONVERT(VARCHAR(10),[pt_lastpay], 101)AS[pt_lastpay]
,CONVERT(VARCHAR(10),[pt_obtaininfo_datecompleted], 101)AS[pt_obtaininfo_datecompleted]
,[pt_missinginfo]
,CONVERT(VARCHAR(10),[pt_missingreceived], 101)AS[pt_missingreceived]
,CONVERT(VARCHAR(10),[pt_entry_datecompleted], 101)AS[pt_entry_datecompleted]
,CONVERT(VARCHAR(10),[pt_rec_datecompleted], 101)AS[pt_rec_datecompleted]
,CONVERT(VARCHAR(10),[pt_review_datecompleted], 101)AS[pt_review_datecompleted]
,CONVERT(VARCHAR(10),[pt_assembly_datecompleted], 101)AS[pt_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pt_delivery_datecompleted], 101)AS[pt_delivery_datecompleted]
,[pt_fees]
,[pt_paymentstatus]      
,[client_name]
,[client_id]
FROM[v_payrolltaxes]
WHERE ([pt_assembly_datecompleted] IS NULL)
AND ([pt_paymentstatus] = '6' OR [pt_paymentstatus] IS NULL OR [pt_paymentstatus] = '0')
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[pt_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
								,"PT_TYPE":"'&PT_TYPE&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTH":"'&PT_MONTH&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_OBTAININFO_DATECOMPLETED":"'&PT_OBTAININFO_DATECOMPLETED&'"
								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
								,"PT_MISSINGRECEIVED":"'&PT_MISSINGRECEIVED&'"
								,"PT_ENTRY_DATECOMPLETED":"'&PT_ENTRY_DATECOMPLETED&'"
								,"PT_REC_DATECOMPLETED":"'&PT_REC_DATECOMPLETED&'"
								,"PT_REVIEW_DATECOMPLETED":"'&PT_REVIEW_DATECOMPLETED&'"
								,"PT_ASSEMBLY_DATECOMPLETED":"'&PT_ASSEMBLY_DATECOMPLETED&'"
								,"PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"
								,"PT_FEES":"'&PT_FEES&'"
								,"PT_PAYMENTSTATUS":"'&PT_PAYMENTSTATUS&'"
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




<!--- Grid 3 Entrance --->
<cfcase value="group3">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[of_id]
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_form]
,CONVERT(VARCHAR(10),[of_obtaininfo_datecompleted], 101)AS[of_obtaininfo_datecompleted]
,[of_missinginfo]
,CONVERT(VARCHAR(10),[of_mireceived], 101)AS[of_mireceived]      
,CONVERT(VARCHAR(10),[of_preparation_datecompleted], 101)AS[of_preparation_datecompleted]
,CONVERT(VARCHAR(10),[of_review_datecompleted], 101)AS[of_review_datecompleted]
,CONVERT(VARCHAR(10),[of_assembly_datecompleted], 101)AS[of_assembly_datecompleted]
,CONVERT(VARCHAR(10),[of_delivery_datecompleted], 101)AS[of_delivery_datecompleted]
,[of_fees]
,[of_esttime]
,[of_paymentstatus]  
,[client_name]
,[client_id]
FROM[v_otherfilings]
WHERE ([of_status] = 2 OR [of_status] = 5)
AND ([of_paymentstatus] = '6' OR [of_paymentstatus] IS NULL OR [of_paymentstatus] = '0')
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[of_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"
								,"OF_PERIOD":"'&OF_PERIOD&'"
								,"OF_STATE":"'&OF_STATE&'"
								,"OF_FORM":"'&OF_FORM&'"
								,"OF_OBTAININFO_DATECOMPLETED":"'&OF_OBTAININFO_DATECOMPLETED&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
								,"OF_MIRECEIVED":"'&OF_MIRECEIVED&'"
								,"OF_PREPARATION_DATECOMPLETED":"'&OF_PREPARATION_DATECOMPLETED&'"
								,"OF_REVIEW_DATECOMPLETED":"'&OF_REVIEW_DATECOMPLETED&'"
								,"OF_ASSEMBLY_DATECOMPLETED":"'&OF_ASSEMBLY_DATECOMPLETED&'"
								,"OF_DELIVERY_DATECOMPLETED":"'&OF_DELIVERY_DATECOMPLETED&'"
								,"OF_FEES":"'&OF_FEES&'"
								,"OF_ESTTIME":"'&OF_ESTTIME&'"
								,"OF_PAYMENTSTATUS":"'&OF_PAYMENTSTATUS&'"
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


<!--- Grid 4 Entrance --->
<cfcase value="group4">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id]
,[bf_assignedto]
,[bf_status]
,[bf_businesstype]
,CONVERT(VARCHAR(10),[bf_businesssubmitted], 101)AS[bf_businesssubmitted]
,CONVERT(VARCHAR(10),[bf_businessreceived], 101)AS[bf_businessreceived]
,CONVERT(VARCHAR(10),[bf_dateinitiated], 101)AS[bf_dateinitiated]
,CONVERT(VARCHAR(10),[bf_articlessubmitted], 101)AS[bf_articlessubmitted]
,CONVERT(VARCHAR(10),[bf_articlesapproved], 101)AS[bf_articlesapproved]
,CONVERT(VARCHAR(10),[bf_tradenamesubmitted], 101)AS[bf_tradenamesubmitted]
,CONVERT(VARCHAR(10),[bf_tradenamereceived], 101)AS[bf_tradenamereceived]
,CONVERT(VARCHAR(10),[bf_minutesbylawsdraft], 101)AS[bf_minutesbylawsdraft]
,CONVERT(VARCHAR(10),[bf_minutesbylawsfinal], 101)AS[bf_minutesbylawsfinal]
,CONVERT(VARCHAR(10),[bf_minutescompleted], 101)AS[bf_minutescompleted]
,CONVERT(VARCHAR(10),[bf_dissolutionrequested], 101)AS[bf_dissolutionrequested]
,CONVERT(VARCHAR(10),[bf_dissolutionsubmitted], 101)AS[bf_dissolutionsubmitted]
,CONVERT(VARCHAR(10),[bf_dissolutioncompleted], 101)AS[bf_dissolutioncompleted]
,CONVERT(VARCHAR(10),[bf_otheractivity], 101)AS[bf_otheractivity]
,CONVERT(VARCHAR(10),[bf_otherstarted], 101)AS[bf_otherstarted]
,CONVERT(VARCHAR(10),[bf_othercompleted], 101)AS[bf_othercompleted]
,CONVERT(VARCHAR(10),[bf_recordbookordered], 101)AS[bf_recordbookordered]
,[bf_fees]
,[bf_paid]
,[client_name]
,[client_id]
FROM[v_businessformation]
WHERE ([bf_status] = 2 OR [bf_status] = 5)
AND ([bf_paid] = '6' OR [bf_paid] IS NULL OR [bf_paid] = '0')
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ASSIGNEDTO":"'&BF_ASSIGNEDTO&'"
								,"BF_BUSINESSTYPE":"'&BF_BUSINESSTYPE&'"
								,"BF_BUSINESSSUBMITTED":"'&BF_BUSINESSSUBMITTED&'"
								,"BF_BUSINESSRECEIVED":"'&BF_BUSINESSRECEIVED&'"
								,"BF_STATUS":"'&BF_STATUS&'"
								,"BF_DATEINITIATED":"'&BF_DATEINITIATED&'"
								,"BF_ARTICLESSUBMITTED":"'&BF_ARTICLESSUBMITTED&'"
								,"BF_ARTICLESAPPROVED":"'&BF_ARTICLESAPPROVED&'"
								,"BF_TRADENAMESUBMITTED":"'&BF_TRADENAMESUBMITTED&'"
								,"BF_TRADENAMERECEIVED":"'&BF_TRADENAMERECEIVED&'"
								,"BF_MINUTESBYLAWSDRAFT":"'&BF_MINUTESBYLAWSDRAFT&'"
								,"BF_MINUTESBYLAWSFINAL":"'&BF_MINUTESBYLAWSFINAL&'"
								,"BF_MINUTESCOMPLETED":"'&BF_MINUTESCOMPLETED&'"
								,"BF_DISSOLUTIONREQUESTED":"'&BF_DISSOLUTIONREQUESTED&'"
								,"BF_DISSOLUTIONSUBMITTED":"'&BF_DISSOLUTIONSUBMITTED&'"
								,"BF_DISSOLUTIONCOMPLETED":"'&BF_DISSOLUTIONCOMPLETED&'"
								,"BF_OTHERACTIVITY":"'&BF_OTHERACTIVITY&'"
								,"BF_OTHERSTARTED":"'&BF_OTHERSTARTED&'"
								,"BF_OTHERCOMPLETED":"'&BF_OTHERCOMPLETED&'"
								,"BF_RECORDBOOKORDERED":"'&BF_RECORDBOOKORDERED&'"
								,"BF_FEES":"'&BF_FEES&'"
								,"BF_PAID":"'&BF_PAID&'"
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



<!--- Grid 5 Entrance --->
<cfcase value="group5">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[mc_category]
,[mc_assignedto]
,[mc_status]
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
,CONVERT(VARCHAR(10),[mc_requestforservice], 101)AS[mc_requestforservice]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
,CONVERT(VARCHAR(10),[mc_workinitiated], 101)AS[mc_workinitiated]
,CONVERT(VARCHAR(10),[mc_projectcompleted], 101)AS[mc_projectcompleted]
,[mc_estimatedtime]
,[mc_fees]
,[mc_paid]    
,[client_name]
,[client_id]
FROM[v_managementconsulting]
WHERE ([mc_status] = 2 OR [mc_status] = 5)
AND ([mc_paid] = '6' OR [mc_paid] IS NULL OR [mc_paid] = '0')
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_CATEGORY":"'&MC_CATEGORY&'"
								,"MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'"
								,"MC_STATUS":"'&MC_STATUS&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_REQUESTFORSERVICE":"'&MC_REQUESTFORSERVICE&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_WORKINITIATED":"'&MC_WORKINITIATED&'"
								,"MC_PROJECTCOMPLETED":"'&MC_PROJECTCOMPLETED&'"
								,"MC_ESTIMATEDTIME":"'&MC_ESTIMATEDTIME&'"
								,"MC_FEES":"'&MC_FEES&'"
								,"MC_PAID":"'&MC_PAID&'"	
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


<!--- Grid 6 Entrance --->
<cfcase value="group6">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[fds_year]
,[fds_month]
,[fds_missinginfo]
,[fds_compilemi]
,CONVERT(VARCHAR(10),[fds_obtaininfo_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_obtaininfo_assignedto]) AS [fds_obtaininfo]
,CONVERT(VARCHAR(10),[fds_sort_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_sort_assignedto]) AS [fds_sort]
,CONVERT(VARCHAR(10),[fds_checks_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_checks_assignedto]) AS [fds_checks]
,CONVERT(VARCHAR(10),[fds_sales_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_sales_assignedto]) AS [fds_sales]
,CONVERT(VARCHAR(10),[fds_entry_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_entry_assignedto]) AS [fds_entry]
,CONVERT(VARCHAR(10),[fds_reconcile_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_reconcile_assignedto]) AS [fds_reconcile]
,CONVERT(VARCHAR(10),[fds_compile_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_compile_assignedto]) AS [fds_compile]
,CONVERT(VARCHAR(10),[fds_review_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_review_assignedto]) AS [fds_review]
,CONVERT(VARCHAR(10),[fds_assembly_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_assembly_assignedto]) AS [fds_assembly]
,CONVERT(VARCHAR(10),[fds_delivery_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_delivery_assignedto]) AS [fds_delivery]
,CONVERT(VARCHAR(10),[fds_acctrpt_datecompleted], 101) + '<br />' + CONVERT(VARCHAR(5),[fds_acctrpt_assignedto]) AS [fds_acctrpt]
,[fds_fees]
,[fds_paymentstatus]
,[client_name]
,[client_id]
FROM[v_financialdatastatus]
WHERE ([fds_status] = '2' OR [fds_status] = '5')
AND ([fds_paymentstatus] = '6' OR [fds_paymentstatus] IS NULL OR [fds_paymentstatus] = '0') 
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTH":"'&FDS_MONTH&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_OBTAININFO":"'&FDS_OBTAININFO&'"
								,"FDS_SORT":"'&FDS_SORT&'"
								,"FDS_CHECKS":"'&FDS_CHECKS&'"
								,"FDS_SALES":"'&FDS_SALES&'"
								,"FDS_ENTRY":"'&FDS_ENTRY&'"
								,"FDS_RECONCILE":"'&FDS_RECONCILE&'"
								,"FDS_COMPILE":"'&FDS_COMPILE&'"
								,"FDS_REVIEW":"'&FDS_REVIEW&'"
								,"FDS_ASSEMBLY":"'&FDS_ASSEMBLY&'"
								,"FDS_DELIVERY":"'&FDS_DELIVERY&'"
								,"FDS_ACCTRPT":"'&FDS_ACCTRPT&'"
								,"FDS_FEES":"'&FDS_FEES&'"
								,"FDS_PAYMENTSTATUS":"'&FDS_PAYMENTSTATUS&'"
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




<!--- Grid 7 Entrance --->
<cfcase value="group7">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[ftp_id]
,[ftp_category]
,[ftp_status]
,CONVERT(VARCHAR(10),[ftp_duedate], 101)AS[ftp_duedate]
,[ftp_assignedto]      
,CONVERT(VARCHAR(10),[ftp_requestservice], 101)AS[ftp_requestservice]
,CONVERT(VARCHAR(10),[ftp_inforequested], 101)AS[ftp_inforequested]
,CONVERT(VARCHAR(10),[ftp_inforeceived], 101)AS[ftp_inforeceived]
,CONVERT(VARCHAR(10),[ftp_infocompiled], 101)AS[ftp_infocompiled]
,[ftp_missinginfo]
,CONVERT(VARCHAR(10),[ftp_missinginforec], 101)AS[ftp_missinginforec]
,CONVERT(VARCHAR(10),[ftp_reportcompleted], 101)AS[ftp_reportcompleted]
,CONVERT(VARCHAR(10),[ftp_finalclientmeeting], 101)AS[ftp_finalclientmeeting]
,[ftp_fees]
,[ftp_paid]
,[client_name]
,[client_id]
FROM[v_financialtaxplanning]
WHERE ([ftp_status] = 2 OR [ftp_status] = 5)
AND ([ftp_paid] = '6' OR [ftp_paid] IS NULL OR [ftp_paid] = '0')
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
								,"FTP_STATUS":"'&FTP_STATUS&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_ASSIGNEDTO":"'&FTP_ASSIGNEDTO&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_INFOREQUESTED":"'&FTP_INFOREQUESTED&'"
								,"FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'"
								,"FTP_INFOCOMPILED":"'&FTP_INFOCOMPILED&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_MISSINGINFOREC":"'&FTP_MISSINGINFOREC&'"
								,"FTP_REPORTCOMPLETED":"'&FTP_REPORTCOMPLETED&'"
								,"FTP_FINALCLIENTMEETING":"'&FTP_FINALCLIENTMEETING&'"
								,"FTP_FEES":"'&FTP_FEES&'"
								,"FTP_PAID":"'&FTP_PAID&'"
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

<!--- Grid 8 Entrance --->
<cfcase value="group8">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_1_taxyear]
,[n_1_taxform]
,[n_1_noticenumber]
,[n_noticestatus]
,[n_3_missinginfo]
,CONVERT(VARCHAR(10),[n_2_datenoticerec], 101)AS[n_2_datenoticerec]
,CONVERT(VARCHAR(10),[n_2_resduedate], 101)AS[n_2_resduedate]
,CONVERT(VARCHAR(10),[n_2_ressubmited], 101)AS[n_2_ressubmited]
,[n_2_revrequired]   
,[n_1_fees]
,[n_1_paid]
,[client_name]
,[client_id]
FROM[v_notice]
WHERE[n_2_ressubmited] IS NOT NULL
AND ([n_1_paid] = '6' OR [n_1_paid] IS NULL OR [n_1_paid] = '0') 
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
 								,"NM_NAME":"'&NM_NAME&'"
 								,"N_1_TAXYEAR":"'&N_1_TAXYEAR&'"
 								,"N_1_TAXFORM":"'&N_1_TAXFORM&'"
 								,"N_1_NOTICENUMBER":"'&N_1_NOTICENUMBER&'"
 								,"N_NOTICESTATUS":"'&N_NOTICESTATUS&'"
 								,"N_3_MISSINGINFO":"'&N_3_MISSINGINFO&'"
 								,"N_2_DATENOTICEREC":"'&N_2_DATENOTICEREC&'"
 								,"N_2_RESDUEDATE":"'&N_2_RESDUEDATE&'"
 								,"N_2_RESSUBMITED":"'&N_2_RESSUBMITED&'"
 								,"N_2_REVREQUIRED":"'&N_2_REVREQUIRED&'"
 								,"N_1_FEES":"'&N_1_FEES&'"
 								,"N_1_PAID":"'&N_1_PAID&'"
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

<!--- Grid 9 Entrance --->
<cfcase value="group9">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,[tr_1_preparedby]
,CONVERT(VARCHAR(10),[tr_1_completed], 101)AS[tr_1_completed]
,CONVERT(VARCHAR(10),[tr_2_delivered], 101)AS[tr_2_delivered]
,[tr_currentfees]
,[tr_2_paymentstatus]
,[tr_2_multistatereturn]
,[client_name]
,[client_id]
FROM[v_taxreturns]
WHERE([tr_2_paymentstatus]IS NULL OR [tr_2_paymentstatus] = '6' OR [tr_2_paymentstatus] = '0')
<cfif ARGUMENTS.search neq "">AND [client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"							
								,"TR_1_PREPAREDBY":"'&TR_1_PREPAREDBY&'"								
								,"TR_1_COMPLETED":"'&TR_1_COMPLETED&'"
								,"TR_2_DELIVERED":"'&TR_2_DELIVERED&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_2_PAYMENTSTATUS":"'&TR_2_PAYMENTSTATUS&'"
								,"TR_2_MULTISTATERETURN":"'&TR_2_MULTISTATERETURN&'"
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


<!--- Grid 10 Entrance --->
<cfcase value="group10">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_3_completed], 101)AS[tr_3_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,[tr_3_currentfees]
,[tr_3_paymentstatus]
,[tr_2_multistatereturn]
,[client_name]
,[client_id]
FROM[v_taxreturns]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
AND ([tr_3_paymentstatus]IS NULL OR[tr_3_paymentstatus] = '6' OR[tr_3_paymentstatus] = '0')
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"							
								,"TR_3_COMPLETED":"'&TR_3_COMPLETED&'"								
								,"TR_3_CURRENTFEES":"'&TR_3_CURRENTFEES&'"
								,"TR_3_PAYMENTSTATUS":"'&TR_3_PAYMENTSTATUS&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_2_MULTISTATERETURN":"'&TR_2_MULTISTATERETURN&'"
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


<!--- Grid 11 Entrance --->
<cfcase value="group11">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[trst_id]
,[tr_id]
,[tr_taxyear]
,[trst_state]
,CONVERT(VARCHAR(10),[trst_1_completed], 101)AS[trst_1_completed]
,CONVERT(VARCHAR(10),[trst_2_delivered], 101)AS[trst_2_delivered]
,[trst_1_preparedby]
,[trst_2_currentfees]
,[trst_2_paymentstatus]
,[client_name]
,[client_id]
FROM[v_taxreturns_state]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
AND[trst_status] = '2'
AND[trst_1_informationreceived] IS NOT NULL
AND[trst_completed] IS NOT NULL
AND ([trst_2_paymentstatus]IS NULL OR [trst_2_paymentstatus] = '6' OR [trst_2_paymentstatus] = '0')
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TRST_STATE":"'&TRST_STATE&'"
								,"TRST_1_COMPLETED":"'&TRST_1_COMPLETED&'"							
								,"TRST_2_DELIVERED":"'&TRST_2_DELIVERED&'"								
								,"TRST_1_PREPAREDBY":"'&TRST_1_PREPAREDBY&'"
								,"TRST_2_CURRENTFEES":"'&TRST_2_CURRENTFEES&'"
								,"TRST_3_PAYMENTSTATUS":"'&TRST_3_PAYMENTSTATUS&'"
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


<!--- Grid 12 Entrance --->
<cfcase value="group12">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,[trst_state]
,CONVERT(VARCHAR(10),[trst_3_pptrcompleted], 101)AS[trst_3_pptrcompleted]
,[trst_3_pptrcurrentfees]
,[trst_3_paymentstatus]
,CONVERT(VARCHAR(10),[trst_3_pptrdelivered], 101)AS[trst_3_pptrdelivered]
,[client_name]
,[client_id]
FROM[v_taxreturns_state]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
AND[trst_1_completed] IS NOT NULL
AND ([trst_3_paymentstatus] IS NULL OR [trst_3_paymentstatus] ='6' OR [trst_3_paymentstatus] ='0') 
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TRST_STATE":"'&TRST_STATE&'"
								,"TRST_3_PPTRCOMPLETED":"'&TRST_3_PPTRCOMPLETED&'"							
								,"TRST_3_PPTRCURRENTFEES":"'&TRST_3_PPTRCURRENTFEES&'"
								,"TRST_3_PAYMENTSTATUS":"'&TRST_3_PAYMENTSTATUS&'"
								,"TRST_3_PPTRDELIVERED":"'&TRST_3_PPTRDELIVERED&'"								
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


<!--- Grid 13 Entrance --->
<cfcase value="group13">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[co_caller]
,[co_for]
,[co_fees]
,[co_paid]
,CONVERT(VARCHAR(10),[co_date], 101)AS[co_date]
,[co_telephone]
,[co_ext]
,[co_emailaddress]
,[co_responseneeded]
,[co_returncall]
,[co_briefmessage]
,[client_name]
,[client_id]
FROM[v_taxreturns]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
AND[co_completed] = 1
AND[co_fees] > 0
AND ([co_paid] IS NULL OR [co_paid] = '6'  OR [co_paid] = '0')
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_FOR":"'&CO_FOR&'"
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



</cfswitch>
</cffunction>
</cfcomponent>