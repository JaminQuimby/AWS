<cfcomponent output="true">

<!--- 

[pt_id]
      ,[client_id]
      ,[pt_year]
      ,[pt_month]
      ,[pt_duedate]
      ,[pt_type]
      ,[pt_lastpay]
      ,[pt_priority]
      ,[pt_esttime]
      ,[pt_missinginfo]
      ,[pt_missinginforeceived]
      ,[pt_fees]
      ,[pt_paid]
      ,[pt_deliverymethod]
      ,[pt_obtaininfo_assignedto]
      ,[pt_obtaininfo_datecomplted]
      ,[pt_obtaininfo_completedby]
      ,[pt_obtaininfo_esttime]
      ,[pt_entry_assignedto]
      ,[pt_entry_datecompleted]
      ,[pt_entry_completedby]
      ,[pt_entry_esttime]
      ,[pt_rec_assignedto]
      ,[pt_rec_datecompleted]
      ,[pt_rec_completedby]
      ,[pt_rec_esttime]
      ,[pt_review_assignedto]
      ,[pt_review_datecompleted]
      ,[pt_review_completedby]
      ,[pt_review_esttime]
      ,[pt_assembly_assignedto]
      ,[pt_assembly_datecompleted]
      ,[pt_assembly_completedby]
      ,[pt_assembly_esttime]
      ,[pt_delivery_assignedto]
      ,[pt_delivery_datecompleted]
      ,[pt_delivery_completedby]
      ,[pt_delivery_esttime]
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
SELECT[pt_id]
,CONVERT(VARCHAR(8),[pt_duedate], 1)AS[pt_duedate]
,[pt_typeTEXT]
,[pt_stateTEXT]
,[pt_year]
,[pt_monthTEXT]
,CONVERT(VARCHAR(8),[pt_lastpay], 1)AS[pt_lastpay]
,CONVERT(VARCHAR(8),[pt_obtaininfo_datecompleted], 1)AS[pt_obtaininfo_datecompleted]
,[pt_missinginfo]
,CONVERT(VARCHAR(8),[pt_missinginforeceived], 1)AS[pt_missinginforeceived]
,CONVERT(VARCHAR(8),[pt_entry_datecompleted], 1)AS[pt_entry_datecompleted]
,CONVERT(VARCHAR(8),[pt_rec_datecompleted], 1)AS[pt_rec_datecompleted]
,CONVERT(VARCHAR(8),[pt_review_datecompleted], 1)AS[pt_review_datecompleted]
,CONVERT(VARCHAR(8),[pt_assembly_datecompleted], 1)AS[pt_assembly_datecompleted]
,CONVERT(VARCHAR(8),[pt_delivery_datecompleted], 1)AS[pt_delivery_datecompleted]
,[pt_fees]
,[pt_paidTEXT]      
,[client_name]
,[client_id]
FROM[v_payrolltaxes]

<cfset sqllist = "pt_assembly_assignedto,pt_assembly_completedby,pt_assembly_datecompleted,pt_assembly_esttime,pt_delivery_assignedto,pt_delivery_completedby,pt_delivery_datecompleted,pt_delivery_esttime,pt_deliverymethod,pt_duedate,pt_entry_assignedto,pt_entry_completedby,pt_entry_datecompleted,pt_entry_esttime,pt_esttime,pt_fees,pt_lastpay,pt_missinginfo,pt_missinginforeceived,pt_month,pt_obtaininfo_assignedto,pt_obtaininfo_completedby,pt_obtaininfo_datecomplted,pt_obtaininfo_esttime,pt_paid,pt_priority,pt_rec_assignedto,pt_rec_completedby,pt_rec_datecompleted,pt_rec_esttime,pt_review_assignedto,pt_review_completedby,pt_review_datecompleted,pt_review_esttime,pt_type,pt_year">
<cfset key="pt_">
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


<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
								,"PT_TYPETEXT":"'&PT_TYPETEXT&'"
								,"PT_STATETEXT":"'&PT_STATETEXT&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTHTEXT":"'&PT_MONTHTEXT&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_OBTAININFO_DATECOMPLETED":"'&PT_OBTAININFO_DATECOMPLETED&'"
								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
								,"PT_MISSINGINFORECEIVED":"'&PT_MISSINGINFORECEIVED&'"
								,"PT_ENTRY_DATECOMPLETED":"'&PT_ENTRY_DATECOMPLETED&'"
								,"PT_REC_DATECOMPLETED":"'&PT_REC_DATECOMPLETED&'"
								,"PT_REVIEW_DATECOMPLETED":"'&PT_REVIEW_DATECOMPLETED&'"
								,"PT_ASSEMBLY_DATECOMPLETED":"'&PT_ASSEMBLY_DATECOMPLETED&'"
								,"PT_DELIVERY_DATECOMPLETED":"'&PT_DELIVERY_DATECOMPLETED&'"
								,"PT_FEES":"'&PT_FEES&'"
								,"PT_PAIDTEXT":"'&PT_PAIDTEXT&'"
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