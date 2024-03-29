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
FROM[payrollcheckstatus]
WHERE[client_id]=<cfqueryparam value="#item[1]#">
AND[pc_year]=<cfqueryparam value="#item[2]#">
AND[pc_payenddate]=<cfqueryparam value="#item[3]#">
AND[pc_paydate]=<cfqueryparam value="#item[4]#">
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
SELECT[PC_ID]
,[client_id]
,[pc_altfreq]
,[pc_assignedto]
,[pc_duedate]=FORMAT(pc_duedate,'#Session.localization.formatdate#') 
,[pc_deliverymethod]
,[pc_esttime]
,[pc_fees]=FORMAT(pc_fees,'C','#Session.localization.language#')
,[pc_missinginfo]
,[pc_missinginforeceived]=FORMAT(pc_missinginforeceived,'#Session.localization.formatdate#') 
,[pc_paydate]=FORMAT(pc_paydate,'#Session.localization.formatdate#') 
,[pc_payenddate]=FORMAT(pc_payenddate,'#Session.localization.formatdate#') 
,[pc_paid]
,[pc_priority]
,[pc_status]
,[pc_year]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pc_obtaininfo_assignedto]
,[pc_obtaininfo_completedby]
,[pc_obtaininfo_datecompleted]=FORMAT(pc_obtaininfo_datecompleted,'#Session.localization.formatdate#') 
,[pc_obtaininfo_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pc_preparation_assignedto]
,[pc_preparation_completedby]
,[pc_preparation_datecompleted]=FORMAT(pc_preparation_datecompleted,'#Session.localization.formatdate#') 
,[pc_preparation_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pc_review_assignedto]
,[pc_review_completedby]
,[pc_review_datecompleted]=FORMAT(pc_review_datecompleted,'#Session.localization.formatdate#') 
,[pc_review_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pc_assembly_assignedto]
,[pc_assembly_completedby]
,[pc_assembly_datecompleted]=FORMAT(pc_assembly_datecompleted,'#Session.localization.formatdate#') 
,[pc_assembly_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pc_delivery_assignedto]
,[pc_delivery_completedby]
,[pc_delivery_datecompleted]=FORMAT(pc_delivery_datecompleted,'#Session.localization.formatdate#') 
,[pc_delivery_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
SELECT[pc_obtaininfo_datecompleted]=FORMAT(pc_obtaininfo_datecompleted,'#Session.localization.formatdate#')
,[pc_obtaininfo_completedbyTEXT]
,[pc_preparation_datecompleted]=FORMAT(pc_preparation_datecompleted,'#Session.localization.formatdate#')
,[pc_preparation_completedbyTEXT]
,[pc_review_datecompleted]=FORMAT(pc_review_datecompleted,'#Session.localization.formatdate#')
,[pc_review_completedbyTEXT]
,[pc_assembly_datecompleted]=FORMAT(pc_assembly_datecompleted,'#Session.localization.formatdate#')
,[pc_assembly_completedbyTEXT]
,[pc_delivery_datecompleted]=FORMAT(pc_delivery_datecompleted,'#Session.localization.formatdate#')
,[pc_delivery_completedbyTEXT]
FROM[v_payrollcheckstatus]
WHERE[PC_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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


<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pc_id]
,[pc_year]
,[pc_assignedto]
,[pc_duedate]=FORMAT(pc_duedate,'#Session.localization.formatdate#') 
,[pc_missinginfo]
,[pc_payenddate]=FORMAT(pc_payenddate,'#Session.localization.formatdate#') 
,[pc_paydate]=FORMAT(pc_paydate,'#Session.localization.formatdate#') 
,[pc_obtaininfo_datecompleted]=ISNULL(FORMAT(pc_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_obtaininfo_assignedtoTEXT]
,[pc_preparation_datecompleted]=ISNULL(FORMAT(pc_preparation_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_preparation_assignedtoTEXT]
,[pc_review_datecompleted]=ISNULL(FORMAT(pc_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_review_assignedtoTEXT]
,[pc_assembly_datecompleted]=ISNULL(FORMAT(pc_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_assembly_assignedtoTEXT]
,[pc_delivery_datecompleted]=ISNULL(FORMAT(pc_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_delivery_assignedtoTEXT]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE ISNULL([pc_status],0) != 2 
AND  ISNULL([pc_status],0) != 3
AND [deleted] IS NULL
AND [client_active]=(1)
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY convert(datetime, pc_duedate, 101) ASC </cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
 									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"PC_YEAR":"'&PC_YEAR&'"
									,"PC_DUEDATE":"'&PC_DUEDATE&'"
									,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
									,"PC_PAYDATE":"'&PC_PAYDATE&'"
									,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
									,"PC_PAYDATE":"'&PC_PAYDATE&'"
									,"PC_OBTAININFO":"'&pc_obtaininfo_datecompleted&'<br/>'&pc_obtaininfo_assignedtoTEXT&'"
									,"PC_PREPARATION":"'&pc_preparation_datecompleted&'<br/>'&pc_preparation_assignedtoTEXT&'"
									,"PC_REVIEW":"'&pc_review_datecompleted&'<br/>'&pc_review_assignedtoTEXT&'"
									,"PC_ASSEMBLY":"'&pc_assembly_datecompleted&'<br/>'&pc_assembly_assignedtoTEXT&'"
									,"PC_DELIVERY":"'&pc_delivery_datecompleted&'<br/>'&pc_delivery_assignedtoTEXT&'"
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[payrollcheckstatus](
[client_id]
,[pc_altfreq]
,[pc_assignedto]
,[pc_duedate]
,[pc_deliverymethod]
,[pc_esttime]
,[pc_fees]
,[pc_missinginfo]
,[pc_missinginforeceived]
,[pc_paydate]
,[pc_payenddate]
,[pc_paid]
,[pc_priority]
,[pc_status]
,[pc_year]
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
<!--- RETURN PC_ID--->
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
UPDATE[payrollcheckstatus]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_altfreq]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_assignedto]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_duedate]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[pc_deliverymethod]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[pc_esttime]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[pc_fees]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[pc_missinginfo]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[pc_missinginforeceived]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[pc_paydate]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[pc_payenddate]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[pc_paid]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[pc_priority]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[pc_status]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[pc_year]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[payrollcheckstatus]
SET[pc_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_obtaininfo_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_obtaininfo_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
UPDATE[payrollcheckstatus]
SET[pc_preparation_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_preparation_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_preparation_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_preparation_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
UPDATE[payrollcheckstatus]
SET[pc_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_review_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_review_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
UPDATE[payrollcheckstatus]
SET[pc_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_assembly_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_assembly_esttime]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
UPDATE[payrollcheckstatus]
SET[pc_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[pc_delivery_datecompleted]=<cfqueryparam value="#j.DATA[1][4]#"  null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_delivery_esttime]=<cfqueryparam value="#j.DATA[1][5]#"null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
update[payrollcheckstatus]
SET[deleted]=GETDATE()
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.id#">
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