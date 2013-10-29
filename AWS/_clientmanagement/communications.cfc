<cfcomponent output="true">
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Assets --->
<cfcase value="assetSpouse">
<cfquery datasource="AWS" name="fQuery">
SELECT[client_spouse]
FROM[client_listing]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[co_id]
,[client_id]
,[co_briefmessage]
,[co_caller]
,[co_completed]
,[co_contactmethod]
,[co_credithold]
,CONVERT(CHAR(10),[co_date], 101)+' '+RIGHT(CONVERT(VARCHAR,co_date, 100),7)AS[co_date]
,CONVERT(VARCHAR(10),[co_duedate], 101)AS[co_duedate]
,[co_emailaddress]
,[co_ext]
,[co_faxnumber]
,[co_fees]
,[co_for]
,[co_paid]
,[co_responseneeded]
,[co_returncall]
,[co_takenby]
,[co_telephone]
,[client_spouse]
FROM[v_communications]
WHERE[co_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>

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
<!--- LOOKUP Communications --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[co_forTEXT]
,[co_briefmessage]
,[co_caller]
,CONVERT(VARCHAR(10),[co_duedate], 101)AS[co_duedate]
,[co_responseneeded]
,[client_name]
,[client_id]
FROM[v_communications]
WHERE[co_telephone] = 0 
<cfif ARGUMENTS.search neq "">
AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfif> 
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_FORTEXT":"'&CO_FORTEXT&'"
								,"CO_BRIEFMESSAGE":"'&CO_BRIEFMESSAGE&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_DUEDATE":"'&CO_DUEDATE&'"
								,"CO_RESPONSENEEDED":"'&CO_RESPONSENEEDED&'"
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



<!--- [SAVE FUNCTIONs] --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cftry>
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">
<cfcase value="none">
</cfcase>
<!--- Group1 --->
<cfcase value="group1">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][5])><cfset j.DATA[1][5]=1><cfelse><cfset j.DATA[1][5]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][7])><cfset j.DATA[1][7]=1><cfelse><cfset j.DATA[1][7]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][16])><cfset j.DATA[1][16]=1><cfelse><cfset j.DATA[1][16]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][17])><cfset j.DATA[1][17]=1><cfelse><cfset j.DATA[1][17]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[COMMUNICATIONS](
[client_id]
,[co_briefmessage]
,[co_caller]
,[co_completed]
,[co_contactmethod]
,[co_credithold]
,[co_date]
,[co_duedate]
,[co_emailaddress]
,[co_ext]
,[co_faxnumber]
,[co_fees]
,[co_for]
,[co_paid]
,[co_responseneeded]
,[co_returncall]
,[co_takenby]
,[co_telephone]
)
VALUES(
<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
,<cfqueryparam value="#j.DATA[1][8]#"/>
,<cfqueryparam value="#j.DATA[1][9]#"/>
,<cfqueryparam value="#j.DATA[1][10]#"/>
,<cfqueryparam value="#j.DATA[1][11]#"/>
,<cfqueryparam value="#j.DATA[1][12]#"/>
,<cfqueryparam value="#j.DATA[1][13]#"/>
,<cfqueryparam value="#j.DATA[1][14]#"/>
,<cfqueryparam value="#j.DATA[1][15]#"/>
,<cfqueryparam value="#j.DATA[1][16]#"/>
,<cfqueryparam value="#j.DATA[1][17]#"/>
,<cfqueryparam value="#j.DATA[1][18]#"/>
,<cfqueryparam value="#j.DATA[1][19]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN CO_ID--->
<cfreturn '{"id":#fquery.id#,"group":"plugins","result":"ok"}'>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[COMMUNICATIONS]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[co_briefmessage]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[co_caller]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[co_completed]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[co_contactmethod]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[co_credithold]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[co_date]=<cfqueryparam value="#dateFormat(j.DATA[1][8],'YYYY-MM-DD')# #timeFormat(j.DATA[1][8],'hh:mm:ss tt')#"/>
,[co_duedate]=<cfqueryparam value="#j.DATA[1][9]#" null="#LEN(j.DATA[1][9]) eq 0#"/>
,[co_emailaddress]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[co_ext]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[co_faxnumber]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[co_fees]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[co_for]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[co_paid]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[co_responseneeded]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[co_returncall]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[co_takenby]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[co_telephone]=<cfqueryparam value="#j.DATA[1][19]#"/>
WHERE[CO_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"plugins","result":"ok"}'>
</cfif>
</cfcase>

</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.client_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>

