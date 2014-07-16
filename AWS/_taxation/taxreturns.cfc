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
<!--- Client, Tax Year, Tax Form --->
<cfloop list="#ARGUMENTS.check#" index="s" delimiters=",">
<cfset i=i+1>
<cfset item[i]=s>
</cfloop>

<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT TOP(1)[client_id]
FROM[taxreturns]
WHERE[client_id]=<cfqueryparam value="#item[1]#">
AND[tr_taxyear]=<cfqueryparam value="#item[2]#">
AND[tr_taxform]=<cfqueryparam value="#item[3]#">
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
<cfargument name="formid" type="string" default="6">
<cfargument name="option1" type="string" default="6">

<cfquery datasource="#Session.organization.name#" name="fquery" >
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



<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[tr_id]
,[client_id]
,[tr_currentfees]
,[tr_duedate]=FORMAT(tr_duedate,'#Session.localization.formatdate#')
,[tr_esttime]
,[tr_extensiondone]=FORMAT(tr_extensiondone,'#Session.localization.formatdate#')
,[tr_extensionrequested]=FORMAT(tr_extensionrequested,'#Session.localization.formatdate#')
,[tr_filingdeadline]=FORMAT(tr_filingdeadline,'#Session.localization.formatdate#')
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'#Session.localization.formatdate#')
,[tr_missinginfo]
,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'#Session.localization.formatdate#')
,[tr_notrequired]
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
,[tr_3_multistatereturn]
,[tr_credithold]
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT [tr_1_dropoffappointment]=FORMAT(tr_1_dropoffappointment,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[tr_1_dropoffappointmentlength] 
,[tr_1_dropoffappointmentwith] 
,[tr_1_pickupappointment]=FORMAT(tr_1_pickupappointment,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[tr_1_pickupappointmentlength]
,[tr_1_pickupappointmentwith]
,[tr_1_whileyouwaitappt]
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[tr_2_assignedto]
,[tr_2_preparedby] 
,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'#Session.localization.formatdate#')
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[tr_2_completed]=FORMAT(tr_2_completed,'#Session.localization.formatdate#')
,[tr_2_reviewassignedto]
,[tr_2_reviewed]=FORMAT(tr_2_reviewed,'#Session.localization.formatdate#')
,[tr_2_reviewedby] 
,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'#Session.localization.formatdate#')
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT [tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'#Session.localization.formatdate#')
,[tr_3_contacted]=FORMAT(tr_3_contacted,'#Session.localization.formatdate#')
,[tr_3_delivered]=FORMAT(tr_3_delivered,'#Session.localization.formatdate#')
,[tr_3_emailed]
,[tr_3_messageleft] 
,[tr_3_missingsignatures] 
,[tr_deliverymethod] 
,[tr_paid] 
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[tr_4_assignedto] 
,[tr_4_completed]=FORMAT(tr_4_completed,'#Session.localization.formatdate#')
,[tr_4_completedby] 
,[tr_4_currentfees]
,[tr_4_delivered]=FORMAT(tr_4_delivered,'#Session.localization.formatdate#')
,[tr_4_extended]=FORMAT(tr_4_extended,'#Session.localization.formatdate#')
,[tr_4_extensionrequested]=FORMAT(tr_4_extensionrequested,'#Session.localization.formatdate#')
,[tr_4_paid] 
,[tr_4_pptresttime] 
,[tr_4_priorfees] 
,[tr_4_required] 
,[tr_4_reviewassigned]
,[tr_4_reviewed]
,[tr_4_reviewedby]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'#Session.localization.formatdate#')
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group 2--->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[trst_id]
,[trst_assignedto]
,[trst_completed]=FORMAT(trst_completed,'#Session.localization.formatdate#') 
,[trst_primary]
,[trst_reviewassignedto]
,[trst_state]
,[trst_status]
,[trst_requiredforms]
FROM[v_taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group 2 State--->
<cfcase value="group2_state">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[trst_state]
FROM[v_taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group2 Subgroup1 --->
<cfcase value="group2_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT [trst_1_assignedto]
,[trst_1_completed]=FORMAT(trst_1_completed,'#Session.localization.formatdate#') 
,[trst_1_duedate]=FORMAT(trst_1_duedate,'#Session.localization.formatdate#') 
,[trst_1_informationreceived]=FORMAT(trst_1_informationreceived,'#Session.localization.formatdate#') 
,[trst_1_missinginforeceived]=FORMAT(trst_1_missinginforeceived,'#Session.localization.formatdate#') 
,[trst_1_missinginfo]
,[trst_1_preparedby]
,[trst_1_readyforreview]=FORMAT(trst_1_readyforreview,'#Session.localization.formatdate#') 
,[trst_1_reviewassignedto]
,[trst_1_reviewed]=FORMAT(trst_1_reviewed,'#Session.localization.formatdate#') 
,[trst_1_reviewedby]
,[trst_1_reviewedwithnotes]=FORMAT(trst_1_reviewedwithnotes,'#Session.localization.formatdate#') 
FROM[v_taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT  [trst_2_assemblereturn]=FORMAT(trst_2_assemblereturn,'#Session.localization.formatdate#') 
,[trst_2_contacted]=FORMAT(trst_2_contacted,'#Session.localization.formatdate#') 
,[trst_2_currentfees]
,[trst_2_delivered]=FORMAT(trst_2_delivered,'#Session.localization.formatdate#') 
,[trst_2_deliverymethod]
,[trst_2_emailed]
,[trst_2_messageleft]
,[trst_2_missingsignatures]
,[trst_2_paid]
,[trst_2_priorfees]

FROM[v_taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 Subgroup3 --->
<cfcase value="group2_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[trst_3_pptrassignedto]
,[trst_3_pptrcompleted]=FORMAT(trst_3_pptrcompleted,'#Session.localization.formatdate#') 
,[trst_3_pptrcurrentfees]
,[trst_3_pptrdelivered]=FORMAT(trst_3_pptrdelivered,'#Session.localization.formatdate#') 
,[trst_3_pptrextended]=FORMAT(trst_3_pptrextended,'#Session.localization.formatdate#') 
,[trst_3_paid]
,[trst_3_pptrpriorfees]
,[trst_3_pptrrequired]
,[trst_3_pptrrfr]=FORMAT(trst_3_pptrrfr,'#Session.localization.formatdate#') 
FROM[v_taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group 3--->
<cfcase value="group3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[trsc_id]
,[trsc_assignedto]
,[trsc_reviewassignedto]
,[trsc_schedule]
,[trsc_status]
FROM[v_taxreturns_schedule]
WHERE[trsc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group3 Subgroup1 --->
<cfcase value="group3_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[trsc_1_assignedto]
,[trsc_1_completed]=FORMAT(trsc_1_completed,'#Session.localization.formatdate#') 
,[trsc_1_duedate]=FORMAT(trsc_1_duedate,'#Session.localization.formatdate#') 
,[trsc_1_informationreceived]=FORMAT(trsc_1_informationreceived,'#Session.localization.formatdate#') 
,[trsc_1_missinginforeceived]=FORMAT(trsc_1_missinginforeceived,'#Session.localization.formatdate#') 
,[trsc_1_missinginfo]
,[trsc_1_preparedby]
,[trsc_1_readyforreview]=FORMAT(trsc_1_readyforreview,'#Session.localization.formatdate#') 
,[trsc_1_reviewassignedto]
,[trsc_1_reviewed]=FORMAT(trsc_1_reviewed,'#Session.localization.formatdate#') 
,[trsc_1_reviewedby]
,[trsc_1_reviewedwithnotes]=FORMAT(trsc_1_reviewedwithnotes,'#Session.localization.formatdate#') 
FROM[v_taxreturns_schedule]
WHERE[trsc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
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
<!--- LOOKUP TAX RETURNS --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,[tr_duedate]=FORMAT(tr_duedate,'#Session.localization.formatdate#') 
,[tr_missinginfo]
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'#Session.localization.formatdate#') 
,[tr_4_assignedto]
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[client_name]
,[client_id]
,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'#Session.localization.formatdate#') 
,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'#Session.localization.formatdate#') 
,[tr_2_reviewassignedtoTEXT] 
,[tr_2_reviewed]=FORMAT(tr_2_reviewed,'#Session.localization.formatdate#') 
,[tr_2_completed]=FORMAT(tr_2_completed,'#Session.localization.formatdate#') 
,[tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'#Session.localization.formatdate#') 
,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'#Session.localization.formatdate#') 
,[tr_3_delivered]=FORMAT(tr_3_delivered,'#Session.localization.formatdate#')
,[tr_4_required] 
FROM[v_taxreturns]
WHERE  ISNULL([tr_notrequired],0) != 1
AND [tr_3_delivered] IS NULL 
AND [client_active]=(1)
AND [tr_active]=(1)
AND [deleted] IS NULL
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, tr_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
 									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
									,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
									,"TR_DUEDATE":"'&TR_DUEDATE&'"
									,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
 									,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
									,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
									,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
									,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
									,"TR_2_REVIEWASSIGNEDTOTEXT":"'&TR_2_REVIEWASSIGNEDTOTEXT&'"
									,"TR_2_REVIEWED":"'&TR_2_REVIEWED&'"
									,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
 									,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
									,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"	
									,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"	
									,"TR_4_REQUIRED":"'&TR_4_REQUIRED&'"	
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2 --->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[trst_id]
,[trst_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[trst_state]=[optionvalue_id])
,[trst_primary]
,[trst_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[trst_status]=[optionvalue_id])     
,[trst_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trst_assignedto=user_id))
,[trst_1_reviewassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trst_1_reviewassignedto=user_id))
FROM[v_taxreturns_state]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> 
AND  ISNULL([trst_status],0) !=2 
AND  ISNULL([trst_status],0)!=3
AND [trst_active]=(1)
AND [deleted] IS NULL
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[trst_status]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'"
								,"TRST_STATETEXT":"'&TRST_STATETEXT&'"
								,"TRST_PRIMARY":"'&TRST_PRIMARY&'"
								,"TRST_STATUSTEXT":"'&TRST_STATUSTEXT&'"
								,"TRST_ASSIGNEDTOTEXT":"'&TRST_ASSIGNEDTOTEXT&'"
								,"TRST_1_REVIEWASSIGNEDTOTEXT":"'&TRST_1_REVIEWASSIGNEDTOTEXT&'"
 								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 3  --->
<cfcase value="group3">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[trsc_id]
,[trsc_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trsc_assignedto=user_id))
,[trsc_schedule]
,[trsc_scheduleTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxreturnschedule'AND[trsc_schedule]=[optionvalue_id])     
,[trsc_status]
,[trsc_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[trsc_status]=[optionvalue_id])     
,[trsc_reviewassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trsc_reviewassignedto=user_id))
FROM[v_taxreturns_schedule]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
AND [trsc_active]=(1)
AND [deleted] IS NULL
AND[trsc_status]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[trsc_status]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRSC_ID":"'&TRSC_ID&'"
								,"TRSC_SCHEDULETEXT":"'&TRSC_SCHEDULETEXT&'"
								,"TRSC_STATUSTEXT":"'&TRSC_STATUSTEXT&'"
								,"TRSC_ASSIGNEDTOTEXT":"'&TRSC_ASSIGNEDTOTEXT&'"
								,"TRSC_REVIEWASSIGNEDTOTEXT":"'&TRSC_REVIEWASSIGNEDTOTEXT&'"
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][18])><cfset j.DATA[1][18]=1><cfelse><cfset j.DATA[1][18]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[taxreturns](
[client_id]
,[tr_currentfees]
,[tr_duedate] 
,[tr_esttime]
,[tr_extensiondone]
,[tr_extensionrequested]
,[tr_filingdeadline]
,[tr_2_informationreceived]
,[tr_missinginfo]
,[tr_missinginforeceived]
,[tr_notrequired]
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
,[tr_3_multistatereturn]
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
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN TR_ID--->
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
UPDATE[taxreturns]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_currentfees]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_duedate]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_extensiondone]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_extensionrequested]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_filingdeadline]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_2_informationreceived]=<cfqueryparam value="#j.DATA[1][9]#"  null="#LEN(j.DATA[1][9]) eq 0#"/>
,[tr_missinginfo]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[tr_missinginforeceived]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[tr_notrequired]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[tr_priorfees]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[tr_priority]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[tr_reason]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[tr_taxform]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
,[tr_taxyear]=<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#"/>
,[tr_3_multistatereturn]=<cfqueryparam value="#j.DATA[1][18]#" null="#LEN(j.DATA[1][18]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>

