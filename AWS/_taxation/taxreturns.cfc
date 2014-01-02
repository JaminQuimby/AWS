<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!---
 [dbo].[taxreturns](
    [tr_id] [int] IDENTITY(1,1) NOT NULL,
    [client_id] [int] NULL,
    [tr_credithold] [bit] NULL,
    [tr_currentfees] [money] NULL,
    [tr_esttime] [int] NULL,
    [tr_extensiondone] [date] NULL,
    [tr_extensionrequested] [date] NULL,
    [tr_notrequired] [bit] NULL,
    [tr_priority] [int] NULL,
    [tr_priorfees] [money] NULL,
    [tr_taxform] [int] NULL,
    [tr_taxyear] [int] NULL,
    [tr_duedate] [date] NULL,
    [tr_filingdeadline] [date] NULL,
    [tr_missinginfo] [bit] NULL,
    [tr_missinginforeceived] [date] NULL,
    [tr_deliverymethod] [int] NULL,
    [tr_paid] [int] NULL,
    [tr_reason] [nchar](10) NULL,
    [tr_1_dropoffappointment] [smalldatetime] NULL,
    [tr_1_dropoffappointmentlength] [int] NULL,
    [tr_1_dropoffappointmentwith] [int] NULL,
    [tr_1_whileyouwaitappt] [bit] NULL,
    [tr_1_pickupappointment] [smalldatetime] NULL,
    [tr_1_pickupappointmentlength] [int] NULL,
    [tr_1_pickupappointmentwith] [int] NULL,
    [tr_2_assignedto] [int] NULL,
    [tr_2_completed] [date] NULL,
    [tr_2_informationreceived] [date] NULL,
    [tr_2_preparedby] [int] NULL,
    [tr_2_readyforreview] [date] NULL,
    [tr_2_reviewassignedto] [int] NULL,
    [tr_2_reviewed] [date] NULL,
    [tr_2_reviewedby] [int] NULL,
    [tr_2_reviewedwithnotes] [date] NULL,
    [tr_3_assemblereturn] [date] NULL,
    [tr_3_contacted] [date] NULL,
    [tr_3_delivered] [date] NULL,
    [tr_3_emailed] [bit] NULL,
    [tr_3_messageleft] [bit] NULL,
    [tr_3_missingsignatures] [int] NULL,
    [tr_3_multistatereturn] [bit] NULL,
    [tr_4_assignedto] [int] NULL,
    [tr_4_completed] [date] NULL,
    [tr_4_currentfees] [money] NULL,
    [tr_4_delivered] [date] NULL,
    [tr_4_extended] [date] NULL,
    [tr_4_paid] [int] NULL,
    [tr_4_pptresttime] [int] NULL,
    [tr_4_priorfees] [money] NULL,
    [tr_4_required] [bit] NULL,
    [tr_4_rfr] [date] NULL,
    [tr_4_extensionrequested] [bit] NULL,
    [tr_4_completedby] [int] NULL,
    [tr_4_reviewassigned] [int] NULL,
    [tr_4_reviewed] [bit] NULL,
    [tr_4_reviewedby] [int] NULL
)
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
SELECT[TR_ID]
,[client_id]
,[tr_currentfees]
,[tr_deliverymethod] 
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate] 
,[tr_esttime]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,CONVERT(VARCHAR(10),[tr_filingdeadline], 101)AS[tr_filingdeadline]
,[tr_missinginfo]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,[tr_notrequired]
,[tr_paid] 
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
,[tr_credithold]
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(CHAR(10),[tr_1_dropoffappointment], 101)+' '+RIGHT(CONVERT(VARCHAR,tr_1_dropoffappointment, 100),7)AS[tr_1_dropoffappointment]
,[tr_1_dropoffappointmentlength] 
,[tr_1_dropoffappointmentwith] 
,CONVERT(CHAR(10),[tr_1_pickupappointment], 101)+' '+RIGHT(CONVERT(VARCHAR,tr_1_pickupappointment, 100),7)AS[tr_1_pickupappointment]
,[tr_1_pickupappointmentlength]
,[tr_1_pickupappointmentwith]
,[tr_1_whileyouwaitappt]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[tr_2_assignedto]
,CONVERT(VARCHAR(10),[tr_2_completed], 101)AS[tr_2_completed] 
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_2_informationreceived]
,[tr_2_preparedby] 
,CONVERT(VARCHAR(10),[tr_2_readyforreview], 101)AS[tr_2_readyforreview] 
,[tr_2_reviewassignedto] 
,CONVERT(VARCHAR(10),[tr_2_reviewed], 101)AS[tr_2_reviewed] 
,[tr_2_reviewedby]
,CONVERT(VARCHAR(10),[tr_2_reviewedwithnotes], 101)AS[tr_2_reviewedwithnotes]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[tr_3_assemblereturn], 101)AS[tr_3_assemblereturn] 
,CONVERT(VARCHAR(10),[tr_3_contacted], 101)AS[tr_3_contacted] 
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]  
,[tr_3_emailed]
,[tr_3_messageleft] 
,[tr_3_missingsignatures] 
,[tr_3_multistatereturn]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[tr_4_assignedto] 
,CONVERT(VARCHAR(10),[tr_4_completed], 101)AS[tr_4_completed]
,[tr_4_completedby] 
,[tr_4_currentfees]
,CONVERT(VARCHAR(10),[tr_4_delivered], 101)AS[tr_4_delivered]
,CONVERT(VARCHAR(10),[tr_4_extended], 101)AS[tr_4_extended]
,CONVERT(VARCHAR(10),[tr_4_extensionrequested], 101)AS[tr_4_extensionrequested] 
,[tr_4_paid] 
,[tr_4_pptresttime] 
,[tr_4_priorfees] 
,[tr_4_required] 
,[tr_4_reviewassigned]
,CONVERT(VARCHAR(10),[tr_4_reviewed], 101)AS[tr_4_reviewed] 
,[tr_4_reviewedby]
,[tr_4_rfr] 
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group 2--->
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
SELECT[trst_id]
,[trst_assignedto]
,CONVERT(VARCHAR(10),[trst_completed], 101)AS[trst_completed]
,[trst_primary]
,[trst_reviewassignedto]
,[trst_state]
,[trst_status]
FROM[TAXRETURNS_STATE]
WHERE[TRST_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group2 Subgroup1 --->
<cfcase value="group2_1">
<cfquery datasource="AWS" name="fQuery">
SELECT [trst_1_assignedto]
,CONVERT(VARCHAR(10),[trst_1_completed], 101)AS[trst_1_completed]
,CONVERT(VARCHAR(10),[trst_1_duedate], 101)AS[trst_1_duedate]
,CONVERT(VARCHAR(10),[trst_1_informationreceived], 101)AS[trst_1_informationreceived]
,CONVERT(VARCHAR(10),[trst_1_missinginforeceived], 101)AS[trst_1_missinginforeceived]
,[trst_1_missinginfo]
,[trst_1_preparedby]
,CONVERT(VARCHAR(10),[trst_1_readyforreview], 101)AS[trst_1_readyforreview]
,[trst_1_reviewassignedto]
,CONVERT(VARCHAR(10),[trst_1_reviewed], 101)AS[trst_1_reviewed]
,[trst_1_reviewedby]
,CONVERT(VARCHAR(10),[trst_1_reviewedwithnotes], 101)AS[trst_1_reviewedwithnotes]
FROM[taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group2 Subgroup2 --->
<cfcase value="group2_2">
<cfquery datasource="AWS" name="fQuery">
SELECT  CONVERT(VARCHAR(10),[trst_2_assemblereturn], 101)AS[trst_2_assemblereturn]
,CONVERT(VARCHAR(10),[trst_2_contacted], 101)AS[trst_2_contacted]
,[trst_2_currentfees]
,CONVERT(VARCHAR(10),[trst_2_delivered], 101)AS[trst_2_delivered]
,[trst_2_deliverymethod]
,[trst_2_emailed]
,[trst_2_messageleft]
,[trst_2_missingsignatures]
,[trst_2_paid]
,[trst_2_priorfees]
,[trst_2_requiredforms]
FROM[taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group2 Subgroup3 --->
<cfcase value="group2_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[trst_3_pptrassignedto]
,CONVERT(VARCHAR(10),[trst_3_pptrcompleted], 101)AS[trst_3_pptrcompleted]
,[trst_3_pptrcurrentfees]
,CONVERT(VARCHAR(10),[trst_3_pptrdelivered], 101)AS[trst_3_pptrdelivered]
,CONVERT(VARCHAR(10),[trst_3_pptrextended], 101)AS[trst_3_pptrextended]
,[trst_3_paymentstatus]
,[trst_3_pptrpriorfees]
,[trst_3_pptrrequired]
,CONVERT(VARCHAR(10),[trst_3_pptrrfr], 101)AS[trst_3_pptrrfr]
FROM[taxreturns_state]
WHERE[trst_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group 3--->
<cfcase value="group3">
<cfquery datasource="AWS" name="fQuery">
SELECT[trsc_id]
,[trsc_assignedto]
,[trsc_reviewassignedto]
,[trsc_schedule]
,[trsc_status]
FROM[taxreturns_schedule]
WHERE[trsc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group3 Subgroup1 --->
<cfcase value="group3_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[trsc_1_assignedto]
,CONVERT(VARCHAR(10),[trsc_1_completed], 101)AS[trsc_1_completed]
,CONVERT(VARCHAR(10),[trsc_1_duedate], 101)AS[trsc_1_duedate]
,CONVERT(VARCHAR(10),[trsc_1_informationreceived], 101)AS[trsc_1_informationreceived]
,CONVERT(VARCHAR(10),[trsc_1_missinginforeceived], 101)AS[trsc_1_missinginforeceived]
,[trsc_1_missinginfo]
,[trsc_1_preparedby]
,CONVERT(VARCHAR(10),[trsc_1_readyforreview], 101)AS[trsc_1_readyforreview]
,[trsc_1_reviewassignedto]
,CONVERT(VARCHAR(10),[trsc_1_reviewed], 101)AS[trsc_1_reviewed]
,[trsc_1_reviewedby]
,CONVERT(VARCHAR(10),[trsc_1_reviewedwithnotes], 101)AS[trsc_1_reviewedwithnotes]
FROM[taxreturns_schedule]
WHERE[trsc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,tr_taxformTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate]
,[tr_missinginfo]
,[tr_4_assignedto]
,tr_4_assignedtoTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[client_name]
,[client_id]
FROM[v_taxreturns]
WHERE [tr_taxyear] IS NOT NULL

<!---[tr_2_informationreceived] IS NOT NULL
AND [tr_4_delivered] IS NULL
AND [tr_notrequired] = 0--->
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
	  ,[trst_id]
,trst_assignedtoTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trst_assignedto=user_id))
      ,[trst_state]
,trst_stateTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[trst_state]=[optionvalue_id])
      ,[trst_status]
,trst_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[trst_status]=[optionvalue_id])     
FROM[v_taxreturns_state]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[trst_status]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[trst_status]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'"
								,"TRST_STATETEXT":"'&TRST_STATETEXT&'"
								,"TRST_STATUSTEXT":"'&TRST_STATUSTEXT&'"
								,"TRST_ASSIGNEDTOTEXT":"'&TRST_ASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- Grid 3  --->
<cfcase value="group3">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
	  ,[trsc_id]
,trsc_assignedtoTEXT=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(trsc_assignedto=user_id))
      ,[trsc_schedule]
