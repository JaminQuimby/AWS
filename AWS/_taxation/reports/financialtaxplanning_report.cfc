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


<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[ftp_id]
,[ftp_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])
,[ftp_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])
,[ftp_duedate]=FORMAT(ftp_duedate,'#Session.localization.formatdate#')
,[ftp_assignedtoTEXT]
,[ftp_description]
,[ftp_requestservice]=FORMAT(ftp_requestservice,'#Session.localization.formatdate#')
,[ftp_inforequested]=FORMAT(ftp_inforequested,'#Session.localization.formatdate#')
,[ftp_inforeceived]=FORMAT(ftp_inforeceived,'#Session.localization.formatdate#')
,[ftp_infocompiled]=FORMAT(ftp_infocompiled,'#Session.localization.formatdate#')
,[ftp_missinginfo]
,[ftp_priority]
,[ftp_esttime]
,[ftp_missinginforeceived]=FORMAT(ftp_missinginforeceived,'#Session.localization.formatdate#')
,[ftp_reportcompleted]=FORMAT(ftp_reportcompleted,'#Session.localization.formatdate#')
,[ftp_finalclientmeeting]=FORMAT(ftp_finalclientmeeting,'#Session.localization.formatdate#')
,FORMAT(ftp_fees, 'C', 'en-us')AS[ftp_fees]
,[ftp_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[ftp_paid]=[optionvalue_id])
,[client_name]
,[client_id]
FROM[v_financialtaxplanning]
WHERE [client_active]=(1)
AND [ftp_active]=(1)

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
								,"FTP_DESCRIPTION":"'&FTP_DESCRIPTION&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_STATUSTEXT":"'&FTP_STATUSTEXT&'"
								,"FTP_ASSIGNEDTOTEXT":"'&FTP_ASSIGNEDTOTEXT&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_INFOREQUESTED":"'&FTP_INFOREQUESTED&'"
								,"FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'"
								,"FTP_INFOCOMPILED":"'&FTP_INFOCOMPILED&'"
								,"FTP_REPORTCOMPLETED":"'&FTP_REPORTCOMPLETED&'"
								,"FTP_FINALCLIENTMEETING":"'&FTP_FINALCLIENTMEETING&'"
								,"FTP_FEES":"'&FTP_FEES&'"
								,"FTP_PAIDTEXT":"'&FTP_PAIDTEXT&'"
								,"FTP_PRIORITY":"'&FTP_PRIORITY&'"
								,"FTP_ESTTIME":"'&FTP_ESTTIME&'"
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