<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!--- 
SELECT TOP 1000 [cas_id]
      ,[client_id]
      ,[cas_assignedto]
      ,[cas_category]
      ,[cas_completed]
      ,[cas_datereqested]
      ,[cas_datestarted]
      ,[cas_duedate]
      ,[cas_esttime]
      ,[cas_instructions]
      ,[cas_priority]
      ,[cas_reqestby]
      ,[cas_status]
      ,[cas_taskdesc]
  FROM [AWS].[dbo].[clientadministrativetasks]
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
SELECT[cas_id]
,[client_id]
,[cas_assignedto]
,[cas_category]
,[cas_completed]=FORMAT(cas_completed,'d','#Session.localization.language#') 
,[cas_datereqested]=FORMAT(cas_datereqested,'d','#Session.localization.language#') 
,[cas_datestarted]=FORMAT(cas_datestarted,'d','#Session.localization.language#') 
,[cas_duedate]=FORMAT(cas_duedate,'d','#Session.localization.language#') 
,[cas_esttime]
,[cas_instructions]
,[cas_priority]
,[cas_reqestby]
,[cas_status]
,[cas_taskdesc]
,[cas_workinitiated]
FROM[v_clientadministrativetasks]
WHERE[cas_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
SELECT [cas_id]
,[client_id]
,[client_name]
,[cas_duedate]=FORMAT(cas_duedate,'d','#Session.localization.language#') 
,[cas_assignedto]
,[cas_category]
,[cas_datereqested]=FORMAT(cas_datereqested,'d','#Session.localization.language#') 
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc]
,[cas_status]
,cas_assignedtoTEXT=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))FOR XML PATH('')),3,1000)
,cas_categoryTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[cas_category]=[optionvalue_id])
,cas_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[cas_status]=[optionvalue_id])

FROM[v_clientadministrativetasks]
WHERE[cas_status] != 2 AND [cas_status] != 3
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
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_CATEGORYTEXT":"'&CAS_CATEGORYTEXT&'"
								,"CAS_TASKDESC":"'&CAS_TASKDESC&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_STATUSTEXT":"'&CAS_STATUSTEXT&'"
								,"CAS_ASSIGNEDTOTEXT":"'&CAS_ASSIGNEDTOTEXT&'"
								,"CAS_DATEREQESTED":"'&CAS_DATEREQESTED&'"	
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
INSERT INTO[clientadministrativetasks](
[client_id]
,[cas_assignedto]
,[cas_category]
,[cas_completed]
,[cas_datereqested]
,[cas_datestarted]
,[cas_duedate]
,[cas_esttime]
,[cas_instructions]
,[cas_priority]
,[cas_reqestby]
,[cas_status]
,[cas_taskdesc]
,[cas_workinitiated]
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
SELECT SCOPE_IDENTITY()AS[cas_id]
</cfquery>
<cfreturn '{"id":#fquery.cas_id#,"group":"plugins","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[clientadministrativetasks]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[cas_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0 or j.DATA[1][3] eq 'null'#"/>
,[cas_category]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[cas_completed]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[cas_datereqested]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[cas_datestarted]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[cas_duedate]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[cas_esttime]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[cas_instructions]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[cas_priority]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[cas_reqestby]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[cas_status]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[cas_taskdesc]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[cas_workinitiated]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
WHERE[cas_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
update[clientadministrativetasks]
SET[cas_active]=0
WHERE[cas_id]=<cfqueryparam value="#ARGUMENTS.id#">
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