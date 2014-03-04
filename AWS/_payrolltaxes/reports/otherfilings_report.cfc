<cfcomponent output="true">

<!---
SELECT TOP 1000 [of_id]
      ,[client_id]
      ,[of_taxyear]
      ,[of_period]
      ,[of_state]
      ,[of_type]
      ,[of_form]
      ,[of_duedate]
      ,[of_filingdeadline]
      ,[of_extensiondeadline]
      ,[of_extensioncompleted]
      ,[of_status]
      ,[of_priority]
      ,[of_esttime]
      ,[of_missinginfo]
      ,[of_missinginforeceived]
      ,[of_fees]
      ,[of_paid]
      ,[of_deliverymethod]
      ,[of_obtaininfo_assignedto]
      ,[of_obtaininfo_datecompleted]
      ,[of_obtaininfo_completedby]
      ,[of_obtaininfo_esttime]
      ,[of_preparation_assignedto]
      ,[of_preparation_datecompleted]
      ,[of_preparation_completedby]
      ,[of_preparation_esttime]
      ,[of_review_assignedto]
      ,[of_review_datecompleted]
      ,[of_review_completedby]
      ,[of_review_esttime]
      ,[of_assembly_assignedto]
      ,[of_assembly_datecompleted]
      ,[of_assembly_completedby]
      ,[of_assembly_esttime]
      ,[of_delivery_assignedto]
      ,[of_delivery_datecompleted]
      ,[of_delivery_completedby]
      ,[of_delivery_esttime]
  FROM [otherfilings]
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
SELECT[of_id]
,CONVERT(VARCHAR(8),[of_duedate], 1)AS[of_duedate]
,[of_taxyear]
,[of_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[of_paid]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_state]=[optionvalue_id])
,[of_periodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])

,[of_missinginfo]
,CONVERT(VARCHAR(8),[of_missinginforeceived], 1)AS[of_missinginforeceived]
,CONVERT(VARCHAR(8),of_obtaininfo_datecompleted, 1) + '<br />' + CONVERT(VARCHAR(5),of_obtaininfo_assignedtoTEXT) AS [of_obtaininfo]
,CONVERT(VARCHAR(8),of_preparation_datecompleted, 1) + '<br />' + CONVERT(VARCHAR(5),of_preparation_assignedtoTEXT) AS [of_preparation]
,CONVERT(VARCHAR(8),[of_review_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),of_review_assignedtoTEXT) AS [of_review]
,CONVERT(VARCHAR(8),[of_assembly_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),of_assembly_assignedtoTEXT) AS [of_assembly]
,CONVERT(VARCHAR(8),[of_delivery_datecompleted], 1) + '<br />' + CONVERT(VARCHAR(5),of_delivery_assignedtoTEXT) AS [of_delivery]
,[of_fees]
,[of_esttime]
,[client_name]
,[client_id]
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
								,"OF_OBTAININFO":"'&OF_OBTAININFO&'"
								,"OF_PREPARATION":"'&OF_PREPARATION&'"
								,"OF_REVIEW":"'&OF_REVIEW&'"
								,"OF_ASSEMBLY":"'&OF_ASSEMBLY&'"
								,"OF_DELIVERY":"'&OF_DELIVERY&'"
								,"OF_FEES":"'&OF_FEES&'"
 								,"OF_PAIDTEXT":"'&OF_PAIDTEXT&'"
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