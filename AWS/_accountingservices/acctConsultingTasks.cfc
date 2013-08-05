<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
!--- LOAD DATA --->
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
      ,[si_id]
,[mc_category]
,[mc_description]
,[mc_priority]
,[mc_assignedto]
,[mc_status]
,CONVERT(VARCHAR(10),[mc_requestforservice], 101)AS[mc_requestforservice]
,CONVERT(VARCHAR(10),[mc_workinitiated], 101)AS[mc_workinitiated]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
,CONVERT(VARCHAR(10),[mc_projectcompleted], 101)AS[mc_projectcompleted]
,[mc_estimatedtime]
,[mc_fees]
,[mc_paid]
FROM[managementconsulting]
WHERE[mc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>


</cfcase>
<!--- Load Group2 --->
<cfcase value="group2"><cfquery datasource="AWS" name="fQuery">
SELECT[mcs_id]
,[client_id]
,[mc_id]
,[mcs_actualtime]
,[mcs_assignedto]
,[mcs_category]
,[mcs_completed]
,[mcs_dependencies]
,[mcs_duedate]
,[mcs_estimatedtime]
,[mcs_group]
,[mcs_notes]
,[mcs_sequence]
,[mcs_status]
FROM[managementconsulting_subtask]
WHERE[mcs_id]=<cfqueryparam value="#ARGUMENTS.ID#"/></cfquery>
</cfcase>
<!--- Load Group3 --->
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

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">

<!--- LOOKUP Group1 --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[MC_ID]
,[MC_ASSIGNEDTO]
    ,[client_id]
    ,[client_name]
   	,[mc_categoryTEXT]
    ,[mc_description]
    ,[mc_status]
    ,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
FROM[v_managementconsulting]
WHERE[CLIENT_NAME]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>

<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>
ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]
<cfelse>
ORDER BY[client_name]</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","MC_ID":"'&MC_ID&'","MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'","CLIENT_NAME":"'&CLIENT_NAME&'","MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'","MC_DESCRIPTION":"'&MC_DESCRIPTION&'","MC_STATUS":"'&MC_STATUS&'","MC_DUEDATE":"'&MC_DUEDATE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- LOOKUP Group2 --->
<cfcase value="group2">


<cfquery datasource="AWS" name="fquery">
SELECT
[mcs_id]
,[client_id]
,[mc_id]
,[mcs_actualtime]
,[mcs_assignedto]
,[mcs_category]
,[mcs_completed]
,[mcs_dependencies]
,[mcs_duedate]
,[mcs_estimatedtime]
,[mcs_group]
,[mcs_notes]
,[mcs_sequence]
,[mcs_status]

FROM[managementconsulting_subtask]
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>
ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]
<cfelse>
ORDER BY[client_name]</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","mc_id":"'&mc_id&'","si_id":"'&si_id&'","CLIENT_NAME":"'&CLIENT_NAME&'","mc_categoryTEXT":"'&mc_categoryTEXT&'","mc_description":"'&mc_description&'","mc_status":"'&mc_status&'","mc_duedate":"'&mc_duedate&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>


</cfcase>
<!--- LOOKUP Group2 --->
<cfcase value="group2"></cfcase>
<!--- LOOKUP Group3 --->
<cfcase value="group3">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
<!--- STOPPED HERE --->
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


<!---Save Group1 --->
<cfcase value="group1">

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[managementconsulting](
[client_id]
,[mc_assignedto]
,[mc_category]
,[mc_description]
,[mc_duedate]
,[mc_estimatedtime]
,[mc_fees]
,[mc_paid]
,[mc_priority]
,[mc_projectcompleted]
,[mc_requestforservice]
,[mc_status]
,[mc_workinitiated]
,[mc_credithold]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfif j.DATA[1][3] neq ""><cfqueryparam value="#j.DATA[1][3]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][4] neq ""><cfqueryparam value="#j.DATA[1][4]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][5] neq ""><cfqueryparam value="#j.DATA[1][5]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][6] neq ""><cfqueryparam value="#j.DATA[1][6]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][7] neq ""><cfqueryparam value="#j.DATA[1][7]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][8] neq ""><cfqueryparam value="#j.DATA[1][8]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][9] neq ""><cfqueryparam value="#j.DATA[1][9]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][10] neq ""><cfqueryparam value="#j.DATA[1][10]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][11] neq ""><cfqueryparam value="#j.DATA[1][11]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][12] neq ""><cfqueryparam value="#j.DATA[1][12]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][13] neq ""><cfqueryparam value="#j.DATA[1][13]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][14] neq ""><cfqueryparam value="#j.DATA[1][14]#"/><cfelse>null</cfif>
,<cfif j.DATA[1][15] neq ""><cfqueryparam value="#j.DATA[1][15]#"/><cfelse>null</cfif>
)
SELECT SCOPE_IDENTITY()AS[mc_id]
</cfquery>

<cfreturn '{"id":#fquery.mc_id#,"group":"group2","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[managementconsulting]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[mc_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[mc_category]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[mc_description]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[mc_duedate]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[mc_estimatedtime]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[mc_fees]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[mc_paid]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[mc_priority]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[mc_projectcompleted]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[mc_requestforservice]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[mc_status]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[mc_workinitiated]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[mc_credithold]=<cfqueryparam value="#j.DATA[1][15]#"/>
WHERE[mc_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>

<!--- Group2 --->
<cfcase value="group2">
<!---
$("#g2_sequence").val()+'","'+
$("#g2_subtask").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_duedate").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_dependancy").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_actualtime").val()+'","'+
$("#g2_note").val()+'","'+
--->

<cfreturn '{"id":0,"group":"group3","result":"ok"}'>
</cfcase>
<!--- Group3 --->
<cfcase value="group3">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group4","result":"ok"}'>
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