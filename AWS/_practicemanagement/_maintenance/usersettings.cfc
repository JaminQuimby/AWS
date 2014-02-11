<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[user_id]
      ,[m_payrolltaxes]
      ,[m_accountingservices]
      ,[m_taxation]
      ,[m_clientmanagement]
      ,[g_delete]
      ,[m_maintenance]
FROM[v_staffinitials]
WHERE[user_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>


</cffunction>


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

<!--- LOOKUP Financial Statements --->
<cfcase value="group1">
<cfquery datasource="AWS" name="fquery">
SELECT[user_id]
      ,[name]
      ,[m_payrolltaxes]
      ,[m_accountingservices]
      ,[m_taxation]
      ,[m_clientmanagement]
      ,[g_delete]
      ,[m_maintenance]
FROM[v_staffinitials]

<cfif ARGUMENTS.search neq "">
AND[name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[name]</cfif>
</cfquery>


<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"USER_ID":"'&USER_ID&'"
								,"NAME":"'&NAME&'"
								,"M_PAYROLLTAXES":"'&M_PAYROLLTAXES&'"
								,"M_ACCOUNTINGSERVICES":"'&M_ACCOUNTINGSERVICES&'"
								,"M_TAXATION":"'&M_TAXATION&'"
								,"M_CLIENTMANAGEMENT":"'&M_CLIENTMANAGEMENT&'"
								,"M_MAINTENANCE":"'&M_MAINTENANCE&'"
								,"G_DELETE":"'&G_DELETE&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

</cfswitch>

</cffunction>

<!--- [SAVE FUNCTIONs] --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">



<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>


<cfswitch expression="#ARGUMENTS.group#">
<cfcase value="none"></cfcase>

<!--- Group1 --->
<cfcase value="group1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][4])><cfset j.DATA[1][4]=1><cfelse><cfset j.DATA[1][4]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<!--- if this is a new record, then insert it--->

<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">

<cfquery name="fquery" datasource="AWS">
UPDATE[staffinitials]
SET[m_accountingservices]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[m_clientmanagement]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[g_delete]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[m_maintenance]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[m_payrolltaxes]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[m_taxation]=<cfqueryparam value="#j.DATA[1][7]#"/>
WHERE[user_id]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>
<cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>

</cfif>

</cfcase>

</cfswitch>

</cffunction>


</cfcomponent>