<cfcomponent output="true">
<!---
SELECT TOP 1000 [co_id]
      ,[client_id]
      ,[co_date]
      ,[co_takenby]
      ,[co_for]
      ,[co_caller]
      ,[co_telephone]
      ,[co_ext]
      ,[co_faxnumber]
      ,[co_emailaddress]
      ,[co_voicemail]
      ,[co_personalcontact]
      ,[co_textmessage]
      ,[co_email]
      ,[co_mail]
      ,[co_fax]
      ,[co_briefmessage]
      ,[co_responsenotneeded]
      ,[co_returncall]
      ,[co_completed]
      ,[co_fees]                        duedate, credithold,spouse, starttime
      ,[co_paid]
  FROM [AWS].[dbo].[communications]
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
SELECT[CO_ID]
,[client_id]
,[co_briefmessage]
,[co_caller]
,[co_completed]
,[co_credithold]
,CONVERT(CHAR(10),[co_date], 101)+' '+RIGHT(CONVERT(VARCHAR,co_date, 100),7)AS[co_date]
,CONVERT(VARCHAR(10),[co_duedate], 101)AS[co_duedate]
,[co_email]
,[co_emailaddress]
,[co_ext]
,[co_fax]
,[co_faxnumber]
,[co_fees]
,[co_for]
,[co_mail]
,[co_paid]
,[co_personalcontact]
,[co_responsenotneeded]
,[co_returncall]
,[co_takenby]
,[co_telephone]
,[co_textmessage]
,[co_voicemail]
FROM[communications]
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
<cfargument name="otherid" type="string" required="no">



<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- LOOKUP Financial Statements --->
<!--- Grid 0 Entrance --->
<cfcase value="group0">
<cfquery datasource="AWS" name="fquery">
SELECT[co_id]
,[co_for]
,[client_name]
,[CLIENT_ID]
FROM[v_communications]
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
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","CO_FOR":"'&CO_FOR&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2  --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[co_date], 101)AS[co_date],[u_name],[u_email],[co_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[other_id]=<cfqueryparam value="#ARGUMENTS.otherid#"/> 

AND[co_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"COMMENT_ID":"'&COMMENT_ID&'","C_DATE":"'&C_DATE&'","U_NAME":"'&U_NAME&'","U_EMAIL":"'&U_EMAIL&'","C_NOTES":"'&C_NOTES&'"}'>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][6])><cfset j.DATA[1][6]=1><cfelse><cfset j.DATA[1][6]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][16])><cfset j.DATA[1][16]=1><cfelse><cfset j.DATA[1][16]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][18])><cfset j.DATA[1][18]=1><cfelse><cfset j.DATA[1][18]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][19])><cfset j.DATA[1][19]=1><cfelse><cfset j.DATA[1][19]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][20])><cfset j.DATA[1][20]=1><cfelse><cfset j.DATA[1][20]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][23])><cfset j.DATA[1][23]=1><cfelse><cfset j.DATA[1][23]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][24])><cfset j.DATA[1][24]=1><cfelse><cfset j.DATA[1][24]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cftry>
<cfquery name="fquery" datasource="AWS">
INSERT INTO[COMMUNICATIONS](
[client_id]
,[co_briefmessage]
,[co_caller]
,[co_completed]
,[co_credithold]
,[co_date]
,[co_duedate]
,[co_email]
,[co_emailaddress]
,[co_ext]
,[co_fax]
,[co_faxnumber]
,[co_fees]
,[co_for]
,[co_mail]
,[co_paid]
,[co_personalcontact]
,[co_responsenotneeded]
,[co_returncall]
,[co_takenby]
,[co_telephone]
,[co_textmessage]
,[co_voicemail]
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
,<cfqueryparam value="#j.DATA[1][20]#"/>
,<cfqueryparam value="#j.DATA[1][21]#"/>
,<cfqueryparam value="#j.DATA[1][22]#"/>
,<cfqueryparam value="#j.DATA[1][23]#"/>
,<cfqueryparam value="#j.DATA[1][24]#"/>
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN CO_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group2","result":"ok"}'>
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
,[co_credithold]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[co_date]=<cfqueryparam value="#dateFormat(j.DATA[1][7],'YYYY-MM-DD')# #timeFormat(j.DATA[1][7],'hh:mm:ss tt')#"/>
,[co_duedate]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[co_email]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[co_emailaddress]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[co_ext]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[co_fax]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[co_faxnumber]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[co_fees]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[co_for]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[co_mail]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[co_paid]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[co_personalcontact]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[co_responsenotneeded]=<cfqueryparam value="#j.DATA[1][19]#"/>
,[co_returncall]=<cfqueryparam value="#j.DATA[1][20]#"/>
,[co_takenby]=<cfqueryparam value="#j.DATA[1][21]#"/>
,[co_telephone]=<cfqueryparam value="#j.DATA[1][22]#"/>
,[co_textmessage]=<cfqueryparam value="#j.DATA[1][23]#"/>
,[co_voicemail]=<cfqueryparam value="#j.DATA[1][24]#"/>
WHERE[CO_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery><cfreturn '{"id":#j.DATA[1][1]#,"group":"group2","result":"ok"}'>
</cfif>
</cfcase>
<!---Group2--->
<cfcase value="group2">
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[comments](
[form_id]
,[user_id]
,[client_id]
,[other_id]
,[c_date]
,[c_notes]
)
VALUES(<cfqueryparam value="#j.DATA[1][2]#"/>
,<cfqueryparam value="#j.DATA[1][3]#"/>
,<cfqueryparam value="#j.DATA[1][4]#"/>
,<cfqueryparam value="#j.DATA[1][5]#"/>
,<cfqueryparam value="#j.DATA[1][6]#" null="#LEN(j.DATA[1][6]) eq 0#"/>
,<cfqueryparam value="#j.DATA[1][7]#"/>
)
SELECT SCOPE_IDENTITY()AS[comment_id]
</cfquery>
<cfreturn '{"id":#fquery.comment_id#,"group":"group3","result":"ok"}'>
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

