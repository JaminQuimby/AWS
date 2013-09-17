<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!---

,[bf_status]
,[bf_assignedto]
,[bf_owners]
,[bf_priority]
,CONVERT(VARCHAR(10),[bf_dateinitiated], 101)AS[bf_dateinitiated]
,CONVERT(VARCHAR(10),[bf_articlessubmitted], 101)AS[bf_articlessubmitted]
,CONVERT(VARCHAR(10),[bf_articlesapproved], 101)AS[bf_articlesapproved]
,CONVERT(VARCHAR(10),[bf_tradenamesubmitted], 101)AS[bf_tradenamesubmitted]
,CONVERT(VARCHAR(10),[bf_tradenamereceived], 101)AS[bf_tradenamereceived]
,CONVERT(VARCHAR(10),[bf_minutesbylawsdraft], 101)AS[bf_minutesbylawsdraft]
,CONVERT(VARCHAR(10),[bf_minutesbylawsfinal], 101)AS[bf_minutesbylawsfinal]
,CONVERT(VARCHAR(10),[bf_tinss4submitted], 101)AS[bf_tinss4submitted]
,CONVERT(VARCHAR(10),[bf_tinreceived], 101)AS[bf_tinreceived]
,CONVERT(VARCHAR(10),[bf_poa2848signed], 101)AS[bf_poa2848signed]
,CONVERT(VARCHAR(10),[bf_statecrasubmitted], 101)AS[bf_statecrasubmitted]
,CONVERT(VARCHAR(10),[bf_statecrareceived], 101)AS[bf_statecrareceived]
,CONVERT(VARCHAR(10),[bf_scorp2553submitted], 101)AS[bf_scorp2553submitted]
,CONVERT(VARCHAR(10),[bf_scorp2553received], 101)AS[bf_scorp2553received]
,CONVERT(VARCHAR(10),[bf_corp8832submitted], 101)AS[bf_corp8832submitted]
,CONVERT(VARCHAR(10),[bf_corp8832received], 101)AS[bf_corp8832received]
,CONVERT(VARCHAR(10),[bf_501c3submitted], 101)AS[bf_501c3submitted]
,CONVERT(VARCHAR(10),[bf_501creceived], 101)AS[bf_501creceived]
,CONVERT(VARCHAR(10),[bf_minutescompleted], 101)AS[bf_minutescompleted]
,CONVERT(VARCHAR(10),[bf_dissolutionrequested], 101)AS[bf_dissolutionrequested]
,CONVERT(VARCHAR(10),[bf_dissolutionsubmitted], 101)AS[bf_dissolutionsubmitted]
,CONVERT(VARCHAR(10),[bf_dissolutioncompleted], 101)AS[bf_dissolutioncompleted]
,CONVERT(VARCHAR(10),[bf_otheractivity], 101)AS[bf_otheractivity]
,CONVERT(VARCHAR(10),[bf_otherstarted], 101)AS[bf_otherstarted]
,CONVERT(VARCHAR(10),[bf_othercompleted], 101)AS[bf_othercompleted]
,CONVERT(VARCHAR(10),[bf_recordbookordered], 101)AS[bf_recordbookordered]
,CONVERT(VARCHAR(10),[bf_estimatedtime], 101)AS[bf_estimatedtime]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_fees]
,[bf_paid]
,[bf_activity]


