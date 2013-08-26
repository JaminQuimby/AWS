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
SELECT[PRC_ID]
,[client_id]
,[prc_altfrequency]
,[prc_deliverymethod]
,CONVERT(VARCHAR(10),[prc_duedate], 101)AS[prc_duedate]
,[prc_estimatedtime]
,[prc_fees]
,CONVERT(VARCHAR(10),[prc_missinginforeceived], 101)AS[prc_missinginforeceived]
,[prc_missinginformation]
,CONVERT(VARCHAR(10),[prc_paydate], 101)AS[prc_paydate]
,CONVERT(VARCHAR(10),[prc_payenddate], 101)AS[prc_payenddate]
,[prc_paymentstatus]
,[prc_year]
FROM[v_payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[prc_1_assignedto]
,CONVERT(VARCHAR(10),[prc_1_completed], 101)AS[prc_1_completed]
,[prc_1_completedby]
,[prc_1_estimatedtime]
FROM[payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[prc_2_assignedto]
,CONVERT(VARCHAR(10),[prc_2_completed], 101)AS[prc_2_completed]
,[prc_2_completedby]
,[prc_2_estimatedtime]
FROM[payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[prc_3_assignedto]
,CONVERT(VARCHAR(10),[prc_3_completed], 101)AS[prc_3_completed]
,[prc_3_completedby]
,[prc_3_estimatedtime]
FROM[payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[prc_4_assignedto]
,CONVERT(VARCHAR(10),[prc_4_completed], 101)AS[prc_4_completed]
,[prc_4_completedby]
,[prc_4_estimatedtime]
FROM[payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT[prc_5_assignedto]
,CONVERT(VARCHAR(10),[prc_5_completed], 101)AS[prc_5_completed]
,[prc_5_completedby]
,[prc_5_estimatedtime]
FROM[payrollchecks]
WHERE[prc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="otherid" type="string" required="no">


<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[prc_id]
,[prc_year]
,[client_name]
,[CLIENT_ID]
FROM[v_payrollchecks]
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
<cfset queryResult=queryResult&'{"PRC_ID":"'&PRC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PRC_YEAR":"'&PRC_YEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2  --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[other_id]=<cfqueryparam value="#ARGUMENTS.otherid#"/> 

AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"COMMENT_ID":"'&COMMENT_ID&'","C_DATE":"'&C_DATE&'","U_NAME":"'&U_NAME&'","U_EMAIL":"'&U_EMAIL&'","C_NOTES":"'&C_NOTES&'"}'>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[PAYROLLCHECKS](
[client_id]
,[prc_altfrequency]
,[prc_deliverymethod]
,[prc_duedate]
,[prc_estimatedtime]
,[prc_fees]
,[prc_missinginforeceived]
,[prc_missinginformation]
,[prc_paydate]
,[prc_payenddate]
,[prc_paymentstatus]
,[prc_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN PRC_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group1_1","result":"ok"}'>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_altfrequency]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[prc_deliverymethod]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[prc_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[prc_estimatedtime]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[prc_fees]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[prc_missinginforeceived]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[prc_missinginformation]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[prc_paydate]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[prc_payenddate]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[prc_paymentstatus]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[prc_year]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[prc_1_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_1_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[prc_1_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[prc_1_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[prc_2_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_2_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[prc_2_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[prc_2_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[prc_3_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_3_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[prc_3_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[prc_3_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[prc_4_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_4_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[prc_4_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[prc_4_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup5 --->
<cfcase value="group1_5"><cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKS]
SET[prc_5_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[prc_5_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[prc_5_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[prc_5_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[PRC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[client_id]
,[other_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group3","result":"ok"}'>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>