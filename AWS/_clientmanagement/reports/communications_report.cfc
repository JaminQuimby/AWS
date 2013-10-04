<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---

SELECT[co_id]
,[client_id]
,[co_briefmessage]
,[co_caller]
,[co_completed]
,[co_contactmethod]
,[co_credithold]
,CONVERT(CHAR(10),[co_date], 101)+' '+RIGHT(CONVERT(VARCHAR,co_date, 100),7)AS[co_date]
,CONVERT(VARCHAR(10),[co_duedate], 101)AS[co_duedate]
,[co_emailaddress]
,[co_ext]
,[co_faxnumber]
,[co_fees]
,[co_for]
,[co_paid]
,[co_responseneeded]
,[co_returncall]
,[co_takenby]
,[co_telephone]
   FROM [v_communications]
  
  
--->


<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="formid" type="string" required="no">


<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cftry>

<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[co_caller]
,[co_for]
,[co_fees]
,[co_paid]
,CONVERT(CHAR(10),[co_date], 101)+' '+RIGHT(CONVERT(VARCHAR,co_date, 100),7)AS[co_date]
,[co_telephone]
,[co_ext]
,[co_emailaddress]
,CASE [co_responseneeded] WHEN 1 THEN 'Yes' ELSE 'No' END AS[co_responseneeded]
,CASE [co_returncall] WHEN 1 THEN 'Yes' ELSE 'No' END AS[co_returncall]
,CASE [co_completed] WHEN 1 THEN 'Yes' ELSE 'No' END AS[co_completed]
,[co_briefmessage]
,[client_name]
,[client_id]
FROM[v_communications]
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
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_FOR":"'&CO_FOR&'"
								,"CO_FEES":"'&CO_FEES&'"
								,"CO_PAID":"'&CO_PAID&'"
								,"CO_DATE":"'&CO_DATE&'"
								,"CO_TELEPHONE":"'&CO_TELEPHONE&'"
								,"CO_EXT":"'&CO_EXT&'"
								,"CO_EMAILADDRESS":"'&CO_EMAILADDRESS&'"
								,"CO_RESPONSENEEDED":"'&CO_RESPONSENEEDED&'"
								,"CO_RETURNCALL":"'&CO_RETURNCALL&'"
								,"CO_COMPLETED":"'&CO_COMPLETED&'"
								,"CO_BRIEFMESSAGE":"'&CO_BRIEFMESSAGE&'"
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



<!--- Grid 1 Entrance --->
<cfcase value="group2">
<cftry>


<cfquery datasource="AWS" name="fquery">
SELECT[comment_id]
,CONVERT(VARCHAR(10),[c_date], 101)AS[c_date]
,[u_name]
,[u_email]
,CASE WHEN LEN([c_notes]) >= 101 THEN SUBSTRING([c_notes],0,100) +  '...' ELSE [c_notes] END AS[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.formid#"/>
AND[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[task_id]=<cfqueryparam value="#ARGUMENTS.taskid#"/> 
AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"COMMENT_ID":"'&COMMENT_ID&'"
								,"C_DATE":"'&C_DATE&'"
								,"U_NAME":"'&U_NAME&'"
								,"U_EMAIL":"'&U_EMAIL&'"
								,"C_NOTES":"'&C_NOTES&'"
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