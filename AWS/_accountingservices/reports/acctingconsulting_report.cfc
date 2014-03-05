<cfcomponent output="true">
<!---
SELECT TOP 1000 [mc_id]
      ,[client_id]
      ,[mc_assignedto]
      ,[mc_category]
      ,[mc_description]
      ,[mc_duedate]
      ,[mc_esttime]
      ,[mc_fees]
      ,[mc_paid]
      ,[mc_priority]
      ,[mc_projectcompleted]
      ,[mc_requestforservice]
      ,[mc_status]
      ,[mc_workinitiated]
      ,[mc_credithold]
  FROM [AWS].[dbo].[managementconsulting]
  
  
SELECT TOP 1000 [mcs_id]
      ,[mc_id]
      ,[mcs_actualtime]
      ,[mcs_assignedto]
      ,[mcs_completed]
      ,[mcs_dependencies]
      ,[mcs_duedate]
      ,[mcs_esttime]
      ,[mcs_notes]
      ,[mcs_sequence]
      ,[mcs_status]
      ,[mcs_subtask]
  FROM [AWS].[dbo].[managementconsulting_subtask]
--->


<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="numeric" required="no">
<cfargument name="formid" type="numeric" required="no">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[mc_id]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,[mc_assignedtoTEXT]
,mc_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,[mc_status]
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
,CONVERT(VARCHAR(8),[mc_requestforservice], 1)AS[mc_requestforservice]
,CONVERT(VARCHAR(8),[mc_duedate], 1)AS[mc_duedate]
,CONVERT(VARCHAR(8),[mc_workinitiated], 1)AS[mc_workinitiated]
,CONVERT(VARCHAR(8),[mc_projectcompleted], 1)AS[mc_projectcompleted]
,[mc_esttime]
,FORMAT(mc_fees, 'C', 'en-us')AS[mc_fees]
,[mc_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[mc_paid]=[optionvalue_id])
,[client_name]
,[client_id]
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
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_STATUSTEXT":"'&MC_STATUSTEXT&'"		
								,"MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'"
								,"MC_REQUESTFORSERVICE":"'&MC_REQUESTFORSERVICE&'"
								,"MC_WORKINITIATED":"'&MC_WORKINITIATED&'"
								,"MC_PROJECTCOMPLETED":"'&MC_PROJECTCOMPLETED&'"
								,"MC_FEES":"'&MC_FEES&'"
								,"MC_PAIDTEXT":"'&MC_PAIDTEXT&'"	
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