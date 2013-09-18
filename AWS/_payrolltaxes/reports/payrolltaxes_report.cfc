<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!--- 

[pt_id]
      ,[client_id]
      ,[pt_year]
      ,[pt_month]
      ,[pt_duedate]
      ,[pt_type]
      ,[pt_lastpay]
      ,[pt_priority]
      ,[pt_esttime]
      ,[pt_missinginfo]
      ,[pt_missingreceived]
      ,[pt_fees]
      ,[pt_paymentstatus]
      ,[pt_deliverymethod]
      ,[pt_obtaininfo_assignedto]
      ,[pt_obtaininfo_datecomplted]
      ,[pt_obtaininfo_completedby]
      ,[pt_obtaininfo_esttime]
      ,[pt_entry_assignedto]
      ,[pt_entry_datecompleted]
      ,[pt_entry_completedby]
      ,[pt_entry_esttime]
      ,[pt_rec_assignedto]
      ,[pt_rec_datecompleted]
      ,[pt_rec_completedby]
      ,[pt_rec_esttime]
      ,[pt_review_assignedto]
      ,[pt_review_datecompleted]
      ,[pt_review_completedby]
      ,[pt_review_esttime]
      ,[pt_assembly_assignedto]
      ,[pt_assembly_datecompleted]
      ,[pt_assembly_completedby]
      ,[pt_assembly_esttime]
      ,[pt_delivery_assignedto]
      ,[pt_delivery_datecompleted]
      ,[pt_delivery_completedby]
      ,[pt_delivery_esttime]
	  
	  --->


<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="jtSorting" type="any" required="no" default="client_name">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="otherid" type="string" required="no">

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT
[pt_id],
[client_name], 
[pt_year],
	           (SELECT     optionName
                            FROM          dbo.ctrl_selectoptions
                            WHERE      (selectName_id = 8) AND (optionValue_id = dbo.financialdatastatus.fds_month)) AS pt_monthTEXT,
[pt_duedate],
	[pt_type],
[pt_lastpay],
[pt_priority],
[pt_esttime],
[pt_missinginfo],
[pt_missingreceived],
[pt_fees],
	[pt_paymentstatus],
	[pt_deliverymethod],
	[pt_obtaininfo_assignedto],
[pt_obtaininfo_datecompleted],
	[pt_obtaininfo_completedby],
[pt_obtaininfo_esttime],
	[pt_entry_assignedto],
[pt_entry_datecompleted],
	[pt_entry_completedby],
[pt_entry_esttime],
	[pt_rec_assignedto],
[pt_rec_datecompleted],
	[pt_rec_completedby],
[pt_rec_esttime],
	[pt_review_assignedto],
[pt_review_datecompleted],
	[pt_review_completedby],
[pt_review_esttime],
	[pt_assembly_assignedto],
[pt_assembly_datecompleted],
	[pt_assembly_completedby],
[pt_assembly_esttime],
	[pt_delivery_assignedto],
[pt_delivery_datecompleted],
	[pt_delivery_completedby],
[pt_delivery_esttime]
FROM[v_payrolltaxes]
<cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif>
ORDER BY #ARGUMENTS.jtSorting#



</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PT_YEAR":"'&PT_YEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


</cfswitch>

</cffunction>

</cfcomponent>