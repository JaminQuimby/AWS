<cfcomponent output="true">
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="userid" type="string" required="no">

<cfswitch expression="#ARGUMENTS.loadType#">

<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group1">
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

<cfset sqllist = "mc_assignedto,mc_category,mc_description,mc_duedate,mc_esttime,mc_fees,mc_paid,mc_priority,mc_projectcompleted,mc_requestforservice,mc_status,mc_workinitiated">
<cfset key="mc_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
			
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>


</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_REQUESTFORSERVICE":"'&MC_REQUESTFORSERVICE&'"
								,"MC_PROJECTCOMPLETED":"'&MC_PROJECTCOMPLETED&'"
								,"MC_STATUSTEXT":"'&MC_STATUSTEXT&'"
								,"MC_PRIORITY":"'&MC_PRIORITY&'"
								,"MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_ESTTIME":"'&MC_ESTTIME&'"
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Administrative Tasks --->
<cfcase value="group2">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT [cas_id]
,[client_id]
,[client_name]
,[cas_duedate]=FORMAT(cas_duedate,'#Session.localization.formatdate#') 
,[cas_assignedto]
,[cas_category]
,[cas_datereqested]=FORMAT(cas_datereqested,'#Session.localization.formatdate#') 
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc]
,[cas_status]
,cas_assignedtoTEXT=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))FOR XML PATH('')),3,1000)
,cas_categoryTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[cas_category]=[optionvalue_id])
,cas_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[cas_status]=[optionvalue_id])
FROM[v_clientadministrativetasks]

<cfset sqllist = "cas_assignedto,cas_category,cas_completed,cas_datereqested,cas_datestarted,cas_duedate,cas_esttime,cas_instructions,cas_priority,cas_reqestby,cas_status,cas_taskdesc">
<cfset key="cas_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_CATEGORYTEXT":"'&CAS_CATEGORYTEXT&'"
								,"CAS_TASKDESC":"'&CAS_TASKDESC&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_STATUSTEXT":"'&CAS_STATUSTEXT&'"
								,"CAS_ASSIGNEDTOTEXT":"'&CAS_ASSIGNEDTOTEXT&'"
								,"CAS_DATEREQESTED":"'&CAS_DATEREQESTED&'"	
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

<!--- LOOKUP Business Formation --->
<cfcase value="group3">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[bf_id]
,[client_id]
,[client_name]
,[bf_owners]
,[bf_status]
,[bf_duedate]=FORMAT(bf_duedate,'#Session.localization.formatdate#') 
,[bf_businesstypeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[bf_businesstype]=[optionvalue_id])
,[bf_assignedtoTEXT]
,[bf_activity]
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_missinginforeceived]=FORMAT(bf_missinginforeceived,'#Session.localization.formatdate#') 
,[bf_missinginfo]
FROM[v_businessformation]

<cfset sqllist = "bf_activity,bf_assignedto,bf_dateinitiated,bf_duedate,bf_esttime,bf_fees,bf_owners,bf_paid,bf_priority,bf_status,bf_articlesapproved,bf_articlessubmitted,bf_tradenamereceived,bf_tradenamesubmitted,bf_minutesbylawsdraft,bf_minutesbylawsfinal,bf_minutescompleted,bf_dissolutioncompleted,bf_dissolutionrequested,bf_dissolutionsubmitted,bf_businessreceived,bf_businesssubmitted,bf_otheractivity,bf_othercompleted,bf_otherstarted">
<cfset key="bf_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

ORDER BY[bf_duedate]
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
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Client Maintenance --->
<cfcase value="group4">

