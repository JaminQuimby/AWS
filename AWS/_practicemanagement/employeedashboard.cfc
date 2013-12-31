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

<!--- LOOKUP EMPLOYEES --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[user_id],[name]
FROM[v_staffinitials]
WHERE[name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"USER_ID":"'&USER_ID&'","NAME":"'&NAME&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>




<!--- LOOKUP Payroll Checks --->
<cfcase value="group1_1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,CONVERT(VARCHAR(10),[pc_obtaininfo_datecompleted], 101)AS[pc_obtaininfo_datecompleted]
,[pc_missinginfo]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE ([pc_delivery_datecompleted] IS NULL)
AND(
 ([pc_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pc_obtaininfo_datecompleted] IS NULL )
OR ([pc_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pc_preparation_datecompleted] IS NULL)
OR ([pc_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pc_review_datecompleted] IS NULL)
OR ([pc_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pc_assembly_datecompleted] IS NULL)
OR ([pc_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  )
)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[pc_datedue]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PC_YEAR":"'&PC_YEAR&'","PC_PAYENDDATE":"'&PC_PAYENDDATE&'","PC_PAYDATE":"'&PC_PAYDATE&'","PC_DATEDUE":"'&PC_DATEDUE&'","PC_OBTAININFO_DATECOMPLETED":"'&PC_OBTAININFO_DATECOMPLETED&'","PC_MISSINGINFO":"'&PC_MISSINGINFO&'"}'>
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
<cfcase value="group1_2">
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
WHERE([pt_delivery_datecompleted] IS NULL)
AND(
 ([pt_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pt_obtaininfo_datecompleted] IS NULL )
OR ([pt_entry_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pt_entry_datecompleted] IS NULL )
OR ([pt_rec_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pt_rec_datecompleted] IS NULL)
OR ([pt_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pt_review_datecompleted] IS NULL)
OR ([pt_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [pt_assembly_datecompleted] IS NULL)
OR ([pt_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  )
)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[pt_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PT_YEAR":"'&PT_YEAR&'","PT_MONTH":"'&PT_MONTH&'","PT_TYPE":"'&PT_TYPE&'","PT_PAID":"'&PT_PAID&'","PT_LASTPAY":"'&PT_LASTPAY&'","PT_DUEDATE":"'&PT_DUEDATE&'","PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Other Filings --->
<cfcase value="group1_3">
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
WHERE([of_delivery_datecompleted] IS NULL)
AND(
 ([of_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [of_obtaininfo_datecompleted] IS NULL )
OR ([of_preparation_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [of_preparation_datecompleted] IS NULL)
OR ([of_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [of_review_datecompleted] IS NULL)
OR ([of_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [of_assembly_datecompleted] IS NULL)
OR ([of_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  )
)

<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[of_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","OF_TAXYEAR":"'&OF_TAXYEAR&'","OF_STATE":"'&OF_STATE&'","OF_TASK":"'&OF_TASK&'","OF_FORM":"'&OF_FORM&'","OF_STATUS":"'&OF_STATUS&'","OF_DUEDATE":"'&OF_DUEDATE&'","OF_MISSINGINFO":"'&OF_MISSINGINFO&'"}'>
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


<!--- LOOKUP Business Formation --->
<cfcase value="group2_1">
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
WHERE[bf_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND ([bf_status] !=3 OR [bf_status] !=6)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[bf_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","BF_ACTIVITY":"'&BF_ACTIVITY&'","BF_STATUS":"'&BF_STATUS&'","BF_DUEDATE":"'&BF_DUEDATE&'","BF_FEES":"'&BF_FEES&'","BF_PAID":"'&BF_PAID&'"}'>
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
<cfcase value="group2_2">
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
WHERE[mc_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
OR [mcs_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/> 
AND ([mc_status] !=2 OR [mc_status] !=5)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[mc_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'","MC_DESCRIPTION":"'&MC_DESCRIPTION&'","MC_STATUS":"'&MC_STATUS&'","MC_DUEDATE":"'&MC_DUEDATE&'"}'>
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

<!--- LOOKUP Financial Statements --->
<cfcase value="group2_3">
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
WHERE([fds_acctrpt_datecompleted] IS NULL)
AND(
 ([fds_obtaininfo_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_obtaininfo_datecompleted] IS NULL )
OR ([fds_sort_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_sort_datecompleted] IS NULL)
OR ([fds_checks_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_checks_datecompleted] IS NULL)
OR ([fds_sales_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_sales_datecompleted] IS NULL)
OR ([fds_entry_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_entry_datecompleted] IS NULL)
OR ([fds_reconcile_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_reconcile_datecompleted] IS NULL)
OR ([fds_compile_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_compile_datecompleted] IS NULL)
OR ([fds_review_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_review_datecompleted] IS NULL)
OR ([fds_assembly_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_assembly_datecompleted] IS NULL)
OR ([fds_delivery_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  AND [fds_delivery_datecompleted] IS NULL)
OR ([fds_acctrpt_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>  )
)
AND ([fds_status] !=2 OR [fds_status] !=5)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[fds_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FDS_YEAR":"'&FDS_YEAR&'","FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'","FDS_DUEDATE":"'&FDS_DUEDATE&'","FDS_MISSINGINFORECEIVED":"'&FDS_MISSINGINFORECEIVED&'","FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'","FDS_CMIRECEIVED":"'&FDS_CMIRECEIVED&'","FDS_COMPILEMI":"'&FDS_COMPILEMI&'"}'>
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
<cfcase value="group3_1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_1_taxyear]
,[n_1_taxform]
,[n_1_noticenumber]
,[n_missinginfo]
,[nm_status]
,CONVERT(VARCHAR(10),[n_1_datenoticerec], 101)AS[n_1_datenoticerec]
,CONVERT(VARCHAR(10),[n_1_resduedate], 101)AS[n_1_resduedate]
,CONVERT(VARCHAR(10),[n_2_rescompleted], 101)AS[n_2_rescompleted]
,[client_name]
FROM[v_notice]
WHERE[n_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND ([n_noticestatus] !=2 OR [n_noticestatus] !=5)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[n_1_resduedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","NM_NAME":"'&NM_NAME&'","N_1_TAXYEAR":"'&N_1_TAXYEAR&'","N_1_TAXFORM":"'&N_1_TAXFORM&'","N_1_NOTICENUMBER":"'&N_1_NOTICENUMBER&'","N_MISSINGINFO":"'&N_MISSINGINFO&'","NM_STATUS":"'&NM_STATUS&'","N_1_DATENOTICEREC":"'&N_1_DATENOTICEREC&'","N_1_RESDUEDATE":"'&N_1_RESDUEDATE&'","N_2_RESCOMPLETED":"'&N_2_RESCOMPLETED&'"}'>
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


<!--- Grid Notice  --->
<cfcase value="group3_2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_1_taxyear]
,[n_1_taxform]
,[n_1_noticenumber]
,[n_missinginfo]
,[nm_status]
,CONVERT(VARCHAR(10),[n_1_datenoticerec], 101)AS[n_1_datenoticerec]
,CONVERT(VARCHAR(10),[n_1_resduedate], 101)AS[n_1_resduedate]
,CONVERT(VARCHAR(10),[n_2_rescompleted], 101)AS[n_2_rescompleted]
,[client_name]
FROM[v_notice]
WHERE[n_2_revassignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND ([n_noticestatus] !=3 OR [n_noticestatus] !=6)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
ORDER BY[n_1_resduedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","NM_NAME":"'&NM_NAME&'","N_1_TAXYEAR":"'&N_1_TAXYEAR&'","N_1_TAXFORM":"'&N_1_TAXFORM&'","N_1_NOTICENUMBER":"'&N_1_NOTICENUMBER&'","N_MISSINGINFO":"'&N_MISSINGINFO&'","NM_STATUS":"'&NM_STATUS&'","N_1_DATENOTICEREC":"'&N_1_DATENOTICEREC&'","N_1_RESDUEDATE":"'&N_1_RESDUEDATE&'","N_2_RESCOMPLETED":"'&N_2_RESCOMPLETED&'"}'>
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

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group4_1">
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
WHERE[tr_2_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND [tr_2_informationreceived] IS NOT NULL
AND [tr_missinginfo]='0'
AND [tr_notrequired]='0'
AND [tr_2_completed] IS NULL
AND [tr_2_reviewedwithnotes] IS NOT NULL
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[tr_duedate]</cfif>
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

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group4_2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_2_informationreceived]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,[client_name]
,[client_id]
FROM[v_taxreturns]
WHERE [tr_missinginfo]='1'
AND [tr_2_informationreceived] IS NOT NULL
AND [tr_notrequired]='0'
AND [tr_2_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[tr_duedate]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{
								"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
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
<cfcase value="group4_3">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_1_informationreceived]
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate]
,CONVERT(VARCHAR(10),[tr_2_readyforreview], 101)AS[tr_2_readyforreview]
,CONVERT(VARCHAR(10),[tr_1_dropoffappointment], 101)AS[tr_1_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_1_pickupappointment], 101)AS[tr_1_pickupappointment]
,[tr_missinginfo]
,CONVERT(VARCHAR(10),[tr_2_reviewedwithnotes], 101)AS[tr_2_reviewedwithnotes]
,CONVERT(VARCHAR(10),[tr_2_completed], 101)AS[tr_2_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,[tr_paid]
FROM[v_taxreturns]
WHERE[tr_2_reviewassignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND [tr_2_readyforreview] IS NOT NULL
AND [tr_2_informationreceived] IS NOT NULL
AND [tr_2_completed] IS NULL
AND [tr_notrequired]='0'
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[tr_duedate]</cfif>
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
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
								,"TR_1_DROPOFFAPPOINTMENT":"'&TR_1_DROPOFFAPPOINTMENT&'"
								,"TR_1_PICKUPAPPOINTMENT":"'&TR_1_PICKUPAPPOINTMENT&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_PAID":"'&TR_PAID&'"}'>
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
<cfcase value="group4_4">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_2_completed], 101)AS[tr_2_completed]
,[tr_currentfees]
,CONVERT(VARCHAR(10),[tr_3_assemblereturn], 101)AS[tr_3_assemblereturn]
,CONVERT(VARCHAR(10),[tr_3_contacted], 101)AS[tr_3_contacted]
,CONVERT(VARCHAR(10),[tr_1_dropoffappointment], 101)AS[tr_1_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_1_pickupappointment], 101)AS[tr_1_pickupappointment]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,[tr_paid]
FROM[v_taxreturns]
WHERE[tr_2_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND [tr_2_informationreceived] IS NOT NULL
AND [tr_2_completed] IS NOT NULL
AND [tr_notrequired]='0'
AND [tr_3_delivered] IS NULL
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[tr_duedate]</cfif>
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
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"
								,"TR_3_CONTACTED":"'&TR_3_CONTACTED&'"
								,"TR_1_DROPOFFAPPOINTMENT":"'&TR_1_DROPOFFAPPOINTMENT&'"
								,"TR_1_PICKUPAPPOINTMENT":"'&TR_1_PICKUPAPPOINTMENT&'"
								,"TR_PAID":"'&TR_PAID&'"}'>
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
<cfcase value="group4_5">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[trst_id]
,[tr_id]
,[client_name]
,[tr_taxyear]
,[tr_taxform]
,[trst_state]
,CONVERT(VARCHAR(10),[trst_1_informationreceived], 101)AS[trst_1_informationreceived]
,CONVERT(VARCHAR(10),[trst_1_duedate], 101)AS[trst_1_duedate]
,CONVERT(VARCHAR(10),[trst_1_missinginforeceived], 101)AS[trst_1_missinginforeceived]
,CONVERT(VARCHAR(10),[trst_1_readyforreview], 101)AS[trst_1_readyforreview]
FROM[v_TAXRETURNS_STATE]
WHERE [trst_reviewassignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
OR [trst_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND ([trst_status] != '2' OR [trst_status] != '5')
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[tr_duedate]</cfif>
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
								,"TRST_1_INFORMATIONRECEIVED":"'&TRST_1_INFORMATIONRECEIVED&'"
								,"TRST_1_DUEDATE":"'&TRST_1_DUEDATE&'"
								,"TRST_1_MISSINGINFORECEIVED":"'&TRST_1_MISSINGINFORECEIVED&'"
								,"TRST_1_READYFORREVIEW":"'&TRST_1_READYFORREVIEW&'"}'>
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
<cfcase value="group4_6">
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
WHERE[ftp_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
AND [ftp_status] != '2'
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FTP_CATEGORY":"'&FTP_CATEGORY&'","FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'","FTP_DUEDATE":"'&FTP_DUEDATE&'","FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'","FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'","FTP_STATUS":"'&FTP_STATUS&'"}'>
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


<!--- LOOKUP Administrative Tasks --->
<cfcase value="group5_1">
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
WHERE[cas_assignedto]=<cfqueryparam value="#ARGUMENTS.userid#"/>
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

<!--- LOOKUP Communications --->
<cfcase value="group5_2">
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
WHERE[co_for]=<cfqueryparam value="#ARGUMENTS.userid#"/>
And[co_completed]='0'
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

<!--- LOOKUP Document Tracking Log --->
<cfcase value="group5_3">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[dt_id]
,[dt_sender]
,CASE WHEN LEN([dt_description]) >= 101 THEN SUBSTRING([dt_description],0,100) +  '...' ELSE [dt_description] END AS[dt_description]
,CASE WHEN LEN([dt_routing]) >= 101 THEN SUBSTRING([dt_routing],0,100) +  '...' ELSE [dt_routing] END AS[dt_routing]
,CONVERT(VARCHAR(10),[dt_date], 101)AS[dt_date]
,[dt_delivery]
,[dt_staffTEXT]
,[client_name]
,[client_id]
,STUFF((SELECT','+[si_initials] 
FROM[staffinitials] 
WHERE(','+[v_documenttracking].[dt_assignedto]
LIKE'%,'+CONVERT(VARCHAR(12),[user_id])+'%'  )
FOR XML PATH('')),1,1,'') AS 'dt_assignedtoTEXT' 
FROM[v_documenttracking]
WHERE(','+[dt_assignedto]LIKE'%,'+CONVERT(VARCHAR(12),<cfqueryparam value="#ARGUMENTS.userid#"/>)+'%')

<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"DT_ID":"'&DT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"DT_DATE":"'&DT_DATE&'"
								,"DT_STAFFTEXT":"'&DT_STAFFTEXT&'"
								,"DT_SENDER":"'&DT_SENDER&'"
								,"DT_DESCRIPTION":"'&DT_DESCRIPTION&'"
								,"DT_DELIVERY":"'&DT_DELIVERY&'"
								,"DT_ROUTING":"'&DT_ROUTING&'"
								,"DT_ASSIGNEDTOTEXT":"'&DT_ASSIGNEDTOTEXT&'"		
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