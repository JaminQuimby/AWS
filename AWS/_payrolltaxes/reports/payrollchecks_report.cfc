<cfcomponent output="true">

<!--- 
[pc_id],[client_id]
      ,[pc_year]
      ,[pc_payenddate]
      ,[pc_paydate]
      ,[pc_datedue]
      ,[pc_esttime]
      ,[pt_altfreq]
      ,[pc_missinginfo]
      ,[pc_missinginforeceived]
      ,[pc_fees]
      ,[pc_paid]
      ,[pc_deliverymethod]
      ,[pc_obtaininfo_assignedto]
      ,[pc_obtaininfo_datecompleted]
      ,[pc_obtaininfo_completedby]
      ,[pc_obtaininfo_esttime]
      ,[pc_preparation_assignedto]
      ,[pc_preparation_datecompleted]
      ,[pc_preparation_completedby]
      ,[pc_preparation_esttime]
      ,[pc_review_assignedto]
      ,[pc_review_datecompleted]
      ,[pc_review_completedby]
      ,[pc_review_esttime]
      ,[pc_assembly_assignedto]
      ,[pc_assembly_datecompleted]
      ,[pc_assembly_completedby]
      ,[pc_assembly_esttime]
      ,[pc_delivery_assignedto]
      ,[pc_delivery_datecompleted]
      ,[pc_delivery_completedby]
      ,[pc_delivery_esttime]
  FROM [payrollcheckstatus]
--->



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
<!---


      ,[pc_obtaininfo_assignedtoTEXT]
      ,[pc_preparation_assignedtoTEXT]
      ,[pc_review_assignedtoTEXT]
      ,[pc_assembly_assignedtoTEXT]
      ,[pc_delivery_assignedtoTEXT]
--->

<cfquery datasource="AWS" name="fquery">
SELECT
[client_id]
,[client_name]
,[pc_id]
,[pc_year]
,CONVERT(VARCHAR(10),[pc_payenddate], 101)AS[pc_payenddate]
,CONVERT(VARCHAR(10),[pc_paydate], 101)AS[pc_paydate] 
,CONVERT(VARCHAR(10),[pc_datedue], 101)AS[pc_datedue]
,[pc_missinginfo] 
,CONVERT(VARCHAR(10),[pc_obtaininfo_datecompleted], 101)AS[pc_obtaininfo_datecompleted]
,CONVERT(VARCHAR(10),[pc_assembly_datecompleted], 101)AS[pc_assembly_datecompleted]
,CONVERT(VARCHAR(10),[pc_delivery_datecompleted], 101)AS[pc_delivery_datecompleted]
,[pc_fees]
,[pc_paid]
,[pc_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[pc_paid]=[optionvalue_id])

FROM[v_payrollcheckstatus]

<cfset sqllist = "pc_year,pc_payenddate,pc_paydate,pc_datedue,pc_esttime,pt_altfreq,pc_missinginfo,pc_missinginforeceived,pc_fees,pc_paid,pc_deliverymethod,pc_obtaininfo_assignedto,pc_obtaininfo_datecompleted,pc_obtaininfo_completedby,pc_obtaininfo_esttime,pc_preparation_assignedto,pc_preparation_datecompleted,pc_preparation_completedby,pc_preparation_esttime,pc_review_assignedto,pc_review_datecompleted,pc_review_completedby,pc_review_esttime,pc_assembly_assignedto,pc_assembly_datecompleted,pc_assembly_completedby,pc_assembly_esttime,pc_delivery_assignedto,pc_delivery_datecompleted,pc_delivery_completedby,pc_delivery_esttime">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>

<cfif ArrayLen(data.b) gt 0>

WHERE 1=1 
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
				<cfif ListContains('pc_'&g.n&',pc_'&g.n&'_less'&',pc_'&g.n&'_more' , list)>
                
                	<cfif list eq 'pc_'&g.n>
                	AND[#list#]='#g.v#'
                	</cfif>
                    <cfif list eq 'pc_'&g.n&'_less'>
                	AND[#list#]<='#g.v#'
                	</cfif>
                    <cfif list eq 'pc_'&g.n&'_more'>
                	AND[#list#]>='#g.v#'
                	</cfif>
                
                
				</cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>


</cfif>
</cfif>
<!--- <cfif ARGUMENTS.search neq "">
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
--->
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
								,"PC_DATEDUE":"'&PC_DATEDUE&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_OBTAININFO_DATECOMPLETED":"'&PC_OBTAININFO_DATECOMPLETED&'"
								,"PC_ASSEMBLY_DATECOMPLETED":"'&PC_ASSEMBLY_DATECOMPLETED&'"
								,"PC_DELIVERY_DATECOMPLETED":"'&PC_DELIVERY_DATECOMPLETED&'"
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