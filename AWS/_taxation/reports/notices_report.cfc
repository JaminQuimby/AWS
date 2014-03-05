<cfcomponent output="true">
<!--- 
SELECT[nm_id]
      ,[client_id]
      ,[nm_name]
      ,[nm_status]
FROM [noticematter]
  


GROUP2 LEVEL2  
SELECT[n_id]
      ,[n_assignedto]
      ,[n_deliverymethod]
	  ,[n_fees]
      ,[n_missinginfo]
      ,[n_missinginforeceived]
      ,[n_status]
      ,[n_paid]
      ,[n_priority]
      ,[n_esttime]
      ,[n_1_datenoticerec]
      ,[n_1_noticenumber]
      ,[n_1_noticedate]
      ,[n_1_taxform]
      ,[n_1_taxyear]
      ,[n_1_methodreceived]
      ,[n_2_rescompleted]
      ,[n_2_rescompletedby]
      ,[n_1_resduedate]
      ,[n_2_revrequired]
      ,[n_2_revassignedto]
      ,[n_2_revcompleted]
      ,[n_2_ressubmited]
      ,[n_2_irsstateresponse]
  FROM[notice]
  
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
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[nm_id]
,[n_id]
,[nm_name]
,[n_1_taxyear]



,[n_missinginfo]
,CONVERT(VARCHAR(10),[n_1_datenoticerec], 1)AS[n_1_datenoticerec]
,CONVERT(VARCHAR(10),[n_1_resduedate], 1)AS[n_1_resduedate]
,CONVERT(VARCHAR(10),[n_2_ressubmited], 1)AS[n_2_ressubmited]
,[n_2_revrequired]   
,FORMAT(n_fees, 'C', 'en-us')AS[n_fees]
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
,[n_1_noticenumberTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_noticenumber'AND[n_1_noticenumber]=[optionvalue_id])
,[n_1_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[n_1_taxform]=[optionvalue_id])
,[n_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[n_paid]=[optionvalue_id])


,[client_name]
,[client_id]
FROM[v_notice]
    
<cfset sqllist = "n_assignedto,n_deliverymethod,n_esttime,n_fees,n_missinginfo,n_missinginforeceived,n_status,n_paid,n_priority,n_1_datenoticerec,n_1_methodreceived,n_1_noticenumber,n_1_noticedate,n_1_taxform,n_1_taxyear,n_2_rescompleted,n_2_rescompletedby,n_1_resduedate,n_2_irsstateresponse,n_2_revassignedto,n_2_revcompleted,n_2_ressubmited,n_2_revrequired">
<cfset key="n_">
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
<cfset queryResult=queryResult&'{"NM_ID":"'&NM_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
 								,"NM_NAME":"'&NM_NAME&'"
 								,"N_1_TAXYEAR":"'&N_1_TAXYEAR&'"
 								,"N_1_TAXFORMTEXT":"'&N_1_TAXFORMTEXT&'"
 								,"N_1_NOTICENUMBERTEXT":"'&N_1_NOTICENUMBERTEXT&'"
 								,"N_STATUSTEXT":"'&N_STATUSTEXT&'"
 								,"N_MISSINGINFO":"'&N_MISSINGINFO&'"
 								,"N_1_DATENOTICEREC":"'&N_1_DATENOTICEREC&'"
 								,"N_1_RESDUEDATE":"'&N_1_RESDUEDATE&'"
 								,"N_2_RESSUBMITED":"'&N_2_RESSUBMITED&'"
 								,"N_2_REVREQUIRED":"'&N_2_REVREQUIRED&'"
 								,"N_FEES":"'&N_FEES&'"
 								,"N_PAIDTEXT":"'&N_PAIDTEXT&'"
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
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>