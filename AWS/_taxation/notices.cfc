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
      ,[n_1_noticedate]
      ,[n_1_noticenumber]
      ,[n_1_taxform]
      ,[n_1_taxyear]
      ,[n_2_resduedate]
      ,[n_2_rescompleted]
      ,[n_2_rescompletedby]
      ,[n_2_revrequired]
      ,[n_2_revassignedto]
      ,[n_2_revcompleted]
      ,[n_2_ressubmited]
      ,[n_2_irsstateresponse]
      ,[n_3_missinginfo]
      ,[n_3_missinginforeceived]
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
,[client_id]
,[nm_name]
,[nm_status]
,[nm_name]
FROM[noticematter]
WHERE[nm_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
SELECT[n_id]
      ,[n_assignedto]
      ,[n_deliverymethod]
      ,[n_esttime]
      ,[n_fees]
      ,[n_missinginfo]
      ,CONVERT(VARCHAR(10),[n_missinginforeceived], 1)AS[n_missinginforeceived]
      ,[n_noticestatus]
      ,[n_paid]
      ,[n_priority]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub1 --->
<cfcase value="group2_1">
<cfquery datasource="AWS" name="fQuery">
SELECT ,CONVERT(VARCHAR(10),[n_1_noticedate], 1)AS[n_1_datenoticerec]
	   ,[n_1_methodreceived]
	   ,CONVERT(VARCHAR(10),[n_1_noticedate], 1)AS[n_1_noticedate]
	   ,[n_1_noticenumber]
	   ,CONVERT(VARCHAR(10),[n_1_noticedate], 1)AS[n_1_resduedate]
	   ,[n_1_taxform]
	   ,[n_1_taxyear]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub2 --->
<cfcase value="group2_2">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[n_2_irsstateresponse], 1)AS[n_2_irsstateresponse]
	  ,CONVERT(VARCHAR(10),[n_2_rescompleted], 1)AS[n_2_rescompleted]
	  ,[n_2_rescompletedby]
 	  ,CONVERT(VARCHAR(10),[n_2_ressubmited], 1)AS[n_2_ressubmited]      
	  ,[n_2_revassignedto]
	  ,CONVERT(VARCHAR(10),[n_2_revcompleted], 1)AS[n_2_revcompleted]
	  ,CONVERT(VARCHAR(10),[n_2_revrequired], 1)AS[n_2_revrequired]  
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Asset Credit Hold --->
<cfcase value="assetCreditHold">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_credit_hold]
FROM[client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<cfargument name="formid" type="string" required="no">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Taxation Notices --->
<!--- Grid 0  --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[nm_name]
,[nm_status]
,[client_name]
,[client_id]
,[nm_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[nm_status]=[optionvalue_id]
)
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
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"NM_NAME":"'&NM_NAME&'"
								,"NM_STATUSTEXT":"'&NM_STATUSTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- Grid 2  --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_assignedtoTEXT]
,[n_noticestatus]
,[n_1_noticenumber]
,[n_1_taxform]
,[n_1_taxyear]
,[n_1_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[n_1_taxform]=[optionvalue_id])

,CONVERT(VARCHAR(10),[n_1_resduedate], 1)AS[n_1_resduedate]
,[n_noticestatusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_noticestatus]=[optionvalue_id])
FROM[v_notice]
WHERE[nm_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[n_assignedtoTEXT]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'"
								,"NM_NAME":"'&NM_NAME&'"
								,"N_ASSIGNEDTOTEXT":"'&N_ASSIGNEDTOTEXT&'"
								,"N_NOTICESTATUSTEXT":"'&N_NOTICESTATUSTEXT&'"
								,"N_1_TAXFORMTEXT":"'&N_1_TAXFORMTEXT&'"
								,"N_1_TAXYEAR":"'&N_1_TAXYEAR&'"
								,"N_1_RESDUEDATE":"'&N_1_RESDUEDATE&'"
								,"N_1_NOTICENUMBER":"'&N_1_NOTICENUMBER&'"
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
INSERT INTO[noticematter](
[client_id]
,[nm_name]
,[nm_status]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[nm_id]
</cfquery>
<!--- RETURN TR_ID--->
<cfreturn '{"id":#fquery.nm_id#,"group":"group2","result":"ok"}'>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[noticematter]
SET
[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[nm_name]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[nm_status]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[nm_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[notice](
[nm_id]
,[n_assignedto]
,[n_deliverymethod]
,[n_esttime]
,[n_fees]
,[n_missinginfo]
,[n_missinginforeceived]
,[n_noticestatus]
,[n_paid]
,[n_priority]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" NULL="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" NULL="#LEN(j.DATA[1][11]) eq 0#"/>

)
SELECT SCOPE_IDENTITY()AS[n_id]
</cfquery>
<cfreturn '{"id":#fquery.n_id#,"group":"group2_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[notice]
SET[nm_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[n_deliverymethod]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[n_esttime]=<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,[n_fees]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[n_missinginfo]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[n_missinginforeceived]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[n_noticestatus]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[n_paid]=<cfqueryparam value="#j.DATA[1][10]#" NULL="#LEN(j.DATA[1][10]) eq 0#"/>
,[n_priority]=<cfqueryparam value="#j.DATA[1][11]#" NULL="#LEN(j.DATA[1][11]) eq 0#"/>
WHERE[n_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2 Subgroup1 --->
<cfcase value="group2_1">
 <cfquery name="fquery" datasource="AWS">
UPDATE[notice]
SET[nm_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_1_noticenumber]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[n_1_noticedate]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[n_1_taxyear]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[n_1_taxform]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[n_1_methodreceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[n_1_datenoticerec]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[n_1_resduedate]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
</cfcase>
<!---Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[notice]  
SET[nm_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_2_irsstateresponse]=<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0#"/>
,[n_2_rescompleted]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[n_2_rescompletedby]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[n_2_ressubmited]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[n_2_revassignedto]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[n_2_revcompleted]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[n_2_revrequired]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[N_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>

<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
update[noticematter]
SET[nm_active]=0
WHERE[nm_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
update[notice]
SET[n_active]=0
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>