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

--->


<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->

<cfcase value="financialDataStatus">
<cfquery datasource="AWS" name="fQuery">
SELECT[fds_id],[client_id],[client_name],[fds_month],[fds_periodend],[fds_year],[fds_monthTEXT]
FROM[v_financialDataStatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>

</cfcase>


</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"]}'> 
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

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<cfcase value="financialdatastatus">
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id],[client_id],[client_name],CONVERT(VARCHAR(10),[fds_periodend], 101)AS[fds_periodend],[fds_month],[fds_year],[fds_monthTEXT]
FROM[v_financialDataStatus]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'","FDS_YEAR":"'&FDS_YEAR&'","FDS_PERIODEND":"'&FDS_PERIODEND&'"}'>
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
<!--- Client --->
<cfcase value="client">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[CLIENT_LISTING](
[client_active],
[client_credit_hold],
[client_dms_refrence],
[client_group],
[client_name],
[client_notes],
[client_referred_by],
[client_salutation],
[client_since],
[client_spouse],
[client_trade_name],
[client_type]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>,<cfqueryparam value="#j.DATA[1][3]#"/>,<cfqueryparam value="#j.DATA[1][4]#"/>,<cfqueryparam value="#j.DATA[1][5]#"/>,<cfqueryparam value="#j.DATA[1][6]#"/>,<cfqueryparam value="#j.DATA[1][7]#"/>,<cfqueryparam value="#j.DATA[1][8]#"/>,<cfqueryparam value="#j.DATA[1][9]#"/>,<cfqueryparam value="#j.DATA[1][10]#"/>,<cfqueryparam value="#j.DATA[1][11]#"/>,<cfqueryparam value="#j.DATA[1][12]#"/>,<cfqueryparam value="#j.DATA[1][13]#"/>)
SELECT SCOPE_IDENTITY()AS[clientId]
</cfquery>
<cfreturn '{"id":#fquery.clientId#,"group":"customfield","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_active]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[client_credit_hold]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[client_dms_refrence]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[client_group]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[client_name]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[client_notes]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[client_referred_by]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[client_salutation]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[client_since]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[client_spouse]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[client_trade_name]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[client_type]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"customfields","result":"ok"}'>
</cfif>

</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>