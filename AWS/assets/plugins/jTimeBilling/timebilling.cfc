<cfcomponent output="true">

<!---
SELECT TOP 1000 [t_id]
      ,[tb_id]
      ,[t_start]
      ,[t_stop]
  FROM [AWS].[dbo].[time]

SELECT TOP 1000 [tb_id]
      ,[client_id]
      ,[user_id]
      ,[form_id]
      ,[task_id]
      ,[tb_date]
      ,[tb_description]
      ,[tb_notes]
      ,[tb_paymentstatus]
      ,[tb_mileage]
      ,[tb_reimbursment]
      ,[tb_billingtype]
      ,[tb_ratetype]
      ,[tb_flatfee]
      ,[tb_adjustment]
      ,[tb_manualtime]
      ,[tb_timestamp]
  FROM [AWS].[dbo].[timebilling]
--->

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">

<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group102--->
<cfcase value="group102">
<cfquery datasource="AWS" name="fQuery">
SELECT 
'GROUP102'AS[GROUP102]
,[tb_id]
,[tb_adjustment]
,[tb_billingtype]
,CONVERT(VARCHAR(10),[tb_date], 101)AS[tb_date]
,[tb_description]
,[tb_flatfee]
,CONVERT(VARCHAR(5),[tb_manualtime], 108)AS[tb_manualtime]
,[tb_mileage]
,[tb_notes]
,[tb_paymentstatus]
,[tb_ratetype]
,[tb_reimbursment]
FROM[timebilling]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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


<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 102  --->
<cfcase value="group102">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tb_id]
,CONVERT(VARCHAR(10),[tb_date], 101)AS[tb_date]
,[u_name]
,[tb_description]
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
								,"TB_DESCRIPTION":"'&TB_DESCRIPTION&'"
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

<!--- Grid 102_1  --->
<cfcase value="group102_1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[t_id]
,[tb_id]
,[t_start]
,[t_stop]
FROM[v_time]
WHERE[tb_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"T_ID":"'&T_ID&'"
								,"T_START":"'&T_START&'"
								,"T_STOP":"'&T_STOP&'"
								}'>
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

 
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>


<!--- SAVE DATA --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cftry>
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">



<!---Group102--->
<cfcase value="group102">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[timebilling](
[form_id]
,[user_id]
,[client_id]
,[task_id]
,[tb_adjustment]
,[tb_billingtype]
,[tb_date]
,[tb_description]
,[tb_flatfee]
,[tb_manualtime]
,[tb_mileage]
,[tb_notes]
,[tb_paymentstatus]
,[tb_ratetype]
,[tb_reimbursment]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#Session.user.id#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[tb_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group102_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>

<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[timebilling]
SET[form_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[client_id]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[task_id]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tb_adjustment]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tb_billingtype]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[tb_date]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tb_description]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[tb_flatfee]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[tb_manualtime]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[tb_mileage]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[tb_notes]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[tb_paymentstatus]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[tb_ratetype]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[tb_reimbursment]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
WHERE[TB_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group102_1","result":"ok"}'>
</cfif>
</cfcase>




<!---

<!---Group102_1--->
<cfcase value="group102_1">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[time](
[tb_id]
,[t_start]
,[t_stop]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[t_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"saved","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>

<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[time]
SET[tb_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[t_start]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[t_stop]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[T_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"saved","result":"ok"}'>
</cfif>

</cfcase>
--->



</cfswitch>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>