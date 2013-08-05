<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="false">
<cfargument name="selectName" type="string" required="yes">
<cfquery name="fquery" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">
SELECT[optionvalue_id],[optionname]
FROM[v_selectOptions]
WHERE[formName]='Client Maintenance'AND[selectName]='#ARGUMENTS.selectName#'
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"optionvalue_id":"'&optionvalue_id&'","optionname":"'&optionname&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cffunction>

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->

<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">

SELECT [mc_id]
      ,[client_id]
      ,[si_id]
      ,[mc_category]
      ,[mc_comments]
      ,[mc_description]
      ,[mc_duedate]
      ,[mc_estimatedtime]
      ,[mc_fees]
      ,[mc_paid]
      ,[mc_priority]
      ,[mc_projectcompleted]
      ,[mc_requestforservice]
      ,[mc_status]
      ,[mc_source]
      ,[mc_workinitiated]
  FROM[managementconsulting]
WHERE[mc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>

</cfcase>

<cfcase value="group3"></cfcase>
<cfcase value="group2"></cfcase>
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

<!--- LOOKUP Group1 --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
    ,[si_id]
    ,[client_id]
    ,[client_name]
   	,[mc_categoryTEXT]
    ,[mc_description]
    ,[mc_status]
    ,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
  FROM[v_managementconsulting]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","mc_id":"'&mc_id&'","si_id":"'&si_id&'","CLIENT_NAME":"'&CLIENT_NAME&'","mc_categoryTEXT":"'&mc_categoryTEXT&'","mc_description":"'&mc_description&'","mc_status":"'&mc_status&'","mc_duedate":"'&mc_duedate&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- STOPPED HERE --->
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[managementconsulting](
[client_id]
,[si_id]
,[mc_category]
,[mc_comments]
,[mc_description]
,[mc_duedate]
,[mc_estimatedtime]
,[mc_fees]
,[mc_paid]
,[mc_priority]
,[mc_projectcompleted]
,[mc_requestforservice]
,[mc_status]
,[mc_workinitiated]
,[mc_credithold]
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
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#"/>

)
SELECT SCOPE_IDENTITY()AS[mc_id]
</cfquery>
<cfreturn '{"id":#fquery.mc_id#,"group":"group2","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[managementconsulting]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[si_id]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[mc_category]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[mc_comments]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[mc_description]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[mc_duedate]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[mc_estimatedtime]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[mc_fees]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[mc_paid]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[mc_priority]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[mc_projectcompleted]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[mc_requestforservice]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[mc_status]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[mc_workinitiated]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[mc_credithold]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[mc_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>

<!--- Group2 --->
<cfcase value="group2">
<cfreturn '{"id":#fquery.comment_id#,"group":"group3","result":"ok"}'>
</cfcase>
<!--- Group3 --->
<cfcase value="group3">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group4","result":"ok"}'>
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