<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!--- 
SELECT TOP 1000 [as_id]
      ,[client_id]
      ,[as_assignedto]
      ,[as_category]
      ,[as_completed]
      ,[as_datereqested]
      ,[as_datestarted]
      ,[as_duedate]
      ,[as_esttime]
      ,[as_instructions]
      ,[as_priority]
      ,[as_reqestby]
      ,[as_status]
      ,[as_taskdesc]
  FROM [AWS].[dbo].[administrativetasks]
  --->


<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load GROUP1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[as_id]
,[client_id]
,[as_assignedto]
,[as_category]
,[as_completed]=FORMAT(as_completed,'#Session.localization.formatdate#') 
,[as_datereqested]=FORMAT(as_datereqested,'#Session.localization.formatdate#') 
,[as_datestarted]=FORMAT(as_datestarted,'#Session.localization.formatdate#') 
,[as_duedate]=FORMAT(as_duedate,'#Session.localization.formatdate#') 
,[as_esttime]
,[as_instructions]
,[as_priority]
,[as_reqestby]
,[as_status]
,[as_taskdesc]
,[as_workinitiated]
FROM[v_administrativetasks]
WHERE[as_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Asset Credit Hold --->
<cfcase value="assetCreditHold">
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<!--- LOOKUP GROUP1 --->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT [as_id]
,[client_id]
,[client_name]
,[as_duedate]=FORMAT(as_duedate,'#Session.localization.formatdate#') 
,[as_assignedto]
,[as_category]
,[as_datereqested]=FORMAT(as_datereqested,'#Session.localization.formatdate#') 
,CASE WHEN LEN([as_taskdesc]) >= 101 THEN SUBSTRING([as_taskdesc],0,100) +  '...' ELSE [as_taskdesc] END AS[as_taskdesc]
,[as_status]
,as_assignedtoTEXT=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](as_assignedto)))FOR XML PATH('')),3,1000)
,as_categoryTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[as_category]=[optionvalue_id])
,as_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[as_status]=[optionvalue_id])
FROM[v_administrativetasks]
WHERE ISNULL([as_status],0) != 2
AND ISNULL([as_status],0) != 3
AND [client_active]=(1)
AND [deleted] IS NULL
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, as_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"AS_ID":"'&AS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"AS_CATEGORYTEXT":"'&AS_CATEGORYTEXT&'"
								,"AS_TASKDESC":"'&AS_TASKDESC&'"
								,"AS_DUEDATE":"'&AS_DUEDATE&'"
								,"AS_STATUSTEXT":"'&AS_STATUSTEXT&'"
								,"AS_ASSIGNEDTOTEXT":"'&AS_ASSIGNEDTOTEXT&'"
								,"AS_DATEREQESTED":"'&AS_DATEREQESTED&'"	
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

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[administrativetasks](
[client_id]
,[as_assignedto]
,[as_category]
,[as_completed]
,[as_datereqested]
,[as_datestarted]
,[as_duedate]
,[as_esttime]
,[as_instructions]
,[as_priority]
,[as_reqestby]
,[as_status]
,[as_taskdesc]
,[as_workinitiated]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0 or j.DATA[1][3] eq 'null'#"/>
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
)
SELECT SCOPE_IDENTITY()AS[as_id]
</cfquery>
<cfreturn '{"id":#fquery.as_id#,"group":"plugins","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[administrativetasks]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[as_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0 or j.DATA[1][3] eq 'null'#"/>
,[as_category]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[as_completed]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[as_datereqested]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[as_datestarted]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[as_duedate]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[as_esttime]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[as_instructions]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[as_priority]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[as_reqestby]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[as_status]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[as_taskdesc]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[as_workinitiated]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
WHERE[as_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>

<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[administrativetasks]
SET[deleted]=GETDATE()
WHERE[as_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>