--->

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[bf_id]
,[client_id]
,[bf_activity]
,[bf_assignedto]
,CONVERT(VARCHAR(10),[bf_dateinitiated], 101)AS[bf_dateinitiated]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_estimatedtime]
,[bf_fees]
,[bf_owners]
,[bf_paid]
,[bf_priority]
,[bf_status]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1_1--->
<cfcase value="group1_1">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[bf_articlesapproved], 101)AS[bf_articlesapproved]
,CONVERT(VARCHAR(10),[bf_articlessubmitted], 101)AS[bf_articlessubmitted]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1_2--->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[bf_tradenamereceived], 101)AS[bf_tradenamereceived]
,CONVERT(VARCHAR(10),[bf_tradenamesubmitted], 101)AS[bf_tradenamesubmitted]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1_3--->
<cfcase value="group1_3">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[bf_minutesbylawsdraft], 101)AS[bf_minutesbylawsdraft]
,CONVERT(VARCHAR(10),[bf_minutesbylawsfinal], 101)AS[bf_minutesbylawsfinal]
,CONVERT(VARCHAR(10),[bf_minutescompleted], 101)AS[bf_minutescompleted]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1_4--->
<cfcase value="group1_4">
<cfquery datasource="AWS" name="fQuery">
SELECT CONVERT(VARCHAR(10),[bf_dissolutioncompleted], 101)AS[bf_dissolutioncompleted]
,CONVERT(VARCHAR(10),[bf_dissolutionrequested], 101)AS[bf_dissolutionrequested]
,CONVERT(VARCHAR(10),[bf_dissolutionsubmitted], 101)AS[bf_dissolutionsubmitted]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Group1_5--->
<cfcase value="group1_5">
<cfquery datasource="AWS" name="fQuery">
SELECT [bf_businesstype]
,CONVERT(VARCHAR(10),[bf_businessreceived], 101)AS[bf_businessreceived]
,CONVERT(VARCHAR(10),[bf_businesssubmitted], 101)AS[bf_businesssubmitted]
,CONVERT(VARCHAR(10),[bf_otheractivity], 101)AS[bf_otheractivity]
,CONVERT(VARCHAR(10),[bf_othercompleted], 101)AS[bf_othercompleted]
,CONVERT(VARCHAR(10),[bf_otherstarted], 101)AS[bf_otherstarted]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<!--- LOOKUP Business Formation --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id],[client_id],[client_name],[bf_owners],[bf_status]
FROM[v_businessformation]
WHERE[bf_owners]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> OR[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","BF_OWNERS":"'&BF_OWNERS&'","BF_STATUS":"'&BF_STATUS&'"}'>
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
<!--- Save Group1 --->
<cfcase value="group1">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[BUSINESSFORMATION](
[client_id]
,[bf_activity]
,[bf_assignedto]
,[bf_dateinitiated]
,[bf_duedate]
,[bf_estimatedtime]
,[bf_fees]
,[bf_owners]
,[bf_paid]
,[bf_priority]
,[bf_status]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
)
SELECT SCOPE_IDENTITY()AS[bf_id]
</cfquery>
<cfreturn '{"id":#fquery.bf_id#,"group":"group1_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[BUSINESSFORMATION]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[bf_activity]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[bf_assignedto]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[bf_dateinitiated]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[bf_duedate]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[bf_estimatedtime]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[bf_fees]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[bf_owners]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[bf_paid]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[bf_priority]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[bf_status]=<cfqueryparam value="#j.DATA[1][12]#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>

</cfcase>


<!---Group1 Subgroup1 --->
<cfcase value="group1_1">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[BUSINESSFORMATION]
SET[bf_articlesapproved]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[bf_articlessubmitted]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
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
UPDATE[BUSINESSFORMATION]
SET[bf_tradenamereceived]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[bf_tradenamesubmitted]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
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
UPDATE[BUSINESSFORMATION]
SET[bf_minutesbylawsdraft]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[bf_minutesbylawsfinal]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[bf_minutescompleted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
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
UPDATE[BUSINESSFORMATION]
SET[bf_dissolutioncompleted]=<cfqueryparam value="#j.DATA[1][2]#" null="#LEN(j.DATA[1][2]) eq 0#"/>
,[bf_dissolutionrequested]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[bf_dissolutionsubmitted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
UPDATE[BUSINESSFORMATION]
SET[bf_businesstype]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[bf_businessreceived]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[bf_businesssubmitted]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[bf_otheractivity]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[bf_othercompleted]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[bf_otherstarted]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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