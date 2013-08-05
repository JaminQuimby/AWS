<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->


<cffunction name="f_loadSelect" access="remote" output="false">
<cfargument name="selectName" type="string" required="yes">
<cfquery name="data" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">
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
<cfif queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cffunction>
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfquery datasource="AWS" name="data">
SELECT
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Client--->
<cfcase value="client">
[client_active]
,[client_credit_hold]
,[client_dms_refrence]
,[client_group]
,[client_name]
,[client_notes]
,[client_referred_by]
,[client_salutation]
,CONVERT(VARCHAR(10),[CLIENT_SINCE], 101)AS[CLIENT_SINCE]
,[client_spouse]
,[client_trade_name]
,[client_type]
,[client_statelabel1]
,[client_statelabel2]
,[client_statelabel3]
,[client_statelabel4]
,[client_relations]
FROM[CLIENT_LISTING]
WHERE[CLIENT_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Contact--->
<cfcase value="contact">
[contact_id]
,[contact_type]
,[contact_name]
,[contact_address1]
,[contact_address2]
,[contact_city]
,[contact_state]
,[contact_zip]
,[contact_phone1]
,[contact_phone2]
,[contact_phone3]
,[contact_phone4]
,[contact_phone5]
,[contact_email1]
,[contact_email2]
,[contact_website]
,CONVERT(VARCHAR(10),[contact_effectivedate], 101)AS[contact_effectivedate]
,[contact_acctsoftwareupdate]
,[contact_taxupdate]
,[contact_customLabel]
,[contact_customValue]
FROM[CLIENT_CONTACT]
WHERE[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Taxes--->
<cfcase value="taxes">
[client_tax_services]
,[client_form_type]
,[client_schedule_c]
,[client_schedule_e]
,[client_disregaurde]
,[client_personal_property]
FROM[CLIENT_LISTING]
WHERE[CLIENT_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Payroll--->
<cfcase value="payroll">
[client_payroll_prep]
,[client_payroll_freq]
,[client_payroll_services] 
,[client_pr_tax_deposit_schedule]
,[client_1099_preperation]
,[client_ein]
,[client_pin]
,[client_password]
FROM[CLIENT_LISTING]
WHERE[CLIENT_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Accounting--->
<cfcase value="accounting">
[client_accounting_services]
,[client_bookkeeping]
,[client_compilation]
,[client_review]
,[client_audit]
,[client_fs_frequency]
,[client_fiscal_year_end]
,[client_software]
,[client_version]
,[client_username],[client_password2]
FROM[CLIENT_LISTING]
WHERE[CLIENT_ID]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Custom Fields--->
<cfcase value="customfields">
[field_id],[field_name],[field_value]
FROM[ctrl_customfields]
WHERE[field_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Accounting Consulting Tasks--->
<cfcase value="accountingconsultingtasks">
[ac_id],[ac_group],[ac_category],[ac_dueDate]
FROM[client_accountingConsulting]
WHERE[ac_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Financial Statments--->
<cfcase value="financialstatements">
[fs_id],[fs_month],[fs_year],[fs_periodEnd]
FROM[client_financialStatements]
WHERE[fs_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Payroll Checks--->
<cfcase value="payrollchecks">
[pc_id],[pc_year],[pc_dateEnd],[pc_payDate],[pc_dateDue],[pc_infoReceived],[pc_missingInfo]
FROM[client_payrollChecks]
WHERE[pc_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Payroll Taxes--->
<cfcase value="payrolltaxes">
[pt_id],[pt_year],[pt_month],[pt_returnType],[pt_dueDate],[pt_infoReceived],[pt_missingInfo]
FROM[client_payrollTaxes]
WHERE[pt_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Tax Status Listing--->
<cfcase value="taxstatuslisting">
[tsl_id],[tsl_year],[tsl_form],[tsl_inforeceived],[tsl_missingInfo]
FROM[client_taxStatusListing]
WHERE[tsl_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load Other Filings--->
<cfcase value="otherfilings">
[of_id],[of_period],[of_state],[of_task],[of_form],[of_dueDate],[of_taxYear]
FROM[client_otherFilings]
WHERE[of_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load State Labels--->
<cfcase value="statelabels">
[client_statelabel1],[client_statelabel2],[client_statelabel3],[client_statelabel4]
FROM[client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load STATE INFORMATION --->
<cfcase value="stateinformation">
[si_id],[si_state],[si_revenue],[si_employees],[si_property],[si_nexus],[si_reason],[si_registered],[si_misc1],[si_misc2],[si_misc3],[si_misc4]
FROM[state_information]
WHERE[si_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
<!--- Load CLIENT RELATIONS --->
<cfcase value="clientrelations">
[client_relations]
FROM[client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfcase>
</cfswitch>
</cfquery>

<cfreturn SerializeJSON(data)>
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
<!--- LOOKUP CLIENT --->
<cfcase value="client">
<cfquery datasource="AWS" name="data">
SELECT[client_listing].[CLIENT_ID]
,[client_listing].[CLIENT_NAME]
,[client_listing].[CLIENT_SALUTATION]
,CONVERT(VARCHAR(10),[client_listing].[CLIENT_SINCE], 101)AS[CLIENT_SINCE]
,[ctrl_selectoptions].[optionName]AS[CLIENT_TYPETEXT]
FROM[client_listing]
LEFT OUTER JOIN[ctrl_selectoptions]
ON[client_listing].[client_type]=[ctrl_selectoptions].[optionValue_id]
WHERE([ctrl_selectoptions].[selectName_id]=1)AND([client_listing].[CLIENT_NAME]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>)
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_listing].[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CLIENT_SALUTATION":"'&CLIENT_SALUTATION&'","CLIENT_TYPETEXT":"'&CLIENT_TYPETEXT&'","CLIENT_SINCE":"'&CLIENT_SINCE&'"}'>
<cfif  queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- LOOKUP CONTACT --->
<cfcase value="contact">
<cfquery datasource="AWS" name="data">
SELECT
[contact_id]
,[contact_name]
,[contact_phone1]
,[contact_email1]
FROM[CLIENT_CONTACT]
WHERE
<cfif ARGUMENTS.ID neq "0">[contact_id]=<cfqueryparam value="#ARGUMENTS.ID#"/> AND</cfif>
[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>AND
[contact_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>

<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[contact_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"contact_id":"'&contact_id&'","contact_name":"'&contact_name&'","contact_phone1":"'&contact_phone1&'","contact_email1":"'&contact_email1&'"}'>
<cfif queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- LOOKUP CUSTOM FIELDS --->
<cfcase value="customfields"><cfquery datasource="AWS" name="data">
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
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"field_id":"'&field_id&'","field_name":"'&field_name&'","field_value":"'&field_value&'"}'>
<cfif queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- LOOKUP STATE INFORMATION --->
<cfcase value="stateinformation"><cfquery datasource="AWS" name="data">
SELECT[state_information].[si_id],[state_information].[si_revenue],[state_information].[si_employees]
,[state_information].[si_property],[state_information].[si_nexus],[state_information].[si_reason],[state_information].[si_registered]
,[state_information].[si_misc1],[state_information].[si_misc2],[state_information].[si_misc3],[state_information].[si_misc4]
,[ctrl_selectoptions].[optionName]AS[si_state]
FROM[state_information]
LEFT OUTER JOIN[ctrl_selectoptions]
ON[state_information].[si_state]=[ctrl_selectoptions].[optionValue_id]
WHERE([ctrl_selectoptions].[selectName_id]=9)AND
(
<cfif ARGUMENTS.ID neq "0">[state_information].[si_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND</cfif>
[state_information].[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>AND
[state_information].[si_reason]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/> )
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"si_id":"'&si_id&'","si_state":"'&si_state&'","si_revenue":"'&si_revenue&'","si_employees":"'&si_employees&'","si_property":"'&si_property&'","si_nexus":"'&si_nexus&'","si_reason":"'&si_reason&'","si_registered":"'&si_registered&'","si_misc1":"'&si_misc1&'","si_misc2":"'&si_misc2&'","si_misc3":"'&si_misc3&'","si_misc4":"'&si_misc4&'"}'>
<cfif queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>
<!--- LOOKUP client relations --->
<cfcase value="clientrelations"><cfquery datasource="AWS" name="data">
SELECT[client_listing].[client_id]
,[client_listing].[client_name]
,[client_listing].[client_active]
,CONVERT(VARCHAR(10),[client_listing].[client_since], 101)AS[client_since]
,[ctrl_selectoptions].[optionName]AS[client_typeTEXT]
,[client_listing].[client_type]
FROM[client_listing]
LEFT OUTER JOIN[ctrl_selectoptions]
ON[client_listing].[client_type]=[ctrl_selectoptions].[optionValue_id]
WHERE([ctrl_selectoptions].[selectName_id]=1)AND(<cfset i=0><cfloop index="clientid" list = "#ARGUMENTS.ID#"><cfset i=i+1><cfif clientid neq "">[client_listing].[client_id]='<cfoutput>#trim(clientid)#</cfoutput>'<cfif not listLen(ARGUMENTS.ID) eq i>OR</cfif></cfif></cfloop>)
AND NOT[client_listing].[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[ctrl_selectoptions].[optionName]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="data">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"client_id":"'&client_id&'","client_name":"'&client_name&'","client_active":"'&client_active&'","client_since":"'&client_since&'","client_typeTEXT":"'&client_typeTEXT&'"}'>
<cfif queryIndex lt data.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.cl_id#","MESSAGE":"#cfcatch.detail#"]}'> 
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
<cfcase value="client">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[CLIENT_LISTING](
[client_active],
[client_credit_hold],
[client_dms_refrence],
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
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>,<cfqueryparam value="#j.DATA[1][3]#"/>,<cfqueryparam value="#j.DATA[1][4]#"/>,<cfqueryparam value="#j.DATA[1][5]#"/>,<cfqueryparam value="#j.DATA[1][6]#"/>,<cfqueryparam value="#j.DATA[1][7]#"/>,<cfqueryparam value="#j.DATA[1][8]#"/>,<cfqueryparam value="#j.DATA[1][9]#"/>,<cfqueryparam value="#j.DATA[1][10]#"/>,<cfqueryparam value="#j.DATA[1][11]#"/>,<cfqueryparam value="#j.DATA[1][12]#"/>,<cfqueryparam value="#j.DATA[1][13]#"/>)
SELECT SCOPE_IDENTITY()AS[clientId]
</cfquery>
<cfreturn '{"id":#fquery.clientId#,"group":"customfield","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_active]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[client_credit_hold]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[client_dms_refrence]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[client_group]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[client_name]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[client_notes]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[client_referred_by]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[client_salutation]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[client_since]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[client_spouse]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[client_trade_name]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[client_type]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"customfields","result":"ok"}'>
</cfif>

</cfcase>
<!--- Custom Fields --->
<cfcase value="customfields">
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
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
)
SELECT SCOPE_IDENTITY()AS[field_id]
</cfquery>
</cfif>
<cfif j.DATA[1][2] neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[ctrl_customfields]
SET[field_name]=<cfqueryparam value="#j.DATA[1][3]#">
,[field_value]=<cfqueryparam value="#j.DATA[1][4]#">
WHERE[field_id]=<cfqueryparam value="#j.DATA[1][2]#">
</cfquery>
</cfif>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"taxes","result":"ok"}'>
</cfcase>

<!--- Taxes --->
<cfcase value="taxes">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_tax_services]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_form_type]=<cfqueryparam value="#j.DATA[1][3]#"/> 
,[client_schedule_c]=<cfqueryparam value="#j.DATA[1][4]#"/> 
,[client_schedule_e]=<cfqueryparam value="#j.DATA[1][5]#"/> 
,[client_disregaurde]=<cfqueryparam value="#j.DATA[1][6]#"/> 
,[client_personal_property]=<cfqueryparam value="#j.DATA[1][7]#"/> 
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"payroll","result":"ok"}'> 
</cfcase>
<!--- Payroll --->
<cfcase value="payroll">
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][2]#)><cfset #j.DATA[1][2]#=1><cfelse><cfset #j.DATA[1][2]#=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][4]#)><cfset #j.DATA[1][4]#=1><cfelse><cfset #j.DATA[1][4]#=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',#j.DATA[1][6]#)><cfset #j.DATA[1][6]#=1><cfelse><cfset #j.DATA[1][6]#=0></cfif>
<cfquery name="uClientListing" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_payroll_prep]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_payroll_freq]=<cfqueryparam value="#j.DATA[1][3]#"/> 
,[client_payroll_services]=<cfqueryparam value="#j.DATA[1][4]#"/> 
,[client_pr_tax_deposit_schedule]=<cfqueryparam value="#j.DATA[1][5]#"/> 
,[client_1099_preperation]=<cfqueryparam value="#j.DATA[1][6]#"/> 
,[client_ein]=<cfqueryparam value="#j.DATA[1][7]#"/> 
,[client_pin]=<cfqueryparam value="#j.DATA[1][8]#"/> 
,[client_password]=<cfqueryparam value="#j.DATA[1][9]#"/> 
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"accounting","result":"ok"}'> 
</cfcase>
<!--- Accounting --->
<cfcase value="accounting">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfquery name="uClientListing" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_accounting_services]=<cfqueryparam value="#j.DATA[1][2]#"/> 
,[client_bookkeeping]=<cfqueryparam value="#j.DATA[1][3]#"/> 
,[client_compilation]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[client_review]=<cfqueryparam value="#j.DATA[1][5]#"/> 
,[client_audit]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[client_fs_frequency]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[client_fiscal_year_end]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[client_software]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[client_version]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[client_username]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[client_password2]=<cfqueryparam value="#j.DATA[1][12]#"/>
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"contact","result":"ok"}'>
</cfcase>
<!--- Contacts --->
<cfcase value="contact">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][19])><cfset j.DATA[1][19]=1><cfelse><cfset j.DATA[1][19]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][20])><cfset j.DATA[1][20]=1><cfelse><cfset j.DATA[1][20]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][22])><cfset j.DATA[1][22]=1><cfelse><cfset j.DATA[1][22]=0></cfif>
<cfif j.DATA[1][2] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[CLIENT_CONTACT](
[client_id]
,[contact_type]
,[contact_name]
,[contact_address1]
,[contact_address2]
,[contact_city]
,[contact_state]
,[contact_zip]
,[contact_phone1]
,[contact_phone2]
,[contact_phone3]
,[contact_phone4]
,[contact_phone5]
,[contact_email1]
,[contact_email2]
,[contact_website]
,[contact_effectivedate]
,[contact_acctsoftwareupdate]
,[contact_taxupdate]
,[contact_customlabel]
,[contact_customvalue]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
,<cfqueryparam value="#j.DATA[1][7]#">
,<cfqueryparam value="#j.DATA[1][8]#">
,<cfqueryparam value="#j.DATA[1][9]#">
,<cfqueryparam value="#j.DATA[1][10]#">
,<cfqueryparam value="#j.DATA[1][11]#">
,<cfqueryparam value="#j.DATA[1][12]#">
,<cfqueryparam value="#j.DATA[1][13]#">
,<cfqueryparam value="#j.DATA[1][14]#">
,<cfqueryparam value="#j.DATA[1][15]#">
,<cfqueryparam value="#j.DATA[1][16]#">
,<cfqueryparam value="#j.DATA[1][17]#">
,<cfqueryparam value="#j.DATA[1][18]#">
,<cfqueryparam value="#j.DATA[1][19]#">
,<cfqueryparam value="#j.DATA[1][20]#">
,<cfqueryparam value="#j.DATA[1][21]#">
,<cfqueryparam value="#j.DATA[1][22]#">
)
SELECT SCOPE_IDENTITY()AS[contact_id]
</cfquery>
</cfif>
<cfif j.DATA[1][2] neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_CONTACT]
SET
[contact_type]=<cfqueryparam value="#j.DATA[1][3]#">
,[contact_name]=<cfqueryparam value="#j.DATA[1][4]#">
,[contact_address1]=<cfqueryparam value="#j.DATA[1][5]#">
,[contact_address2]=<cfqueryparam value="#j.DATA[1][6]#">
,[contact_city]=<cfqueryparam value="#j.DATA[1][7]#">
,[contact_state]=<cfqueryparam value="#j.DATA[1][8]#">
,[contact_zip]=<cfqueryparam value="#j.DATA[1][9]#">
,[contact_phone1]=<cfqueryparam value="#j.DATA[1][10]#">
,[contact_phone2]=<cfqueryparam value="#j.DATA[1][11]#">
,[contact_phone3]=<cfqueryparam value="#j.DATA[1][12]#">
,[contact_phone4]=<cfqueryparam value="#j.DATA[1][13]#">
,[contact_phone5]=<cfqueryparam value="#j.DATA[1][14]#">
,[contact_email1]=<cfqueryparam value="#j.DATA[1][15]#">
,[contact_email2]=<cfqueryparam value="#j.DATA[1][16]#">
,[contact_website]=<cfqueryparam value="#j.DATA[1][17]#">
,[contact_effectivedate]=<cfqueryparam value="#j.DATA[1][18]#">
,[contact_acctsoftwareupdate]=<cfqueryparam value="#j.DATA[1][19]#">
,[contact_taxupdate]=<cfqueryparam value="#j.DATA[1][20]#">
,[contact_customlabel]=<cfqueryparam value="#j.DATA[1][21]#">
,[contact_customvalue]=<cfqueryparam value="#j.DATA[1][22]#">
WHERE[contact_id]=<cfqueryparam value="#j.DATA[1][2]#">
</cfquery>
</cfif>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"managementconsulting","result":"ok"}'>
</cfcase>
<!--- Financial Statements --->
<cfcase value="financialstatements">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[financialdatastatus](
[client_id]
,[fds_month]
,[fds_periodend]
,[fds_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"managementconsulting","result":"ok"}'>
</cfcase>
<!--- Management Consulting --->
<cfcase value="managementconsulting">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[managementconsulting](
[client_id]
,[mc_category]
,[mc_duedate]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"payrollchecks","result":"ok"}'>
</cfcase>
<!--- Payroll Checks --->
<cfcase value="payrollchecks">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[payrollcheckstatus](
[client_id]
,[pc_datedue]
,[pc_inforeceived]
,[pc_missinginfo]
,[pc_paydate]
,[pc_payenddate]
,[pc_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
,<cfqueryparam value="#j.DATA[1][7]#">
,<cfqueryparam value="#j.DATA[1][8]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"payrolltaxes","result":"ok"}'>
</cfcase>
<!--- Payroll Taxes --->
<cfcase value="payrolltaxes">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[payrolltaxreturnstatus](
[client_id]
,[pt_duedate]
,[pt_inforeceived]
,[pt_lastpaydate]
,[pt_missinginfo]
,[pt_month]
,[pt_returntype]
,[pt_year]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
,<cfqueryparam value="#j.DATA[1][7]#">
,<cfqueryparam value="#j.DATA[1][8]#">
,<cfqueryparam value="#j.DATA[1][9]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"taxstatuslisting","result":"ok"}'>
</cfcase>
<!--- Tax Status Listings --->
<cfcase value="taxstatuslisting">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[taxstatuslisting](
[client_id]
,[tsl_inforeceived]
,[tsl_missinginfo]
,[tsl_taxfrom]
,[tsl_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"otherfilings","result":"ok"}'>
</cfcase>
<!--- Other Filings --->
<cfcase value="otherfilings">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[otherfilings](
[client_id]
,[of_duedate]
,[of_form]
,[of_period]
,[of_state]
,[of_task]
,[of_taxyear]
)
VALUES(
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
,<cfqueryparam value="#j.DATA[1][7]#">
,<cfqueryparam value="#j.DATA[1][8]#">
)
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"statelabels","result":"ok"}'>
</cfcase>
<!--- State Labels --->
<cfcase value="statelabels">
<cfquery name="fquery" datasource="AWS">
UPDATE[client_listing]
SET[client_statelabel1]=<cfqueryparam value="#j.DATA[1][2]#">
,[client_statelabel2]=<cfqueryparam value="#j.DATA[1][3]#">
,[client_statelabel3]=<cfqueryparam value="#j.DATA[1][4]#">
,[client_statelabel4]=<cfqueryparam value="#j.DATA[1][5]#">
WHERE[client_id]=<cfqueryparam value="#j.DATA[1][1]#">
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"stateinformation","result":"ok"}'>
</cfcase>
<!--- State Information --->
<cfcase value="stateinformation">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][8])><cfset j.DATA[1][8]=1><cfelse><cfset j.DATA[1][8]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][10])><cfset j.DATA[1][10]=1><cfelse><cfset j.DATA[1][10]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][11])><cfset j.DATA[1][11]=1><cfelse><cfset j.DATA[1][11]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][13])><cfset j.DATA[1][13]=1><cfelse><cfset j.DATA[1][13]=0></cfif>
<cfif j.DATA[1][2] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[state_information](
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
<cfqueryparam value="#j.DATA[1][1]#">
,<cfqueryparam value="#j.DATA[1][3]#">
,<cfqueryparam value="#j.DATA[1][4]#">
,<cfqueryparam value="#j.DATA[1][5]#">
,<cfqueryparam value="#j.DATA[1][6]#">
,<cfqueryparam value="#j.DATA[1][7]#">
,<cfqueryparam value="#j.DATA[1][8]#">
,<cfqueryparam value="#j.DATA[1][9]#">
,<cfqueryparam value="#j.DATA[1][10]#">
,<cfqueryparam value="#j.DATA[1][11]#">
,<cfqueryparam value="#j.DATA[1][12]#">
,<cfqueryparam value="#j.DATA[1][13]#">
)</cfquery>
<cfelse>
<cfquery name="fquery" datasource="AWS">
UPDATE[state_information]
SET[si_employees]=<cfqueryparam value="#j.DATA[1][3]#">
,[si_nexus]=<cfqueryparam value="#j.DATA[1][4]#">
,[si_property]=<cfqueryparam value="#j.DATA[1][5]#">
,[si_reason]=<cfqueryparam value="#j.DATA[1][6]#">
,[si_registered]=<cfqueryparam value="#j.DATA[1][7]#">
,[si_revenue]=<cfqueryparam value="#j.DATA[1][8]#">
,[si_state]=<cfqueryparam value="#j.DATA[1][9]#">
,[si_misc1]=<cfqueryparam value="#j.DATA[1][10]#">
,[si_misc2]=<cfqueryparam value="#j.DATA[1][11]#">
,[si_misc3]=<cfqueryparam value="#j.DATA[1][12]#">
,[si_misc4]=<cfqueryparam value="#j.DATA[1][13]#">
WHERE[is_id]=<cfqueryparam value="#j.DATA[1][2]#">
</cfquery>
</cfif>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"clientrelations","result":"ok"}'>
</cfcase>
<!--- Client Relations --->
<cfcase value="clientrelations">

<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_relations]='#j.DATA[1][2]#'
WHERE[CLIENT_ID]='#j.DATA[1][1]#'
</cfquery>

<cfreturn '{"id":#j.DATA[1][1]#,"group":"saved","result":"ok"}'>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>