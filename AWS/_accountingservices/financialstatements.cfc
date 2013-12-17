<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_id]
,[client_id]
,CONVERT(VARCHAR(10),[fds_cmireceived], 101)AS[fds_cmireceived]
,[fds_compilemi]
,[fds_deliverymethod]
,CONVERT(VARCHAR(10),[fds_duedate], 101)AS[fds_duedate]
,[fds_esttime]
,[fds_fees]
,CONVERT(VARCHAR(10),[fds_missinginforeceived], 101)AS[fds_missinginforeceived]
,[fds_missinginfo]
,[fds_month]
,[fds_paid]
,CONVERT(VARCHAR(10),[fds_periodend], 101)AS[fds_periodend]
,[fds_priority]
,[fds_status]
,[fds_year]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_obtaininfo_assignedto]
,[fds_obtaininfo_completedby]
,CONVERT(VARCHAR(10),[fds_obtaininfo_datecompleted], 101)AS[fds_obtaininfo_datecompleted]
,[fds_obtaininfo_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_sort_assignedto]
,[fds_sort_completedby]
,CONVERT(VARCHAR(10),[fds_sort_datecompleted], 101)AS[fds_sort_datecompleted]
,[fds_sort_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_checks_assignedto]
,[fds_checks_completedby]
,CONVERT(VARCHAR(10),[fds_checks_datecompleted], 101)AS[fds_checks_datecompleted]
,[fds_checks_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_sales_assignedto]
,[fds_sales_completedby]
,CONVERT(VARCHAR(10),[fds_sales_datecompleted], 101)AS[fds_sales_datecompleted]
,[fds_sales_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_entry_assignedto]
,[fds_entry_completedby]
,CONVERT(VARCHAR(10),[fds_entry_datecompleted], 101)AS[fds_entry_datecompleted]
,[fds_entry_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup6 --->
<cfcase value="group1_6">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_reconcile_assignedto]
,[fds_reconcile_completedby]
,CONVERT(VARCHAR(10),[fds_reconcile_datecompleted], 101)AS[fds_reconcile_datecompleted]
,[fds_reconcile_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup7 --->
<cfcase value="group1_7">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_compile_assignedto]
,[fds_compile_completedby]
,CONVERT(VARCHAR(10),[fds_compile_datecompleted], 101)AS[fds_compile_datecompleted]
,[fds_compile_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup8 --->
<cfcase value="group1_8">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_review_assignedto]
,[fds_review_completedby]
,CONVERT(VARCHAR(10),[fds_review_datecompleted], 101)AS[fds_review_datecompleted]
,[fds_review_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup9 --->
<cfcase value="group1_9">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_assembly_assignedto]
,[fds_assembly_completedby]
,CONVERT(VARCHAR(10),[fds_assembly_datecompleted], 101)AS[fds_assembly_datecompleted]
,[fds_assembly_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup10 --->
<cfcase value="group1_10">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_delivery_assignedto]
,[fds_delivery_completedby]
,CONVERT(VARCHAR(10),[fds_delivery_datecompleted], 101)AS[fds_delivery_datecompleted]
,[fds_delivery_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup11 --->
<cfcase value="group1_11">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_acctrpt_assignedto]
,[fds_acctrpt_completedby]
,CONVERT(VARCHAR(10),[fds_acctrpt_datecompleted], 101)AS[fds_acctrpt_datecompleted]
,[fds_acctrpt_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group 2--->
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
SELECT[fdss_id]
,[fdss_assignedto]
,CONVERT(VARCHAR(10),[fdss_completed], 101)AS[fdss_completed]
,CONVERT(VARCHAR(10),[fdss_duedate], 101)AS[fdss_duedate]
,[fdss_notes]
,[fdss_sequence]
,[fdss_status]
,[fdss_subtask]
FROM[financialdatastatus_subtask]
WHERE[fdss_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Asset Credit Hold --->
<cfcase value="assetCreditHold">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_credit_hold]
FROM[client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"]}'> 
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
<cfargument name="formid" type="string" required="no">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">

<!--- LOOKUP Financial Statements --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,CONVERT(VARCHAR(10),[fds_periodend], 101)AS[fds_periodend]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]
,CONVERT(VARCHAR(10),[fds_duedate], 101)AS[fds_duedate]
,[fds_status]
,[fds_missinginfo]
,[fds_compilemi]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id]
)AS[fds_statusTEXT]

