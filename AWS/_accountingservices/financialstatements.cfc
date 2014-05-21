<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="true">
<cfargument name="selectName" type="string">
<cfargument name="formid" type="string" default="">
<cfargument name="option1" type="numeric" default="0">

<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT[optionname]=CONVERT(char(4),fds_year) +' | '+ ISNULL(FORMAT(fds_periodend,'d','en-us'),'---N/A---') +' | '+ (SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='0'OR[form_id]='0')AND([optionGroup]='0'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id]),[fds_id]AS[optionvalue_id]
FROM[financialdatastatus]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.option1#" cfsqltype="cf_sql_integer">
ORDER BY[fds_year]DESC,[fds_periodend]

</cfquery>
<cfset myResult="">
<cfset queryResult='{"optionvalue_id":"0","optionname":"&nbsp;"},'>
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"optionvalue_id":"'&optionvalue_id&'","optionname":"'&optionname&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cffunction>

<!--- dupe chk--->
<cffunction name="f_duplicateCheck" access="remote" output="true">
<cfargument name="check" type="string">
<cfargument name="loadType" type="string">

<cfswitch expression="#ARGUMENTS.loadType#">
<cfcase value="group1">
<cfset i=0>
<!--- Client, Year, Period, Period End--->
<cfloop list="#ARGUMENTS.check#" index="s" delimiters=",">
<cfset i=i+1>
<cfset item[i]=s>
</cfloop>
<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT TOP(1)[client_id]
FROM[financialdatastatus]
WHERE[client_id]=<cfqueryparam value="#item[1]#">
AND[fds_year]=<cfqueryparam value="#item[2]#">
AND[fds_month]=<cfqueryparam value="#item[3]#">
AND[fds_periodend]=<cfqueryparam value="#item[4]#">
</cfquery>
</cfcase>
</cfswitch>
<cfif fquery.recordcount gt 0>
<cfset myResult='{"Result":"OK","check":"true"}'>
<cfelse>
<cfset myResult='{"Result":"OK","check":"false"}'>
</cfif>
<cfreturn myResult>
</cffunction>

