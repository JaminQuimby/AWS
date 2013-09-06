<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

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
,[tr_credithold]
,[tr_currentfees]
,[tr_esttime]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,[tr_notrequired]
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
,[client_spouse]
FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[tr_g1_1_assignedto]
,CONVERT(VARCHAR(10),[tr_g1_1_completed], 101)AS[tr_g1_1_completed]
,CONVERT(VARCHAR(10),[tr_g1_1_duedate], 101)AS[tr_g1_1_duedate]
,CONVERT(VARCHAR(10),[tr_g1_1_filingdeadline], 101)AS[tr_g1_1_filingdeadline]
,CONVERT(VARCHAR(10),[tr_g1_1_informationreceived], 101)AS[tr_g1_1_informationreceived]
,CONVERT(VARCHAR(10),[tr_g1_1_missinginforeceived], 101)AS[tr_g1_1_missinginforeceived]
,[tr_g1_1_missinginfo]
,[tr_g1_1_preparedby]
,CONVERT(VARCHAR(10),[tr_g1_1_readyforreview], 101)AS[tr_g1_1_readyforreview]
,[tr_g1_1_reviewassignedto]
,CONVERT(VARCHAR(10),[tr_g1_1_reviewd], 101)AS[tr_g1_1_reviewd]
,[tr_g1_1_reviewedby]
,CONVERT(VARCHAR(10),[tr_g1_1_reviewedwithnotes], 101)AS[tr_g1_1_reviewedwithnotes]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT
CONVERT(VARCHAR(10),[tr_g1_2_assemblereturn], 101)AS[tr_g1_2_assemblereturn]
,CONVERT(VARCHAR(10),[tr_g1_2_contacted], 101)AS[tr_g1_2_contacted]
,CONVERT(VARCHAR(10),[tr_g1_2_delivered], 101)AS[tr_g1_2_delivered]
,[tr_g1_2_deliverymethod]
,[tr_g1_2_emailed]
,[tr_g1_2_messageleft]
,[tr_g1_2_missingsignatures]
,[tr_g1_2_multistatereturn]
,[tr_g1_2_paymentstatus]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[tr_g1_3_assignedto]
,CONVERT(VARCHAR(10),[tr_g1_3_completed], 101)AS[tr_g1_3_completed]
,[tr_g1_3_currentfees]
,CONVERT(VARCHAR(10),[tr_g1_3_delivered], 101)AS[tr_g1_3_delivered]
,CONVERT(VARCHAR(10),[tr_g1_3_extended], 101)AS[tr_g1_3_extended]
,[tr_g1_3_paymentstatus]
,[tr_g1_3_pptresttime]
,[tr_g1_3_priorfees]
,[tr_g1_3_required]
,CONVERT(VARCHAR(10),[tr_g1_3_rfr], 101)AS[tr_g1_3_rfr]
FROM[taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT
CONVERT(CHAR(10),[tr_g1_4_dropoffappointment], 101)+' '+RIGHT(CONVERT(VARCHAR,tr_g1_4_dropoffappointment, 100),7)AS[tr_g1_4_dropoffappointment]
,[tr_g1_4_dropoffappointmentlength]
,[tr_g1_4_dropoffappointmentwith]
,CONVERT(CHAR(10),[tr_g1_4_pickupappointment], 101)+' '+RIGHT(CONVERT(VARCHAR,tr_g1_4_pickupappointment, 100),7)AS[tr_g1_4_pickupappointment]
,[tr_g1_4_pickupappointmentlength]
,[tr_g1_4_pickupappointmentwith]
,[tr_g1_4_whileyouwaitappt]
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
<!--- Load Group 3--->
<cfcase value="group3">
<cfquery datasource="AWS" name="fQuery">
SELECT[trsc_id]
,[trsc_assignedto]
,[trsc_reviewassignedto]
,[trsc_schedule]
,[trsc_status]
FROM[TAXRETURNS_SCHEDULE]
WHERE[TRSC_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Asset Spouse --->
<cfcase value="assetSpouse">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_spouse]
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
<cfargument name="otherid" type="string" required="no">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP TAX RETURNS --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[CLIENT_ID]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- Grid 2 --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[trst_id]
      ,[trst_assignedto]
      ,[trst_assignedtoTEXT]
      ,[trst_completed]
      ,[trst_primary]
      ,[trst_reviewassignedto]
      ,[trst_state]
      ,[trst_status]
FROM[v_TAXRETURNS_STATE]
WHERE[trst_status]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[trst_status]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'","TRST_ASSIGNEDTOTEXT":"'&TRST_ASSIGNEDTOTEXT&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- Grid 3  --->
<cfcase value="group3">
<cfquery datasource="AWS" name="fquery">
SELECT[trsc_id]
      ,[trsc_assignedto]
      ,[trsc_assignedtoTEXT]
      ,[trsc_reviewassignedto]
      ,[trsc_schedule]
      ,[trsc_status]
FROM[v_TAXRETURNS_SCHEDULE]
WHERE[trsc_status]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[trsc_status]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TRSC_ID":"'&TRSC_ID&'","TRSC_ASSIGNEDTOTEXT":"'&TRSC_ASSIGNEDTOTEXT&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- Grid 4  --->
<cfcase value="group4">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[other_id]=<cfqueryparam value="#ARGUMENTS.otherid#"/> 

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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[TAXRETURNS](
[client_id]
,[tr_credithold]
,[tr_currentfees]
,[tr_esttime]
,[tr_extensiondone]
,[tr_extensionrequested]
,[tr_notrequired]
,[tr_priorfees]
,[tr_priority]
,[tr_reason]
,[tr_taxform]
,[tr_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
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
,[tr_credithold]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[tr_currentfees]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tr_esttime]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[tr_extensiondone]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_extensionrequested]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_notrequired]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[tr_priorfees]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[tr_priority]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[tr_reason]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[tr_taxform]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[tr_taxyear]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_g1_1_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_g1_1_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_g1_1_duedate]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_g1_1_filingdeadline]=<cfqueryparam value="#j.DATA[1][5]#"  null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_g1_1_informationreceived]=<cfqueryparam value="#j.DATA[1][6]#"  null="#LEN(j.DATA[1][6]) eq 0#"/>
,[tr_g1_1_missinginforeceived]=<cfqueryparam value="#j.DATA[1][7]#"  null="#LEN(j.DATA[1][7]) eq 0#"/>
,[tr_g1_1_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[tr_g1_1_preparedby]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[tr_g1_1_readyforreview]=<cfqueryparam value="#j.DATA[1][10]#"  null="#LEN(j.DATA[1][10]) eq 0#"/>
,[tr_g1_1_reviewassignedto]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[tr_g1_1_reviewd]=<cfqueryparam value="#j.DATA[1][12]#"  null="#LEN(j.DATA[1][12]) eq 0#"/>
,[tr_g1_1_reviewedby]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[tr_g1_1_reviewedwithnotes]=<cfqueryparam value="#j.DATA[1][14]#"  null="#LEN(j.DATA[1][14]) eq 0#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_g1_2_assemblereturn]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_g1_2_contacted]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_g1_2_delivered]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_g1_2_deliverymethod]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[tr_g1_2_emailed]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[tr_g1_2_messageleft]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[tr_g1_2_missingsignatures]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[tr_g1_2_multistatereturn]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[tr_g1_2_paymentstatus]=<cfqueryparam value="#j.DATA[1][10]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_3","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET[tr_g1_3_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[tr_g1_3_completed]=<cfqueryparam value="#j.DATA[1][3]#"  null="#LEN(j.DATA[1][3]) eq 0#"/>
,[tr_g1_3_currentfees]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[tr_g1_3_delivered]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[tr_g1_3_extended]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_g1_3_paymentstatus]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[tr_g1_3_pptresttime]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[tr_g1_3_priorfees]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[tr_g1_3_required]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[tr_g1_3_rfr]=<cfqueryparam value="#j.DATA[1][11]#"/>
WHERE[TR_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<!---Returns ID, Returns Group Next in List to be saved, Returns an OK Result--->
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_4","result":"ok"}'>
</cfcase>
<!---Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[TAXRETURNS]
SET
[tr_g1_4_dropoffappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][2],'YYYY-MM-DD')# #timeFormat(j.DATA[1][2],'hh:mm:ss tt')#"/>
,[tr_g1_4_dropoffappointmentlength]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[tr_g1_4_dropoffappointmentwith]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[tr_g1_4_pickupappointment]=<cfqueryparam value="#dateFormat(j.DATA[1][5],'YYYY-MM-DD')# #timeFormat(j.DATA[1][5],'hh:mm:ss tt')#"/>
,[tr_g1_4_pickupappointmentlength]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[tr_g1_4_pickupappointmentwith]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[tr_g1_4_whileyouwaitappt]=<cfqueryparam value="#j.DATA[1][8]#"/>
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
<cfreturn '{"id":#fquery.id#,"group":"group3","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
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
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3","result":"ok"}'>
</cfif>
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
<cfreturn '{"id":#fquery.id#,"group":"group4","result":"ok"}'>
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
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group4","result":"ok"}'>
</cfif>
</cfcase>
<!---Group4--->
<cfcase value="group4">
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
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group5","result":"ok"}'>
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