<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---

SELECT[ftp_id]
      ,[client_id]
      ,[ftp_category]
      ,[ftp_status]
      ,[ftp_assignedto]
      ,[ftp_priority]
      ,[ftp_requestservice]
      ,[ftp_duedate]
      ,[ftp_inforequested]
      ,[ftp_inforeceived]
      ,[ftp_infocompiled]
      ,[ftp_missinginfo]
      ,[ftp_missinginforec]
      ,[ftp_reportcompleted]
      ,[ftp_finalclientmeeting]
      ,[ftp_esttime]
      ,[ftp_fees]
      ,[ftp_paid]
  FROM [financialtaxplanning]
  
  
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
SELECT[ftp_id]
,[ftp_category]
,[ftp_status]
,CONVERT(VARCHAR(10),[ftp_duedate], 101)AS[ftp_duedate]
,[ftp_assignedto]      
,CONVERT(VARCHAR(10),[ftp_requestservice], 101)AS[ftp_requestservice]
,CONVERT(VARCHAR(10),[ftp_inforequested], 101)AS[ftp_inforequested]
,CONVERT(VARCHAR(10),[ftp_inforeceived], 101)AS[ftp_inforeceived]
,CONVERT(VARCHAR(10),[ftp_infocompiled], 101)AS[ftp_infocompiled]
,CASE [ftp_missinginfo] WHEN 1 THEN 'Yes' ELSE 'No' END AS[ftp_missinginfo]
,CONVERT(VARCHAR(10),[ftp_missinginforec], 101)AS[ftp_missinginforec]
,CONVERT(VARCHAR(10),[ftp_reportcompleted], 101)AS[ftp_reportcompleted]
,CONVERT(VARCHAR(10),[ftp_finalclientmeeting], 101)AS[ftp_finalclientmeeting]
,[ftp_fees]
,[ftp_paid]
,[client_name]
,[client_id]
FROM[v_financialtaxplanning]
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
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FTP_CATEGORY":"'&FTP_CATEGORY&'"
								,"FTP_STATUS":"'&FTP_STATUS&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_ASSIGNEDTO":"'&FTP_ASSIGNEDTO&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_INFOREQUESTED":"'&FTP_INFOREQUESTED&'"
								,"FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'"
								,"FTP_INFOCOMPILED":"'&FTP_INFOCOMPILED&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_MISSINGINFOREC":"'&FTP_MISSINGINFOREC&'"
								,"FTP_REPORTCOMPLETED":"'&FTP_REPORTCOMPLETED&'"
								,"FTP_FINALCLIENTMEETING":"'&FTP_FINALCLIENTMEETING&'"
								,"FTP_FEES":"'&FTP_FEES&'"
								,"FTP_PAID":"'&FTP_PAID&'"
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