<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_id]
,[client_id]
,[fds_cmireceived]=FORMAT(fds_cmireceived,'d','#Session.localization.language#') 
,[fds_compilemi]
,[fds_deliverymethod]
,[fds_duedate]=FORMAT(fds_duedate,'d','#Session.localization.language#') 
,[fds_esttime]
,[fds_fees]
,[fds_missinginforeceived]=FORMAT(fds_missinginforeceived,'d','#Session.localization.language#') 
,[fds_missinginfo]
,[fds_month]
,[fds_paid]
,[fds_periodend]=FORMAT(fds_periodend,'d','#Session.localization.language#') 
,[fds_priority]
,[fds_status]
,[fds_year]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_obtaininfo_assignedto]
,[fds_obtaininfo_completedby]
,[fds_obtaininfo_datecompleted]=FORMAT(fds_obtaininfo_datecompleted,'d','#Session.localization.language#') 
,[fds_obtaininfo_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_sort_assignedto]
,[fds_sort_completedby]
,[fds_sort_datecompleted]=FORMAT(fds_sort_datecompleted,'d','#Session.localization.language#') 
,[fds_sort_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_checks_assignedto]
,[fds_checks_completedby]
,[fds_checks_datecompleted]=FORMAT(fds_checks_datecompleted,'d','#Session.localization.language#') 
,[fds_checks_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_sales_assignedto]
,[fds_sales_completedby]
,[fds_sales_datecompleted]=FORMAT(fds_sales_datecompleted,'d','#Session.localization.language#') 
,[fds_sales_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_entry_assignedto]
,[fds_entry_completedby]
,[fds_entry_datecompleted]=FORMAT(fds_entry_datecompleted,'d','#Session.localization.language#') 
,[fds_entry_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup6 --->
<cfcase value="group1_6">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_reconcile_assignedto]
,[fds_reconcile_completedby]
,[fds_reconcile_datecompleted]=FORMAT(fds_reconcile_datecompleted,'d','#Session.localization.language#') 
,[fds_reconcile_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup7 --->
<cfcase value="group1_7">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_compile_assignedto]
,[fds_compile_completedby]
,[fds_compile_datecompleted]=FORMAT(fds_compile_datecompleted,'d','#Session.localization.language#') 
,[fds_compile_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup8 --->
<cfcase value="group1_8">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_review_assignedto]
,[fds_review_completedby]
,[fds_review_datecompleted]=FORMAT(fds_review_datecompleted,'d','#Session.localization.language#') 
,[fds_review_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup9 --->
<cfcase value="group1_9">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_assembly_assignedto]
,[fds_assembly_completedby]
,[fds_assembly_datecompleted]=FORMAT(fds_assembly_datecompleted,'d','#Session.localization.language#') 
,[fds_assembly_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup10 --->
<cfcase value="group1_10">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_delivery_assignedto]
,[fds_delivery_completedby]
,[fds_delivery_datecompleted]=FORMAT(fds_delivery_datecompleted,'d','#Session.localization.language#') 
,[fds_delivery_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup11 --->
<cfcase value="group1_11">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fds_acctrpt_assignedto]
,[fds_acctrpt_completedby]
,[fds_acctrpt_datecompleted]=FORMAT(fds_acctrpt_datecompleted,'d','#Session.localization.language#') 
,[fds_acctrpt_esttime]
FROM[financialdatastatus]
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group 2--->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[fdss_id]
,[fdss_assignedto]
,[fdss_completed]=FORMAT(fdss_completed,'d','#Session.localization.language#') 
,[fdss_duedate]=FORMAT(fdss_duedate,'d','#Session.localization.language#') 
,[fdss_notes]
,[fdss_sequence]
,[fdss_status]
,[fdss_subtask]
,[fdss_dependencies]
,[fdss_esttime]
,[fdss_actualtime]
FROM[financialdatastatus_subtask]
WHERE[fdss_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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

<!--- Asset GUI Completed Tasks--->
<cfcase value="assetCompTask">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT
[fds_obtaininfo_datecompleted]=FORMAT(fds_obtaininfo_datecompleted,'d','#Session.localization.language#')
,[fds_obtaininfo_assignedtoTEXT]
,[fds_sort_datecompleted]=FORMAT(fds_sort_datecompleted,'d','#Session.localization.language#') 
,[fds_sort_assignedtoTEXT]
,[fds_checks_datecompleted]=FORMAT(fds_checks_datecompleted,'d','#Session.localization.language#') 
,[fds_checks_assignedtoTEXT]
,[fds_sales_datecompleted]=FORMAT(fds_sales_datecompleted,'d','#Session.localization.language#') 
,[fds_sales_assignedtoTEXT]
,[fds_entry_datecompleted]=FORMAT(fds_entry_datecompleted,'d','#Session.localization.language#') 
,[fds_entry_assignedtoTEXT]
,[fds_reconcile_datecompleted]=FORMAT(fds_reconcile_datecompleted,'d','#Session.localization.language#') 
,[fds_reconcile_assignedtoTEXT]
,[fds_compile_datecompleted]=FORMAT(fds_compile_datecompleted,'d','#Session.localization.language#') 
,[fds_compile_assignedtoTEXT]
,[fds_review_datecompleted]=FORMAT(fds_review_datecompleted,'d','#Session.localization.language#') 
,[fds_review_assignedtoTEXT]
,[fds_assembly_datecompleted]=FORMAT(fds_assembly_datecompleted,'d','#Session.localization.language#') 
,[fds_assembly_assignedtoTEXT]
,[fds_delivery_datecompleted]=FORMAT(fds_delivery_datecompleted,'d','#Session.localization.language#') 
,[fds_delivery_assignedtoTEXT]
,[fds_acctrpt_datecompleted]=FORMAT(fds_acctrpt_datecompleted,'d','#Session.localization.language#') 
,[fds_acctrpt_assignedtoTEXT]
FROM[v_financialdatastatus]
WHERE[FDS_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<cfcase value="assetClone2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT CONVERT(char(4),fds_year)+' | '+ISNULL(FORMAT(fds_periodend,'d','#Session.localization.language#'),'------N/A-----')+' | '+(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='0'OR[form_id]='#ARGUMENTS.formid#')AND([optionGroup]='0'OR[optionGroup]='#ARGUMENTS.formid#')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id]),[fds_id]AS[optionvalue_id]
FROM[financialdatastatus]
ORDER BY [fds_Year] DESC ,[fds_periodend]
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
<cfargument name="clientid" type="numeric" required="no">
<cfargument name="formid" type="numeric" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,[fds_periodend]=FORMAT(fds_periodend,'d','#Session.localization.language#') 
,[fds_missinginfo]
,[fds_compilemi]
,[fds_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id])
,[fds_priority]
,[fds_duedate]=FORMAT(fds_duedate,'d','#Session.localization.language#')    
,[fds_esttime]
,[fds_month]
,[fds_year]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='5'OR[form_id]='0')AND([optionGroup]='5'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])

