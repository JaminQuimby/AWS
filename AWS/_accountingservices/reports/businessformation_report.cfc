<cfcomponent output="true">
<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="true">
<cfargument name="selectName" type="string">
<cfargument name="formid" type="string" default="">
<cfargument name="option1" type="string" default="">
<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[v_staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]
</cfquery>
<cfset myResult="">
<cfset queryResult='{"optionvalue_id":"0","optionname":"&nbsp;"},'>
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"optionvalue_id":"'&optionvalue_id&'","optionname":"'&optionname&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
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

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[bf_id]
,[bf_assignedtoTEXT]
,[bf_activity]
,[bf_duedate]=FORMAT(bf_duedate,'#Session.localization.formatdate#') 
,[bf_owners]
,[bf_priority]
,[bf_esttime]
,[bf_missinginforeceived]=FORMAT(bf_missinginforeceived,'#Session.localization.formatdate#') 
,[bf_missinginfo]
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_businesstypeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[bf_businesstype]=[optionvalue_id])
,[bf_businesssubmitted]=FORMAT(bf_businesssubmitted,'#Session.localization.formatdate#') 
,[bf_businessreceived]=FORMAT(bf_businessreceived,'#Session.localization.formatdate#') 
,[bf_dateinitiated]=FORMAT(bf_dateinitiated,'#Session.localization.formatdate#') 
,[bf_articlessubmitted]=FORMAT(bf_articlessubmitted,'#Session.localization.formatdate#') 
,[bf_articlesapproved]=FORMAT(bf_articlesapproved,'#Session.localization.formatdate#') 
,[bf_tradenamesubmitted]=FORMAT(bf_tradenamesubmitted,'#Session.localization.formatdate#') 
,[bf_tradenamereceived]=FORMAT(bf_tradenamereceived,'#Session.localization.formatdate#') 
,[bf_minutesbylawsdraft]=FORMAT(bf_minutesbylawsdraft,'#Session.localization.formatdate#') 
,[bf_minutesbylawsfinal]=FORMAT(bf_minutesbylawsfinal,'#Session.localization.formatdate#') 
,[bf_minutescompleted]=FORMAT(bf_minutescompleted,'#Session.localization.formatdate#') 
,[bf_dissolutionrequested]=FORMAT(bf_dissolutionrequested,'#Session.localization.formatdate#') 
,[bf_dissolutionsubmitted]=FORMAT(bf_dissolutionsubmitted,'#Session.localization.formatdate#') 
,[bf_dissolutioncompleted]=FORMAT(bf_dissolutioncompleted,'#Session.localization.formatdate#') 
,[bf_otheractivity]=FORMAT(bf_otheractivity,'#Session.localization.formatdate#') 
,[bf_otherstarted]=FORMAT(bf_otherstarted,'#Session.localization.formatdate#') 
,[bf_othercompleted]=FORMAT(bf_othercompleted,'#Session.localization.formatdate#') 
,[bf_recordbookordered]=FORMAT(bf_recordbookordered,'#Session.localization.formatdate#') 
,FORMAT(bf_fees, 'C', 'en-us')AS[bf_fees]
,[bf_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[bf_paid]=[optionvalue_id])
,[client_name]
,[client_id]
FROM[v_businessformation]
WHERE [client_active]=(1)
AND [bf_active]=(1)
AND [deleted] IS NULL
<cfset sqllist = "bf_activity,bf_assignedto,bf_dateinitiated,bf_duedate,bf_esttime,bf_fees,bf_owners,bf_paid,bf_priority,bf_status,bf_articlesapproved,bf_articlessubmitted,bf_tradenamereceived,bf_tradenamesubmitted,bf_minutesbylawsdraft,bf_minutesbylawsfinal,bf_minutescompleted,bf_dissolutioncompleted,bf_dissolutionrequested,bf_dissolutionsubmitted,bf_businessreceived,bf_businesssubmitted,bf_otheractivity,bf_othercompleted,bf_otherstarted">
<cfset key="bf_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>

AND(1)=(1)
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
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ACTIVITY":"'&BF_ACTIVITY&'"
								,"BF_OWNERS":"'&BF_OWNERS&'"
								,"BF_BUSINESSTYPETEXT":"'&BF_BUSINESSTYPETEXT&'"
								,"BF_DUEDATE":"'&BF_DUEDATE&'"
								,"BF_STATUSTEXT":"'&BF_STATUSTEXT&'"
								,"BF_ASSIGNEDTOTEXT":"'&BF_ASSIGNEDTOTEXT&'"
								,"BF_MISSINGINFORECEIVED":"'&BF_MISSINGINFORECEIVED&'"
								,"BF_MISSINGINFO":"'&BF_MISSINGINFO&'"							
								,"BF_ARTICLESAPPROVED":"'&BF_ARTICLESAPPROVED&'"
								,"BF_TRADENAMERECEIVED":"'&BF_TRADENAMERECEIVED&'"
								,"BF_MINUTESCOMPLETED":"'&BF_MINUTESCOMPLETED&'"
								,"BF_DISSOLUTIONCOMPLETED":"'&BF_DISSOLUTIONCOMPLETED&'"						
								,"BF_PRIORITY":"'&BF_PRIORITY&'"
								,"BF_ESTTIME":"'&BF_ESTTIME&'"
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