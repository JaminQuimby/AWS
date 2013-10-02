<cfcomponent output="true">
<!---
SELECT TOP 1000 [mc_id]
      ,[client_id]
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
  FROM [AWS].[dbo].[managementconsulting]
  
  
SELECT TOP 1000 [mcs_id]
      ,[mc_id]
      ,[mcs_actualtime]
      ,[mcs_assignedto]
      ,[mcs_completed]
      ,[mcs_dependencies]
      ,[mcs_duedate]
      ,[mcs_estimatedtime]
      ,[mcs_notes]
      ,[mcs_sequence]
      ,[mcs_status]
      ,[mcs_subtask]
  FROM [AWS].[dbo].[managementconsulting_subtask]
--->


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
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[mc_category]
,[mc_assignedto]
,[mc_status]
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
,CONVERT(VARCHAR(10),[mc_requestforservice], 101)AS[mc_requestforservice]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
,CONVERT(VARCHAR(10),[mc_workinitiated], 101)AS[mc_workinitiated]
,CONVERT(VARCHAR(10),[mc_projectcompleted], 101)AS[mc_projectcompleted]
,[mc_estimatedtime]
,[mc_fees]
,[mc_paid]    
,[client_name]
,[client_id]
FROM[v_managementconsulting]
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
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_CATEGORY":"'&MC_CATEGORY&'"
								,"MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'"
								,"MC_STATUS":"'&MC_STATUS&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_REQUESTFORSERVICE":"'&MC_REQUESTFORSERVICE&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_WORKINITIATED":"'&MC_WORKINITIATED&'"
								,"MC_PROJECTCOMPLETED":"'&MC_PROJECTCOMPLETED&'"
								,"MC_ESTIMATEDTIME":"'&MC_ESTIMATEDTIME&'"
								,"MC_FEES":"'&MC_FEES&'"
								,"MC_PAID":"'&MC_PAID&'"	
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
</cfcomponent>