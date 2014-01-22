<cfcomponent output="true">

<!--- 
[pc_id]
      ,[client_id]
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


<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.build) gt 0> WHERE 1=1
<cfloop array="#data.build#" index="i">

<cfset altfreq = i.group.altfreq />
<cfset assembly_assignedto = i.group.assembly_assignedto />
	<cfset assembly_datecompleted = i.group.assembly_datecompleted />
<cfset assembly_completedby = i.group.assembly_completedby />
<cfset assembly_esttime = i.group.assembly_esttime />
<cfset clientname = i.group.clientname />
	<cfset datedue = i.group.datedue />
<cfset delivery_assignedto = i.group.delivery_assignedto />
<cfset delivery_datecompleted = i.group.delivery_datecompleted />
	<cfset delivery_completedby = i.group.delivery_completedby />
<cfset delivery_esttime = i.group.delivery_esttime />
<cfset deliverymethod = i.group.deliverymethod />
<cfset esttime = i.group.esttime />
	<cfset fees = i.group.fees />
	<cfset missinginfo = i.group.missinginfo />
<cfset missinginforeceived = i.group.missinginforeceived />
<cfset obtaininfo_assignedto = i.group.obtaininfo_assignedto />
<cfset obtaininfo_datecompleted = i.group.obtaininfo_datecompleted />
	<cfset obtaininfo_completedby = i.group.obtaininfo_completedby />
<cfset obtaininfo_esttime = i.group.obtaininfo_esttime />
<cfset paid = i.group.paid />
	<cfset payenddate = i.group.payenddate />
	<cfset paydate = i.group.paydate />
<cfset preparation_assignedto = i.group.preparation_assignedto />
<cfset preparation_datecompleted = i.group.preparation_datecompleted />
<cfset preparation_completedby = i.group.preparation_completedby />
<cfset preparation_esttime = i.group.preparation_esttime />
<cfset review_assignedto = i.group.review_assignedto />
<cfset review_datecompleted = i.group.review_datecompleted />
<cfset review_completedby = i.group.review_completedby />
<cfset review_esttime = i.group.review_esttime />
	<cfset year = i.group.year />


<cfif i.type eq "NONE">AND((1)=(1)
<cfif search neq "">AND [CLIENT_NAME]LIKE <cfqueryparam value="%#search#%" cfsqltype="cf_sql_varchar" maxlength="20"></cfif>


<cfif assembly_completedby neq ""><cfif isDate(assembly)>AND[pc_assembly_datecompleted]= <cfqueryparam value="#assembly_completedby#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_assembly_datecompleted]IS NULL</cfif></cfif>
<cfif assembly_completedby_less neq "">AND[pc_assembly_datecompleted]<= <cfqueryparam value="#assembly_completedby_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif assembly_completedby_more neq "">AND[pc_assembly_datecompleted]>= <cfqueryparam value="#assembly_completedby_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif datedue neq ""><cfif isDate(duedate)>AND[pc_datedue]= <cfqueryparam value="#datedue#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_datedue]IS NULL</cfif></cfif>
<cfif datedue_less neq "">AND [pc_datedue]<= <cfqueryparam value="#datedue_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif datedue_more neq "">AND [pc_datedue]>= <cfqueryparam value="#datedue_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif paydate neq ""><cfif isDate(duedate)>AND [pc_paydate]= <cfqueryparam value="#paydate#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_paydate]IS NULL</cfif></cfif>
<cfif paydate_less neq "">AND [pc_paydate]<= <cfqueryparam value="#paydate_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif paydate_more neq "">AND [pc_paydate]>= <cfqueryparam value="#paydate_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif payenddate neq ""><cfif isDate(duedate)>AND [pc_payenddate]= <cfqueryparam value="#payenddate#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_payenddate]IS NULL</cfif></cfif>
<cfif payenddate_less neq "">AND [pc_payenddate]<= <cfqueryparam value="#payenddate_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif payenddate_more neq "">AND [pc_payenddate]>= <cfqueryparam value="#payenddate_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif missinginfo neq ""><cfif ListContains('Yes,True,yes,true,1',missinginfo)>AND[pc_missinginfo]=(1)<cfelse>AND [pc_missinginfo]=(0)</cfif></cfif>
<cfif obtaininfo_completedby neq ""><cfif isDate(obtaininfo)>AND[pc_obtaininfo_datecompleted]= <cfqueryparam value="#obtaininfo_completedby#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_obtaininfo_datecompleted]IS NULL</cfif></cfif>
<cfif obtaininfo_completedby_less neq "">AND[pc_obtaininfo_datecompleted]<= <cfqueryparam value="#obtaininfo_completedby_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif obtaininfo_completedby_more neq "">AND[pc_obtaininfo_datecompleted]>= <cfqueryparam value="#obtaininfo_completedby_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif delivery_completedby neq ""><cfif isDate(delivery)>AND[pc_assembly_datecompleted]= <cfqueryparam value="#delivery_completedby#" cfsqltype="cf_sql_date" maxlength="9"><cfelse>AND[pc_assembly_datecompleted]IS NULL</cfif></cfif>
<cfif delivery_completedby_less neq "">AND[pc_assembly_datecompleted]<= <cfqueryparam value="#delivery_completedby_less#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif delivery_completedby_more neq "">AND[pc_assembly_datecompleted]>= <cfqueryparam value="#delivery_completedby_more#" cfsqltype="cf_sql_date" maxlength="9"></cfif>
<cfif fees neq "">AND[pc_fees]= <cfqueryparam value="#fees#" cfsqltype="cf_sql_numeric" maxlength="10"null="#len(fees) eq 0#"></cfif>
<cfif fees_less neq "">AND[pc_fees]<= <cfqueryparam value="#fees#" cfsqltype="cf_sql_numeric" maxlength="10"null="#len(fees_less) eq 0#"></cfif>
<cfif fees_more neq "">AND[pc_fees]>= <cfqueryparam value="#fees#" cfsqltype="cf_sql_numeric" maxlength="10"  null="#len(fees_more) eq 0#"></cfif>
<cfif paid neq "">AND[pc_paid]=(SELECT TOP(1)[optionvalue_id]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[optionname]=<cfqueryparam value="#paid#" cfsqltype="cf_sql_varchar" maxlength="15">)</cfif>
<cfif year neq "">AND [pc_year]= <cfqueryparam value="#year#" cfsqltype="cf_sql_numeric" maxlength="4" null="#len(year) eq 0#"></cfif>
<cfif year_less neq "">AND [pc_year]<= <cfqueryparam value="#year_less#" cfsqltype="cf_sql_numeric" maxlength="4" null="#len(year_less) eq 0#"></cfif>
<cfif year_more neq "">AND [pc_year]>= <cfqueryparam value="#year_more#" cfsqltype="cf_sql_numeric" maxlength="4" null="#len(year_more) eq 0#"></cfif>


)</cfif>

<cfif i.type eq "AND">AND((1)=(1)
)</cfif>

<cfif i.type eq "OR">OR((1)=(1)
)</cfif>
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