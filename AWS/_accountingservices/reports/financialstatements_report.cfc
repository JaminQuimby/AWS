<cfcomponent output="true">
<!---
SELECT[fds_id]
      ,[client_id]
      ,[fds_year]
      ,[fds_month]
      ,[fds_periodend]
      ,[fds_status]
      ,[fds_duedate]
      ,[fds_priority]
      ,[fds_esttime]
      ,[fds_missinginfo]
      ,[fds_missinginforeceived]
      ,[fds_compilemi]
      ,[fds_cmireceived]
      ,[fds_fees]
      ,[fds_paid]
      ,[fds_deliverymethod]
      ,[fds_obtaininfo_assignedto]
      ,[fds_obtaininfo_datecompleted]
      ,[fds_obtaininfo_completedby]
      ,[fds_obtaininfo_esttime]
      ,[fds_sort_assignedto]
      ,[fds_sort_datecompleted]
      ,[fds_sort_completedby]
      ,[fds_sort_esttime]
      ,[fds_checks_assignedto]
      ,[fds_checks_datecompleted]
      ,[fds_checks_completedby]
      ,[fds_checks_esttime]
      ,[fds_sales_assignedto]
      ,[fds_sales_datecompleted]
      ,[fds_sales_completedby]
      ,[fds_sales_esttime]
      ,[fds_entry_assignedto]
      ,[fds_entry_datecompleted]
      ,[fds_entry_completedby]
      ,[fds_entry_esttime]
      ,[fds_reconcile_assignedto]
      ,[fds_reconcile_datecompleted]
      ,[fds_reconcile_completedby]
      ,[fds_reconcile_esttime]
      ,[fds_compile_assignedto]
      ,[fds_compile_datecompleted]
      ,[fds_compile_completedby]
      ,[fds_compile_esttime]
      ,[fds_review_assignedto]
      ,[fds_review_datecompleted]
      ,[fds_review_completedby]
      ,[fds_review_esttime]
      ,[fds_assembly_assignedto]
      ,[fds_assembly_datecompleted]
      ,[fds_assembly_completedby]
      ,[fds_assembly_esttime]
      ,[fds_delivery_assignedto]
      ,[fds_delivery_datecompleted]
      ,[fds_delivery_completedby]
      ,[fds_delivery_esttime]
      ,[fds_acctrpt_assignedto]
      ,[fds_acctrpt_datecompleted]
      ,[fds_acctrpt_completedby]
      ,[fds_acctrpt_esttime]
  FROM [financialdatastatus]

SELECT [fdss_id]
      ,[fds_id]
      ,[fdss_sequence]
      ,[fdss_subtask]
      ,[fdss_status]
      ,[fdss_assignedto]
      ,[fdss_duedate]
      ,[fdss_completed]
      ,[fdss_notes]
  FROM [AWS].[dbo].[financialdatastatus_status]
--->

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

