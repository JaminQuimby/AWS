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
SELECT[PC_ID]
,[client_id]
,[pc_altfreq]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_deliverymethod]
,[pc_esttime]
,[pc_fees]
,[pc_missinginfo]
,CONVERT(VARCHAR(10),[pc_missinginforeceived], 101)AS[pc_missinginforeceived]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,[pc_paid]
,[pc_year]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup1 --->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_obtaininfo_assignedto]
,[pc_obtaininfo_completedby]
,CONVERT(VARCHAR(10),[pc_obtaininfo_datecompleted], 101)AS[pc_obtaininfo_datecompleted]
,[pc_obtaininfo_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup2 --->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_preparation_assignedto]
,[pc_preparation_completedby]
,CONVERT(VARCHAR(10),[pc_preparation_datecompleted], 101)AS[pc_preparation_datecompleted]
,[pc_preparation_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup3 --->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_review_assignedto]
,[pc_review_completedby]
,CONVERT(VARCHAR(10),[pc_review_datecompleted], 101)AS[pc_review_datecompleted]
,[pc_review_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup4 --->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_assembly_assignedto]
,[pc_assembly_completedby]
,CONVERT(VARCHAR(10),[pc_assembly_datecompleted], 101)AS[pc_assembly_datecompleted]
,[pc_assembly_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1 Subgroup5 --->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_delivery_assignedto]
,[pc_delivery_completedby]
,CONVERT(VARCHAR(10),[pc_delivery_datecompleted], 101)AS[pc_delivery_datecompleted]
,[pc_delivery_esttime]
FROM[payrollcheckstatus]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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


<!--- Asset GUI Completed Tasks--->
<cfcase value="assetCompTask">
<cfquery datasource="AWS" name="fQuery">
SELECT[pc_obtaininfo_datecompleted]=CONVERT(VARCHAR(10),pc_obtaininfo_datecompleted,101)
,[pc_obtaininfo_completedbyTEXT]
,[pc_preparation_datecompleted]=CONVERT(VARCHAR(10),pc_preparation_datecompleted,101)
,[pc_preparation_completedbyTEXT]
,[pc_review_datecompleted]=CONVERT(VARCHAR(10),pc_review_datecompleted,101)
,[pc_review_completedbyTEXT]
,[pc_assembly_datecompleted]=CONVERT(VARCHAR(10),pc_assembly_datecompleted,101)
,[pc_assembly_completedbyTEXT]
,[pc_delivery_datecompleted]=CONVERT(VARCHAR(10),pc_delivery_datecompleted,101)
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
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_missinginfo]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate]
,[pc_obtaininfo_assignedtoTEXT]
,[pc_preparation_assignedtoTEXT]
,[pc_review_assignedtoTEXT]
,[pc_assembly_assignedtoTEXT]
,[pc_delivery_assignedtoTEXT]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE[pc_delivery_datecompleted] IS NULL
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
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PC_YEAR":"'&PC_YEAR&'"
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_OBTAININFO_ASSIGNEDTOTEXT":"'&PC_OBTAININFO_ASSIGNEDTOTEXT&'"
								,"PC_PREPARATION_ASSIGNEDTOTEXT":"'&PC_PREPARATION_ASSIGNEDTOTEXT&'"
								,"PC_REVIEW_ASSIGNEDTOTEXT":"'&PC_REVIEW_ASSIGNEDTOTEXT&'"
								,"PC_ASSEMBLY_ASSIGNEDTOTEXT":"'&PC_ASSEMBLY_ASSIGNEDTOTEXT&'"
								,"PC_DELIVERY_ASSIGNEDTOTEXT":"'&PC_DELIVERY_ASSIGNEDTOTEXT&'"
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[payrollcheckstatus](
[client_id]
,[pc_altfreq]
,[pc_datedue]
,[pc_deliverymethod]
,[pc_esttime]
,[pc_fees]
,[pc_missinginfo]
,[pc_missinginforeceived]
,[pc_paydate]
,[pc_payenddate]
,[pc_paid]
,[pc_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"  null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[payrollcheckstatus]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_altfreq]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[pc_datedue]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[pc_deliverymethod]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[pc_esttime]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[pc_fees]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[pc_missinginfo]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[pc_missinginforeceived]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[pc_paydate]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[pc_payenddate]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[pc_paid]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[pc_year]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
WHERE[PC_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
</cfif>
</cfcase>
<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKSTATUS]
SET[pc_obtaininfo_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_obtaininfo_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKSTATUS]
SET[pc_preparation_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_preparation_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKSTATUS]
SET[pc_review_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_review_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKSTATUS]
SET[pc_assembly_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_assembly_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
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
<cfquery name="fquery" datasource="AWS">
UPDATE[PAYROLLCHECKSTATUS]
SET[pc_delivery_assignedto]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pc_delivery_completedby]=<cfqueryparam value="#j.DATA[1][3]#"/>
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
</cfcomponent>