<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[client_id]
,[client_name]
,[client_salutation]
,[client_since]=FORMAT(client_since,'#Session.localization.formatdate#') 
,[client_type]
,[client_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_clienttype'AND[client_type]=[optionvalue_id])
FROM[v_client_listing]

<cfset sqllist = "client_active,client_credit_hold,client_group,client_name,client_notes,client_referred_by,client_salutation,client_since,client_spouse,client_trade_name,client_type,client_statelabel1,client_statelabel2,client_statelabel3,client_statelabel4,client_relations,client_schedule_c,client_schedule_e,client_disregard,client_personal_property">
<cfset key="client_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CLIENT_SALUTATION":"'&CLIENT_SALUTATION&'"
								,"CLIENT_TYPETEXT":"'&CLIENT_TYPETEXT&'"
								,"CLIENT_SINCE":"'&CLIENT_SINCE&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>



<!--- LOOKUP Communications --->
<cfcase value="group5">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[co_id]
,[co_forTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](co_for)))FOR XML PATH('')),3,1000)
,CASE WHEN LEN([co_briefmessage]) >= 101 THEN SUBSTRING([co_briefmessage],0,100) +  '...' ELSE [co_briefmessage] END AS[co_briefmessage]
,[co_caller]
,[co_duedate]=FORMAT(co_duedate,'#Session.localization.formatdate#')
,[co_date]=FORMAT(co_date,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[co_status]
,[co_responseneeded]
,[co_returncall]
,[client_name]
,[client_id]
,[co_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[co_status]=[optionvalue_id])

FROM[v_communications]

<cfset sqllist = "co_briefmessage,co_caller,co_completed,co_contactmethod,co_credithold,co_date,co_duedate,co_emailaddress,co_ext,co_faxnumber,co_fees,co_for,co_paid,co_responseneeded,co_returncall,co_takenby,co_telephone">
<cfset key="co_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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

<!--- LOOKUP Financia &amp; Tax Planning --->
<cfcase value="group6">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[ftp_id]
,[ftp_status]
,[ftp_category]
,[ftp_assignedtoTEXT]
,[ftp_duedate]=FORMAT(ftp_duedate,'#Session.localization.formatdate#')
,[ftp_requestservice]=FORMAT(ftp_requestservice,'#Session.localization.formatdate#')
,[ftp_missinginfo]
,[client_name]
,[client_id]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])AS[ftp_categoryTEXT]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])AS[ftp_statusTEXT]
FROM[v_financialtaxplanning]

<cfset sqllist = "ftp_category,ftp_status,ftp_assignedto,ftp_priority,ftp_requestservice,ftp_duedate,ftp_inforequested,ftp_inforeceived,ftp_infocompiled,ftp_missinginfo,ftp_missinginforeceived,ftp_reportcompleted,ftp_finalclientmeeting,ftp_esttime,ftp_fees,ftp_paid">
<cfset key="ftp_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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
<cfcase value="group7">
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

<cfset sqllist = "fds_year,fds_month,fds_periodend,fds_status,fds_duedate,fds_priority,fds_esttime,fds_missinginfo,fds_missinginforeceived,fds_compilemi,fds_cmireceived,fds_fees,fds_paid,fds_deliverymethod,fds_obtaininfo_assignedto,fds_obtaininfo_datecompleted,fds_obtaininfo_completedby,fds_obtaininfo_esttime,fds_sort_assignedto,fds_sort_datecompleted,fds_sort_completedby,fds_sort_esttime,fds_checks_assignedto,fds_checks_datecompleted,fds_checks_completedby,fds_checks_esttime,fds_sales_assignedto,fds_sales_datecompleted,fds_sales_completedby,fds_sales_esttime,fds_entry_assignedto,fds_entry_datecompleted,fds_entry_completedby,fds_entry_esttime,fds_reconcile_assignedto,fds_reconcile_datecompleted,fds_reconcile_completedby,fds_reconcile_esttime,fds_compile_assignedto,fds_compile_datecompleted,fds_compile_completedby,fds_compile_esttime,fds_review_assignedto,fds_review_datecompleted,fds_review_completedby,fds_review_esttime,fds_assembly_assignedto,fds_assembly_datecompleted,fds_assembly_completedby,fds_assembly_esttime,fds_delivery_assignedto,fds_delivery_datecompleted,fds_delivery_completedby,fds_delivery_esttime,fds_acctrpt_assignedto,fds_acctrpt_datecompleted,fds_acctrpt_completedby,fds_acctrpt_esttime">
<cfset key="fds_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>



<!--- Grid Notice  --->
<cfcase value="group8">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[n_id]
,[client_name]
,[n_name]
,[nst_1_noticedate]=FORMAT(nst_1_noticedate,'#Session.localization.formatdate#') 
,[nst_missinginfo]
,[nst_priority]
,[nst_assignedtoTEXT]
,[nst_1_resduedate]=FORMAT(nst_1_resduedate,'#Session.localization.formatdate#') 
,[nst_esttime]
,[nst_2_revrequired]
,[nst_2_revassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(nst_2_revassignedto=user_id))
FROM[v_notice_subtask]

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&N_NAME&'"
								,"NST_1_NOTICEDATE":"'&NST_1_NOTICEDATE&'"
								,"NST_MISSINGINFO":"'&NST_MISSINGINFO&'"
								,"NST_PRIORITY":"'&NST_PRIORITY&'"
								,"NST_ASSIGNEDTOTEXT":"'&NST_ASSIGNEDTOTEXT&'"
								,"NST_1_RESDUEDATE":"'&NST_1_RESDUEDATE&'"
								,"NST_ESTTIME":"'&NST_ESTTIME&'"
								,"NST_2_REVREQUIRED":"'&NST_2_REVREQUIRED&'"
								,"NST_2_REVASSIGNEDTOTEXT":"'&NST_2_REVASSIGNEDTOTEXT&'"
								}'>
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

