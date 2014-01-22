<cfcomponent output="true">

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
      ,[pt_missinginforeceived]
      ,[pt_fees]
      ,[pt_paid]
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
,[pt_state]
,[pt_year]
,[pt_month]
,CONVERT(VARCHAR(10),[pt_lastpay], 101)AS[pt_lastpay]
,CONVERT(VARCHAR(10),[pt_obtaininfo_datecompleted], 101)AS[pt_obtaininfo_datecompleted]
,[pt_missinginfo]
,CONVERT(VARCHAR(10),[pt_missinginforeceived], 101)AS[pt_missinginforeceived]
,CONVERT(VARCHAR(10),[pt_entry_datecompleted], 101)AS[pt_entry_datecompleted]
,CONVERT(VARCHAR(10),[pt_rec_datecompleted], 101)AS[pt_rec_datecompleted]
,CONVERT(VARCHAR(10),[pt_review_datecompleted], 101)AS[pt_review_datecompleted]
,CONVERT(VARCHAR(10),[pt_assembly_datecompleted], 101)AS[pt_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pt_delivery_datecompleted], 101)AS[pt_delivery_datecompleted]
,[pt_fees]
,[pt_paid]      
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
								,"PT_STATE":"'&PT_STATE&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTH":"'&PT_MONTH&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_OBTAININFO_DATECOMPLETED":"'&PT_OBTAININFO_DATECOMPLETED&'"
								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
								,"PT_MISSINGINFORECEIVED":"'&PT_MISSINGINFORECEIVED&'"
								,"PT_ENTRY_DATECOMPLETED":"'&PT_ENTRY_DATECOMPLETED&'"
								,"PT_REC_DATECOMPLETED":"'&PT_REC_DATECOMPLETED&'"
								,"PT_REVIEW_DATECOMPLETED":"'&PT_REVIEW_DATECOMPLETED&'"
								,"PT_ASSEMBLY_DATECOMPLETED":"'&PT_ASSEMBLY_DATECOMPLETED&'"
								,"PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"
								,"PT_FEES":"'&PT_FEES&'"
								,"PT_PAID":"'&PT_PAID&'"
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