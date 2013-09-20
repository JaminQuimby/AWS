<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->


<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->







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

<cfswitch expression="#ARGUMENTS.loadType#">

<!--- Grid 0 Entrance --->
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
<cfcase value="group2_1">
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,[pc_payenddate]
,[pc_paydate]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_missingreceived]
,[pc_missinginfo]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE[pc_obtaininfo_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[pc_datedue]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PC_YEAR":"'&PC_YEAR&'","PC_PAYENDDATE":"'&PC_PAYENDDATE&'","PC_PAYDATE":"'&PC_PAYDATE&'","PC_DATEDUE":"'&PC_DATEDUE&'","PC_MISSINGRECEIVED":"'&PC_MISSINGRECEIVED&'","PC_MISSINGINFO":"'&PC_MISSINGINFO&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Payroll Taxes --->
<cfcase value="group2_2">
<cfquery datasource="AWS" name="fquery">
SELECT[pt_id]
,[pt_year]
,[pt_month]
,[pt_type]
,[pt_paymentstatus]
,[pt_lastpay]
,CONVERT(VARCHAR(10),[pt_duedate], 101)AS[pt_duedate]
,[pt_delivery_datecompleted]
,[pt_obtaininfo_assignedto]
,[client_name]
,[CLIENT_ID]
FROM[v_payrolltaxes]
WHERE[pt_obtaininfo_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[pt_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PT_YEAR":"'&PT_YEAR&'","PT_MONTH":"'&PT_MONTH&'","PT_TYPE":"'&PT_TYPE&'","PT_PAYMENTSTATUS":"'&PT_PAYMENTSTATUS&'","PT_LASTPAY":"'&PT_LASTPAY&'","PT_DUEDATE":"'&PT_DUEDATE&'","PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Other Filings --->
<cfcase value="group2_3">
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
,[of_obtaininfo_assignedto]
FROM[v_otherfilings]
WHERE[of_obtaininfo_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[of_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","OF_TAXYEAR":"'&OF_TAXYEAR&'","OF_STATE":"'&OF_STATE&'","OF_TASK":"'&OF_TASK&'","OF_FORM":"'&OF_FORM&'","OF_STATUS":"'&OF_STATUS&'","OF_DUEDATE":"'&OF_DUEDATE&'","OF_MISSINGINFO":"'&OF_MISSINGINFO&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Business Formation --->
<cfcase value="group3_1">
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,[bf_activity]
,[bf_status]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_fees]
,[bf_paid]
,[bf_assignedto]
FROM[v_businessformation]
WHERE[bf_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
</cfcase>


<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group3_2">
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,[mc_assignedto]
,[mc_categorytext]
,[mc_description]
,[mc_status]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
FROM[v_managementconsulting]
WHERE[mc_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[mc_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'","CLIENT_NAME":"'&CLIENT_NAME&'","MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'","MC_DESCRIPTION":"'&MC_DESCRIPTION&'","MC_STATUS":"'&MC_STATUS&'","MC_DUEDATE":"'&MC_DUEDATE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Financial Statements --->
<cfcase value="group3_3">
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]
,[fds_missinginfo]
,[fds_mireceived]
,[fds_compilemi]
,[fds_cmireceived]
,[fds_obtaininfo_assignedto]
,CONVERT(VARCHAR(10),[fds_duedate], 101)AS[fds_duedate]
FROM[v_financialDataStatus]
WHERE[fds_obtaininfo_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[fds_duedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FDS_YEAR":"'&FDS_YEAR&'","FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'","FDS_DUEDATE":"'&FDS_DUEDATE&'","FDS_MIRECEIVED":"'&FDS_MIRECEIVED&'","FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'","FDS_CMIRECEIVED":"'&FDS_CMIRECEIVED&'","FDS_COMPILEMI":"'&FDS_COMPILEMI&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- Grid Notice  --->
<cfcase value="group4_1">
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_1_taxyear]
,[n_1_taxform]
,[n_1_noticenumber]
,[n_3_missinginfo]
,[nm_status]
,CONVERT(VARCHAR(10),[n_2_datenoticerec], 101)AS[n_2_datenoticerec]
,CONVERT(VARCHAR(10),[n_2_resduedate], 101)AS[n_2_resduedate]
,CONVERT(VARCHAR(10),[n_2_rescompleted], 101)AS[n_2_rescompleted]
,[n_assignedtoTEXT]
,[client_id]
,[client_name]
FROM[v_notice]
WHERE[n_assignedto]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/> AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[n_2_resduedate]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","NM_NAME":"'&NM_NAME&'","N_1_TAXYEAR":"'&N_1_TAXYEAR&'","N_1_TAXFORM":"'&N_1_TAXFORM&'","N_1_NOTICENUMBER":"'&N_1_NOTICENUMBER&'","N_3_MISSINGINFO":"'&N_3_MISSINGINFO&'","NM_STATUS":"'&NM_STATUS&'","N_2_DATENOTICEREC":"'&N_2_DATENOTICEREC&'","N_2_RESDUEDATE":"'&N_2_RESDUEDATE&'","N_2_RESCOMPLETED":"'&N_2_RESCOMPLETED&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- Grid Notice  --->
<cfcase value="group4_2">
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[n_assignedtoTEXT]
FROM[v_notice]
WHERE[nm_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[n_assignedtoTEXT]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","N_ASSIGNEDTOTEXT":"'&N_ASSIGNEDTOTEXT&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_1">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_taxyear]
,[tr_taxform]
,[tr_g1_1_informationreceived]
,[tr_priorfees]
,[tr_g1_4_dropoffappointment]
,[tr_g1_4_pickupappointment]
,[tr_g1_1_missinginforeceived]
,[tr_g1_1_duedate]
,[tr_g1_1_reviewedwithnotes]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_G1_1_INFORMATIONRECEIVED":"'&TR_G1_1_INFORMATIONRECEIVED&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_G1_4_DROPOFFAPPOINTMENT":"'&TR_G1_4_DROPOFFAPPOINTMENT&'"
								,"TR_G1_4_PICKUPAPPOINTMENT":"'&TR_G1_4_PICKUPAPPOINTMENT&'"
								,"TR_G1_1_MISSINGINFORECEIVED":"'&TR_G1_1_MISSINGINFORECEIVED&'"
								,"TR_G1_1_DUEDATE":"'&TR_G1_1_DUEDATE&'"
								,"TR_G1_1_REVIEWEDWITHNOTES":"'&TR_G1_1_REVIEWEDWITHNOTES&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_2">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]


,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'","TR_TAXFORM":"'&TR_TAXFORM&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_3">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_4">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_5">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group5_6">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Administrative Tasks --->
<cfcase value="group6_1">
<cfquery datasource="AWS" name="fquery">
SELECT [cas_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[cas_duedate], 101)AS[cas_duedate]
FROM[v_clientadministrativetasks]WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CAS_DUEDATE":"'&CAS_DUEDATE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Communications --->
<cfcase value="group6_2">
<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[co_forTEXT]
,[client_name]
,[CLIENT_ID]
FROM[v_communications]
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
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CO_FORTEXT":"'&CO_FORTEXT&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Document Tracking Log --->
<cfcase value="group6_3">
<cfquery datasource="AWS" name="fquery">
SELECT[dt_id]
,[dt_sender]
,[dt_description]
,[dt_assignedto]
,[dt_routing]
,[client_name]
,[CLIENT_ID]
FROM[v_documenttracking]
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
<cfset queryResult=queryResult&'{"DT_ID":"'&DT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","DT_SENDER":"'&DT_SENDER&'","DT_ASSIGNEDTO":"'&DT_ASSIGNEDTO&'","DT_ROUTING":"'&DT_ROUTING&'","DT_DESCRIPTION":"'&DT_DESCRIPTION&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>



</cfswitch>

</cffunction>
</cfcomponent>