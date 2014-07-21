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
<!--- Client, Year, Period, Period End--->
<cfloop list="#ARGUMENTS.check#" index="s" delimiters=",">
<cfset i=i+1>
<cfset item[i]=s>
</cfloop>

<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT TOP(1)[client_id]
FROM[payrolltaxes]
WHERE[client_id]=<cfqueryparam value="#item[1]#">
AND[pt_year]=<cfqueryparam value="#item[2]#">
AND[pt_month]=<cfqueryparam value="#item[3]#">
AND[pt_lastpay]=<cfqueryparam value="#item[4]#">
AND[pt_type]=<cfqueryparam value="#item[5]#">
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
<!--- LOAD DATA --->

<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[PT_ID]
,[client_id]
,[pt_deliverymethod]
,[pt_duedate]=FORMAT(pt_duedate,'#Session.localization.formatdate#')
,[pt_esttime]
,[pt_fees]=FORMAT(pt_fees,'C','#Session.localization.language#')
,[pt_lastpay]=FORMAT(pt_lastpay,'#Session.localization.formatdate#')
,[pt_missinginfo]
,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#')
,[pt_month]
,[pt_paid]
,[pt_priority]
,[pt_state]
,[pt_type]
,[pt_year]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_obtaininfo_assignedto]
,[pt_obtaininfo_completedby]
,[pt_obtaininfo_datecompleted]=FORMAT(pt_obtaininfo_datecompleted,'#Session.localization.formatdate#')
,[pt_obtaininfo_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_entry_assignedto]
,[pt_entry_completedby]
,[pt_entry_datecompleted]=FORMAT(pt_entry_datecompleted,'#Session.localization.formatdate#')
,[pt_entry_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_rec_assignedto]
,[pt_rec_completedby]
,[pt_rec_datecompleted]=FORMAT(pt_rec_datecompleted,'#Session.localization.formatdate#')
,[pt_rec_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_review_assignedto]
,[pt_review_completedby]
,[pt_review_datecompleted]=FORMAT(pt_review_datecompleted,'#Session.localization.formatdate#')
,[pt_review_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_assembly_assignedto]
,[pt_assembly_completedby]
,[pt_assembly_datecompleted]=FORMAT(pt_assembly_datecompleted,'#Session.localization.formatdate#')
,[pt_assembly_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup6 --->
<cfcase value="group1_6">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pt_delivery_assignedto]
,[pt_delivery_completedby]
,[pt_delivery_datecompleted]=FORMAT(pt_delivery_datecompleted,'#Session.localization.formatdate#')
,[pt_delivery_esttime]
FROM[payrolltaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
SELECT[pt_obtaininfo_datecompleted]=FORMAT(pt_obtaininfo_datecompleted,'#Session.localization.formatdate#')
,[pt_obtaininfo_completedbyTEXT]
,[pt_entry_datecompleted]=FORMAT(pt_entry_datecompleted,'#Session.localization.formatdate#')
,[pt_entry_completedbyTEXT]
,[pt_rec_datecompleted]=FORMAT(pt_rec_datecompleted,'#Session.localization.formatdate#')
,[pt_rec_completedbyTEXT]
,[pt_review_datecompleted]=FORMAT(pt_review_datecompleted,'#Session.localization.formatdate#')
,[pt_review_completedbyTEXT]
,[pt_assembly_datecompleted]=FORMAT(pt_assembly_datecompleted,'#Session.localization.formatdate#')
,[pt_assembly_completedbyTEXT]
,[pt_delivery_datecompleted]=FORMAT(pt_delivery_datecompleted,'#Session.localization.formatdate#')
,[pt_delivery_completedbyTEXT]
FROM[v_payrolltaxes]
WHERE[PT_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<cfargument name="form_id" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pt_id]
		,[pt_year]
		,[pt_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[pt_state]=[optionvalue_id])
		,[pt_duedate]=FORMAT(pt_duedate,'#Session.localization.formatdate#') 
		,[pt_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[pt_month]=[optionvalue_id])
		,[pt_lastpay]=FORMAT(pt_lastpay,'#Session.localization.formatdate#') 
		,[pt_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_returntypes'AND[pt_type]=[optionvalue_id])
		,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#') 
		,[pt_obtaininfo_datecompleted]=ISNULL(FORMAT(pt_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_obtaininfo_assignedtoTEXT]
		,[pt_entry_datecompleted]=ISNULL(FORMAT(pt_entry_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_entry_assignedtoTEXT]
		,[pt_rec_datecompleted]=ISNULL(FORMAT(pt_rec_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_rec_assignedtoTEXT]
		,[pt_review_datecompleted]=ISNULL(FORMAT(pt_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_review_assignedtoTEXT]
		,[pt_assembly_datecompleted]=ISNULL(FORMAT(pt_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_assembly_assignedtoTEXT]
		,[pt_delivery_datecompleted]=ISNULL(FORMAT(pt_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
		,[pt_delivery_assignedtoTEXT]
		,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#')
	 	,[pt_missinginfo]
		,[client_name]
	,[client_id]
FROM[v_payrolltaxes]
WHERE[pt_delivery_datecompleted] IS NULL
AND [deleted] IS NULL
AND [client_active]=(1)
AND [pt_active]=(1)
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, pt_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"PT_YEAR":"'&PT_YEAR&'"
									,"PT_MONTHTEXT":"'&PT_MONTHTEXT&'"
									,"PT_STATETEXT":"'&PT_STATETEXT&'"
									,"PT_TYPETEXT":"'&PT_TYPETEXT&'"
 									,"PT_LASTPAY":"'&PT_LASTPAY&'"
  									,"PT_DUEDATE":"'&PT_DUEDATE&'"
	 								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
	 								,"PT_MISSINGINFORECEIVED":"'&PT_MISSINGINFORECEIVED&'"
									,"PT_OBTAININFO":"'&pt_obtaininfo_datecompleted&'<br/>'&pt_obtaininfo_assignedtoTEXT&'"
									,"PT_ENTRY":"'&pt_entry_datecompleted&'<br/>'&pt_entry_assignedtoTEXT&'"
									,"PT_REC":"'&pt_rec_datecompleted&'<br/>'&pt_rec_assignedtoTEXT&'"
									,"PT_REVIEW":"'&pt_review_datecompleted&'<br/>'&pt_review_assignedtoTEXT&'"
									,"PT_ASSEMBLY":"'&pt_assembly_datecompleted&'<br/>'&pt_assembly_assignedtoTEXT&'"
									,"PT_DELIVERY":"'&pt_delivery_datecompleted&'<br/>'&pt_delivery_assignedtoTEXT&'"
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[payrolltaxes](
[client_id]
,[pt_deliverymethod]
,[pt_duedate]
,[pt_esttime]
,[pt_fees]
,[pt_lastpay]
,[pt_missinginfo]
,[pt_missinginforeceived]
,[pt_month]
,[pt_paid]
,[pt_priority]
,[pt_state]
,[pt_type]
,[pt_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#"null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#"null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#"null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#"null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
) 
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN PT_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group1_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pt_deliverymethod]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_duedate]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[pt_fees]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[pt_lastpay]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[pt_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[pt_missinginforeceived]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[pt_month]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[pt_paid]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[pt_priority]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[pt_state]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[pt_type]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[pt_year]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[pt_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_entry_assignedto]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[pt_entry_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_entry_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_entry_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_rec_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pt_rec_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_rec_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_rec_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pt_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup5 --->
<cfcase value="group1_5">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pt_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_6","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup6 --->
<cfcase value="group1_6">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrolltaxes]
SET[pt_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pt_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pt_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pt_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[pt_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>

<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[payrolltaxes]
SET[deleted]=GETDATE()
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.id#">
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