,trsc_scheduleTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_timespans'AND[trsc_schedule]=[optionvalue_id])     

      ,[trsc_status]
,trsc_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[trsc_status]=[optionvalue_id])     

FROM[v_taxreturns_schedule]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND[trsc_status]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[TAXRETURNS](
[client_id]
,[tr_currentfees]
,[tr_deliverymethod] 
,[tr_duedate] 
,[tr_esttime]
,[tr_extensiondone]
,[tr_extensionrequested]
,[tr_filingdeadline]
,[tr_missinginfo]
,[tr_missinginforeceived]
,[tr_notrequired]
,[tr_paid] 
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][16]#"/>
,<cfqueryparam value="#j.DATA[1][17]#"/>
,<cfqueryparam value="#j.DATA[1][18]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_currentfees]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_deliverymethod]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tr_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_esttime]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_extensiondone]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_extensionrequested]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_filingdeadline]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[tr_missinginfo]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[tr_missinginforeceived]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[tr_notrequired]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[tr_paid] =<cfqueryparam value="#j.DATA[1][13]#"/>
,[tr_priorfees]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[tr_priority]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[tr_reason]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[tr_taxform]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[tr_taxyear]=<cfqueryparam value="#j.DATA[1][18]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_1_dropoffappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][2],'YYYY-MM-DD')# #timeFormat(j.DATA[1][2],'hh:mm:ss tt')#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_1_dropoffappointmentlength]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_1_dropoffappointmentwith]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tr_1_pickupappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][5],'YYYY-MM-DD')# #timeFormat(j.DATA[1][5],'hh:mm:ss tt')#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_1_pickupappointmentlength]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_1_pickupappointmentwith]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[tr_1_whileyouwaitappt]=<cfqueryparam value="#j.DATA[1][8]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_2_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_2_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_2_informationreceived]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_2_preparedby]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[tr_2_readyforreview]=<cfqueryparam value="#j.DATA[1][6]#"  null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_2_reviewassignedto]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[tr_2_reviewed]=<cfqueryparam value="#j.DATA[1][8]#"  null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_2_reviewedby]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[tr_2_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][10]#"  null="#LEN(j.DATA[1][10]) eq 0#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_3_assemblereturn]=<cfqueryparam value="#j.DATA[1][2]#"  null="#LEN(j.DATA[1][2]) eq 0#"/>
,[tr_3_contacted]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_3_delivered]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_3_emailed]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_3_messageleft]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_3_missingsignatures]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_3_multistatereturn]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][14])><cfset j.DATA[1][14]=1><cfelse><cfset j.DATA[1][14]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_4_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_4_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_4_completedby]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tr_4_currentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_4_delivered]=<cfqueryparam value="#j.DATA[1][6]#"  null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_4_extended]=<cfqueryparam value="#j.DATA[1][7]#"  null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_4_extensionrequested]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[tr_4_paid]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[tr_4_pptresttime]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[tr_4_priorfees]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[tr_4_required]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[tr_4_reviewassigned]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[tr_4_reviewed]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[tr_4_reviewedby]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[tr_4_rfr]=<cfqueryparam value="#j.DATA[1][16]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[TAXRETURNS_STATE]([tr_id]
,[trst_assignedto]
,[trst_completed]
,[trst_primary]
,[trst_reviewassignedto]
,[trst_state]
,[trst_status]

)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#" />
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"group2_1","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[trst_completed]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_primary]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[trst_reviewassignedto]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[trst_state]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[trst_status]=<cfqueryparam value="#j.DATA[1][8]#"/>
WHERE[TRST_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_1_assignedto]= <cfqueryparam value="#j.DATA[1][3]#"/>
,[trst_1_completed]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_1_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_1_informationreceived]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_1_missinginforeceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_1_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[trst_1_preparedby]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[trst_1_readyforreview]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[trst_1_reviewassignedto]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[trst_1_reviewed]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[trst_1_reviewedby]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[trst_1_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
WHERE[TRST_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_2_assemblereturn]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[trst_2_contacted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_2_currentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_2_delivered]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_2_deliverymethod]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[trst_2_emailed]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[trst_2_messageleft]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[trst_2_missingsignatures]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[trst_2_paid]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[trst_2_priorfees]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[trst_2_requiredforms]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[TRST_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_STATE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trst_3_pptrassignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[trst_3_pptrcompleted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trst_3_pptrcurrentfees]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trst_3_pptrdelivered]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trst_3_pptrextended]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trst_3_paymentstatus]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[trst_3_pptrpriorfees]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[trst_3_pptrrequired]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[trst_3_pptrrfr]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
WHERE[TRST_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
<cfquery name="fquery" datasource="AWS">
INSERT INTO[TAXRETURNS_SCHEDULE]([tr_id]
,[trsc_assignedto]
,[trsc_reviewassignedto]
,[trsc_schedule]
,[trsc_status]
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
<cfreturn '{"id":#fquery.id#,"group":"group3_1","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_SCHEDULE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trsc_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[trsc_reviewassignedto]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[trsc_schedule]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[trsc_status]=<cfqueryparam value="#j.DATA[1][6]#"/>
WHERE[TRSC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group3 Subgroup1 --->
<cfcase value="group3_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS_SCHEDULE]
SET[tr_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[trsc_1_assignedto]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[trsc_1_completed]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[trsc_1_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[trsc_1_informationreceived]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[trsc_1_missinginforeceived]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[trsc_1_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[trsc_1_preparedby]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[trsc_1_readyforreview]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[trsc_1_reviewassignedto]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[trsc_1_reviewed]=<cfqueryparam value="#j.DATA[1][12]#"  null="#LEN(j.DATA[1][12]) eq 0#"/>
,[trsc_1_reviewedby]=<cfqueryparam value="#j.DATA[1][13]#"/>
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
</cfcomponent>