<cfquery datasource="AWS" name="fquery">
SELECT[fds_id]
,[fds_year]
,[fds_month]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
,[fds_missinginfo]
,[fds_compilemi]
,CONVERT(VARCHAR(8),fds_obtaininfo_datecompleted, 1) + '<br />' + CONVERT(VARCHAR(5),fds_obtaininfo_assignedtoTEXT) AS [fds_obtaininfo]
,CONVERT(VARCHAR(8),[fds_sort_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_sort_assignedtoTEXT) AS [fds_sort]
,CONVERT(VARCHAR(8),[fds_checks_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_checks_assignedtoTEXT) AS [fds_checks]
,CONVERT(VARCHAR(8),[fds_sales_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_sales_assignedtoTEXT) AS [fds_sales]
,CONVERT(VARCHAR(8),[fds_entry_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_entry_assignedtoTEXT) AS [fds_entry]
,CONVERT(VARCHAR(8),[fds_reconcile_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_reconcile_assignedtoTEXT) AS [fds_reconcile]
,CONVERT(VARCHAR(8),[fds_compile_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_compile_assignedtoTEXT) AS [fds_compile]
,CONVERT(VARCHAR(8),[fds_review_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_review_assignedtoTEXT) AS [fds_review]
,CONVERT(VARCHAR(8),[fds_assembly_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_assembly_assignedtoTEXT) AS [fds_assembly]
,CONVERT(VARCHAR(8),[fds_delivery_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_delivery_assignedtoTEXT) AS [fds_delivery]
,CONVERT(VARCHAR(8),[fds_acctrpt_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),fds_acctrpt_assignedtoTEXT) AS [fds_acctrpt]
,FORMAT(fds_fees, 'C', 'en-us')AS[fds_fees]
,[fds_paid]
,[client_name]
,[client_id]
FROM[v_financialdatastatus]


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
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_OBTAININFO":"'&FDS_OBTAININFO&'"
								,"FDS_SORT":"'&FDS_SORT&'"
								,"FDS_CHECKS":"'&FDS_CHECKS&'"
								,"FDS_SALES":"'&FDS_SALES&'"
								,"FDS_ENTRY":"'&FDS_ENTRY&'"
								,"FDS_RECONCILE":"'&FDS_RECONCILE&'"
								,"FDS_COMPILE":"'&FDS_COMPILE&'"
								,"FDS_REVIEW":"'&FDS_REVIEW&'"
								,"FDS_ASSEMBLY":"'&FDS_ASSEMBLY&'"
								,"FDS_DELIVERY":"'&FDS_DELIVERY&'"
								,"FDS_ACCTRPT":"'&FDS_ACCTRPT&'"
								,"FDS_FEES":"'&FDS_FEES&'"
								,"FDS_PAID":"'&FDS_PAID&'"
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

<!--- Grid 2 Entrance --->
<cfcase value="group2">
<cftry>

<cfquery datasource="AWS" name="fquery">
SELECT[fdss_id]
,[fds_id]
,[fds_year]
,[fds_month]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
,[fds_missinginfo]
,[fds_compilemi]
,COALESCE(CONVERT(VARCHAR(10),fds_obtaininfo_datecompleted, 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_obtaininfo_assignedtoTEXT) AS [fds_obtaininfo]
,COALESCE(CONVERT(VARCHAR(10),[fds_sort_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_sort_assignedtoTEXT) AS [fds_sort]
,COALESCE(CONVERT(VARCHAR(10),[fds_checks_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_checks_assignedtoTEXT) AS [fds_checks]
,COALESCE(CONVERT(VARCHAR(10),[fds_sales_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_sales_assignedtoTEXT) AS [fds_sales]
,COALESCE(CONVERT(VARCHAR(10),[fds_entry_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_entry_assignedtoTEXT) AS [fds_entry]
,COALESCE(CONVERT(VARCHAR(10),[fds_reconcile_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_reconcile_assignedtoTEXT) AS [fds_reconcile]
,COALESCE(CONVERT(VARCHAR(10),[fds_compile_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_compile_assignedtoTEXT) AS [fds_compile]
,COALESCE(CONVERT(VARCHAR(10),[fds_review_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_review_assignedtoTEXT) AS [fds_review]
,COALESCE(CONVERT(VARCHAR(10),[fds_assembly_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_assembly_assignedtoTEXT) AS [fds_assembly]
,COALESCE(CONVERT(VARCHAR(10),[fds_delivery_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_delivery_assignedtoTEXT) AS [fds_delivery]
,COALESCE(CONVERT(VARCHAR(10),[fds_acctrpt_datecompleted], 1), '') + '<br />' + CONVERT(VARCHAR(5),fds_acctrpt_assignedtoTEXT) AS [fds_acctrpt]
,FORMAT(fds_fees, 'C', 'en-us')AS[fds_fees]
,[fds_paid]
,[fdss_subtaskTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialstatmentsubtask'AND[fdss_subtask]=[optionvalue_id])
,[fdss_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fdss_status]=[optionvalue_id])
,[client_name]
,[client_id]
FROM[v_financialdatastatus_subtask]
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
<cfset queryResult=queryResult&'{"FDSS_ID":"'&FDSS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
								,"FDS_OBTAININFO":"'&FDS_OBTAININFO&'"
								,"FDS_SORT":"'&FDS_SORT&'"
								,"FDS_CHECKS":"'&FDS_CHECKS&'"
								,"FDS_SALES":"'&FDS_SALES&'"
								,"FDS_ENTRY":"'&FDS_ENTRY&'"
								,"FDS_RECONCILE":"'&FDS_RECONCILE&'"
								,"FDS_COMPILE":"'&FDS_COMPILE&'"
								,"FDS_REVIEW":"'&FDS_REVIEW&'"
								,"FDS_ASSEMBLY":"'&FDS_ASSEMBLY&'"
								,"FDS_DELIVERY":"'&FDS_DELIVERY&'"
								,"FDS_ACCTRPT":"'&FDS_ACCTRPT&'"
								,"FDSS_SUBTASKTEXT":"'&FDSS_SUBTASKTEXT&'"
								,"FDSS_STATUSTEXT":"'&FDSS_STATUSTEXT&'"
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