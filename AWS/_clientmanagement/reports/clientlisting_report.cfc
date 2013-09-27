<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->
<!---
SELECT
[client_id]
	,[client_active]
	,[client_credit_hold]
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
	
	
	,[client_schedule_c]
	,[client_schedule_e]
	,[client_disregard]
	,[client_personal_property]
	
	
	
	
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
	
	
	
FROM[CLIENT_LISTING]
--->

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
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[client_id]
,[client_name]
,[client_salutation]
,[client_spouse]
,[client_credit_hold]
,[contact_id]
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
 FROM[v_client_listing]
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
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CLIENT_SALUTATION":"'&CLIENT_SALUTATION&'"
								,"CLIENT_SPOUSE":"'&CLIENT_SPOUSE&'"
								,"CLIENT_CREDIT_HOLD":"'&CLIENT_CREDIT_HOLD&'"
								,"CONTACT_TYPE":"'&CONTACT_TYPE&'"
								,"CONTACT_NAME":"'&CONTACT_NAME&'"
								,"CONTACT_ADDRESS2":"'&CONTACT_ADDRESS2&'"
								,"CONTACT_ADDRESS1":"'&CONTACT_ADDRESS1&'"
								,"CONTACT_CITY":"'&CONTACT_CITY&'"
								,"CONTACT_STATE":"'&CONTACT_STATE&'"
								,"CONTACT_ZIP":"'&CONTACT_ZIP&'"
								,"CONTACT_PHONE1":"'&CONTACT_PHONE1&'"
								,"CONTACT_PHONE2":"'&CONTACT_PHONE2&'"
								,"CONTACT_PHONE3":"'&CONTACT_PHONE3&'"
								,"CONTACT_PHONE4":"'&CONTACT_PHONE4&'"
								,"CONTACT_PHONE5":"'&CONTACT_PHONE5&'"
								,"CONTACT_EMAIL1":"'&CONTACT_EMAIL1&'"
								,"CONTACT_EMAIL2":"'&CONTACT_EMAIL2&'"
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
</cfcomponent>