FROM[v_financialDataStatus]
WHERE[fds_status] != 2 
AND [fds_status] != 5
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
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
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_PERIODEND":"'&FDS_PERIODEND&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_STATUSTEXT":"'&FDS_STATUSTEXT&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2 --->
<cfcase value="group2"><cfquery datasource="AWS" name="fquery">
SELECT[fdss_id],[fdss_subtaskTEXT],[fdss_subtask]
FROM[v_financialDataStatus_Subtask]
WHERE<cfif ARGUMENTS.ID neq "0">[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND</cfif>
[fds_id]=<cfqueryparam value="#ARGUMENTS.id#"/>AND[fdss_subtaskTEXT]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[fdss_subtaskTEXT]</cfif></cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDSS_ID":"'&FDSS_ID&'","fdss_subtaskTEXT":"'&fdss_subtaskTEXT&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>

<!--- [SAVE FUNCTIONs] --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cftry>
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">
<cfcase value="none">
</cfcase>

<!--- Group1 --->
<cfcase value="group1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[financialdatastatus](
[client_id]
,[fds_cmireceived]
,[fds_compilemi]
,[fds_deliverymethod]
,[fds_duedate]
,[fds_esttime]
,[fds_fees]
,[fds_missinginforeceived]
,[fds_missinginfo]
,[fds_month]
,[fds_paid]
,[fds_periodend]
,[fds_priority]
,[fds_status]
,[fds_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#"  null="#LEN(j.DATA[1][16]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN FDS_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group1_1","result":"ok"}'>

<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[financialdatastatus]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_cmireceived]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_compilemi]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[fds_deliverymethod]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[fds_duedate]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[fds_esttime]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[fds_fees]=<cfqueryparam value="#j.DATA[1][8]#"  null="#LEN(j.DATA[1][8]) eq 0#"/>
,[fds_missinginforeceived]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[fds_missinginfo]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[fds_month]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[fds_paid]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[fds_periodend]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[fds_priority]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[fds_status]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[fds_year]=<cfqueryparam value="#j.DATA[1][16]#"  null="#LEN(j.DATA[1][16]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>

<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_sort_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_sort_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_sort_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_sort_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_checks_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_checks_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_checks_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_checks_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_sales_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_sales_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_sales_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_sales_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup5 --->
<cfcase value="group1_5">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_entry_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_entry_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_entry_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_entry_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_6","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup6 --->
<cfcase value="group1_6">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_reconcile_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_reconcile_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_reconcile_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_reconcile_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_7","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup7 --->
<cfcase value="group1_7">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_compile_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_compile_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_compile_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_compile_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_8","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup8 --->
<cfcase value="group1_8">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_9","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup9 --->
<cfcase value="group1_9">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_10","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup10 --->
<cfcase value="group1_10">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_11","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup11 --->
<cfcase value="group1_11">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS]
SET[fds_acctrpt_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_acctrpt_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fds_acctrpt_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_acctrpt_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[FDS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[FINANCIALDATASTATUS_SUBTASK]([fds_id]
,[fdss_assignedto]
,[fdss_completed]
,[fdss_duedate]
,[fdss_notes]
,[fdss_sequence]
,[fdss_status]
,[fdss_subtask]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALDATASTATUS_SUBTASK]
SET[fds_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fdss_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[fdss_completed]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[fdss_duedate]=<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,[fdss_notes]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[fdss_sequence]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[fdss_status]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[fdss_subtask]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[FDSS_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>