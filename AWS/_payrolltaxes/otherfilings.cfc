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
SELECT[OF_ID]
,[client_id]
,[of_deliverymethod]
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_esttime]
,CONVERT(VARCHAR(10),[of_extensioncompleted], 101)AS[of_extensioncompleted]
,CONVERT(VARCHAR(10),[of_extensiondeadline], 101)AS[of_extensiondeadline]
,[of_fees]
,CONVERT(VARCHAR(10),[of_filingdeadline], 101)AS[of_filingdeadline]
,[of_form]
,CONVERT(VARCHAR(10),[of_missinginforeceived], 101)AS[of_missinginforeceived]
,[of_missinginfo]
,[of_paid]
,[of_period]
,[of_priority]
,[of_state]
,[of_status]
,[of_task]
,[of_taxyear]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_obtaininfo_assignedto]
,[of_obtaininfo_completedby]
,CONVERT(VARCHAR(10),[of_obtaininfo_datecompleted], 101)AS[of_obtaininfo_datecompleted]
,[of_obtaininfo_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_preparation_assignedto]
,[of_preparation_completedby]
,CONVERT(VARCHAR(10),[of_preparation_datecompleted], 101)AS[of_preparation_datecompleted]
,[of_preparation_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_review_assignedto]
,[of_review_completedby]
,CONVERT(VARCHAR(10),[of_review_datecompleted], 101)AS[of_review_datecompleted]
,[of_review_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_assembly_assignedto]
,[of_assembly_completedby]
,CONVERT(VARCHAR(10),[of_assembly_datecompleted], 101)AS[of_assembly_datecompleted]
,[of_assembly_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_delivery_assignedto]
,[of_delivery_completedby]
,CONVERT(VARCHAR(10),[of_delivery_datecompleted], 101)AS[of_delivery_datecompleted]
,[of_delivery_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Other Filings --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[of_id]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_task]
,[of_form]
,[of_period]
,[of_obtaininfo_assignedto]
,[of_preparation_assignedto]
,[of_review_assignedto]
,[of_assembly_assignedto]
,[of_delivery_assignedto]
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_missinginfo]
,[client_name]
,[client_id]
,OF_OBTAININFO_ASSIGNEDTOTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(of_obtaininfo_assignedto=user_id))
,OF_PREPARATION_ASSIGNEDTOTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(of_preparation_assignedto=user_id))
,OF_REVIEW_ASSIGNEDTOTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(of_review_assignedto=user_id))
,OF_ASSEMBLY_ASSIGNEDTOTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(of_assembly_assignedto=user_id))
,OF_DELIVERY_ASSIGNEDTOTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(of_delivery_assignedto=user_id))
,of_taskTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_task]=[optionvalue_id])
,of_stateTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_task]=[optionvalue_id])
,of_periodTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])

FROM[v_otherfilings]
WHERE[of_status] != 2 
AND [of_status] != 5
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
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"								
								,"OF_PERIODTEXT":"'&OF_PERIODTEXT&'"
								,"OF_STATETEXT":"'&OF_STATETEXT&'"
								,"OF_TASKTEXT":"'&OF_TASKTEXT&'"
								,"OF_FORM":"'&OF_FORM&'"
								,"OF_OBTAININFO_ASSIGNEDTOTEXT":"'&OF_OBTAININFO_ASSIGNEDTOTEXT&'"
								,"OF_PREPARATION_ASSIGNEDTOTEXT":"'&OF_PREPARATION_ASSIGNEDTOTEXT&'"
								,"OF_REVIEW_ASSIGNEDTOTEXT":"'&OF_REVIEW_ASSIGNEDTOTEXT&'"
								,"OF_ASSEMBLY_ASSIGNEDTOTEXT":"'&OF_ASSEMBLY_ASSIGNEDTOTEXT&'"
								,"OF_DELIVERY_ASSIGNEDTOTEXT":"'&OF_DELIVERY_ASSIGNEDTOTEXT&'"								
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
								}'>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[otherfilings](
[client_id]
,[of_deliverymethod]
,[of_duedate]
,[of_esttime]
,[of_extensioncompleted]
,[of_extensiondeadline]
,[of_fees]
,[of_filingdeadline]
,[of_form]
,[of_missinginforeceived]
,[of_missinginfo]
,[of_paid]
,[of_period]
,[of_priority]
,[of_state]
,[of_status]
,[of_task]
,[of_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#"/>
,<cfqueryparam value="#j.DATA[1][17]#"/>
,<cfqueryparam value="#j.DATA[1][18]#"/>
,<cfqueryparam value="#j.DATA[1][19]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN OF_ID--->
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
UPDATE[otherfilings]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_deliverymethod]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_duedate]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_esttime]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[of_extensioncompleted]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[of_extensiondeadline]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[of_fees]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_filingdeadline]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[of_form]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[of_missinginforeceived]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[of_missinginfo]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[of_paid]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[of_period]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[of_priority]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[of_state]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[of_status]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[of_task]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[of_taxyear]=<cfqueryparam value="#j.DATA[1][19]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery name="fquery" datasource="AWS">
UPDATE[OTHERFILINGS]
SET[of_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery name="fquery" datasource="AWS">
UPDATE[OTHERFILINGS]
SET[of_preparation_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_preparation_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_preparation_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_preparation_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery name="fquery" datasource="AWS">
UPDATE[OTHERFILINGS]
SET[of_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery name="fquery" datasource="AWS">
UPDATE[OTHERFILINGS]
SET[of_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
</cfcase>
<cfcase value="group1_5">
<cfquery name="fquery" datasource="AWS">
UPDATE[OTHERFILINGS]
SET[of_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>