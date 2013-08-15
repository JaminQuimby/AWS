<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->
<!--- [LOAD FUNCTIONs] --->

<!--- 

[taxreturns_id]
      ,[client_id]
      ,[tr_taxyear]
      ,[tr_taxform]
      ,[tr_currentfees]
      ,[tr_priorfees]
      ,[tr_notrequired]
      ,[tr_credithold]
      ,[tr_priority]
      ,[tr_esttime]
      ,[tr_pptresttime]
      ,[tr_g2_informationreceived]
      ,[tr_g2_filingdeadline]
      ,[tr_g2_missinginfo]
      ,[tr_g2_missinginforeceived]
      ,[tr_g2_assignedto]
      ,[tr_g2_preparedby]
      ,[tr_g2_readyforreview]
      ,[tr_g2_reviewassignedto]
      ,[tr_g2_reviewd]
      ,[tr_g2_reviewedby]
      ,[tr_g2_reviewedwithnotes]
      ,[tr_g2_completed]
      ,[tr_g3_assemblereturn]
      ,[tr_g3_contacted]
      ,[tr_g3_messageleft]
      ,[tr_g3_emailed]
      ,[tr_g3_missingsignatures]
      ,[tr_g3_delivered]
      ,[tr_g3_deliverymethod]
      ,[tr_g3_paymentstatus]
      ,[tr_g3_multistatereturn]
      ,[tr_g4_pptrrequired]
      ,[tr_g4_pptrassignedto]
      ,[tr_g4_extended]
      ,[tr_g4_rfr]
      ,[tr_g4_completed]
      ,[tr_g4_delivered]
      ,[tr_g4_paymentstatus]
      ,[tr_g4_pptrcurrentfees]
      ,[tr_g4_pptrpriorfees]

--->
<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->

<cfcase value="group1">
<cfquery datasource="AWS" name="fQuery">
SELECT[tr_id]
,[tr_taxyear]

FROM[v_taxreturns]
WHERE[tr_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>

</cfcase>


</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"]}'> 
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
<!--- LOOKUP Financial Statements --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
FROM[v_taxreturns]
WHERE[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy)>ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[client_name]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","TR_TAXYEAR":"'&TR_TAXYEAR&'"}'>
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
<!--- Client --->
<cfcase value="client">
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][2])><cfset j.DATA[1][2]=1><cfelse><cfset j.DATA[1][2]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][3])><cfset j.DATA[1][3]=1><cfelse><cfset j.DATA[1][3]=0></cfif>

<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[CLIENT_LISTING](
[client_active],
[client_credit_hold],
[client_dms_refrence],
[client_group],
[client_name],
[client_notes],
[client_referred_by],
[client_salutation],
[client_since],
[client_spouse],
[client_trade_name],
[client_type]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>,<cfqueryparam value="#j.DATA[1][3]#"/>,<cfqueryparam value="#j.DATA[1][4]#"/>,<cfqueryparam value="#j.DATA[1][5]#"/>,<cfqueryparam value="#j.DATA[1][6]#"/>,<cfqueryparam value="#j.DATA[1][7]#"/>,<cfqueryparam value="#j.DATA[1][8]#"/>,<cfqueryparam value="#j.DATA[1][9]#"/>,<cfqueryparam value="#j.DATA[1][10]#"/>,<cfqueryparam value="#j.DATA[1][11]#"/>,<cfqueryparam value="#j.DATA[1][12]#"/>,<cfqueryparam value="#j.DATA[1][13]#"/>)
SELECT SCOPE_IDENTITY()AS[clientId]
</cfquery>
<cfreturn '{"id":#fquery.clientId#,"group":"customfield","result":"ok"}'>
</cfif>

<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[CLIENT_LISTING]
SET[client_active]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[client_credit_hold]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[client_dms_refrence]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[client_group]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[client_name]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[client_notes]=<cfqueryparam value="#j.DATA[1][7]#"/>
,[client_referred_by]=<cfqueryparam value="#j.DATA[1][8]#"/>
,[client_salutation]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[client_since]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[client_spouse]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[client_trade_name]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[client_type]=<cfqueryparam value="#j.DATA[1][13]#"/>
WHERE[CLIENT_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"customfields","result":"ok"}'>
</cfif>

</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>