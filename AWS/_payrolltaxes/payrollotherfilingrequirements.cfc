<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---
SELECT TOP 1000 [of_id]
      ,[client_id]
      ,[of_taxyear]
      ,[of_period]
      ,[of_state]
      ,[of_task]
      ,[of_form]
      ,[of_duedate]
      ,[of_filingdeadline]
      ,[of_extensiondeadline]
      ,[of_extensioncomplted]
      ,[of_status]
      ,[of_priority]
      ,[of_esttime]
      ,[of_missinginfo]
      ,[of_mireceived]
      ,[of_fees]
      ,[of_paymentstatus]
      ,[of_deliverymethod]
      ,[of_obtaininfo_assignedto]
      ,[of_obtaininfo_datecompleted]
      ,[of_obtaininfo_completedby]
      ,[of_obtaininfo_estimatedtime]
      ,[of_preparation_assignedto]
      ,[of_preparation_datecompleted]
      ,[of_preparation_completedby]
      ,[of_preparation_estimatedtime]
      ,[of_review_assignedto]
      ,[of_review_datecompleted]
      ,[of_review_completedby]
      ,[of_review_estimatedtime]
      ,[of_assembly_assignedto]
      ,[of_assembly_datecomplted]
      ,[of_assembly_compltedby]
      ,[of_assembly_estimatedtime]
      ,[of_delivery_assignedto]
      ,[of_delivery_datecomplted]
      ,[of_delivery_compltedby]
      ,[of_delivery_esttime]
  FROM [otherfilings]
  --->
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
,[of_estimatedtime]
,CONVERT(VARCHAR(10),[of_extensioncompleted], 101)AS[of_extensioncompleted]
,CONVERT(VARCHAR(10),[of_extensiondeadline], 101)AS[of_extensiondeadline]
,[of_fees]
,[of_filingdeadline]
,[of_form]
,CONVERT(VARCHAR(10),[of_missinginforeceived], 101)AS[of_missinginforeceived]
,[of_missinginformation]
,[of_paymentstatus]
,[of_period]
,[of_priority]
,[of_state]
,[of_status]
,[of_type]
,[of_year]
FROM[v_payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_1_assignedto]
,CONVERT(VARCHAR(10),[of_1_completed], 101)AS[of_1_completed]
,[of_1_completedby]
,[of_1_estimatedtime]
FROM[payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_2_assignedto]
,CONVERT(VARCHAR(10),[of_2_completed], 101)AS[of_2_completed]
,[of_2_completedby]
,[of_2_estimatedtime]
FROM[payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_3_assignedto]
,CONVERT(VARCHAR(10),[of_3_completed], 101)AS[of_3_completed]
,[of_3_completedby]
,[of_3_estimatedtime]
FROM[payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_4_assignedto]
,CONVERT(VARCHAR(10),[of_4_completed], 101)AS[of_4_completed]
,[of_4_completedby]
,[of_4_estimatedtime]
FROM[payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT[of_5_assignedto]
,CONVERT(VARCHAR(10),[of_5_completed], 101)AS[of_5_completed]
,[of_5_completedby]
,[of_5_estimatedtime]
FROM[payrollotherfilingrequirements]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
SELECT[of_id]
,[of_year]
,[client_name]
,[CLIENT_ID]
FROM[v_payrollotherfilingrequirements]
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
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","OF_YEAR":"'&OF_YEAR&'"}'>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][11])><cfset j.DATA[1][11]=1><cfelse><cfset j.DATA[1][11]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[PAYROLLOTHERFILINGREQUIREMENTS](
[client_id]
[of_deliverymethod]
[of_duedate]
[of_estimatedtime]
[of_extensioncompleted]
[of_extensiondeadline]
[of_fees]
[of_filingdeadline]
[of_form]
[of_missinginforeceived]
[of_missinginformation]
[of_paymentstatus]
[of_period]
[of_priority]
[of_state]
[of_status]
[of_type]
[of_year]
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
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_deliverymethod]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[of_duedate]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_estimatedtime]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[of_extensioncompleted]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[of_extensiondeadline]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[of_fees]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_filingdeadline]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[of_form]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[of_missinginforeceived]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[of_missinginformation]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[of_paymentstatus]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[of_period]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[of_priority]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[of_state]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[of_status]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[of_type]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[of_year]=<cfqueryparam value="#j.DATA[1][19]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[of_1_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_1_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_1_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_1_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[of_2_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_2_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_2_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_2_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[of_3_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_3_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_3_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_3_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[of_4_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_4_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_4_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_4_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
</cfcase>
<cfcase value="group1_5"><cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLOTHERFILINGREQUIREMENTS]
SET[of_5_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_5_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_5_completedby]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[of_5_estimatedtime]=<cfqueryparam value="#j.DATA[1][9]#"/>
WHERE[OF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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