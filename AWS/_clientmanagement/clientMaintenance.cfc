<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- LOAD SELECT BOXES --->
<cffunction name="f_duplicateCheck" access="remote" output="true">
<cfargument name="check" type="string">
<cfargument name="loadType" type="string">

<cfswitch expression="#ARGUMENTS.loadType#">
<cfcase value="group1">
<cfset i=0>
<!--- Client_Name --->
<cfloop list="#ARGUMENTS.check#" index="s" delimiters=",">
<cfset i=i+1>
<cfset item[i]=s>
</cfloop>

<cfquery datasource="AWS" name="fquery" >
SELECT TOP(1)[client_name]FROM[client_listing]WHERE[client_name]=<cfqueryparam value="#item[1]#">
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



<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT TOP(1)
[client_id]
	,[client_active]
	,[client_credit_hold]
	,[client_group]
	,[client_name]
	,[client_notes]
	,[client_referred_by]
	,[client_salutation]
	,CONVERT(VARCHAR(10),[client_since], 101)AS[client_since]
	,[client_spouse]
	,[client_trade_name]
	,[client_type]
 	,[client_statelabel1]
	,[client_statelabel2]
	,[client_statelabel3]
	,[client_statelabel4]
	,[client_relations]
FROM[v_client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Custom Fields--->
<cfcase value="group1_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[field_id]
	,[field_name]
	,[field_value]
FROM[ctrl_customfields]
WHERE[field_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Taxes--->
<cfcase value="group2_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_tax_services]
	,[client_form_type]
	,[client_schedule_c]
	,[client_schedule_e]
	,[client_disregard]
	,[client_personal_property]
FROM[v_client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


<!--- Load Payroll--->
<cfcase value="group2_2">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_payroll_prep]
	,[client_payroll_freq]
	,[client_payroll_services] 
	,[client_pr_tax_deposit_schedule]
	,[client_1099_preperation]
	,[client_ein]
	,[client_pin]
	,[client_password]
FROM[v_client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


<!--- Load Accounting--->
<cfcase value="group2_3">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_accounting_services]
	,[client_bookkeeping]
	,[client_compilation]
	,[client_review]
	,[client_audit]
	,[client_fs_frequency]
	,[client_fiscal_year_end]
	,[client_software]
	,[client_version]
	,[client_username]
	,[client_password2]
FROM[v_client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>



<!--- Load Contact--->
<cfcase value="group3">
<cfquery datasource="AWS" name="fQuery">
SELECT[contact_id]
,[contact_acctsoftwareupdate]
,[contact_address1]
,[contact_address2]
,[contact_city]
,[contact_customLabel]
,[contact_customValue]
,[contact_effectivedate]=FORMAT(contact_effectivedate,'d','#Session.localization.language#')
,[contact_email1]
,[contact_email2]
,[contact_ext1]
,[contact_ext2]
,[contact_name]
,[contact_phone1]=FORMAT(contact_phone1,'#Session.localization.formatphone#')
,[contact_phone2]=FORMAT(contact_phone2,'#Session.localization.formatphone#')
,[contact_phone3]=FORMAT(contact_phone3,'#Session.localization.formatphone#')
,[contact_phone4]=FORMAT(contact_phone4,'#Session.localization.formatphone#')
,[contact_phone5]=FORMAT(contact_phone5,'#Session.localization.formatphone#')
,[contact_state]
,[contact_taxupdate]
,[contact_type]
,[contact_website]
,[contact_zip]
FROM[v_client_contact]
WHERE[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>



<!--- Load STATE INFORMATION --->
<cfcase value="group5">
<cfquery datasource="AWS" name="fQuery">
SELECT[si_id]
	,[si_state]
    ,[si_revenue]
    ,[si_employees]
    ,[si_property]
    ,[si_nexus]
    ,[si_reason]
    ,[si_registered]
    ,[si_misc1]
    ,[si_misc2]
    ,[si_misc3]
    ,[si_misc4]
FROM[v_client_state]
WHERE[si_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load State Labels--->
<cfcase value="group5_1">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_statelabel1]
	,[client_statelabel2]
    ,[client_statelabel3]
    ,[client_statelabel4]
FROM[v_client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


<!--- Load CLIENT RELATIONS --->
<cfcase value="group6">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_relations]
FROM[v_client_listing]
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

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP CLIENT --->
<cfcase value="group0">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[client_id]
,[client_name]
,[client_salutation]
,CONVERT(VARCHAR(10),[client_since], 101)AS[client_since]
,[client_type]
,[client_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_clienttype'AND[client_type]=[optionvalue_id])
FROM[v_client_listing]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CLIENT_SALUTATION":"'&CLIENT_SALUTATION&'","CLIENT_TYPETEXT":"'&CLIENT_TYPETEXT&'","CLIENT_SINCE":"'&CLIENT_SINCE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP CUSTOM FIELDS --->
<cfcase value="group1_1"><cfquery datasource="AWS" name="fquery">
SELECT[field_id],[field_name],[field_value]
FROM[ctrl_customfields]
WHERE[form_id]='1'
<cfif ARGUMENTS.ID neq "0">
AND[field_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfif>
AND[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[field_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[field_name]</cfif></cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FIELD_ID":"'&FIELD_ID&'","FIELD_NAME":"'&FIELD_NAME&'","FIELD_VALUE":"'&FIELD_VALUE&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP CONTACT --->
<cfcase value="group3">
<cfquery datasource="AWS" name="fquery">
SELECT[contact_id]
,[contact_name]
,[contact_phone1]=FORMAT(contact_phone1,'#Session.localization.formatphone#')
,[contact_email1]
FROM[client_contact]
WHERE
<cfif ARGUMENTS.ID neq "0">[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND</cfif>
[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>AND
[contact_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>

<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[contact_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CONTACT_ID":"'&CONTACT_ID&'","CONTACT_NAME":"'&CONTACT_NAME&'","CONTACT_PHONE1":"'&CONTACT_PHONE1&'","CONTACT_EMAIL1":"'&CONTACT_EMAIL1&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Financial Statements --->
<cfcase value="group4_1">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[client_id]
,[client_name]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
,[fds_year]
,CONVERT(VARCHAR(10),[fds_periodend], 101)AS[fds_periodend]
FROM[v_financialDataStatus]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'","FDS_YEAR":"'&FDS_YEAR&'","FDS_PERIODEND":"'&FDS_PERIODEND&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group4_2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,[mc_assignedto]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,[mc_description]
,[mc_status]
,CONVERT(VARCHAR(10),[mc_duedate], 101)AS[mc_duedate]
FROM[v_managementconsulting]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","MC_ID":"'&MC_ID&'","MC_ASSIGNEDTO":"'&MC_ASSIGNEDTO&'","CLIENT_NAME":"'&CLIENT_NAME&'","MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'","MC_DESCRIPTION":"'&MC_DESCRIPTION&'","MC_STATUS":"'&MC_STATUS&'","MC_DUEDATE":"'&MC_DUEDATE&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>



<!--- LOOKUP Payroll Checks --->
<cfcase value="group4_3">
<cfquery datasource="AWS" name="fquery">
SELECT[pc_id]
,[pc_year]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PC_YEAR":"'&PC_YEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group4_4">
<cfquery datasource="AWS" name="fquery">
SELECT[pt_id]
,[pt_year]
,[client_name]
,[client_id]
FROM[v_payrolltaxes]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","PT_YEAR":"'&PT_YEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group4_5">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[client_name]
,[client_id]
FROM[v_taxreturns]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
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

<!--- LOOKUP Other Filings --->
<cfcase value="group4_6">
<cfquery datasource="AWS" name="fquery">
SELECT[of_id]
,[of_taxyear]
,[client_name]
,[client_id]
FROM[v_otherfilings]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","OF_TAXYEAR":"'&OF_TAXYEAR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP STATE INFORMATION --->
<cfcase value="group5">
<cfquery datasource="AWS" name="fquery">
SELECT[si_id]
,[si_revenue]
,[si_employees]
,[si_property]
,[si_nexus]
,[si_reason]
,[si_registered]
,[si_misc1]
,[si_misc2]
,[si_misc3]
,[si_misc4]
,[si_stateTEXT]
FROM[v_client_state]
WHERE(
<cfif ARGUMENTS.ID neq "0">[si_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND</cfif>
[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>AND
[si_reason]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> )
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"SI_ID":"'&SI_ID&'"
								,"SI_STATETEXT":"'&SI_STATETEXT&'"
								,"SI_REVENUE":"'&SI_REVENUE&'"
								,"SI_EMPLOYEES":"'&SI_EMPLOYEES&'"
								,"SI_PROPERTY":"'&SI_PROPERTY&'"
								,"SI_NEXUS":"'&SI_NEXUS&'"
								,"SI_REASON":"'&SI_REASON&'"
								,"SI_REGISTERED":"'&SI_REGISTERED&'"
								,"SI_MISC1":"'&SI_MISC1&'"
								,"SI_MISC2":"'&SI_MISC2&'"
								,"SI_MISC3":"'&SI_MISC3&'"
								,"SI_MISC4":"'&SI_MISC4&'"
								}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP client relations --->
<cfcase value="group6">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[client_id]
,[client_name]
,[client_active]
,CONVERT(VARCHAR(10),[client_since], 101)AS[client_since]
,[client_typeTEXT]
,[client_type]
FROM[v_client_listing]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfset i=0>AND(<cfif ARGUMENTS.ID neq "null"><cfloop index="cid" list="#ARGUMENTS.ID#"><cfset i=i+1><cfif cid neq"">[client_id]=<cfqueryparam value="#cid#"/><cfif not listLen(ARGUMENTS.ID) eq i>OR</cfif></cfif></cfloop><cfelse>[client_id]=0</cfif>)
AND NOT[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CLIENT_ACTIVE":"'&CLIENT_ACTIVE&'","CLIENT_SINCE":"'&CLIENT_SINCE&'","CLIENT_TYPETEXT":"'&CLIENT_TYPETEXT&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>

</cfcase>


</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.client_id#","MESSAGE":"#cfcatch.detail#"]}'> 
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


<!--- Group 1 --->
<cfcase value="group1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_listing](
[client_active],
[client_credit_hold],
[client_group],
[client_name],
[client_notes],
[client_referred_by],
[client_salutation],
[client_since],
[client_spouse],
[client_trade_name],
[client_type]
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
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>)
SELECT SCOPE_IDENTITY()AS[client_id]
</cfquery>
<cfreturn '{"id":#fquery.client_id#,"group":"group1_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[client_listing]
SET[client_active]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[client_credit_hold]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[client_group]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[client_name]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[client_notes]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[client_referred_by]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[client_salutation]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[client_since]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[client_spouse]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[client_trade_name]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[client_type]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group1_2","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>

</cfif>

</cfcase>
<!---Group 1_2 Custom Fields --->
<cfcase value="group1_2">
<cfif j.DATA[1][2] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[ctrl_customfields](
[form_id]
,[client_id]
,[field_name]
,[field_value]
)
VALUES(
<cfqueryparam value="1">
,<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[field_id]
</cfquery>
<cfreturn '{"id":#fquery.id#,"group":"group2_1","result":"ok"}'>
</cfif>
<cfif j.DATA[1][2] neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[ctrl_customfields]
SET[field_name]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[field_value]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
WHERE[field_id]=<cfqueryparam value="#j.DATA[1][2]#">
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
</cfif>

</cfcase>

<!--- Taxes --->
<cfcase value="group2_1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_listing](
[client_tax_services]
,[client_form_type]
,[client_schedule_c]
,[client_schedule_e]
,[client_disregard]
,[client_personal_property]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
SELECT SCOPE_IDENTITY()AS[client_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_tax_services]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_form_type]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[client_schedule_c]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[client_schedule_e]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[client_disregard]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[client_personal_property]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_2","result":"ok"}'>
</cfif>
</cfcase>


<!--- Payroll --->
<cfcase value="group2_2">
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][2]#)><cfset #j.DATA[1][2]#=1><cfelse><cfset #j.DATA[1][2]#=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][4]#)><cfset #j.DATA[1][4]#=1><cfelse><cfset #j.DATA[1][4]#=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][6]#)><cfset #j.DATA[1][6]#=1><cfelse><cfset #j.DATA[1][6]#=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_listing](
[client_payroll_prep]
,[client_payroll_freq]
,[client_payroll_services]
,[client_pr_tax_deposit_schedule]
,[client_1099_preperation]
,[client_ein]
,[client_pin]
,[client_password]
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
SELECT SCOPE_IDENTITY()AS[client_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[client_listing]
SET[client_payroll_prep]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_payroll_freq]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[client_payroll_services]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[client_pr_tax_deposit_schedule]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[client_1099_preperation]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[client_ein]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[client_pin]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[client_password]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_3","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>

<!--- Accounting --->
<cfcase value="group2_3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_listing](
[client_accounting_services]
,[client_bookkeeping]
,[client_compilation]
,[client_review]
,[client_audit]
,[client_fs_frequency]
,[client_fiscal_year_end]
,[client_software]
,[client_version]
,[client_username]
,[client_password2]
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
SELECT SCOPE_IDENTITY()AS[client_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3","result":"ok"}'>
</cfif>
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_accounting_services]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_bookkeeping]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[client_compilation]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[client_review]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[client_audit]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[client_fs_frequency]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[client_fiscal_year_end]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[client_software]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[client_version]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[client_username]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[client_password2]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group3","result":"ok"}'>
</cfif>
</cfcase>


<!--- Contacts --->
<cfcase value="group3">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][21])><cfset j.DATA[1][21]=1><cfelse><cfset j.DATA[1][21]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_contact](
[client_id]
,[contact_acctsoftwareupdate]
,[contact_address1]
,[contact_address2]
,[contact_city]
,[contact_customLabel]
,[contact_customValue]
,[contact_effectivedate]
,[contact_email1]
,[contact_email2]
,[contact_ext1]
,[contact_ext2]
,[contact_name]
,[contact_phone1]
,[contact_phone2]
,[contact_phone3]
,[contact_phone4]
,[contact_phone5]
,[contact_state]
,[contact_taxupdate]
,[contact_type]
,[contact_website]
,[contact_zip]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#">
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#">
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#">
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#">
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#">
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#">
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#">
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#">
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#">
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#">
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#">
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#">
,<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#">
,<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#">
,<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#">
,<cfqueryparam value="#j.DATA[1][17]#" null="#LEN(j.DATA[1][17]) eq 0#">
,<cfqueryparam value="#j.DATA[1][18]#" null="#LEN(j.DATA[1][18]) eq 0#">
,<cfqueryparam value="#j.DATA[1][19]#" null="#LEN(j.DATA[1][19]) eq 0#">
,<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][20]) eq 0#">
,<cfqueryparam value="#j.DATA[1][21]#" null="#LEN(j.DATA[1][21]) eq 0#">
,<cfqueryparam value="#j.DATA[1][22]#" null="#LEN(j.DATA[1][22]) eq 0#">
)
SELECT SCOPE_IDENTITY()AS[contact_id]
</cfquery>
<cfreturn '{"id":#fquery.contact_id#,"group":"group5","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif j.DATA[1][1] neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[client_contact]
SET[contact_acctsoftwareupdate]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#">
,[contact_address1]= <cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[contact_address2]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[contact_city]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[contact_customLabel]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[contact_customValue]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[contact_effectivedate]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#">
,[contact_email1]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[contact_email2]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[contact_ext1]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[contact_ext2]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
,[contact_name]=<cfqueryparam value="#j.DATA[1][14]#" null="#LEN(j.DATA[1][14]) eq 0#"/>
,[contact_phone1]=<cfqueryparam value="#j.DATA[1][15]#" null="#LEN(j.DATA[1][15]) eq 0#"/>
,[contact_phone2]=<cfqueryparam value="#j.DATA[1][16]#" null="#LEN(j.DATA[1][16]) eq 0#"/>
,[contact_phone3]=<cfqueryparam value="#j.DATA[1][17]#"null="#LEN(j.DATA[1][17]) eq 0#"/>
,[contact_phone4]=<cfqueryparam value="#j.DATA[1][18]#"null="#LEN(j.DATA[1][18]) eq 0#"/>
,[contact_phone5]=<cfqueryparam value="#j.DATA[1][19]#"null="#LEN(j.DATA[1][19]) eq 0#"/>
,[contact_state]=<cfqueryparam value="#j.DATA[1][20]#"null="#LEN(j.DATA[1][20]) eq 0#"/>
,[contact_taxupdate]=<cfqueryparam value="#j.DATA[1][21]#"null="#LEN(j.DATA[1][21]) eq 0#"/>
,[contact_type]=<cfqueryparam value="#j.DATA[1][22]#"null="#LEN(j.DATA[1][22]) eq 0#"/>
,[contact_website]=<cfqueryparam value="#j.DATA[1][23]#"null="#LEN(j.DATA[1][23]) eq 0#"/>
,[contact_zip]=<cfqueryparam value="#j.DATA[1][24]#"null="#LEN(j.DATA[1][24]) eq 0#"/>
WHERE[contact_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group5","result":"ok"}'>
</cfif>
</cfcase>


<!--- State Information --->
<cfcase value="group5">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][11])><cfset j.DATA[1][11]=1><cfelse><cfset j.DATA[1][11]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][13])><cfset j.DATA[1][13]=1><cfelse><cfset j.DATA[1][13]=0></cfif>
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_state](
[client_id]
,[si_employees]
,[si_nexus]
,[si_property]
,[si_reason]
,[si_registered]
,[si_revenue]
,[si_state]
,[si_misc1]
,[si_misc2]
,[si_misc3]
,[si_misc4]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#">
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
, <cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[si_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group5_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif j.DATA[1][1] neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[client_state]
SET[si_employees]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[si_nexus]= <cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[si_property]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
,[si_reason]=<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,[si_registered]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[si_revenue]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[si_state]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[si_misc1]=<cfqueryparam value="#j.DATA[1][10]#" null="#LEN(j.DATA[1][10]) eq 0#"/>
,[si_misc2]=<cfqueryparam value="#j.DATA[1][11]#" null="#LEN(j.DATA[1][11]) eq 0#"/>
,[si_misc3]=<cfqueryparam value="#j.DATA[1][12]#" null="#LEN(j.DATA[1][12]) eq 0#"/>
,[si_misc4]=<cfqueryparam value="#j.DATA[1][13]#" null="#LEN(j.DATA[1][13]) eq 0#"/>
WHERE[si_id]=<cfqueryparam value="#j.DATA[1][1]#">
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group5_1","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
</cfcase>

<!--- State Labels --->
<cfcase value="group5_1">
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[client_listing](
,[client_statelabel1]
,[client_statelabel2]
,[client_statelabel3]
,[client_statelabel4]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#">
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
, <cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[client_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group6","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif j.DATA[1][1] neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[client_listing]
SET[client_statelabel1]=<cfqueryparam value="#j.DATA[1][2]#">
,[client_statelabel2]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[client_statelabel3]= <cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[client_statelabel4]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#">
</cfquery>
</cfif>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group6","result":"ok"}'>
</cfcase>


<!--- Client Relations --->
<cfcase value="group6">
<cfif j.DATA[1][1] neq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[client_listing]
SET[client_relations]=<cfqueryparam value="#j.DATA[1][2]#">
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#">
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

<cffunction name="f_removeData" access="remote" output="false">
<cfargument name="id" type="numeric" required="yes" default="0">
<cfargument name="group" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.group#">
<!--- Load Group1--->
<cfcase value="group0">
<cfquery datasource="AWS" name="fQuery">
update[client_listing]
SET[client_active]=0
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.id#">
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