FROM[v_financialDataStatus]
WHERE ISNULL([fds_status],0) != 2 
AND ISNULL([fds_status],0) != 3
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, fds_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_PERIODEND":"'&FDS_PERIODEND&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_STATUSTEXT":"'&FDS_STATUSTEXT&'"
								,"FDS_PRIORITY":"'&FDS_PRIORITY&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_ESTTIME":"'&FDS_ESTTIME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2 --->
<cfcase value="group2"><cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[fdss_id]
,[fdss_subtaskTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialstatmentsubtask'AND[fdss_subtask]=[optionvalue_id])
,[fdss_assignedtoTEXT]
,[fdss_duedate]=FORMAT(fdss_duedate,'d','#Session.localization.language#')
,[fdss_sequence]
,[fdss_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fdss_status]=[optionvalue_id])
,[fdss_subtask]
FROM[v_financialDataStatus_Subtask]
WHERE ISNULL([fdss_status],0) != 2 
AND ISNULL([fdss_status],0) != 3
AND[fds_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>



<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[fdss_subtaskTEXT]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDSS_ID":"'&FDSS_ID&'"
								,"FDSS_SEQUENCE":"'&FDSS_SEQUENCE&'"
								,"FDSS_SUBTASKTEXT":"'&FDSS_SUBTASKTEXT&'"
								,"FDSS_DUEDATE":"'&FDSS_DUEDATE&'"
								,"FDSS_STATUSTEXT":"'&FDSS_STATUSTEXT&'"
								,"FDSS_ASSIGNEDTOTEXT":"'&FDSS_ASSIGNEDTOTEXT&'"
								}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[financialdatastatus](
[client_id]
,[fds_cmireceived]
,[fds_compilemi]
,[fds_deliverymethod]
,[fds_duedate]
,[fds_esttime]
,[fds_fees]
,[fds_missinginforeceived]
,[fds_missinginfo]
,[fds_month]
,[fds_paid]
,[fds_periodend]
,[fds_priority]
,[fds_status]
,[fds_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN FDS_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group1_1","result":"ok"}'>

<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cftry>

<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_cmireceived]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_compilemi]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_deliverymethod]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[fds_duedate]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[fds_esttime]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[fds_fees]=<cfqueryparam value="#j.DATA[1][8]#"  null="#LEN(j.DATA[1][8]) eq 0#"/>
,[fds_missinginforeceived]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[fds_missinginfo]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[fds_month]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[fds_paid]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[fds_periodend]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[fds_priority]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[fds_status]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[fds_year]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>

<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>

