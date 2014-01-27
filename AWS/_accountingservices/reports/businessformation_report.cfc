<cfcomponent output="true">


<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">


<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[bf_id]
,[bf_assignedto]
,[bf_status]
,[bf_businesstype]
,CONVERT(VARCHAR(10),[bf_businesssubmitted], 101)AS[bf_businesssubmitted]
,CONVERT(VARCHAR(10),[bf_businessreceived], 101)AS[bf_businessreceived]
,CONVERT(VARCHAR(10),[bf_dateinitiated], 101)AS[bf_dateinitiated]
,CONVERT(VARCHAR(10),[bf_articlessubmitted], 101)AS[bf_articlessubmitted]
,CONVERT(VARCHAR(10),[bf_articlesapproved], 101)AS[bf_articlesapproved]
,CONVERT(VARCHAR(10),[bf_tradenamesubmitted], 101)AS[bf_tradenamesubmitted]
,CONVERT(VARCHAR(10),[bf_tradenamereceived], 101)AS[bf_tradenamereceived]
,CONVERT(VARCHAR(10),[bf_minutesbylawsdraft], 101)AS[bf_minutesbylawsdraft]
,CONVERT(VARCHAR(10),[bf_minutesbylawsfinal], 101)AS[bf_minutesbylawsfinal]
,CONVERT(VARCHAR(10),[bf_minutescompleted], 101)AS[bf_minutescompleted]
,CONVERT(VARCHAR(10),[bf_dissolutionrequested], 101)AS[bf_dissolutionrequested]
,CONVERT(VARCHAR(10),[bf_dissolutionsubmitted], 101)AS[bf_dissolutionsubmitted]
,CONVERT(VARCHAR(10),[bf_dissolutioncompleted], 101)AS[bf_dissolutioncompleted]
,CONVERT(VARCHAR(10),[bf_otheractivity], 101)AS[bf_otheractivity]
,CONVERT(VARCHAR(10),[bf_otherstarted], 101)AS[bf_otherstarted]
,CONVERT(VARCHAR(10),[bf_othercompleted], 101)AS[bf_othercompleted]
,CONVERT(VARCHAR(10),[bf_recordbookordered], 101)AS[bf_recordbookordered]
,[bf_fees]
,[bf_paid]
,[client_name]
,[client_id]
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


</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ASSIGNEDTO":"'&BF_ASSIGNEDTO&'"
								,"BF_BUSINESSTYPE":"'&BF_BUSINESSTYPE&'"
								,"BF_BUSINESSSUBMITTED":"'&BF_BUSINESSSUBMITTED&'"
								,"BF_BUSINESSRECEIVED":"'&BF_BUSINESSRECEIVED&'"
								,"BF_STATUS":"'&BF_STATUS&'"
								,"BF_DATEINITIATED":"'&BF_DATEINITIATED&'"
								,"BF_ARTICLESSUBMITTED":"'&BF_ARTICLESSUBMITTED&'"
								,"BF_ARTICLESAPPROVED":"'&BF_ARTICLESAPPROVED&'"
								,"BF_TRADENAMESUBMITTED":"'&BF_TRADENAMESUBMITTED&'"
								,"BF_TRADENAMERECEIVED":"'&BF_TRADENAMERECEIVED&'"
								,"BF_MINUTESBYLAWSDRAFT":"'&BF_MINUTESBYLAWSDRAFT&'"
								,"BF_MINUTESBYLAWSFINAL":"'&BF_MINUTESBYLAWSFINAL&'"
								,"BF_MINUTESCOMPLETED":"'&BF_MINUTESCOMPLETED&'"
								,"BF_DISSOLUTIONREQUESTED":"'&BF_DISSOLUTIONREQUESTED&'"
								,"BF_DISSOLUTIONSUBMITTED":"'&BF_DISSOLUTIONSUBMITTED&'"
								,"BF_DISSOLUTIONCOMPLETED":"'&BF_DISSOLUTIONCOMPLETED&'"
								,"BF_OTHERACTIVITY":"'&BF_OTHERACTIVITY&'"
								,"BF_OTHERSTARTED":"'&BF_OTHERSTARTED&'"
								,"BF_OTHERCOMPLETED":"'&BF_OTHERCOMPLETED&'"
								,"BF_RECORDBOOKORDERED":"'&BF_RECORDBOOKORDERED&'"
								,"BF_FEES":"'&BF_FEES&'"
								,"BF_PAID":"'&BF_PAID&'"
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