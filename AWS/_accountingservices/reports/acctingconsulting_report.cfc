<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
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
SELECT[pt_id]
,CONVERT(VARCHAR(10),[pt_duedate], 101)AS[pt_duedate]
,[pt_type]
,[pt_year]
,[pt_month]
,CONVERT(VARCHAR(10),[pt_lastpay], 101)AS[pt_lastpay]
,CONVERT(VARCHAR(10),[pt_obtaininfo_datecompleted], 101)AS[pt_obtaininfo_datecompleted]
,CASE [pt_missinginfo] WHEN 1 THEN 'Yes' ELSE 'No' END AS [pt_missinginfo]
,CONVERT(VARCHAR(10),[pt_missingreceived], 101)AS[pt_missingreceived]
,CONVERT(VARCHAR(10),[pt_entry_datecompleted], 101)AS[pt_entry_datecompleted]
,CONVERT(VARCHAR(10),[pt_rec_datecompleted], 101)AS[pt_rec_datecompleted]
,CONVERT(VARCHAR(10),[pt_review_datecompleted], 101)AS[pt_review_datecompleted]
,CONVERT(VARCHAR(10),[pt_assembly_datecompleted], 101)AS[pt_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pt_delivery_datecompleted], 101)AS[pt_delivery_datecompleted]
,[pt_fees]
,[pt_paymentstatus]      
,[client_name]
,[client_id]
FROM[v_payrolltaxes]
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
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
								,"PT_TYPE":"'&PT_TYPE&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTH":"'&PT_MONTH&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_OBTAININFO_DATECOMPLETED":"'&PT_OBTAININFO_DATECOMPLETED&'"
								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
								,"PT_MISSINGRECEIVED":"'&PT_MISSINGRECEIVED&'"
								,"PT_ENTRY_DATECOMPLETED":"'&PT_ENTRY_DATECOMPLETED&'"
								,"PT_REC_DATECOMPLETED":"'&PT_REC_DATECOMPLETED&'"
								,"PT_REVIEW_DATECOMPLETED":"'&PT_REVIEW_DATECOMPLETED&'"
								,"PT_ASSEMBLY_DATECOMPLETED":"'&PT_ASSEMBLY_DATECOMPLETED&'"
								,"PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"
								,"PT_FEES":"'&PT_FEES&'"
								,"PT_PAYMENTSTATUS":"'&PT_PAYMENTSTATUS&'"
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