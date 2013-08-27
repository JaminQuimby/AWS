<!---
SELECT TOP 1000 [c_id]
      ,[client_id]
      ,[c_date]
      ,[c_takenby]
      ,[c_for]
      ,[c_caller]
      ,[c_telephone]
      ,[c_ext]
      ,[c_faxnumber]
      ,[c_emailaddress]
      ,[c_voicemail]
      ,[c_personalcontact]
      ,[c_textmessage]
      ,[c_email]
      ,[c_mail]
      ,[c_fax]
      ,[c_briefmessage]
      ,[c_responsenotneeded]
      ,[c_returncall]
      ,[c_completed]
      ,[c_fees]
      ,[c_paid]
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
SELECT[C_ID]
,[client_id]
,[c_briefmessage]
,[c_caller]
,[c_completed]
,[c_credithold]
,CONVERT(VARCHAR(10),[c_date], 101)AS[c_date]
,CONVERT(VARCHAR(10),[c_duedate], 101)AS[c_duedate]
,[c_email]
,[c_emailaddress]
,[c_ext]
,[c_fax]
,[c_faxnumber]
,[c_fees]
,[c_for]
,[c_mail]
,[c_paid]
,[c_personalcontact]
,[c_responsenotneeded]
,[c_returnedcall]
,[c_spouse]
,[c_starttime]
,[c_takenby]
,[c_telephone]
,[c_textmessage]
,[c_voicemail]
FROM[v_communications]
WHERE[c_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>


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
SELECT[c_id]
,[c_voicemail]
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
<cfset queryResult=queryResult&'{"C_ID":"'&C_ID&'","CLIENT_ID":"'&CLIENT_ID&'","CLIENT_NAME":"'&CLIENT_NAME&'","C_VOICEMAIL":"'&C_VOICEMAIL&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid 2  --->
<cfcase value="group2">
<cfquery datasource="AWS" name="fquery">
SELECT[comment_id],CONVERT(VARCHAR(10),[c_date], 101)AS[c_date],[u_name],[u_email],[c_notes]
FROM[v_comments]
WHERE[form_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>AND[client_id]=<cfqueryparam value="#ARGUMENTS.CLIENTID#"/> AND[other_id]=<cfqueryparam value="#ARGUMENTS.otherid#"/> 

AND[c_notes]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/>
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
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][9])><cfset j.DATA[1][9]=1><cfelse><cfset j.DATA[1][9]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][12])><cfset j.DATA[1][12]=1><cfelse><cfset j.DATA[1][12]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][16])><cfset j.DATA[1][16]=1><cfelse><cfset j.DATA[1][16]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][18])><cfset j.DATA[1][18]=1><cfelse><cfset j.DATA[1][18]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][19])><cfset j.DATA[1][19]=1><cfelse><cfset j.DATA[1][19]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][20])><cfset j.DATA[1][20]=1><cfelse><cfset j.DATA[1][20]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][25])><cfset j.DATA[1][25]=1><cfelse><cfset j.DATA[1][25]=0></cfif>
<cfif ListFindNoCase('YES,TRUE,ON',j.DATA[1][26])><cfset j.DATA[1][26]=1><cfelse><cfset j.DATA[1][26]=0></cfif>
<!--- if this is a new record, then insert it--->
<cfif j.DATA[1][1] eq "0">
<cfquery name="fquery" datasource="AWS">
INSERT INTO[COMMUNICATIONS](
[client_id]
,[c_briefmessage]
,[c_caller]
,[c_completed]
,[c_credithold]
,[c_date]
,[c_duedate]
,[c_email]
,[c_emailaddress]
,[c_ext]
,[c_fax]
,[c_faxnumber]
,[c_fees]
,[c_for]
,[c_mail]
,[c_paid]
,[c_personalcontact]
,[c_responsenotneeded]
,[c_returnedcall]
,[c_spouse]
,[c_starttime]
,[c_takenby]
,[c_telephone]
,[c_textmessage]
,[c_voicemail]
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
)
SELECT SCOPE_IDENTITY()AS[id]
</cfquery>
<!--- RETURN C_ID--->
<cfreturn '{"id":#fquery.id#,"group":"group2","result":"ok"}'>
</cfif>
<!--- if this is a not a new record, then insert it--->
<cfif #j.DATA[1][1]# neq "0">
<cfquery name="fquery" datasource="AWS">
UPDATE[COMMUNICATIONS]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[c_briefmessage]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[c_caller]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[c_completed]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[c_credithold]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[c_date]=<cfqueryparam value="#j.DATA[1][7]#" null="#LEN(j.DATA[1][7]) eq 0#"/>
,[c_duedate]=<cfqueryparam value="#j.DATA[1][8]#" null="#LEN(j.DATA[1][8]) eq 0#"/>
,[c_email]=<cfqueryparam value="#j.DATA[1][9]#"/>
,[c_emailaddress]=<cfqueryparam value="#j.DATA[1][10]#"/>
,[c_ext]=<cfqueryparam value="#j.DATA[1][11]#"/>
,[c_fax]=<cfqueryparam value="#j.DATA[1][12]#"/>
,[c_faxnumber]=<cfqueryparam value="#j.DATA[1][13]#"/>
,[c_fees]=<cfqueryparam value="#j.DATA[1][14]#"/>
,[c_for]=<cfqueryparam value="#j.DATA[1][15]#"/>
,[c_mail]=<cfqueryparam value="#j.DATA[1][16]#"/>
,[c_paid]=<cfqueryparam value="#j.DATA[1][17]#"/>
,[c_personalcontact]=<cfqueryparam value="#j.DATA[1][18]#"/>
,[c_responsenotneeded]=<cfqueryparam value="#j.DATA[1][19]#"/>
,[c_returnedcall]=<cfqueryparam value="#j.DATA[1][20]#"/>
,[c_spouse]=<cfqueryparam value="#j.DATA[1][21]#"/>
,[c_starttime]=<cfqueryparam value="#j.DATA[1][22]#"/>
,[c_takenby]=<cfqueryparam value="#j.DATA[1][23]#"/>
,[c_telephone]=<cfqueryparam value="#j.DATA[1][24]#"/>
,[c_textmessage]=<cfqueryparam value="#j.DATA[1][25]#"/>
,[c_voicemail]=<cfqueryparam value="#j.DATA[1][26]#"/>
WHERE[C_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
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
,<cfqueryparam value="#j.DATA[1][6]#"/>
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
<cfreturn '{"group":""#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>