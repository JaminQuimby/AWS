<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="false">
<cfargument name="selectName" type="string" required="yes">
<cfquery name="fquery" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">
SELECT[optionvalue_id],[optionname]
FROM[v_selectOptions]
WHERE[formName]='Client Maintenance'AND[selectName]='#ARGUMENTS.selectName#'
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
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
<!--- Load Client--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[bf_id],[client_id]
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
,CONVERT(VARCHAR(10),[bf_disolutioncompleted], 101)AS[bf_disolutioncompleted]
,CONVERT(VARCHAR(10),[bf_otheractivity], 101)AS[bf_otheractivity]
,CONVERT(VARCHAR(10),[bf_otherstarted], 101)AS[bf_otherstarted]
,CONVERT(VARCHAR(10),[bf_othercompleted], 101)AS[bf_othercompleted]
,CONVERT(VARCHAR(10),[bf_recoardbookordered], 101)AS[bf_recoardbookordered]
,CONVERT(VARCHAR(10),[bf_estimatedtime], 101)AS[bf_estimatedtime]
,CONVERT(VARCHAR(10),[bf_duedate], 101)AS[bf_duedate]
,[bf_fees]
,[bf_paid]
,[bf_activity]
FROM[businessformation]
WHERE[bf_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Comments --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fQuery">
<!--- NOTES ARE PERMINANTE --->
</cfquery>
</cfcase>


</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"]}'> 
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
SELECT[bf_id],[client_id],[client_name],[bf_owners]
FROM[v_businessformation]
WHERE[bf_owners]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> OR[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","BF_OWNERS":"'&BF_OWNERS&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP FOR COMMENTS --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
<!--- Client --->
<cfcase value="group1">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[BUSINESSFORMATION](
[client_id]
,[bf_status]
,[bf_assignedto]
,[bf_owners]
,[bf_priority]
,[bf_dateinitiated]
,[bf_articlessubmitted]
,[bf_articlesapproved]
,[bf_tradenamesubmitted]
,[bf_tradenamereceived]
,[bf_minutesbylawsdraft]
,[bf_minutesbylawsfinal]
,[bf_tinss4submitted]
,[bf_tinreceived]
,[bf_poa2848signed]
,[bf_statecrasubmitted]
,[bf_statecrareceived]
,[bf_scorp2553submitted]
,[bf_scorp2553received]
,[bf_corp8832submitted]
,[bf_corp8832received]
,[bf_501c3submitted]
,[bf_501creceived]
,[bf_minutescompleted]
,[bf_dissolutionrequested]
,[bf_dissolutionsubmitted]
,[bf_disolutioncompleted]
,[bf_otheractivity]
,[bf_otherstarted]
,[bf_othercompleted]
,[bf_recoardbookordered]
,[bf_estimatedtime]
,[bf_duedate]
,[bf_fees]
,[bf_paid]
,[bf_activity]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
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
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#"/>
,<cfqueryparam value="#j.DATA[1][17]#"/>
,<cfqueryparam value="#j.DATA[1][18]#"/>
,<cfqueryparam value="#j.DATA[1][19]#"/>
,<cfqueryparam value="#j.DATA[1][20]#"/>
,<cfqueryparam value="#j.DATA[1][21]#"/>
,<cfqueryparam value="#j.DATA[1][22]#"/>
,<cfqueryparam value="#j.DATA[1][23]#"/>
,<cfqueryparam value="#j.DATA[1][24]#"/>
,<cfqueryparam value="#j.DATA[1][25]#"/>
,<cfqueryparam value="#j.DATA[1][26]#"/>
,<cfqueryparam value="#j.DATA[1][27]#"/>
,<cfqueryparam value="#j.DATA[1][28]#"/>
,<cfqueryparam value="#j.DATA[1][29]#"/>
,<cfqueryparam value="#j.DATA[1][30]#"/>
,<cfqueryparam value="#j.DATA[1][31]#"/>
,<cfqueryparam value="#j.DATA[1][32]#"/>
,<cfqueryparam value="#j.DATA[1][33]#"/>
,<cfqueryparam value="#j.DATA[1][34]#"/>
,<cfqueryparam value="#j.DATA[1][35]#"/>
,<cfqueryparam value="#j.DATA[1][36]#"/>
,<cfqueryparam value="#j.DATA[1][37]#"/>
)
SELECT SCOPE_IDENTITY()AS[bf_id]
</cfquery>
<cfreturn '{"id":#fquery.bf_id#,"group":"group2","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfif not isNumeric(j.DATA[1][35]) or j.DATA[1][35] lt -1> 
<cfset j.DATA[1][35] =0>
</cfif> 
<cfquery name="fquery" datasource="AWS">
UPDATE[BUSINESSFORMATION]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[bf_status]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[bf_assignedto]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[bf_owners]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[bf_priority]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[bf_dateinitiated]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[bf_articlessubmitted]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[bf_articlesapproved]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[bf_tradenamesubmitted]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[bf_tradenamereceived]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[bf_minutesbylawsdraft]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[bf_minutesbylawsfinal]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[bf_tinss4submitted]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[bf_tinreceived]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[bf_poa2848signed]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[bf_statecrasubmitted]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[bf_statecrareceived]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[bf_scorp2553submitted]=<cfqueryparam value="#j.DATA[1][19]#"/>
,[bf_scorp2553received]=<cfqueryparam value="#j.DATA[1][20]#"/>
,[bf_corp8832submitted]=<cfqueryparam value="#j.DATA[1][21]#"/>
,[bf_corp8832received]=<cfqueryparam value="#j.DATA[1][22]#"/>
,[bf_501c3submitted]=<cfqueryparam value="#j.DATA[1][23]#"/>
,[bf_501creceived]=<cfqueryparam value="#j.DATA[1][24]#"/>
,[bf_minutescompleted]=<cfqueryparam value="#j.DATA[1][25]#"/>
,[bf_dissolutionrequested]=<cfqueryparam value="#j.DATA[1][26]#"/>
,[bf_dissolutionsubmitted]=<cfqueryparam value="#j.DATA[1][27]#"/>
,[bf_disolutioncompleted]=<cfqueryparam value="#j.DATA[1][28]#"/>
,[bf_otheractivity]=<cfqueryparam value="#j.DATA[1][29]#"/>
,[bf_otherstarted]=<cfqueryparam value="#j.DATA[1][30]#"/>
,[bf_othercompleted]=<cfqueryparam value="#j.DATA[1][31]#"/>
,[bf_recoardbookordered]=<cfqueryparam value="#j.DATA[1][32]#"/>
,[bf_estimatedtime]=<cfqueryparam value="#j.DATA[1][33]#"/>
,[bf_duedate]=<cfqueryparam value="#j.DATA[1][34]#"/>
,[bf_fees]=<cfqueryparam value="#j.DATA[1][35]#" />
,[bf_paid]=<cfqueryparam value="#j.DATA[1][36]#"/>
,[bf_activity]=<cfqueryparam value="#j.DATA[1][37]#"/>
WHERE[BF_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>

</cfcase>



<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[client_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group3","result":"ok"}'>
</cfif>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>