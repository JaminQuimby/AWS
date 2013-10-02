<cfcomponent output="true">
<!---  Few of mispelled column names
[cas_id]
      ,[client_id]
      ,[cas_assignto]
      ,[cas_category]
      ,[cas_completed]
      ,[cas_datereqested]
      ,[cas_datestarted]
      ,[cas_duedate]
      ,[cas_estimatedtime]
      ,[cas_instructions]
      ,[cas_priority]
      ,[cas_reqestby]
      ,[cas_status]
      ,[cas_taskdesc]
  FROM [AWS].[dbo].[clientadministrativetasks]
	  
	  --->

<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">


<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[cas_id]
,CONVERT(VARCHAR(10),[cas_duedate], 101)AS[cas_duedate]
,[cas_priority]
,[cas_assignto]
,[cas_status]
,CONVERT(VARCHAR(10),[cas_datereqested], 101)AS[cas_datereqested]
,CONVERT(VARCHAR(10),[cas_completed], 101)AS[cas_completed]
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc]
,CASE WHEN LEN([cas_instructions]) >= 101 THEN SUBSTRING([cas_instructions],0,100) +  '...' ELSE [cas_instructions] END AS[cas_instructions]
,[client_name]
,[client_id]
FROM[v_clientadministrativetasks]
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
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_PRIORITY":"'&CAS_PRIORITY&'"
								,"CAS_ASSIGNTO":"'&CAS_ASSIGNTO&'"
								,"CAS_STATUS":"'&CAS_STATUS&'"
								,"CAS_DATEREQESTED":"'&CAS_DATEREQESTED&'"
								,"CAS_COMPLETED":"'&CAS_COMPLETED&'"
								,"CAS_TASKDESC":"'&CAS_TASKDESC&'"
								,"CAS_INSTRUCTIONS":"'&CAS_INSTRUCTIONS&'"
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
</cfswitch>
</cffunction>
</cfcomponent>