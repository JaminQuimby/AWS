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
FROM[otherfilings]
WHERE[client_id]=<cfqueryparam value="#item[1]#">
AND[of_taxyear]=<cfqueryparam value="#item[2]#">
AND[of_period]=<cfqueryparam value="#item[3]#">
AND[of_state]=<cfqueryparam value="#item[4]#">
AND[of_type]=<cfqueryparam value="#item[5]#">
AND[of_form]=<cfqueryparam value="#item[6]#">
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


<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="true">
<cfargument name="selectName" type="string">
<cfargument name="formid" type="string" default="11">
<cfargument name="option1" type="string" default="">

<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT '0'AS[optionvalue_id],'&nbsp 'AS[optionname]UNION
SELECT[optionvalue_id],[optionname]
FROM[v_selectOptions]
WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND([optionHide]!='#ARGUMENTS.formid#'OR[optionHide]IS NULL)AND[selectName]='#ARGUMENTS.selectName#'
AND[option_1]='#ARGUMENTS.option1#'

</cfquery>


<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"optionvalue_id":"'&optionvalue_id&'","optionname":"'&optionname&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
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
SELECT[OF_ID]
,[client_id]
,[of_deliverymethod]
,[of_duedate]=FORMAT(of_duedate,'d','#Session.localization.language#') 
,[of_esttime]
,[of_extensioncompleted]=FORMAT(of_extensioncompleted,'d','#Session.localization.language#') 
,[of_extensiondeadline]=FORMAT(of_extensiondeadline,'d','#Session.localization.language#') 
,[of_fees]
,[of_filingdeadline]=FORMAT(of_filingdeadline,'d','#Session.localization.language#') 
,[of_form]
,[of_informationreceived]=FORMAT(of_informationreceived,'d','#Session.localization.language#') 
,[of_missinginforeceived]=FORMAT(of_missinginforeceived,'d','#Session.localization.language#') 
,[of_missinginfo]
,[of_paid]
,[of_period]
,[of_priority]
,[of_state]
,[of_status]
,[of_type]
,[of_taxyear]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group 1 State--->
<cfcase value="group1_state">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_state]
FROM[v_otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_obtaininfo_assignedto]
,[of_obtaininfo_completedby]
,[of_obtaininfo_datecompleted]=FORMAT(of_obtaininfo_datecompleted,'d','#Session.localization.language#') 
,[of_obtaininfo_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_preparation_assignedto]
,[of_preparation_completedby]
,[of_preparation_datecompleted]=FORMAT(of_preparation_datecompleted,'d','#Session.localization.language#') 
,[of_preparation_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_review_assignedto]
,[of_review_completedby]
,[of_review_datecompleted]=FORMAT(of_review_datecompleted,'d','#Session.localization.language#') 
,[of_review_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_assembly_assignedto]
,[of_assembly_completedby]
,[of_assembly_datecompleted]=FORMAT(of_assembly_datecompleted,'d','#Session.localization.language#') 
,[of_assembly_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[of_delivery_assignedto]
,[of_delivery_completedby]
,[of_delivery_datecompleted]=FORMAT(of_delivery_datecompleted,'d','#Session.localization.language#') 
,[of_delivery_esttime]
FROM[otherfilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
SELECT[of_obtaininfo_datecompleted]=FORMAT(of_obtaininfo_datecompleted,'d','#Session.localization.language#')
,[of_obtaininfo_completedbyTEXT]
,[of_preparation_datecompleted]=FORMAT(of_preparation_datecompleted,'d','#Session.localization.language#')
,[of_preparation_completedbyTEXT]
,[of_review_datecompleted]=FORMAT(of_review_datecompleted,'d','#Session.localization.language#')
,[of_review_completedbyTEXT]
,[of_assembly_datecompleted]=FORMAT(of_assembly_datecompleted,'d','#Session.localization.language#')
,[of_assembly_completedbyTEXT]
,[of_delivery_datecompleted]=FORMAT(of_delivery_datecompleted,'d','#Session.localization.language#')
,[of_delivery_completedbyTEXT]
FROM[v_otherfilings]
WHERE[OF_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
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
<!--- LOOKUP Other Filings --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[of_id]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_type]
,[of_form]
,[of_period]
,[of_obtaininfo_assignedto]
,[of_preparation_assignedto]
,[of_review_assignedto]
,[of_assembly_assignedto]
,[of_delivery_assignedto]
,[of_duedate]=FORMAT(of_duedate,'d','#Session.localization.language#') 
,[of_informationreceived]=FORMAT(of_informationreceived,'d','#Session.localization.language#') 
,[of_missinginfo]
,[of_missinginforeceived]=FORMAT(of_missinginforeceived,'d','#Session.localization.language#') 
,[of_filingdeadline]=FORMAT(of_filingdeadline,'d','#Session.localization.language#') 
,[client_name]
,[client_id]
,[of_obtaininfo_datecompleted]=ISNULL(FORMAT(of_obtaininfo_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_obtaininfo_assignedtoTEXT]
,[of_preparation_datecompleted]=ISNULL(FORMAT(of_preparation_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_preparation_assignedtoTEXT]
,[of_review_datecompleted]=ISNULL(FORMAT(of_review_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_review_assignedtoTEXT]
,[of_assembly_datecompleted]=ISNULL(FORMAT(of_assembly_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_assembly_assignedtoTEXT]
,[of_delivery_datecompleted]=ISNULL(FORMAT(of_delivery_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_delivery_assignedtoTEXT] 
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_type]=[optionvalue_id])
,[of_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_state]=[optionvalue_id])
,[of_periodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])

FROM[v_otherfilings]
WHERE[of_status] != 2 
AND [of_status] != 3
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, of_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"								
								,"OF_PERIODTEXT":"'&OF_PERIODTEXT&'"
								,"OF_STATETEXT":"'&OF_STATETEXT&'"
								,"OF_TYPETEXT":"'&OF_TYPETEXT&'"
								,"OF_FORMTEXT":"'&OF_FORMTEXT&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"						
								,"OF_STATUSTEXT":"'&OF_STATUSTEXT&'"
								,"OF_FILINGDEADLINE":"'&OF_FILINGDEADLINE&'"
 								,"OF_INFORMATIONRECEIVED":"'&OF_INFORMATIONRECEIVED&'"								
 								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
 								,"OF_MISSINGINFORECEIVED":"'&OF_MISSINGINFORECEIVED&'"								
								,"OF_OBTAININFO":"'&of_obtaininfo_datecompleted&'<br/>'&of_obtaininfo_assignedtoTEXT&'"
								,"OF_PREPARATION":"'&of_preparation_datecompleted&'<br/>'&of_preparation_assignedtoTEXT&'"
								,"OF_REVIEW":"'&of_review_datecompleted&'<br/>'&of_review_assignedtoTEXT&'"
								,"OF_ASSEMBLY":"'&of_assembly_datecompleted&'<br/>'&of_assembly_assignedtoTEXT&'"
								,"OF_DELIVERY":"'&of_delivery_datecompleted&'<br/>'&of_delivery_assignedtoTEXT&'"								
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][13])><cfset j.DATA[1][13]=1><cfelse><cfset j.DATA[1][13]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[otherfilings](
[client_id]
,[of_deliverymethod]
,[of_duedate]
,[of_esttime]
,[of_extensioncompleted]
,[of_extensiondeadline]
,[of_fees]
,[of_filingdeadline]
,[of_form]
,[of_informationreceived]
,[of_missinginforeceived]
,[of_missinginfo]
,[of_paid]
,[of_period]
,[of_priority]
,[of_state]
,[of_status]
,[of_type]
,[of_taxyear]
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
,<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][18]#" null="#LEN(j.DATA[1][18]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][19]#" null="#LEN(j.DATA[1][19]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][20]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN OF_ID--->
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
UPDATE[otherfilings]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_deliverymethod]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_duedate]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[of_extensioncompleted]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[of_extensiondeadline]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[of_fees]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[of_filingdeadline]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[of_form]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[of_informationreceived]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[of_missinginforeceived]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[of_missinginfo]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[of_paid]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[of_period]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[of_priority]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
,[of_state]=<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#"/>
,[of_status]=<cfqueryparam value="#j.DATA[1][18]#" null="#LEN(j.DATA[1][18]) eq 0#"/>
,[of_type]=<cfqueryparam value="#j.DATA[1][19]#" null="#LEN(j.DATA[1][19]) eq 0#"/>
,[of_taxyear]=<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][20]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[otherfilings]
SET[of_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[OTHERFILINGS]
SET[of_preparation_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_preparation_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_preparation_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_preparation_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[otherfilings]
SET[of_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[otherfilings]
SET[of_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
</cfcase>
<cfcase value="group1_5">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[otherfilings]
SET[of_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[of_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[of_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[of_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[of_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
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
update[otherfilings]
SET[of_active]=0
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.id#">
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