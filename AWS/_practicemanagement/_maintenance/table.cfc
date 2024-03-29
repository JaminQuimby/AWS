<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[selectName_id],[selectLabel],[selectDescription]
FROM[ctrl_selectnames]
WHERE[selectName_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
ORDER BY[selectLabel]
</cfquery>
</cfcase>
<!--- Load Group2--->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[select_id],[optionName],[optionDescription],[optionGroup],[optionHide],[option_1],[option_2],[option_3],[option_4]
FROM[ctrl_selectoptions]
WHERE[select_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
ORDER BY [optionName]
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
</cffunction>
<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP GROUP1 --->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[selectName_id],[selectName],[selectLabel],[selectDescription],[selectUsedIn],[form_id]
FROM[ctrl_selectnames]
WHERE[selectName]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
ORDER BY[selectLabel]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"SELECTNAME_ID":"'&SELECTNAME_ID&'","SELECTLABEL":"'&SELECTLABEL&'","SELECTDESCRIPTION":"'&SELECTDESCRIPTION&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!---  LOOKUP GROUP2 --->
<cfcase value="group2">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[select_id],[selectName_id],[optionValue_id],[optionName],[optionDescription]
,[optionGroupTEXT]=SUBSTRING((SELECT', '+[formName]FROM[ctrl_forms]WHERE(CAST([form_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](optionGroup)))FOR XML PATH('')),3,1000)
,[optionHideTEXT]=SUBSTRING((SELECT', '+[formName]FROM[ctrl_forms]WHERE(CAST([form_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](optionHide)))FOR XML PATH('')),3,1000)
FROM[v_selectoptions]
WHERE[selectName_id]= <cfqueryparam value="#ARGUMENTS.ID#"/>
ORDER BY[optionName]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"SELECT_ID":"'&SELECT_ID&'","OPTIONNAME":"'&OPTIONNAME&'","OPTIONGROUPTEXT":"'&OPTIONGROUPTEXT&'","OPTIONHIDETEXT":"'&OPTIONHIDETEXT&'","OPTIONDESCRIPTION":"'&OPTIONDESCRIPTION&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
</cfswitch>
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
<!--- Save Group2 --->
<cfcase value="group1">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="pquery" datasource="#Session.organization.name#">
SELECT COUNT(*)+1 AS [OPTIONCOUNT]FROM[ctrl_selectoptions]WHERE[selectName_id]=<cfqueryparam value=" #j.DATA[1][2]#"/>
</cfquery>
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[ctrl_selectoptions]([selectName_id],[optionValue_id],[optionName],[optionDescription],[optionGroup],[optionHide],[option_1],[option_2],[option_3],[option_4])
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,#pquery.OPTIONCOUNT#
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0 or j.DATA[1][6] eq 'null'#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0 or j.DATA[1][7] eq 'null'#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[select_id]
</cfquery>
<cfreturn '{"id":#fquery.select_id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>


<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[ctrl_selectoptions]
SET[optionName]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[optionDescription]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[optionGroup]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0  or j.DATA[1][6] eq 'null'#"/>
,[optionHide]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0 or j.DATA[1][7] eq 'null'#"/>
,[option_1]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[option_2]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[option_3]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[option_4]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
WHERE[select_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>