<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns]
SET[tr_1_dropoffappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][2],'YYYY-MM-DD')# #timeFormat(j.DATA[1][2],'hh:mm:ss tt')#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_1_dropoffappointmentlength]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_1_dropoffappointmentwith]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_1_pickupappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][5],'YYYY-MM-DD')# #timeFormat(j.DATA[1][5],'hh:mm:ss tt')#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_1_pickupappointmentlength]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_1_pickupappointmentwith]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_1_whileyouwaitappt]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>

<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns]
SET[tr_2_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_2_preparedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_2_readyforreview]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>

<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns]
SET[tr_2_completed]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_2_reviewassignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_2_reviewed]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_2_reviewedby]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_2_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>

<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns]
SET[tr_3_assemblereturn]=<cfqueryparam value="#j.DATA[1][2]#"  null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_3_contacted]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_3_delivered]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_3_emailed]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_3_messageleft]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_3_missingsignatures]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_deliverymethod] =<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_paid] =<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_5","result":"ok"}'>
</cfcase>

<!---Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][14])><cfset j.DATA[1][14]=1><cfelse><cfset j.DATA[1][14]=0></cfif>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns]
SET[tr_4_assignedto]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_4_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_4_completedby]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_4_currentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_4_delivered]=<cfqueryparam value="#j.DATA[1][6]#"  null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_4_extended]=<cfqueryparam value="#j.DATA[1][7]#"  null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_4_extensionrequested]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_4_paid]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[tr_4_pptresttime]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[tr_4_priorfees]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[tr_4_required]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[tr_4_reviewassigned]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[tr_4_reviewed]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[tr_4_reviewedby]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[tr_4_rfr]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
WHERE[tr_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfcase>

<!---Group2--->
<cfcase value="group2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[taxreturns_state]([tr_id]
,[trst_assignedto]
,[trst_completed]
,[trst_primary]
,[trst_reviewassignedto]
,[trst_state]
,[trst_status]
,[trst_requiredforms]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" NULL="#j.DATA[1][9] eq "null"#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"group2_1","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[taxreturns_state]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trst_completed]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_primary]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_reviewassignedto]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_state]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_status]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[trst_requiredforms]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#j.DATA[1][10] eq "null"#"/>
WHERE[trst_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>

<!---Group2 Subgroup1 --->
<cfcase value="group2_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_1_assignedto]= <cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trst_1_completed]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_1_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_1_informationreceived]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_1_missinginforeceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_1_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[trst_1_preparedby]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[trst_1_readyforreview]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[trst_1_reviewassignedto]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[trst_1_reviewed]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[trst_1_reviewedby]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[trst_1_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
WHERE[trst_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_2_assemblereturn]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trst_2_contacted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_2_currentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_2_delivered]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_2_deliverymethod]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_2_emailed]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[trst_2_messageleft]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[trst_2_missingsignatures]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[trst_2_paid]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[trst_2_priorfees]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
WHERE[trst_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group2 Subgroup3 --->
<cfcase value="group2_3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_3_pptrassignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trst_3_pptrcompleted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_3_pptrcurrentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_3_pptrdelivered]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_3_pptrextended]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_3_paid]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[trst_3_pptrpriorfees]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[trst_3_pptrrequired]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[trst_3_pptrrfr]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
WHERE[trst_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>

<!---Group3--->
<cfcase value="group3">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[TAXRETURNS_SCHEDULE]([tr_id]
,[trsc_assignedto]
,[trsc_reviewassignedto]
,[trsc_schedule]
,[trsc_status]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0 or j.DATA[1][5] eq 'null' #"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"group3_1","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[TAXRETURNS_SCHEDULE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trsc_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trsc_reviewassignedto]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trsc_schedule]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0 or j.DATA[1][5] eq 'null' #"/>
,[trsc_status]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
WHERE[TRSC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group3 Subgroup1 --->
<cfcase value="group3_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[TAXRETURNS_SCHEDULE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trsc_1_assignedto]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trsc_1_completed]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trsc_1_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trsc_1_informationreceived]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trsc_1_missinginforeceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trsc_1_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[trsc_1_preparedby]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[trsc_1_readyforreview]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[trsc_1_reviewassignedto]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[trsc_1_reviewed]=<cfqueryparam value="#j.DATA[1][12]#"  null="#LEN(j.DATA[1][12]) eq 0#"/>
,[trsc_1_reviewedby]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[trsc_1_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][14]#"  null="#LEN(j.DATA[1][14]) eq 0#"/>
WHERE[trsc_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[taxreturns]
SET[tr_active]=0
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[taxreturns_state]
SET[trst_active]=0
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[taxreturns_schedule]
SET[trsc_active]=0
WHERE[trsc_id]=<cfqueryparam value="#ARGUMENTS.id#">
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