<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- DUPE CHECK --->
<cffunction name="f_duplicateCheck" access="remote" output="true">
<cfargument name="check" type="string">
<cfargument name="loadType" type="string">

<cfswitch expression="#ARGUMENTS.loadType#">
<cfcase value="group1">
<cfset i=0>
<!--- 

WHERE[client_id]=<cfqueryparam value="#item[1]#" null="#LEN(item[1]) eq 0#"/>
AND[nst_1_noticenumber]=<cfqueryparam value="#item[2]#" null="#LEN(item[2]) eq 0#"/>
AND[nst_1_noticedate]=<cfqueryparam value="#item[3]#" null="#LEN(item[3]) eq 0#"/>
AND[nst_1_taxyear]=<cfqueryparam value="#item[4]#" null="#LEN(item[4]) eq 0#"/>
AND[nst_1_taxform]=<cfqueryparam value="#item[5]#" null="#LEN(item[5]) eq 0#"/>
AND[nst_1_resduedate]=<cfqueryparam value="#item[6]#" null="#LEN(item[6]) eq 0#"/>

--->
<cfloop list="#ARGUMENTS.check#" index="s" delimiters=",">
<cfset i=i+1>
<cfset item[i]=s>
</cfloop>

<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT TOP(1)[client_id]
FROM[v_notice_subtask]
WHERE[client_id]=<cfqueryparam value="#item[1]#" null="#LEN(item[1]) eq 0#"/>
AND[nst_1_noticenumber]=<cfqueryparam value="#item[2]#" null="#LEN(item[2]) eq 0#"/>
AND[nst_1_noticedate]=<cfqueryparam value="#item[3]#" null="#LEN(item[3]) eq 0#"/>
AND[nst_1_taxyear]=<cfqueryparam value="#item[4]#" null="#LEN(item[4]) eq 0#"/>
AND[nst_1_taxform]=<cfqueryparam value="#item[5]#" null="#LEN(item[5]) eq 0#"/>
AND[nst_1_resduedate]=<cfqueryparam value="#item[6]#" null="#LEN(item[6]) eq 0#"/>



</cfquery>
</cfcase>
</cfswitch>

<cfif fquery.recordcount gt 0 >
<cfset myResult='{"Result":"OK","check":"true"}'>
<cfelse>
<cfset myResult='{"Result":"OK","check":"false"}'>
</cfif>
<cfreturn myResult>

</cffunction>

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">


<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[n_id]
,[client_id]
,[n_name]
,[n_status]
,[n_name]
FROM[notice]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 --->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[nst_id]
      ,[nst_assignedto]
      ,[nst_deliverymethod]
      ,[nst_esttime]
      ,[nst_fees]
      ,[nst_missinginfo]
      ,CONVERT(VARCHAR(10),[nst_missinginforeceived], 1)AS[nst_missinginforeceived]
      ,[nst_status]
      ,[nst_paid]
      ,[nst_priority]
