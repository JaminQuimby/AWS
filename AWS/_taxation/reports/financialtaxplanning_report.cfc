<cfcomponent output="true">

<!---

SELECT[ftp_id]
      ,[client_id]
      ,[ftp_category]
      ,[ftp_status]
      ,[ftp_assignedto]
      ,[ftp_priority]
      ,[ftp_requestservice]
      ,[ftp_duedate]
      ,[ftp_inforequested]
      ,[ftp_inforeceived]
      ,[ftp_infocompiled]
      ,[ftp_missinginfo]
      ,[ftp_missinginforeceived]
      ,[ftp_reportcompleted]
      ,[ftp_finalclientmeeting]
      ,[ftp_esttime]
      ,[ftp_fees]
      ,[ftp_paid]
  FROM [financialtaxplanning]
  
  
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
SELECT[ftp_id]
,[ftp_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])
,[ftp_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])
,CONVERT(VARCHAR(10),[ftp_duedate], 1)AS[ftp_duedate]
,[ftp_assignedtoTEXT]
,CONVERT(VARCHAR(10),[ftp_requestservice], 1)AS[ftp_requestservice]
,CONVERT(VARCHAR(10),[ftp_inforequested], 1)AS[ftp_inforequested]
,CONVERT(VARCHAR(10),[ftp_inforeceived], 1)AS[ftp_inforeceived]
,CONVERT(VARCHAR(10),[ftp_infocompiled], 1)AS[ftp_infocompiled]
,[ftp_missinginfo]
,CONVERT(VARCHAR(10),[ftp_missinginforeceived], 1)AS[ftp_missinginforeceived]
,CONVERT(VARCHAR(10),[ftp_reportcompleted], 1)AS[ftp_reportcompleted]
,CONVERT(VARCHAR(10),[ftp_finalclientmeeting], 1)AS[ftp_finalclientmeeting]
,FORMAT(ftp_fees, 'C', 'en-us')AS[ftp_fees]
,[ftp_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[ftp_paid]=[optionvalue_id])
,[client_name]
,[client_id]
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
								,"FTP_STATUSTEXT":"'&FTP_STATUSTEXT&'"
								,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
								,"FTP_ASSIGNEDTOTEXT":"'&FTP_ASSIGNEDTOTEXT&'"
								,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
								,"FTP_INFOREQUESTED":"'&FTP_INFOREQUESTED&'"
								,"FTP_INFORECEIVED":"'&FTP_INFORECEIVED&'"
								,"FTP_INFOCOMPILED":"'&FTP_INFOCOMPILED&'"
								,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
								,"FTP_MISSINGINFORECEIVED":"'&FTP_MISSINGINFORECEIVED&'"
								,"FTP_REPORTCOMPLETED":"'&FTP_REPORTCOMPLETED&'"
								,"FTP_FINALCLIENTMEETING":"'&FTP_FINALCLIENTMEETING&'"
								,"FTP_FEES":"'&FTP_FEES&'"
								,"FTP_PAIDTEXT":"'&FTP_PAIDTEXT&'"
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