<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---
SELECT
[fds_id]
      ,[client_id]
      ,[fds_year]
      ,[fds_month]
      ,[fds_periodend]
      ,[fds_status]
      ,[fds_duedate]
      ,[fds_priority]
      ,[fds_esttime]
      ,[fds_missinginfo]
      ,[fds_mireceived]
      ,[fds_compilemi]
      ,[fds_cmireceived]
      ,[fds_fees]
      ,[fds_paymentstatus]
      ,[fds_deliverymethod]
      ,[fds_obtaininfo_assignedto]
      ,[fds_obtaininfo_datecompleted]
      ,[fds_obtaininfo_completedby]
      ,[fds_obtaininfo_esttime]
      ,[fds_sort_assignedto]
      ,[fds_sort_datecompleted]
      ,[fds_sort_completedby]
      ,[fds_sort_esttime]
      ,[fds_checks_assignedto]
      ,[fds_checks_datecompleted]
      ,[fds_checks_completedby]
      ,[fds_checks_esttime]
      ,[fds_sales_assignedto]
      ,[fds_sales_datecompleted]
      ,[fds_sales_completedby]
      ,[fds_sales_esttime]
      ,[fds_entry_assignedto]
      ,[fds_entry_datecompleted]
      ,[fds_entry_completedby]
      ,[fds_entry_esttime]
      ,[fds_reconcile_assignedto]
      ,[fds_reconcile_datecompleted]
      ,[fds_reconcile_completedby]
      ,[fds_reconcile_esttime]
      ,[fds_compile_assignedto]
      ,[fds_compile_datecompleted]
      ,[fds_compile_completedby]
      ,[fds_compile_esttime]
      ,[fds_review_assignedto]
      ,[fds_review_datecompleted]
      ,[fds_review_completedby]
      ,[fds_review_esttime]
      ,[fds_assembly_assignedto]
      ,[fds_assembly_datecompleted]
      ,[fds_assembly_completedby]
      ,[fds_assembly_esttime]
      ,[fds_delivery_assignedto]
      ,[fds_delivery_datecompleted]
      ,[fds_delivery_completedby]
      ,[fds_delivery_esttime]
      ,[fds_acctrpt_assignedto]
      ,[fds_acctrpt_datecompleted]
      ,[fds_acctrpt_completedby]
      ,[fds_acctrpt_esttime]
  FROM [financialdatastatus]

SELECT [fdss_id]
      ,[fds_id]
      ,[fdss_sequence]
      ,[fdss_subtask]
      ,[fdss_status]
      ,[fdss_assignedto]
      ,[fdss_duedate]
      ,[fdss_completed]
      ,[fdss_notes]
  FROM [AWS].[dbo].[financialdatastatus_status]
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
SELECT[fds_id]
,[fds_year]
,[fds_month]
,CASE [fds_missinginfo] WHEN 1 THEN 'Yes' ELSE 'No' END AS [fds_missinginfo]
,CASE [fds_compilemi] WHEN 1 THEN 'Yes' ELSE 'No' END AS [fds_compilemi]
,CONVERT(VARCHAR(10),[fds_obtaininfo_datecompleted], 101)AS[fds_obtaininfo_datecompleted]
,CONVERT(VARCHAR(10),[fds_sort_datecompleted], 101)AS[fds_sort_datecompleted]
,CONVERT(VARCHAR(10),[fds_checks_datecompleted], 101)AS[fds_checks_datecompleted]
,CONVERT(VARCHAR(10),[fds_sales_datecompleted], 101)AS[fds_sales_datecompleted]
,CONVERT(VARCHAR(10),[fds_entry_datecompleted], 101)AS[fds_entry_datecompleted]
,CONVERT(VARCHAR(10),[fds_reconcile_datecompleted], 101)AS[fds_reconcile_datecompleted]
,CONVERT(VARCHAR(10),[fds_compile_datecompleted], 101)AS[fds_compile_datecompleted]
,CONVERT(VARCHAR(10),[fds_review_datecompleted], 101)AS[fds_review_datecompleted]
,CONVERT(VARCHAR(10),[fds_assembly_datecompleted], 101)AS[fds_assembly_datecompleted]
,CONVERT(VARCHAR(10),[fds_delivery_datecompleted], 101)AS[fds_delivery_datecompleted]
,CONVERT(VARCHAR(10),[fds_acctrpt_datecompleted], 101)AS[fds_acctrpt_datecompleted]
,[fds_fees]
,[fds_paymentstatus]
,[client_name]
,[client_id]
FROM[v_financialdatastatus]
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
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTH":"'&FDS_MONTH&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_OBTAININFO_DATECOMPLETED":"'&FDS_OBTAININFO_DATECOMPLETED&'"
								,"FDS_SORT_DATECOMPLETED":"'&FDS_SORT_DATECOMPLETED&'"
								,"FDS_CHECKS_DATECOMPLETED":"'&FDS_CHECKS_DATECOMPLETED&'"
								,"FDS_SALES_DATECOMPLETED":"'&FDS_SALES_DATECOMPLETED&'"
								,"FDS_ENTRY_DATECOMPLETED":"'&FDS_ENTRY_DATECOMPLETED&'"
								,"FDS_RECONCILE_DATECOMPLETED":"'&FDS_RECONCILE_DATECOMPLETED&'"
								,"FDS_COMPILE_DATECOMPLETED":"'&FDS_COMPILE_DATECOMPLETED&'"
								,"FDS_REVIEW_DATECOMPLETED":"'&FDS_REVIEW_DATECOMPLETED&'"
								,"FDS_ASSEMBLY_DATECOMPLETED":"'&FDS_ASSEMBLY_DATECOMPLETED&'"
								,"FDS_DELIVERY_DATECOMPLETED":"'&FDS_DELIVERY_DATECOMPLETED&'"
								,"FDS_ACCTRPT_DATECOMPLETED":"'&FDS_ACCTRPT_DATECOMPLETED&'"
								,"FDS_FEES":"'&FDS_FEES&'"
								,"FDS_PAYMENTSTATUS":"'&FDS_PAYMENTSTATUS&'"
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