<!--- LOOKUP Other Filings --->
<cfcase value="group9">
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

<cfset sqllist = "of_taxyear,of_period,of_state,of_type,of_form,of_duedate,of_filingdeadline,of_extensiondeadline,of_extensioncompleted,of_status,of_priority,of_esttime,of_missinginfo,of_missinginforeceived,of_fees,of_paid,of_deliverymethod,of_obtaininfo_assignedto,of_obtaininfo_datecompleted,of_obtaininfo_completedby,of_obtaininfo_esttime,of_preparation_assignedto,of_preparation_datecompleted,of_preparation_completedby,of_preparation_esttime,of_review_assignedto,of_review_datecompleted,of_review_completedby,of_review_esttime,of_assembly_assignedto,of_assembly_datecompleted,of_assembly_completedby,of_assembly_esttime,of_delivery_assignedto,of_delivery_datecompleted,of_delivery_completedby,of_delivery_esttime">
<cfset key="of_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Checks --->
<cfcase value="group10">
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

<cfset sqllist = "pc_year,pc_payenddate,pc_paydate,pc_duedate,pc_esttime,pt_altfreq,pc_missinginfo,pc_missinginforeceived,pc_fees,pc_paid,pc_deliverymethod,pc_obtaininfo_assignedto,pc_obtaininfo_datecompleted,pc_obtaininfo_completedby,pc_obtaininfo_esttime,pc_preparation_assignedto,pc_preparation_datecompleted,pc_preparation_completedby,pc_preparation_esttime,pc_review_assignedto,pc_review_datecompleted,pc_review_completedby,pc_review_esttime,pc_assembly_assignedto,pc_assembly_datecompleted,pc_assembly_completedby,pc_assembly_esttime,pc_delivery_assignedto,pc_delivery_datecompleted,pc_delivery_completedby,pc_delivery_esttime">
<cfset key="pc_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group11">
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

<cfset sqllist = "pt_assembly_assignedto,pt_assembly_completedby,pt_assembly_datecompleted,pt_assembly_esttime,pt_delivery_assignedto,pt_delivery_completedby,pt_delivery_datecompleted,pt_delivery_esttime,pt_deliverymethod,pt_duedate,pt_entry_assignedto,pt_entry_completedby,pt_entry_datecompleted,pt_entry_esttime,pt_esttime,pt_fees,pt_lastpay,pt_missinginfo,pt_missinginforeceived,pt_month,pt_obtaininfo_assignedto,pt_obtaininfo_completedby,pt_obtaininfo_datecomplted,pt_obtaininfo_esttime,pt_paid,pt_priority,pt_rec_assignedto,pt_rec_completedby,pt_rec_datecompleted,pt_rec_esttime,pt_review_assignedto,pt_review_completedby,pt_review_datecompleted,pt_review_esttime,pt_type,pt_year">
<cfset key="pt_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
			
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
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
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group12">
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
FROM[v_taxreturns]

<cfset sqllist = "tr_currentfees,tr_esttime,tr_extensiondone,tr_extensionrequested,tr_notrequired,tr_priority,tr_priorfees,tr_taxform,tr_taxyear,tr_duedate,tr_filingdeadline,tr_missinginfo,tr_missinginforeceived,tr_deliverymethod,tr_paid,tr_reason,tr_1_dropoffappointment,tr_1_dropoffappointmentlength,tr_1_dropoffappointmentwith,tr_1_whileyouwaitappt,tr_1_pickupappointment,tr_1_pickupappointmentlength,tr_1_pickupappointmentwith,tr_2_assignedto,tr_2_completed,tr_2_informationreceived,tr_2_preparedby,tr_2_readyforreview,tr_2_reviewassignedto,tr_2_reviewed,tr_2_reviewedby,tr_2_reviewedwithnotes,tr_3_assemblereturn,tr_3_contacted,tr_3_delivered,tr_3_emailed,tr_3_messageleft,tr_3_missingsignatures,tr_3_multistatereturn,tr_4_assignedto,tr_4_completed,tr_4_currentfees,tr_4_delivered,tr_4_extended,tr_4_paid,tr_4_pptresttime,tr_4_priorfees,tr_4_required,tr_4_rfr,tr_4_extensionrequested,tr_4_completedby,tr_4_reviewassigned,tr_4_reviewed,tr_4_reviewedby">
<cfset key="tr_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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
</cfswitch>
</cffunction>
</cfcomponent>