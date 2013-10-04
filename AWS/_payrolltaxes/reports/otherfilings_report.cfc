<cfcomponent output="true">

<!---
SELECT TOP 1000 [of_id]
      ,[client_id]
      ,[of_taxyear]
      ,[of_period]
      ,[of_state]
      ,[of_task]
      ,[of_form]
      ,[of_duedate]
      ,[of_filingdeadline]
      ,[of_extensiondeadline]
      ,[of_extensioncomplted]
      ,[of_status]
      ,[of_priority]
      ,[of_esttime]
      ,[of_missinginfo]
      ,[of_mireceived]
      ,[of_fees]
      ,[of_paymentstatus]
      ,[of_deliverymethod]
      ,[of_obtaininfo_assignedto]
      ,[of_obtaininfo_datecompleted]
      ,[of_obtaininfo_completedby]
      ,[of_obtaininfo_estimatedtime]
      ,[of_preparation_assignedto]
      ,[of_preparation_datecompleted]
      ,[of_preparation_completedby]
      ,[of_preparation_estimatedtime]
      ,[of_review_assignedto]
      ,[of_review_datecompleted]
      ,[of_review_completedby]
      ,[of_review_estimatedtime]
      ,[of_assembly_assignedto]
      ,[of_assembly_datecomplted]
      ,[of_assembly_compltedby]
      ,[of_assembly_estimatedtime]
      ,[of_delivery_assignedto]
      ,[of_delivery_datecomplted]
      ,[of_delivery_compltedby]
      ,[of_delivery_esttime]
  FROM [otherfilings]
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
SELECT[of_id]
,CONVERT(VARCHAR(10),[of_duedate], 101)AS[of_duedate]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_form]
,CONVERT(VARCHAR(10),[of_obtaininfo_datecompleted], 101)AS[of_obtaininfo_datecompleted]
,[of_missinginfo]
,CONVERT(VARCHAR(10),[of_mireceived], 101)AS[of_mireceived]      
,CONVERT(VARCHAR(10),[of_preparation_datecompleted], 101)AS[of_preparation_datecompleted]
,CONVERT(VARCHAR(10),[of_review_datecompleted], 101)AS[of_review_datecompleted]
,CONVERT(VARCHAR(10),[of_assembly_datecompleted], 101)AS[of_assembly_datecompleted]
,CONVERT(VARCHAR(10),[of_delivery_datecompleted], 101)AS[of_delivery_datecompleted]
,[of_fees]
,[of_esttime]
,[of_paymentstatus]  
,[client_name]
,[client_id]
FROM[v_otherfilings]
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
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"
								,"OF_PERIOD":"'&OF_PERIOD&'"
								,"OF_STATE":"'&OF_STATE&'"
								,"OF_FORM":"'&OF_FORM&'"
								,"OF_OBTAININFO_DATECOMPLETED":"'&OF_OBTAININFO_DATECOMPLETED&'"
								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
								,"OF_MIRECEIVED":"'&OF_MIRECEIVED&'"
								,"OF_PREPARATION_DATECOMPLETED":"'&OF_PREPARATION_DATECOMPLETED&'"
								,"OF_REVIEW_DATECOMPLETED":"'&OF_REVIEW_DATECOMPLETED&'"
								,"OF_ASSEMBLY_DATECOMPLETED":"'&OF_ASSEMBLY_DATECOMPLETED&'"
								,"OF_DELIVERY_DATECOMPLETED":"'&OF_DELIVERY_DATECOMPLETED&'"
								,"OF_FEES":"'&OF_FEES&'"
								,"OF_ESTTIME":"'&OF_ESTTIME&'"
								,"OF_PAYMENTSTATUS":"'&OF_PAYMENTSTATUS&'"
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