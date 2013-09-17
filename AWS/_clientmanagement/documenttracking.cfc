<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---
SELECT
[dt_id]
      ,[client_id]
      ,[dt_assignedto]
      ,[dt_date]
      ,[dt_delivery]
      ,[dt_description]
      ,[dt_email]
      ,[dt_fax]
      ,[dt_mail]
      ,[dt_routing]
      ,[dt_sender]
      ,[dt_staff]
  FROM [documenttracking]
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
SELECT[DT_ID]
 ,[client_id]
<!--- ,[form_id]
 ,[file_id]--->
 ,[dt_assignedto]
,CONVERT(VARCHAR(10),[dt_date], 101)AS[dt_date]
 ,[dt_delivery]
 ,[dt_description]
 ,[dt_email]
 ,[dt_fax]
 ,[dt_mail]
 ,[dt_routing]
 ,[dt_sender]
 ,[dt_staff]
FROM[documenttracking]
WHERE[dt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[dt_id]
,[dt_sender]
,[dt_description]
,[dt_assignedto]
,[dt_routing]
,[client_name]
,[CLIENT_ID]
FROM[v_documenttracking]
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
<cfset queryResult=queryResult&'{"DT_ID":"'&DT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","DT_SENDER":"'&DT_SENDER&'","DT_ASSIGNEDTO":"'&DT_ASSIGNEDTO&'","DT_ROUTING":"'&DT_ROUTING&'","DT_DESCRIPTION":"'&DT_DESCRIPTION&'"}'>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[documenttracking](
[client_id]
<!---,[form_id]
,[file_id]--->
,[dt_assignedto]
,[dt_date]
,[dt_delivery]
,[dt_description]
,[dt_email]
,[dt_fax]
,[dt_mail]
,[dt_routing]
,[dt_sender]
,[dt_staff]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
<!---,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>--->
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN DT_ID--->
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
UPDATE[documenttracking]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
<!---,[form_id]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[file_id]=<cfqueryparam value="#j.DATA[1][4]#"/>--->
,[dt_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[dt_date]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[dt_delivery]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[dt_description]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[dt_email]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[dt_fax]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[dt_mail]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[dt_routing]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[dt_sender]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[dt_staff]=<cfqueryparam value="#j.DATA[1][12]#"/>
WHERE[DT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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