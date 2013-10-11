<cfcomponent output="true">

<!---

SELECT TOP 1000 [pa_id]
 ,[client_id]
 ,CONVERT(VARCHAR(10),[pa_dateofrevocation], 101)AS[pa_dateofrevocation]
 ,CONVERT(VARCHAR(10),[pa_datesenttoirs], 101)AS[pa_datesenttoirs]
 ,CONVERT(VARCHAR(10),[pa_datesignedbyclient], 101)AS[pa_datesignedbyclient]
 ,[pa_preparers]
 ,[pa_status]
 ,[pa_taxforms]
 ,[pa_taxmatters]
,[pa_taxyears]
FROM[powerofattorney]
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
SELECT[pa_id]
,[pa_taxyears]
,[pa_taxforms]
,[pa_preparers]
,CONVERT(VARCHAR(10),[pa_datesignedbyclient], 101)AS[pa_datesignedbyclient]
,CONVERT(VARCHAR(10),[pa_datesenttoirs], 101)AS[pa_datesenttoirs]
,[client_name]
,[client_id]
FROM[v_powerofattorney]
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
<cfset queryResult=queryResult&'{"PA_ID":"'&PA_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PA_TAXYEARS":"'&PA_TAXYEARS&'"
								,"PA_TAXFORMS":"'&PA_TAXFORMS&'"
								,"PA_PREPARERS":"'&PA_PREPARERS&'"
								,"PA_DATESIGNEDBYCLIENT":"'&PA_DATESIGNEDBYCLIENT&'"
								,"PA_DATESENTTOIRS":"'&PA_DATESENTTOIRS&'"
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