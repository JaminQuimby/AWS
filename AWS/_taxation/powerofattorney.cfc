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
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[pa_id]
 ,[client_id]
 ,[pa_dateofrevocation]=FORMAT(pa_dateofrevocation,'d','#Session.localization.language#')
 ,[pa_datesenttoirs]=FORMAT(pa_datesenttoirs,'d','#Session.localization.language#')
 ,[pa_datesignedbyclient]=FORMAT(pa_datesignedbyclient,'d','#Session.localization.language#')
 ,[pa_preparers]
 ,[pa_status]
 ,[pa_taxforms]
 ,[pa_taxmatters]
,[pa_taxyears]
FROM[powerofattorney]
WHERE[pa_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<cfargument name="formid" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pa_id]
,[pa_taxyears]
,[pa_taxforms]
,[pa_preparers]
,[pa_status]
,[pa_taxmatters]
,[client_name]
,[client_id]
,pa_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[pa_status]=[optionvalue_id])
,pa_taxformsTEXT=SUBSTRING((SELECT', '+[optionName]FROM[v_selectOptions]WHERE(form_id='0'OR[form_id]='#ARGUMENTS.formid#')AND(optionGroup='1'OR[optionGroup]='0')AND(selectName='global_taxservices') AND(CAST([optionValue_id]AS nvarchar(5))IN(SELECT[id]FROM[CSVToTable](pa_taxforms)))FOR XML PATH('')),3,1000)
,pa_taxmattersTEXT=SUBSTRING((SELECT', '+[optionName]FROM[v_selectOptions]WHERE(form_id='0'OR[form_id]='#ARGUMENTS.formid#')AND(optionGroup='1'OR[optionGroup]='0')AND(selectName='global_taxmatters') AND(CAST([optionValue_id]AS nvarchar(5))IN(SELECT[id]FROM[CSVToTable](pa_taxmatters)))FOR XML PATH('')),3,1000)
,pa_preparersTEXT=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](pa_preparers)))FOR XML PATH('')),3,1000)

FROM[v_powerofattorney]
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
<cfset queryResult=queryResult&'{"PA_ID":"'&PA_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PA_TAXYEARS":"'&PA_TAXYEARS&'"
								,"PA_TAXFORMSTEXT":"'&PA_TAXFORMSTEXT&'"
								,"PA_TAXMATTERSTEXT":"'&PA_TAXMATTERSTEXT&'"
								,"PA_PREPARERSTEXT":"'&PA_PREPARERSTEXT&'"
								,"PA_STATUSTEXT":"'&PA_STATUSTEXT&'"
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
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[powerofattorney](
[client_id]
 ,[pa_dateofrevocation]
 ,[pa_datesenttoirs]
 ,[pa_datesignedbyclient]
 ,[pa_preparers]
 ,[pa_status]
 ,[pa_taxforms]
 ,[pa_taxmatters]
 ,[pa_taxyears]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" NULL="#j.DATA[1][6] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][7]#" NULL="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" NULL="#j.DATA[1][8] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][9]#" NULL="#j.DATA[1][9] eq "null"#"/>
,<cfqueryparam value="#j.DATA[1][10]#" NULL="#j.DATA[1][10] eq "null"#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN PA_ID--->
<cfreturn '{"id":#fquery.id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[powerofattorney]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[pa_dateofrevocation]=<cfqueryparam value="#j.DATA[1][3]#" NULL="#LEN(j.DATA[1][3]) eq 0#"/>
,[pa_datesenttoirs]=<cfqueryparam value="#j.DATA[1][4]#" NULL="#LEN(j.DATA[1][4]) eq 0#"/>
,[pa_datesignedbyclient]=<cfqueryparam value="#j.DATA[1][5]#" NULL="#LEN(j.DATA[1][5]) eq 0#"/>
,[pa_preparers]=<cfqueryparam value="#j.DATA[1][6]#" NULL="#j.DATA[1][6] eq "null"#"/>
,[pa_status]=<cfqueryparam value="#j.DATA[1][7]#" NULL="#LEN(j.DATA[1][7]) eq 0#"/>
,[pa_taxforms]=<cfqueryparam value="#j.DATA[1][8]#" NULL="#j.DATA[1][8] eq "null"#"/>
,[pa_taxmatters]=<cfqueryparam value="#j.DATA[1][9]#" NULL="#j.DATA[1][9] eq "null"#"/>
,[pa_taxyears]=<cfqueryparam value="#j.DATA[1][10]#" NULL="#j.DATA[1][10] eq "null"#"/>
WHERE[pa_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfif>
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
UPDATE[powerofattorney]
SET[pa_active]=0
WHERE[pa_id]=<cfqueryparam value="#ARGUMENTS.id#">
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