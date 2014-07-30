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
<cfargument name="formid" type="numeric" required="no" default="0">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">

<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT [client_id]
,[client_name]
,[pc_id]
,[pc_year]
,[pc_payenddate]=FORMAT(pc_payenddate,'#Session.localization.formatdate#')
,[pc_paydate]=FORMAT(pc_paydate,'#Session.localization.formatdate#')
,[pc_missinginforeceived]=ISNULL(FORMAT(pc_missinginforeceived,'#Session.localization.formatdate#'),'N/A')
,[pc_missinginfo] 
,[pc_priority]
,[pc_esttime]
,[pc_duedate]=FORMAT(pc_duedate,'#Session.localization.formatdate#')
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
,[pc_fees]=FORMAT(pc_fees,'C','#Session.localization.language#')
,[pc_paid]
,[pc_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[pc_paid]=[optionvalue_id])
FROM[v_payrollcheckstatus]
WHERE[client_active]=(1)
AND [deleted] IS NULL 

<cfset sqllist = "pc_year,pc_payenddate,pc_paydate,pc_duedate,pc_esttime,pt_altfreq,pc_missinginfo,pc_missinginforeceived,pc_fees,pc_paid,pc_deliverymethod,pc_obtaininfo_assignedto,pc_obtaininfo_datecompleted,pc_obtaininfo_completedby,pc_obtaininfo_esttime,pc_preparation_assignedto,pc_preparation_datecompleted,pc_preparation_completedby,pc_preparation_esttime,pc_review_assignedto,pc_review_datecompleted,pc_review_completedby,pc_review_esttime,pc_assembly_assignedto,pc_assembly_datecompleted,pc_assembly_completedby,pc_assembly_esttime,pc_delivery_assignedto,pc_delivery_datecompleted,pc_delivery_completedby,pc_delivery_esttime">
<cfset key="pc_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>

AND (1)=(1)
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
								,"PC_OBTAININFO":"'&pc_obtaininfo_datecompleted&'<br/>'&pc_obtaininfo_assignedtoTEXT&'"
								,"PC_PREPARATION":"'&pc_preparation_datecompleted&'<br/>'&pc_preparation_assignedtoTEXT&'"
								,"PC_REVIEW":"'&pc_review_datecompleted&'<br/>'&pc_review_assignedtoTEXT&'"
								,"PC_ASSEMBLY":"'&pc_assembly_datecompleted&'<br/>'&pc_assembly_assignedtoTEXT&'"
								,"PC_DELIVERY":"'&pc_delivery_datecompleted&'<br/>'&pc_delivery_assignedtoTEXT&'"
								,"PC_FEES":"'&PC_FEES&'"
								,"PC_PAIDTEXT":"'&PC_PAIDTEXT&'"
								,"PC_PRIORITY":"'&PC_PRIORITY&'"
								,"PC_ESTTIME":"'&PC_ESTTIME&'"								
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