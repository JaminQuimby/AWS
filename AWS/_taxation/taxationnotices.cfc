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
      ,[n_id]
      ,[n_assignedto]
      ,[n_noticestatus]
      ,[n_priority]
      ,[n_esttime]
      ,[n_1_noticenumber]
      ,[n_1_noticedate]
      ,[n_1_taxform]
      ,[n_1_taxyear]
      ,[n_1_methodreceived]
      ,[n_1_fees]
      ,[n_1_paid]
      ,[n_2_datenoticerec]
      ,[n_2_resduedate]
      ,[n_2_rescompleted]
      ,[n_2_rescompletedby]
      ,[n_2_revrequired]
      ,[n_2_revassignedto]
      ,[n_2_revcompleted]
      ,[n_2_ressubmited]
      ,[n_2_irsstateresponse]
      ,[n_3_missinginfo]
      ,[n_3_missingrec]
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
SELECT[nm_id]
	[client_id]
      ,[nm_name]
      ,[nm_status]
FROM[noticematter]
WHERE[nm_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
SELECT[n_id]
      ,[n_assignedto]
      ,[n_estimatedtime]
      ,[n_matter]
      ,[n_noticestatus]
      ,[n_priority]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub1 --->
<cfcase value="group2_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[n_id]
      ,[n_1_fees]
      ,[n_1_methodreceived]
      ,[n_1_noticedate]
      ,[n_1_noticenumber]
      ,[n_1_paid]
      ,[n_1_taxform]
      ,[n_1_taxyear]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub2 --->
<cfcase value="group2_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[n_id]
      ,[n_2_datenoticereceived]
      ,[n_2_duedateforresponse]
      ,[n_2_irsstateresponserecieved]
      ,[n_2_responsecompleted]
      ,[n_2_responsecompletedby]
      ,[n_2_responsesubmitted]
      ,[n_2_reviewassignedto]
      ,[n_2_reviewcompleted]
      ,[n_2_reviewrequired]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group3 sub3 --->
<cfcase value="group2_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[n_id]
      ,[n_3_missinginforeceived]
      ,[n_3_missinginformation]
FROM[notice]
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
SELECT[nm_id]
,[nm_status]
,[client_name]
,[CLIENT_ID]
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
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","NM_STATUS":"'&NM_STATUS&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- Grid 2 Entrance --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[n_id]
,[n_1_taxyear]
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

<!--- Grid 3 --->
<cfcase value="group3">
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
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[NOTICEMATTER](
      [client_id]
 ,[nm_name]
 ,[nm_status]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN TR_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group2","result":"ok"}'>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[NOTICEMATTER]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[nm_name]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[nm_status]=<cfqueryparam value="#j.DATA[1][4]#"/>
WHERE[NM_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>


<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[NOTICE](
   [nm_id]
,[n_assignedto]
,[n_esttime]
,[n_noticestatus]
,[n_priority]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"group3","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[NOTICE]
SET[nm_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[n_esttime]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[n_noticestatus]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[n_priority]=<cfqueryparam value="#j.DATA[1][6]#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2 Subgroup1 --->
<cfcase value="group2_1">
 <cfquery name="fquery" datasource="AWS">
UPDATE[NOTICE]
SET[n_1_fees]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_1_methodreceived]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[n_1_noticedate]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[n_1_noticenumber]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[n_1_paid]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[n_1_taxform]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[n_1_taxyear]=<cfqueryparam value="#j.DATA[1][8]#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
</cfcase>
<!---Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
 <cfquery name="fquery" datasource="AWS">
UPDATE[NOTICE]
SET[n_2_datenoticerec]=<cfqueryparam value="#j.DATA[1][2]#" NULL="#LEN(j.DATA[1][2]) eq 0#"/>
,[n_2_irsstateresponse]=<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0#"/>
,[n_2_rescompleted]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[n_2_rescompletedby]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[n_2_resduedate]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[n_2_ressubmited]=<cfqueryparam value="#j.DATA[1][7]#" NULL="#LEN(j.DATA[1][7]) eq 0#"/>
,[n_2_revassignedto]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[n_2_revcompleted]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#LEN(j.DATA[1][9]) eq 0#"/>
,[n_2_revrequired]=<cfqueryparam value="#j.DATA[1][10]#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_3","result":"ok"}'>
</cfcase>
<!---Group2 Subgroup3 --->
<cfcase value="group2_3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
 <cfquery name="fquery" datasource="AWS">
UPDATE[NOTICE]
SET[n_3_missinginfo]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_3_missingrec]=<cfqueryparam value="#j.DATA[1][3]#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3","result":"ok"}'>
</cfcase>
<!---Group3--->
<cfcase value="group3">
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
,<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group4","result":"ok"}'>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>