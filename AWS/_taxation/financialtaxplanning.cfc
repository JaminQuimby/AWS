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
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[FTP_ID]
 ,[client_id]
 ,[ftp_assignedto]
 ,[ftp_category]
 ,CONVERT(VARCHAR(10),[ftp_duedate], 101)AS[ftp_duedate]
 ,[ftp_esttime]
 ,[ftp_fees]
 ,CONVERT(VARCHAR(10),[ftp_finalclientmeeting], 101)AS[ftp_finalclientmeeting]
 ,CONVERT(VARCHAR(10),[ftp_infocompiled], 101)AS[ftp_infocompiled]
 ,CONVERT(VARCHAR(10),[ftp_inforeceived], 101)AS[ftp_inforeceived]
 ,CONVERT(VARCHAR(10),[ftp_inforequested], 101)AS[ftp_inforequested]
 ,[ftp_missinginfo]
 ,CONVERT(VARCHAR(10),[ftp_missinginforec], 101)AS[ftp_missinginforec]
 ,[ftp_paid]
 ,[ftp_priority]
 ,CONVERT(VARCHAR(10),[ftp_reportcompleted], 101)AS[ftp_reportcompleted]
 ,CONVERT(VARCHAR(10),[ftp_requestservice], 101)AS[ftp_requestservice]
 ,[ftp_status]
FROM[financialtaxplanning]
WHERE[ftp_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"]}'> 
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
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[ftp_id]
,[ftp_status]
,[client_name]
,[CLIENT_ID]
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
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FTP_STATUS":"'&FTP_STATUS&'"}'>
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
<!--- Group1 --->
<cfcase value="group1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>

<cfquery name="fquery" datasource="AWS">
INSERT INTO[FINANCIALTAXPLANNING](
[client_id]
 ,[ftp_assignedto]
 ,[ftp_category]
 ,[ftp_duedate]
 ,[ftp_esttime]
 ,[ftp_fees]
 ,[ftp_finalclientmeeting]
 ,[ftp_infocompiled]
 ,[ftp_inforeceived]
 ,[ftp_inforequested]
 ,[ftp_missinginfo]
 ,[ftp_missinginforec]
 ,[ftp_paid]
 ,[ftp_priority]
 ,[ftp_reportcompleted]
 ,[ftp_requestservice]
 ,[ftp_status]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][18]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>

<!--- RETURN FTP_ID--->
<cfreturn '{"id":#fquery.id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[FINANCIALTAXPLANNING]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
 ,[ftp_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
 ,[ftp_category]=<cfqueryparam value="#j.DATA[1][4]#"/>
 ,[ftp_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
 ,[ftp_esttime]=<cfqueryparam value="#j.DATA[1][6]#"/>
 ,[ftp_fees]=<cfqueryparam value="#j.DATA[1][7]#"/>
 ,[ftp_finalclientmeeting]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
 ,[ftp_infocompiled]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
 ,[ftp_inforeceived]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
 ,[ftp_inforequested]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
 ,[ftp_missinginfo]=<cfqueryparam value="#j.DATA[1][12]#"/>
 ,[ftp_missinginforec]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
 ,[ftp_paid]=<cfqueryparam value="#j.DATA[1][14]#"/>
 ,[ftp_priority]=<cfqueryparam value="#j.DATA[1][15]#"/>
 ,[ftp_reportcompleted]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
 ,[ftp_requestservice]=<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#"/>
 ,[ftp_status]=<cfqueryparam value="#j.DATA[1][18]#"/>
WHERE[FTP_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>