<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- 


GROUP1 LEVEL1
SELECT[nm_id]
      ,[client_id]
      ,[nm_name]
      ,[nm_status]
FROM [noticematter]
  


GROUP2 LEVEL2  
SELECT[n_id]
      ,[m_id]
      ,[m_assignedto]
      ,[m_noticestatus]
      ,[m_priority]
      ,[m_esttime]
      ,[m_1_noticenumber]
      ,[m_1_noticedate]
      ,[m_1_taxform]
      ,[m_1_taxyear]
      ,[m_1_methodreceived]
      ,[m_1_fees]
      ,[m_1_paid]
      ,[m_2_datenoticerec]
      ,[m_2_resduedate]
      ,[m_2_rescompleted]
      ,[m_2_rescompletedby]
      ,[m_2_revrequired]
      ,[m_2_revassignedto]
      ,[m_2_revcompleted]
      ,[m_2_ressubmited]
      ,[m_2_irsstateresponse]
      ,[m_3_missinginfo]
      ,[m_3_missingrec]
  FROM[notice]
  
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
SELECT[n_id]
[client_id]
 ,[g1_assignedto]
 ,[g1_datenoticereceived]
 ,[g1_duedateforresponse]
 ,[g1_estimatedtime]
 ,[g1_fees]
 ,[g1_matter]
 ,[g1_methodreceived]
 ,[g1_missinginforeceived]
 ,[g1_missinginformation]
 ,[g1_noticenumber]
 ,[g1_noticestatus]
 ,[g1_paid]
 ,[g1_priority]
 ,[g1_responsecompleted]
 ,[g1_reviewassignedto]
 ,[g1_reviewcompleted]
 ,[g1_reviewrequired]
 ,[g1_responsesubmitted]
 ,[g1_taxform]
 ,[g1_taxyear]
FROM[notices]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<cfargument name="otherid" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT
[nm_id]
,[client_id]
,[nm_name]
,[nm_status]
,[client_name]
FROM[v_noticematter]
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
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","N_TAXYEAR":"'&N_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!------>
<!--- Grid 0 Entrance --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[n_id]
,[m_1_taxyear]
,[client_name]
FROM[v_notice]
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
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","M_1_TAXYEAR":"'&M_1_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- Grid 2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][11])><cfset j.DATA[1][11]=1><cfelse><cfset j.DATA[1][11]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][19])><cfset j.DATA[1][19]=1><cfelse><cfset j.DATA[1][19]=0></cfif>

<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>

<cfquery name="fquery" datasource="AWS">
INSERT INTO[NOTICES](
[client_id]
 ,[g1_assignedto]
 ,[g1_datenoticereceived]
 ,[g1_duedateforresponse]
 ,[g1_estimatedtime]
 ,[g1_fees]
 ,[g1_matter]
 ,[g1_methodreceived]
 ,[g1_missinginforeceived]
 ,[g1_missinginformation]
 ,[g1_noticenumber]
 ,[g1_noticestatus]
 ,[g1_paid]
 ,[g1_priority]
 ,[g1_responsecompleted]
 ,[g1_reviewassignedto]
 ,[g1_reviewcompleted]
 ,[g1_reviewrequired]
 ,[g1_responsesubmitted]
 ,[g1_taxform]
 ,[g1_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][17]#"/>
,<cfqueryparam value="#j.DATA[1][18]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][19]#"/>
,<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][21]#"/>
,<cfqueryparam value="#j.DATA[1][22]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN N_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[NOTICES]
SET[client_id]
 ,[g1_assignedto]
 ,[g1_datenoticereceived]
 ,[g1_duedateforresponse]
 ,[g1_estimatedtime]
 ,[g1_fees]
 ,[g1_matter]
 ,[g1_methodreceived]
 ,[g1_missinginforeceived]
 ,[g1_missinginformation]
 ,[g1_noticenumber]
 ,[g1_noticestatus]
 ,[g1_paid]
 ,[g1_priority]
 ,[g1_responsecompleted]
 ,[g1_reviewassignedto]
 ,[g1_reviewcompleted]
 ,[g1_reviewrequired]
 ,[g1_responsesubmitted]
 ,[g1_taxform]
 ,[g1_taxyear]
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[client_id]
,[other_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
)
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group3","result":"ok"}'>
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