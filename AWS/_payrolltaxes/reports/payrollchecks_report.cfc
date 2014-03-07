<cfcomponent output="true">


<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="formid" type="numeric" required="no" default="0">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">

<cfquery datasource="AWS" name="fquery">
SELECT
[client_id]
,[client_name]
,[pc_id]
,[pc_year]
,CONVERT(VARCHAR(8),[pc_payenddate], 1)AS[pc_payenddate]
,CONVERT(VARCHAR(8),[pc_paydate], 1)AS[pc_paydate] 
,CONVERT(VARCHAR(8),[pc_missinginforeceived], 1)AS[pc_missinginforeceived]
,[pc_missinginfo] 
,CONVERT(VARCHAR(8),[pc_duedate], 1)AS[pc_duedate]
,CONVERT(VARCHAR(8),[pc_obtaininfo_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),[pc_obtaininfo_assignedtoTEXT]) AS [pc_obtaininfo]
,CONVERT(VARCHAR(8),[pc_preparation_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),[pc_preparation_assignedtoTEXT]) AS [pc_preparation]
,CONVERT(VARCHAR(8),[pc_review_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),[pc_review_assignedtoTEXT]) AS [pc_review]
,CONVERT(VARCHAR(8),[pc_assembly_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),[pc_assembly_assignedtoTEXT]) AS [pc_assembly]
,CONVERT(VARCHAR(8),[pc_delivery_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),[pc_delivery_assignedtoTEXT]) AS [pc_delivery]
,FORMAT(pc_fees, 'C', 'en-us')AS[pc_fees]
,[pc_paid]
,[pc_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[pc_paid]=[optionvalue_id])

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
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_DUEDATE":"'&PC_DUEDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_MISSINGINFORECEIVED":"'&PC_MISSINGINFORECEIVED&'"
								,"PC_OBTAININFO":"'&PC_OBTAININFO&'"
								,"PC_PREPARATION":"'&PC_PREPARATION&'"
								,"PC_REVIEW":"'&PC_REVIEW&'"
								,"PC_ASSEMBLY":"'&PC_ASSEMBLY&'"
								,"PC_DELIVERY":"'&PC_DELIVERY&'"
								,"PC_FEES":"'&PC_FEES&'"
								,"PC_PAIDTEXT":"'&PC_PAIDTEXT&'"
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