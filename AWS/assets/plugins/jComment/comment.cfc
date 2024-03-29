<cfcomponent output="true">
<!--- LOOKUP DATA --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cfargument name="taskid" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">

<!--- Grid 101  --->
<cfcase value="group101">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[comment_id]
,[c_date]=FORMAT(c_date,'#Session.localization.formatdate#') 
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
<cfset queryResult=queryResult&'{"COMMENT_ID":"'&COMMENT_ID&'","C_DATE":"'&C_DATE&'","U_NAME":"'&U_NAME&'","U_EMAIL":"'&U_EMAIL&'","C_NOTES":"'&C_NOTES&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>





<!--- SAVE DATA --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cftry>
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">



<!---Group101--->
<cfcase value="group101">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[comments](
[form_id]
,[user_id]
,[client_id]
,[task_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#Session.user.id#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"saved","result":"ok"}'>
</cfif>

</cfcase>
</cfswitch>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>


<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group101">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[comments]
SET[deleted]=GETDATE()
WHERE[comment_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group101","result":"ok"}'>
</cfcase>

</cfswitch>
<cfcatch>
      <!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>