<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_sort_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_sort_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_sort_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_sort_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_checks_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_checks_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_checks_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_checks_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_sales_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_sales_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_sales_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_sales_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup5 --->
<cfcase value="group1_5">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_entry_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_entry_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_entry_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_entry_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_6","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup6 --->
<cfcase value="group1_6">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_reconcile_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_reconcile_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_reconcile_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_reconcile_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_7","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup7 --->
<cfcase value="group1_7">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_compile_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_compile_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_compile_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_compile_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_8","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup8 --->
<cfcase value="group1_8">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_9","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup9 --->
<cfcase value="group1_9">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_10","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup10 --->
<cfcase value="group1_10">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_11","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group1 Subgroup11 --->
<cfcase value="group1_11">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus]
SET[fds_acctrpt_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fds_acctrpt_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[fds_acctrpt_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[fds_acctrpt_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfcase>

<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[financialdatastatus_subtask]([fds_id]
,[fdss_assignedto]
,[fdss_completed]
,[fdss_duedate]
,[fdss_notes]
,[fdss_sequence]
,[fdss_status]
,[fdss_subtask]
,[fdss_dependencies]
,[fdss_esttime]
,[fdss_actualtime]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0 or j.DATA[1][3] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0 or j.DATA[1][8] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0  or j.DATA[1][8] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][10]#" NULL="#j.DATA[1][10] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[financialdatastatus_subtask]
SET[fds_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[fdss_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0 or j.DATA[1][3] eq "null"#"/>
,[fdss_completed]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[fdss_duedate]=<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,[fdss_notes]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#LEN(j.DATA[1][6]) eq 0#"/>
,[fdss_sequence]=<cfqueryparam value="#j.DATA[1][7]#" NULL="#LEN(j.DATA[1][7]) eq 0#"/>
,[fdss_status]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#LEN(j.DATA[1][8]) eq 0 or j.DATA[1][8] eq "null"#"/>
,[fdss_subtask]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#LEN(j.DATA[1][9]) eq 0  or j.DATA[1][8] eq "null"#"/>
,[fdss_dependencies]=<cfqueryparam value="#j.DATA[1][10]#" NULL="#j.DATA[1][10] eq "null"#"/>
,[fdss_esttime]=<cfqueryparam value="#j.DATA[1][11]#" NULL="#j.DATA[1][11] eq "null"#"/>
,[fdss_actualtime]=<cfqueryparam value="#j.DATA[1][12]#" NULL="#j.DATA[1][12] eq "null"#"/>
WHERE[fdss_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][2]#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>
</cfcatch>
</cftry>
</cfif>
</cfcase>

<!--- Group2_Clone1 --->
<cfcase value="group2_clone1">
<!--- if this is a new record, then insert it--->

<cfquery name="aquery" datasource="#Session.organization.name#">
SELECT TOP(1)[option_1]FROM[ctrl_selectOptions]WHERE[selectName_id]='3'AND[optionValue_id]=<cfqueryparam value="#j.DATA[1][3]#"/>
</cfquery>
<cfquery name="fquery" datasource="#Session.organization.name#">
<cfset indexNumber=0>
<cfloop index="i" list="#aquery.option_1#">
<cfset indexNumber = indexNumber + 1 >
INSERT INTO[financialdatastatus_subtask]([fds_id],[fdss_sequence],[fdss_subtask],[fdss_status])VALUES(<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>,<cfqueryparam value="#indexNumber#"/>,<cfqueryparam value="#i#"/>,<cfqueryparam value="4"/>)
</cfloop>
SELECT SCOPE_IDENTITY()AS[fds_id]
</cfquery>
<cfreturn '{"id":"#fquery.fds_id#","group":"saved","result":"ok"}'>

</cfcase>

<!--- Group2_Clone2 --->
<cfcase value="group2_clone2">
<!--- if this is a new record, then insert it--->


<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO [financialDataStatus_Subtask]([fds_id],[fdss_sequence],[fdss_subtask],[fdss_dependencies])
SELECT <cfqueryparam value="#j.DATA[1][1]#">,[fdss_sequence],[fdss_subtask],[fdss_dependencies]
FROM[financialDataStatus_Subtask]
WHERE[fds_id]=<cfqueryparam value="#j.DATA[1][2]#" />
AND[fdss_active]!=0

</cfquery>
<cfreturn '{"id":"#j.DATA[1][1]#","group":"saved","result":"ok"}'>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":"#cfcatch.message# - #cfcatch.detail#","result":"error"}'>

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
update[financialdatastatus]
SET[fds_active]=0
WHERE[fds_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group1","result":"ok"}'>
</cfcase>
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[financialdatastatus_subtask]
SET[fdss_active]=0
WHERE[fdss_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group2","result":"ok"}'>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>