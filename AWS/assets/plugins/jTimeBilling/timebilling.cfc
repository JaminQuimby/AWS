<cfcomponent output="true">
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group102--->
<cfcase value="group102">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT 
'GROUP102'AS[GROUP102]
,[tb_id]
,[user_id]
,[tb_date]=FORMAT(tb_date,'#Session.localization.formatdate#') 
,[tb_description]
,[tb_manualtime]
,[tb_notes]
,[tb_paymentstatus]
,[tb_activitytype]
,[total_time]=(SELECT SUM(CAST(DATEDIFF(mi, t_start, t_stop) AS decimal) / 60) FROM[time]where[t].[tb_id]=[time].tb_id )

FROM[timebilling]AS[t]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<cfcase value="group102_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT 
'GROUP102_SUBTASK'AS[GROUP102_1]
,[t_id]
,[t_start]=FORMAT(t_start, '#Session.localization.formatdatetime#')
,[t_stop]=FORMAT(t_stop, '#Session.localization.formatdatetime#')
FROM[time]
WHERE[t_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<cfcase value="group102_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT 
'GROUP102_SUBTASK2'AS[GROUP102_2]
,[ta_id]
--,[tb_id]
,[ta_amount]
,[ta_discription]
,[ta_billable]
FROM[timeexpense]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

</cfswitch>
<cfreturn SerializeJSON(fQuery)>
</cffunction>

<!--- LOOKUP DATA --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cfargument name="taskid" type="string" required="no">

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 102  --->
<cfcase value="group102">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tb_id]
,[tb_date]=FORMAT(tb_date,'#Session.localization.formatdate#') 
,[u_name]
,[tb_descriptionTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND('#ARGUMENTS.formid#'IN(SELECT[id]FROM[CSVToTable](optionGroup))OR'0'IN(SELECT[id]FROM[CSVToTable](optionGroup)))AND('#ARGUMENTS.formid#'NOT IN(SELECT[id]FROM[CSVToTable](optionHide))OR[optionHide]IS NULL)AND[selectName]='g102_description'AND[tb_description]=[optionvalue_id])
FROM[v_timebilling]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.formid#"/>
AND[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[task_id]=<cfqueryparam value="#ARGUMENTS.taskid#"/> 
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TB_ID":"'&TB_ID&'"
								,"TB_DATE":"'&TB_DATE&'"
								,"U_NAME":"'&U_NAME&'"
								,"TB_DESCRIPTIONTEXT":"'&TB_DESCRIPTIONTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 102_subtask  --->
<cfcase value="group102_subtask">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT 
'GROUP102_SUBTASK'AS[GROUP102_SUBTASK]
,[t_id],[TB_ID]
,[t_start]= FORMAT(t_start,'#Session.localization.formatdatetime#') 
,[t_stop]= FORMAT(t_stop,'#Session.localization.formatdatetime#') 
,[t_diff]=(DATEDIFF(mi,[t_start],[t_stop])/60)
FROM[time]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"T_ID":"'&T_ID&'"
								,"TB_ID":"'&TB_ID&'"
								,"T_START":"'&T_START&'"
								,"T_STOP":"'&T_STOP&'"
								,"T_DIFF":"'&T_DIFF&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 102_subtask2  --->
<cfcase value="group102_subtask2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT 
'GROUP102_SUBTASK2'AS[GROUP102]
,[ta_id],[TB_ID]
,[ta_amount]
,[ta_discription]
,[ta_billable]
FROM[timeexpense]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TA_ID":"'&TA_ID&'"
								,"TB_ID":"'&TB_ID&'"
								,"TA_AMOUNT":"'&TA_AMOUNT&'"
								,"TA_DISCRIPTION":"'&TA_DISCRIPTION&'"
								,"TA_BILLABLE":"'&TA_BILLABLE&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

</cfswitch>
</cffunction>

<!--- SAVE DATA --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">
<!---Group102--->
<cfcase value="group102">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[timebilling](
[form_id]
,[u_name]
,[task_id]
,[tb_date]
,[tb_description]
,[tb_manualtime]
,[tb_notes]
,[tb_paymentstatus]
,[tb_activitytype]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#Session.user.id#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>

)
SELECT SCOPE_IDENTITY()AS[tb_id]
</cfquery>
<cfreturn '{"id":#fquery.tb_id#,"group":"plugins","subgroup":"102_1","result":"ok"}'>
</cfif>

<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[timebilling]
SET[form_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[user_id]=<cfqueryparam value="#Session.user.id#"/>
,[task_id]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tb_date]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tb_description]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tb_manualtime]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tb_notes]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tb_paymentstatus]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tb_activitytype]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>

WHERE[TB_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":"#j.DATA[1][1]#","group":"plugins","subgroup":"102_1","result":"ok"}'>
</cfif>
</cfcase>

<!---Group102_1--->
<cfcase value="group102_1">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[time](
[tb_id]
,[t_start]
,[t_stop]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[t_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][2]#,"group":"saved","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">

UPDATE[time]
SET[tb_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[t_start]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[t_stop]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[T_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":"#j.DATA[1][1]#","group":"plugins","subgroup":"102_2","result":"ok"}'>
</cfif>

</cfcase>






<!---Group102_2--->
<cfcase value="group102_2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[timeexpense](
[tb_id]
,[ta_amount]
,[ta_discription]
,[ta_billable]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[t_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][2]#,"group":"saved","result":"ok"}'>
</cfif>
</cfcase>

</cfswitch>
</cffunction>


<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group102">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[timebilling]
SET[deleted]=GETDATE()
WHERE[TB_ID]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group102","result":"ok"}'>
</cfcase>
<cfcase value="group102_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[time]
SET[deleted]=GETDATE()
WHERE[T_ID]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group102_1","result":"ok"}'>
</cfcase>
<cfcase value="group102_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[time]
SET[deleted]=GETDATE()
WHERE[TA_ID]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group102_2","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
      <!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>

</cfcomponent>