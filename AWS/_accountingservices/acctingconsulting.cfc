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
<!--- Load Group1--->

<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[mc_id]
,[client_id]
,[mc_assignedto]
,[mc_category]
,[mc_description]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
,[mc_esttime]
,[mc_fees]
,[mc_missinginfo]
,CONVERT(VARCHAR(10),[mc_missinginforeceived], 101)AS[mc_missinginforeceived]
,[mc_paid]
,[mc_priority]
,CONVERT(VARCHAR(10),[mc_projectcompleted], 101)AS[mc_projectcompleted]
,CONVERT(VARCHAR(10),[mc_requestforservice], 101)AS[mc_requestforservice]
,[mc_status]
,CONVERT(VARCHAR(10),[mc_workinitiated], 101)AS[mc_workinitiated]
FROM[v_managementconsulting]
WHERE[mc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>

</cfcase>
<!--- Load Group2 --->
<cfcase value="group2"><cfquery datasource="AWS" name="fQuery">
SELECT[mcs_id]
,[mcs_actualtime]
,[mcs_assignedto]
,CONVERT(VARCHAR(10),[mcs_completed], 101)AS[mcs_completed]
,[mcs_dependencies]
,CONVERT(VARCHAR(10),[mcs_duedate], 101)AS[mcs_duedate]
,[mcs_esttime]
,[mcs_notes]
,[mcs_sequence]
,[mcs_status]
,[mcs_subtask] 
FROM[managementconsulting_subtask]
WHERE[mcs_id]=<cfqueryparam value="#ARGUMENTS.ID#"/></cfquery>
</cfcase>
<!---Assest Cateogry --->
<cfcase value="assetCategory">
<cfquery datasource="AWS" name="fQuery">
SELECT[optionDescription]
FROM[v_selectOptions]
WHERE[selectName]='global_consultingcategory'
AND[optionValue_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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

<!--- LOOKUP Group1 --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[mc_assignedtoTEXT]
,[client_id]
,[client_name]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,[mc_description]
,[mc_status]
,mc_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
FROM[v_managementconsulting]
WHERE[mc_status] != 2 
AND [mc_status] != 3
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
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","MC_ID":"'&MC_ID&'","MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'","CLIENT_NAME":"'&CLIENT_NAME&'","MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'","MC_DESCRIPTION":"'&MC_DESCRIPTION&'","MC_STATUSTEXT":"'&MC_STATUSTEXT&'","MC_DUEDATE":"'&MC_DUEDATE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Group2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT
[mc_id]
,[mcs_id]
,[mcs_actualtime]
,[mcs_assignedto]
,[mcs_completed]
,[mcs_dependencies]
,[mcs_duedate]
,[mcs_esttime]
,CASE WHEN LEN([mcs_notes]) >= 101 THEN SUBSTRING([mcs_notes],0,100) +  '...' ELSE [mcs_notes] END AS[mcs_notes]
,[mcs_sequence]
,[mcs_status]
,[mcs_subtask] 
FROM[managementconsulting_subtask]
WHERE[mc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[mcs_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MCS_ID":"'&MCS_ID&'","MCS_SUBTASK":"'&MCS_SUBTASK&'","MCS_NOTES":"'&MCS_NOTES&'","MCS_STATUS":"'&MCS_STATUS&'","MCS_DEPENDENCIES":"'&MCS_DEPENDENCIES&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
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

<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[managementconsulting](
[client_id]
,[mc_assignedto]
,[mc_category]
,[mc_duedate]
,[mc_esttime]
,[mc_fees]
,[mc_missinginfo]
,[mc_missinginforeceived]
,[mc_paid]
,[mc_priority]
,[mc_projectcompleted]
,[mc_requestforservice]
,[mc_status]
,[mc_description]
,[mc_workinitiated]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[mc_id]
</cfquery>
<!--- RETURN FDS_ID--->
<cfreturn '{"id":#fquery.mc_id#,"group":"group2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[managementconsulting]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[mc_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[mc_category]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[mc_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[mc_esttime]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[mc_fees]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[mc_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[mc_missinginforeceived]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[mc_paid]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[mc_priority]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[mc_projectcompleted]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[mc_requestforservice]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[mc_status]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[mc_description]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[mc_workinitiated]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
WHERE[mc_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>
<!--- Group2 --->
<cfcase value="group2">
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[managementconsulting_subtask](
[mc_id]
,[mcs_actualtime]
,[mcs_assignedto]
,[mcs_completed]
,[mcs_dependencies]
,[mcs_duedate]
,[mcs_esttime]
,[mcs_notes]
,[mcs_sequence]
,[mcs_status]
,[mcs_subtask] 
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[mcs_id]
</cfquery>
<cfreturn '{"id":#fquery.mcs_id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[managementconsulting_subtask]
SET[mc_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[mcs_actualtime]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[mcs_assignedto]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[mcs_completed]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[mcs_dependencies]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[mcs_duedate]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[mcs_esttime]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[mcs_notes]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[mcs_sequence]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[mcs_status]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[mcs_subtask]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
WHERE[mcs_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
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