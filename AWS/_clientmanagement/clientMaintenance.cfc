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

<cfquery datasource="#Session.organization.name#" name="fquery" >
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT TOP(1)
[client_id]
	,[client_active]
	,[client_credit_hold]
	,[client_group]
	,[client_name]
	,[client_notes]
	,[client_referred_by]
	,[client_salutation]
	,[client_since]=FORMAT(client_since,'#Session.localization.formatdate#')
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[field_id]
	,[field_name]
	,[field_value]
    ,[field_global]
FROM[ctrl_customfields]
WHERE[field_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>

<!--- Load Taxes--->
<cfcase value="group2_1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[contact_id]
,[contact_acctsoftwareupdate]
,[contact_address1]
,[contact_address2]
,[contact_city]
,[contact_customLabel]
,[contact_customValue]
,[contact_effectivedate]=FORMAT(contact_effectivedate,'#Session.localization.formatdate#')
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
,[contact_title]
,[contact_type]
,[contact_website]
,[contact_zip]
FROM[v_client_contact]
WHERE[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>



<!--- Load STATE INFORMATION --->
<cfcase value="group5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[client_statelabel1]
	,[client_statelabel2]
    ,[client_statelabel3]
    ,[client_statelabel4]
FROM[v_client_listing]
WHERE[client_active]=(1)AND[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


<!--- Load CLIENT RELATIONS --->
<cfcase value="group6">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[client_relations]
FROM[v_client_listing]
WHERE[client_active]=(1)AND[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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
<!--- LOOKUP CLIENT --->
<cfcase value="group0">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[client_id]
,[client_name]
,[client_salutation]
,[client_since]=FORMAT(client_since,'#Session.localization.formatdate#') 
,[client_type]
,[client_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_clienttype'AND[client_type]=[optionvalue_id])
FROM[v_client_listing]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
AND [deleted] IS NULL
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
<cfcase value="group1_1"><cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[field_id]
,[field_name]
,[field_value]
,[field_global]
FROM[ctrl_customfields]
WHERE[form_id]='1'
AND[field_active]='1'
AND [deleted] IS NULL
AND([client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/> OR [field_global]=1 )
<cfif ARGUMENTS.ID neq "0">
AND[field_id]=<cfqueryparam value="#ARGUMENTS.ID#"/></cfif>
AND[field_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[field_name]</cfif></cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FIELD_ID":"'&FIELD_ID&'","FIELD_NAME":"'&FIELD_NAME&'","FIELD_VALUE":"'&FIELD_VALUE&'","FIELD_GLOBAL":"'&FIELD_GLOBAL&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- LOOKUP CONTACT --->
<cfcase value="group3">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[contact_id]
,[contact_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_contacttype'AND[contact_type]=[optionvalue_id])
,[contact_name]
,[contact_title]
,[contact_phone1]=FORMAT(contact_phone1,'#Session.localization.formatphone#')
,[contact_email1]
FROM[client_contact]
WHERE[contact_active]=(1)
AND [deleted] IS NULL
<cfif ARGUMENTS.ID neq "0">AND[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/></cfif>
AND[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[contact_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[contact_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CONTACT_ID":"'&CONTACT_ID&'"
								,"CONTACT_NAME":"'&CONTACT_NAME&'"
								,"CONTACT_TYPETEXT":"'&CONTACT_TYPETEXT&'"
								,"CONTACT_TITLE":"'&CONTACT_TITLE&'"
								,"CONTACT_PHONE1":"'&CONTACT_PHONE1&'"
								,"CONTACT_EMAIL1":"'&CONTACT_EMAIL1&'"
								}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group4_1">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[mc_id]
,[client_id]
,[client_name]
,[mc_requestforservice]=FORMAT(mc_requestforservice,'#Session.localization.formatdate#') 
,[mc_projectcompleted]=FORMAT(mc_projectcompleted,'#Session.localization.formatdate#') 
,[mc_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,[mc_priority]
,[mc_assignedtoTEXT]
,[mc_duedate]=FORMAT(mc_duedate,'#Session.localization.formatdate#') 
,[mc_esttime]
,[mc_category]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='2'OR[form_id]='0')AND([optionGroup]='2'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
FROM[v_managementconsulting]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'"
								,"MC_ID":"'&MC_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_STATUSTEXT":"'&MC_STATUSTEXT&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'"
								}'>
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

<cfcase value="group4_2">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT [as_id]
,[client_id]
,[client_name]
,[as_duedate]=FORMAT(as_duedate,'#Session.localization.formatdate#') 
,[as_assignedto]
,[as_category]
,[as_datereqested]=FORMAT(as_datereqested,'#Session.localization.formatdate#') 
,CASE WHEN LEN([as_taskdesc]) >= 101 THEN SUBSTRING([as_taskdesc],0,100) +  '...' ELSE [as_taskdesc] END AS[as_taskdesc]
,[as_status]
,[as_assignedtoTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](as_assignedto)))FOR XML PATH('')),3,1000)
,[as_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[as_category]=[optionvalue_id])
,[as_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[as_status]=[optionvalue_id])

FROM[v_administrativetasks]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"AS_ID":"'&AS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"AS_CATEGORYTEXT":"'&AS_CATEGORYTEXT&'"
								,"AS_TASKDESC":"'&AS_TASKDESC&'"
								,"AS_DUEDATE":"'&AS_DUEDATE&'"
								,"AS_STATUSTEXT":"'&AS_STATUSTEXT&'"
								,"AS_ASSIGNEDTOTEXT":"'&AS_ASSIGNEDTOTEXT&'"
								,"AS_DATEREQESTED":"'&AS_DATEREQESTED&'"	
								}'>
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


<cfcase value="group4_3">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,[bf_missinginforeceived]=FORMAT(bf_missinginforeceived,'#Session.localization.formatdate#') 
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_assignedtoTEXT]
,[bf_duedate]=FORMAT(bf_duedate,'#Session.localization.formatdate#') 
,[bf_activity]
,[bf_owners]
,[bf_businesstypeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[bf_businesstype]=[optionvalue_id])
,[bf_missinginfo]

FROM[v_businessformation]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ACTIVITY":"'&BF_ACTIVITY&'"
								,"BF_OWNERS":"'&BF_OWNERS&'"
								,"BF_BUSINESSTYPETEXT":"'&BF_BUSINESSTYPETEXT&'"
								,"BF_DUEDATE":"'&BF_DUEDATE&'"
								,"BF_STATUSTEXT":"'&BF_STATUSTEXT&'"
								,"BF_ASSIGNEDTOTEXT":"'&BF_ASSIGNEDTOTEXT&'"
								,"BF_MISSINGINFO":"'&BF_MISSINGINFO&'"
								,"BF_MISSINGINFORECEIVED":"'&BF_MISSINGINFORECEIVED&'"
								}'>
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

<cfcase value="group4_4">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[co_id]
,[co_forTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](co_for)))FOR XML PATH('')),3,1000)
,CASE WHEN LEN([co_briefmessage]) >= 101 THEN SUBSTRING([co_briefmessage],0,100) +  '...' ELSE [co_briefmessage] END AS[co_briefmessage]
,[co_caller]
,[co_duedate]=FORMAT(co_duedate,'#Session.localization.formatdate#')
,[co_date]=FORMAT(co_duedate,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[co_status]
,[co_responseneeded]
,[co_returncall]
,[client_name]
,[client_id]
,[co_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[co_status]=[optionvalue_id])
FROM[v_communications]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_DATE":"'&CO_DATE&'"
								,"CO_DUEDATE":"'&CO_DUEDATE&'"
								,"CO_STATUSTEXT":"'&CO_STATUSTEXT&'"
								,"CO_FORTEXT":"'&CO_FORTEXT&'"
								,"CO_RESPONSENEEDED":"'&CO_RESPONSENEEDED&'"
								,"CO_RETURNCALL":"'&CO_RETURNCALL&'"
								,"CO_BRIEFMESSAGE":"'&CO_BRIEFMESSAGE&'"
								}'>
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

