<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!--- 
[pc_id]
      ,[client_id]
      ,[pc_year]
      ,[pc_payenddate]
      ,[pc_paydate]
      ,[pc_datedue]
      ,[pc_esttime]
      ,[pt_altfreq]
      ,[pc_missinginfo]
      ,[pc_missingreceived]
      ,[pc_fees]
      ,[pc_paymentstatus]
      ,[pc_deliverymethod]
      ,[pc_obtaininfo_assignedto]
      ,[pc_obtaininfo_datecompleted]
      ,[pc_obtaininfo_completedby]
      ,[pc_obtaininfo_esttime]
      ,[pc_preparation_assignedto]
      ,[pc_preparation_datecompleted]
      ,[pc_preparation_completedby]
      ,[pc_preparation_esttime]
      ,[pc_review_assignedto]
      ,[pc_review_datecompleted]
      ,[pc_review_completedby]
      ,[pc_review_esttime]
      ,[pc_assembly_assignedto]
      ,[pc_assembly_datecompleted]
      ,[pc_assembly_completedby]
      ,[pc_assembly_esttime]
      ,[pc_delivery_assignedto]
      ,[pc_delivery_datecompleted]
      ,[pc_delivery_completedby]
      ,[pc_delivery_esttime]
  FROM [payrollcheckstatus]
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
SELECT[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate] 
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,CASE [pc_missinginfo] WHEN 1 THEN 'Yes' ELSE 'No' END AS [pc_missinginfo] 
,CONVERT(VARCHAR(10),[pc_obtaininfo_datecompleted], 101)AS[pc_obtaininfo_datecompleted]
,CONVERT(VARCHAR(10),[pc_assembly_datecompleted], 101)AS[pc_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pc_delivery_datecompleted], 101)AS[pc_delivery_datecompleted]
,[pc_fees]
,[pc_paymentstatus]      
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
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
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PC_YEAR":"'&PC_YEAR&'"
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_OBTAININFO_DATECOMPLETED":"'&PC_OBTAININFO_DATECOMPLETED&'"
								,"PC_ASSEMBLY_DATECOMPLETED":"'&PC_ASSEMBLY_DATECOMPLETED&'"
								,"PC_DELIVERY_DATECOMPLETED":"'&PC_DELIVERY_DATECOMPLETED&'"
								,"PC_FEES":"'&PC_FEES&'"
								,"PC_PAYMENTSTATUS":"'&PC_PAYMENTSTATUS&'"
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