FROM[notice_subtask]
WHERE[nst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub1 --->
<cfcase value="group2_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT CONVERT(VARCHAR(10),[nst_1_datenoticerec], 101)AS[nst_1_datenoticerec]
	   ,[nst_1_methodreceived]
	   ,CONVERT(VARCHAR(10),[nst_1_noticedate], 101)AS[nst_1_noticedate]
	   ,[nst_1_noticenumber]
	   ,CONVERT(VARCHAR(10),[nst_1_resduedate], 101)AS[nst_1_resduedate]
	   ,[nst_1_taxform]
	   ,[nst_1_taxyear]
FROM[notice_subtask]
WHERE[nst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 sub2 --->
<cfcase value="group2_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT CONVERT(VARCHAR(10),[nst_2_irsstateresponse], 1)AS[nst_2_irsstateresponse]
	  ,CONVERT(VARCHAR(10),[nst_2_rescompleted], 1)AS[nst_2_rescompleted]
	  ,[nst_2_rescompletedby]
 	  ,CONVERT(VARCHAR(10),[nst_2_ressubmited], 1)AS[nst_2_ressubmited]      
	  ,[nst_2_revassignedto]
	  ,CONVERT(VARCHAR(10),[nst_2_revcompleted], 1)AS[nst_2_revcompleted]
	  ,CONVERT(VARCHAR(10),[nst_2_revrequired], 1)AS[nst_2_revrequired]  
FROM[notice_subtask]
WHERE[nst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Asset Credit Hold --->
<cfcase value="assetCreditHold">
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[n_id]
,[n_name]
,[n_status]
,[client_name]
,[client_id]
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id]
)
FROM[v_notice]
WHERE[n_status] != 2 AND [n_status] != 3
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&n_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&n_NAME&'"
								,"N_STATUSTEXT":"'&n_STATUSTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- Grid 2  --->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[n_id]
,[nst_id]
,[n_name]
,[nst_assignedtoTEXT]
,[nst_status]
,[nst_1_noticenumber]
,[nst_1_taxform]
,[nst_1_taxyear]
,[nst_1_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[nst_1_taxform]=[optionvalue_id])
,CONVERT(VARCHAR(10),[nst_1_resduedate], 1)AS[nst_1_resduedate]
,[nst_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[nst_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND ([nst_assignedtoTEXT]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> OR [nst_assignedtoTEXT]IS NULL)
AND [nst_status]!=2 AND [nst_status]!=3

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"NST_ID":"'&nst_id&'"
								,"N_NAME":"'&n_name&'"
								,"NST_ASSIGNEDTOTEXT":"'&nst_ASSIGNEDTOTEXT&'"
								,"NST_STATUSTEXT":"'&nst_STATUSTEXT&'"
								,"NST_1_TAXFORMTEXT":"'&nst_1_TAXFORMTEXT&'"
								,"NST_1_TAXYEAR":"'&nst_1_TAXYEAR&'"
								,"NST_1_RESDUEDATE":"'&nst_1_RESDUEDATE&'"
								,"NST_1_NOTICENUMBER":"'&nst_1_NOTICENUMBER&'"
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
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[notice](
[client_id]
,[n_name]
,[n_status]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[n_id]
</cfquery>
<!--- RETURN TR_ID--->
<cfreturn '{"id":#fquery.n_id#,"group":"group2","result":"ok"}'>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[notice]
SET
[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[n_name]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[n_status]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[n_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[notice_subtask](
[n_id]
,[nst_assignedto]
,[nst_deliverymethod]
,[nst_esttime]
,[nst_fees]
,[nst_missinginfo]
,[nst_missinginforeceived]
,[nst_status]
,[nst_paid]
,[nst_priority]
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
SELECT SCOPE_IDENTITY()AS[nst_id]
</cfquery>
<cfreturn '{"id":#fquery.nst_id#,"group":"group2_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[notice_subtask]
SET[nst_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[nst_deliverymethod]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[nst_esttime]=<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,[nst_fees]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[nst_missinginfo]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[nst_missinginforeceived]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[nst_status]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[nst_paid]=<cfqueryparam value="#j.DATA[1][10]#" NULL="#LEN(j.DATA[1][10]) eq 0#"/>
,[nst_priority]=<cfqueryparam value="#j.DATA[1][11]#" NULL="#LEN(j.DATA[1][11]) eq 0#"/>
WHERE[nst_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
</cfif>
</cfcase>


<!---Group2 Subgroup1 --->
<cfcase value="group2_1">
 <cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[notice_subtask]
SET[nst_1_noticenumber]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[nst_1_noticedate]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[nst_1_taxyear]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[nst_1_taxform]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[nst_1_methodreceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[nst_1_datenoticerec]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[nst_1_resduedate]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[nst_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
</cfcase>



<!---Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[notice_subtask]  
SET[nst_2_irsstateresponse]=<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0#"/>
,[nst_2_rescompleted]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[nst_2_rescompletedby]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[nst_2_ressubmited]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[nst_2_revassignedto]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[nst_2_revcompleted]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0#"/>
,[nst_2_revrequired]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[nst_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>

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
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[notice]
SET[n_active]=0
WHERE[n_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[notice_subtask]
SET[nst_active]=0
WHERE[nst_id]=<cfqueryparam value="#ARGUMENTS.id#">
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