<!--- Grid 0 Entrance --->
<cfcase value="group4_5">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[ftp_id]
,[ftp_status]
,[ftp_category]
,[ftp_description]
,[ftp_assignedtoTEXT]
,[ftp_duedate]=FORMAT(ftp_duedate,'#Session.localization.formatdate#')
,[ftp_requestservice]=FORMAT(ftp_requestservice,'#Session.localization.formatdate#')
,[ftp_missinginfo]
,[client_name]
,[client_id]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])AS[ftp_categoryTEXT]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])AS[ftp_statusTEXT]
FROM[v_financialtaxplanning]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'"
 									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"FTP_CATEGORYTEXT":"'&FTP_CATEGORYTEXT&'"
									,"FTP_DESCRIPTION":"'&FTP_DESCRIPTION&'"
									,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
									,"FTP_STATUSTEXT":"'&FTP_STATUSTEXT&'"
									,"FTP_ASSIGNEDTOTEXT":"'&FTP_ASSIGNEDTOTEXT&'"
 									,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
 									,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								}'>
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

<!--- LOOKUP Financial Statements --->
<cfcase value="group4_6">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[fds_id]
 	,[client_id]
 	,[client_name]
 	,[fds_periodend]=FORMAT(fds_periodend,'#Session.localization.formatdate#') 
	,[fds_month]
	,[fds_year]
	,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
	,[fds_duedate]=FORMAT(fds_duedate,'#Session.localization.formatdate#') 
	,[fds_status]
	,[fds_missinginfo]
 	,[fds_compilemi]
	,[fds_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id])
	,[fds_obtaininfo_datecompleted]=ISNULL(FORMAT(fds_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_obtaininfo_assignedtoTEXT]
	,[fds_sort_datecompleted]=ISNULL(FORMAT(fds_sort_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_sort_assignedtoTEXT]
	,[fds_checks_datecompleted]=ISNULL(FORMAT(fds_checks_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_checks_assignedtoTEXT]
	,[fds_sales_datecompleted]=ISNULL(FORMAT(fds_sales_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_sales_assignedtoTEXT]
	,[fds_entry_datecompleted]=ISNULL(FORMAT(fds_entry_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_entry_assignedtoTEXT]
	,[fds_reconcile_datecompleted]=ISNULL(FORMAT(fds_reconcile_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_reconcile_assignedtoTEXT]
	,[fds_compile_datecompleted]=ISNULL(FORMAT(fds_compile_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_compile_assignedtoTEXT]
	,[fds_review_datecompleted]=ISNULL(FORMAT(fds_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_review_assignedtoTEXT]
	,[fds_assembly_datecompleted]=ISNULL(FORMAT(fds_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_assembly_assignedtoTEXT]
	,[fds_delivery_datecompleted]=ISNULL(FORMAT(fds_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_delivery_assignedtoTEXT]
	,[fds_acctrpt_datecompleted]=ISNULL(FORMAT(fds_acctrpt_datecompleted,'#Session.localization.formatdate#'),'N/A')
	,[fds_acctrpt_assignedtoTEXT]
FROM[v_financialDataStatus]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_PERIODEND":"'&FDS_PERIODEND&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_STATUSTEXT":"'&FDS_STATUSTEXT&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_OBTAININFO":"'&fds_obtaininfo_datecompleted&'<br/>'&fds_obtaininfo_assignedtoTEXT&'"
								,"FDS_SORT":"'&fds_sort_datecompleted&'<br/>'&fds_sort_assignedtoTEXT&'"
								,"FDS_CHECKS":"'&fds_checks_datecompleted&'<br/>'&fds_checks_assignedtoTEXT&'"
								,"FDS_SALES":"'&fds_sales_datecompleted&'<br/>'&fds_sales_assignedtoTEXT&'"
								,"FDS_ENTRY":"'&fds_entry_datecompleted&'<br/>'&fds_entry_assignedtoTEXT&'"
								,"FDS_RECONCILE":"'&fds_reconcile_datecompleted&'<br/>'&fds_reconcile_assignedtoTEXT&'"
								,"FDS_COMPILE":"'&fds_compile_datecompleted&'<br/>'&fds_compile_assignedtoTEXT&'"
								,"FDS_REVIEW":"'&fds_review_datecompleted&'<br/>'&fds_review_assignedtoTEXT&'"
								,"FDS_ASSEMBLY":"'&fds_assembly_datecompleted&'<br/>'&fds_assembly_assignedtoTEXT&'"
								,"FDS_DELIVERY":"'&fds_delivery_datecompleted&'<br/>'&fds_delivery_assignedtoTEXT&'"
								,"FDS_ACCTRPT":"'&fds_acctrpt_datecompleted&'<br/>'&fds_acctrpt_assignedtoTEXT&'"

								}'>
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

<cfcase value="group4_7">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[n_id]
,[nst_id]
,[client_name]
,[client_id]
,[n_name]
,[nst_assignedtoTEXT]
,[nst_status]
,[nst_1_noticenumberTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_noticenumber'AND[nst_1_noticenumber]=[optionvalue_id])
,[nst_1_taxform]
,[nst_1_taxyear]
,[nst_1_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[nst_1_taxform]=[optionvalue_id])
,[nst_1_resduedate]=FORMAT(nst_1_resduedate,'#Session.localization.formatdate#')
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
,[nst_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[nst_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&n_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&N_NAME&'"
								,"N_STATUSTEXT":"'&N_STATUSTEXT&'"
								,"NST_1_TAXYEAR":"'&NST_1_TAXYEAR&'"
								,"NST_1_TAXFORMTEXT":"'&NST_1_TAXFORMTEXT&'"
								,"NST_1_NOTICENUMBERTEXT":"'&NST_1_NOTICENUMBERTEXT&'"
								,"NST_1_RESDUEDATE":"'&NST_1_RESDUEDATE&'"
								,"NST_STATUSTEXT":"'&NST_STATUSTEXT&'"	
								}'>
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


<!--- LOOKUP Other Filings --->
<cfcase value="group4_8">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[of_id]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_type]
,[of_form]
,[of_periodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])
,[of_obtaininfo_assignedto]
,[of_preparation_assignedto]
,[of_review_assignedto]
,[of_assembly_assignedto]
,[of_delivery_assignedto]
,[of_duedate]=FORMAT(of_duedate,'#Session.localization.formatdate#') 
,[of_missinginfo]
,[of_missinginforeceived]=FORMAT(of_missinginforeceived,'#Session.localization.formatdate#') 
,[of_filingdeadline]=FORMAT(of_filingdeadline,'#Session.localization.formatdate#') 
,[client_name]
,[client_id]
,[of_obtaininfo_datecompleted]=ISNULL(FORMAT(of_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_obtaininfo_assignedtoTEXT]
,[of_preparation_datecompleted]=ISNULL(FORMAT(of_preparation_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_preparation_assignedtoTEXT]
,[of_review_datecompleted]=ISNULL(FORMAT(of_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_review_assignedtoTEXT]
,[of_assembly_datecompleted]=ISNULL(FORMAT(of_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_assembly_assignedtoTEXT]
,[of_delivery_datecompleted]=ISNULL(FORMAT(of_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_delivery_assignedtoTEXT] 
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_type]=[optionvalue_id])
,[of_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_state]=[optionvalue_id])
FROM[v_otherfilings]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
 								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"OF_TAXYEAR":"'&OF_TAXYEAR&'"								
								,"OF_PERIODTEXT":"'&OF_PERIODTEXT&'"
								,"OF_STATETEXT":"'&OF_STATETEXT&'"
								,"OF_TYPETEXT":"'&OF_TYPETEXT&'"
 								,"OF_FORMTEXT":"'&OF_FORMTEXT&'"
								,"OF_DUEDATE":"'&OF_DUEDATE&'"						
								,"OF_FILINGDEADLINE":"'&OF_FILINGDEADLINE&'"
 								,"OF_STATUSTEXT":"'&OF_STATUSTEXT&'"
	 							,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
	 							,"OF_MISSINGINFORECEIVED":"'&OF_MISSINGINFORECEIVED&'"								
								,"OF_OBTAININFO":"'&of_obtaininfo_datecompleted&'<br/>'&of_obtaininfo_assignedtoTEXT&'"
								,"OF_PREPARATION":"'&of_preparation_datecompleted&'<br/>'&of_preparation_assignedtoTEXT&'"
								,"OF_REVIEW":"'&of_review_datecompleted&'<br/>'&of_review_assignedtoTEXT&'"
								,"OF_ASSEMBLY":"'&of_assembly_datecompleted&'<br/>'&of_assembly_assignedtoTEXT&'"
								,"OF_DELIVERY":"'&of_delivery_datecompleted&'<br/>'&of_delivery_assignedtoTEXT&'"	
								}'>
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
<cfcase value="group4_9">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pc_id]
,[pc_year]
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
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
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
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group4_10">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pt_id]
,[pt_year]
,[pt_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[pt_state]=[optionvalue_id])
,[pt_duedate]=FORMAT(pt_duedate,'#Session.localization.formatdate#') 
,[pt_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[pt_month]=[optionvalue_id])
,[pt_lastpay]=FORMAT(pt_lastpay,'#Session.localization.formatdate#') 
,[pt_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_returntypes'AND[pt_type]=[optionvalue_id])
,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#') 
,[pt_obtaininfo_datecompleted]=ISNULL(FORMAT(pt_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_obtaininfo_assignedtoTEXT]
,[pt_entry_datecompleted]=ISNULL(FORMAT(pt_entry_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_entry_assignedtoTEXT]
,[pt_rec_datecompleted]=ISNULL(FORMAT(pt_rec_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_rec_assignedtoTEXT]
,[pt_review_datecompleted]=ISNULL(FORMAT(pt_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_review_assignedtoTEXT]
,[pt_assembly_datecompleted]=ISNULL(FORMAT(pt_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_assembly_assignedtoTEXT]
,[pt_delivery_datecompleted]=ISNULL(FORMAT(pt_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_delivery_assignedtoTEXT]
,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#')
,[pt_missinginfo]
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
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
 								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTHTEXT":"'&PT_MONTHTEXT&'"
								,"PT_STATETEXT":"'&PT_STATETEXT&'"
								,"PT_TYPETEXT":"'&PT_TYPETEXT&'"
 								,"PT_LASTPAY":"'&PT_LASTPAY&'"
  								,"PT_DUEDATE":"'&PT_DUEDATE&'"
	 							,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
	 							,"PT_MISSINGINFORECEIVED":"'&PT_MISSINGINFORECEIVED&'"
								,"PT_OBTAININFO":"'&pt_obtaininfo_datecompleted&'<br/>'&pt_obtaininfo_assignedtoTEXT&'"
								,"PT_ENTRY":"'&pt_entry_datecompleted&'<br/>'&pt_entry_assignedtoTEXT&'"
								,"PT_REC":"'&pt_rec_datecompleted&'<br/>'&pt_rec_assignedtoTEXT&'"
								,"PT_REVIEW":"'&pt_review_datecompleted&'<br/>'&pt_review_assignedtoTEXT&'"
								,"PT_ASSEMBLY":"'&pt_assembly_datecompleted&'<br/>'&pt_assembly_assignedtoTEXT&'"
								,"PT_DELIVERY":"'&pt_delivery_datecompleted&'<br/>'&pt_delivery_assignedtoTEXT&'"
								}'>
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

<!--- LOOKUP PERSONAL PROPERTY TAX RETURNS --->
<cfcase value="group4_11">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_4_extended]=FORMAT(tr_4_extended,'#Session.localization.formatdate#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'#Session.localization.formatdate#') 
,[tr_taxyear]
,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'#Session.localization.formatdate#')
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[tr_4_pptresttime]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'#Session.localization.formatdate#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'#Session.localization.formatdate#') 
FROM[v_taxreturns]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
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
								,"TR_4_EXTENDED":"'&TR_4_EXTENDED&'"
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
								,"TR_4_PPTRESTTIME":"'&TR_4_PPTRESTTIME&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"
								}'>
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

<cfcase value="group4_12">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[pa_id]
,[pa_taxyears]
,[pa_taxforms]
,[pa_preparers]
,[pa_status]
,[pa_taxmatters]
,[client_name]
,[client_id]
,[pa_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[pa_status]=[optionvalue_id])
,[pa_taxformsTEXT]=SUBSTRING((SELECT', '+[optionName]FROM[v_selectOptions]WHERE(form_id='0'OR[form_id]='#ARGUMENTS.formid#')AND(optionGroup='1'OR[optionGroup]='0')AND(selectName='global_taxservices') AND(CAST([optionValue_id]AS nvarchar(5))IN(SELECT[id]FROM[CSVToTable](pa_taxforms)))FOR XML PATH('')),3,1000)
,[pa_taxmattersTEXT]=SUBSTRING((SELECT', '+[optionName]FROM[v_selectOptions]WHERE(form_id='0'OR[form_id]='#ARGUMENTS.formid#')AND(optionGroup='1'OR[optionGroup]='0')AND(selectName='global_taxmatters') AND(CAST([optionValue_id]AS nvarchar(5))IN(SELECT[id]FROM[CSVToTable](pa_taxmatters)))FOR XML PATH('')),3,1000)
,[pa_preparersTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](pa_preparers)))FOR XML PATH('')),3,1000)
FROM[v_powerofattorney]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
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
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP TAX RETURNS --->
<cfcase value="group4_13">
<cftry>
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
FROM[v_taxreturns]
WHERE[client_id]LIKE <cfqueryparam value="#ARGUMENTS.ID#%"/>
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
								}'>
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

<!--- LOOKUP STATE INFORMATION --->
<cfcase value="group5">
<cfquery datasource="#Session.organization.name#" name="fquery">
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
WHERE(<cfif ARGUMENTS.ID neq "0">[si_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND</cfif>
[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>AND
([si_reason]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>OR[si_reason] is null ) )
AND [deleted] IS NULL
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
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[client_id]
,[client_name]
,[client_active]
,[client_since]=FORMAT(client_since,'#Session.localization.formatdate#') 
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif j.DATA[1][2] eq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
INSERT INTO[ctrl_customfields](
[form_id]
,[client_id]
,[field_name]
,[field_value]
,[field_global]
)
VALUES(
<cfqueryparam value="1">
,<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
)
SELECT SCOPE_IDENTITY()AS[field_id]
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"group2_1","result":"ok"}'>
</cfif>
<cfif j.DATA[1][2] neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
UPDATE[ctrl_customfields]
SET[field_name]=<cfqueryparam value="#j.DATA[1][3]#" null="#LEN(j.DATA[1][3]) eq 0#"/>
,[field_value]=<cfqueryparam value="#j.DATA[1][4]#" null="#LEN(j.DATA[1][4]) eq 0#"/>
,[field_global]=<cfqueryparam value="#j.DATA[1][5]#" null="#LEN(j.DATA[1][5]) eq 0#"/>
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
,[contact_title]
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
,<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][20]) eq 0 or j.DATA[1][20] eq 'null'#">
,<cfqueryparam value="#j.DATA[1][21]#" null="#LEN(j.DATA[1][21]) eq 0#">
,<cfqueryparam value="#j.DATA[1][22]#" null="#LEN(j.DATA[1][22]) eq 0#">
,<cfqueryparam value="#j.DATA[1][23]#" null="#LEN(j.DATA[1][23]) eq 0#">
,<cfqueryparam value="#j.DATA[1][24]#" null="#LEN(j.DATA[1][24]) eq 0#">
,<cfqueryparam value="#j.DATA[1][25]#" null="#LEN(j.DATA[1][25]) eq 0#">
)
SELECT SCOPE_IDENTITY()AS[contact_id]
</cfquery>
<cfreturn '{"contact_id":#fquery.contact_id#,"group":"group5","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<cfif j.DATA[1][1] neq "0">
<cfquery name="fquery" datasource="#Session.organization.name#">
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
,[contact_state]=<cfqueryparam value="#j.DATA[1][20]#" null="#LEN(j.DATA[1][20]) eq 0 or j.DATA[1][20] eq 'null'#">
,[contact_taxupdate]=<cfqueryparam value="#j.DATA[1][21]#"null="#LEN(j.DATA[1][21]) eq 0#"/>
,[contact_title]=<cfqueryparam value="#j.DATA[1][22]#"null="#LEN(j.DATA[1][22]) eq 0#"/>
,[contact_type]=<cfqueryparam value="#j.DATA[1][23]#"null="#LEN(j.DATA[1][23]) eq 0#"/>
,[contact_website]=<cfqueryparam value="#j.DATA[1][24]#"null="#LEN(j.DATA[1][24]) eq 0#"/>
,[contact_zip]=<cfqueryparam value="#j.DATA[1][25]#"null="#LEN(j.DATA[1][25]) eq 0#"/>
WHERE[contact_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"contact_id":#j.DATA[1][1]#,"group":"group5","result":"ok"}'>
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery name="fquery" datasource="#Session.organization.name#">
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
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[client_listing]
SET[deleted]=GETDATE()
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group1_2">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[ctrl_customfields]
SET[deleted]=GETDATE()
WHERE[field_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group0","result":"ok"}'>
</cfcase>
<cfcase value="group3">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[client_contact]
SET[deleted]=GETDATE()
WHERE[contact_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group3","result":"ok"}'>
</cfcase>
<cfcase value="group5">
<cfquery datasource="#Session.organization.name#" name="fQuery">
update[client_state]
SET[deleted]=GETDATE()
WHERE[si_id]=<cfqueryparam value="#ARGUMENTS.id#">
</cfquery>
<cfreturn '{"id":#ARGUMENTS.id#,"group":"group5","result":"ok"}'>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>