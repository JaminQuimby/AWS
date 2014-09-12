<cfcomponent output="true">
<!--- LOAD SELECT BOXES --->
<cffunction name="f_loadSelect" access="remote" output="true">
<cfargument name="selectName" type="string">
<cfargument name="formid" type="string" default="">
<cfargument name="option1" type="string" default="">
<cfquery datasource="#Session.organization.name#" name="fquery" >
SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[v_staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]
</cfquery>
<cfset myResult="">
<cfset queryResult='{"optionvalue_id":"0","optionname":"&nbsp;"},'>
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"optionvalue_id":"'&optionvalue_id&'","optionname":"'&optionname&'"}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cffunction>

<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no">
<cfargument name="currentdate" type="date" required="no" default="#now()#">
 



<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cfquery datasource="#Session.organization.name#" name="fquery">
<cfset var dtToday = arguments.currentDate />


SELECT 1 as [column_ID], 'Number of New Clients' as [column1], [column3], [column4], [column5], [column6]
from
(
    SELECT SUM(CASE WHEN datediff(dd, client_since, getdate()) = 0 THEN 1 ELSE 0 END) AS 'column3'  
    ,SUM(CASE WHEN (datediff(year, client_since, getdate()) = 0 AND client_since <= getdate())THEN 1 ELSE 0 END) AS 'column4'  
    ,SUM(CASE WHEN (datediff(year, client_since, DateAdd(year, -1, GetDate())) = 0 AND client_since <= DateAdd(year, -1, GetDate()))THEN 1 ELSE 0 END) AS 'column5'  
    ,SUM(CASE WHEN (datediff(year, client_since, DateAdd(year, -1, GetDate())) = 0)THEN 1 ELSE 0 END) AS 'column6'  
    FROM [v_client_listing]
    WHERE [client_active]=(1)
	AND [deleted] IS NULL
 )clients
 
    


UNION SELECT 2 as [column_ID],'Number of Returns Received' as [column1], [column3], [column4], [column5], [column6]
from
(
    SELECT SUM(CASE WHEN datediff(dd, tr_2_informationreceived, getdate()) = 0 THEN 1 ELSE 0 END) AS 'column3'  
    ,SUM(CASE WHEN (datediff(year, tr_2_informationreceived, getdate()) = 0 AND tr_2_informationreceived <= getdate())THEN 1 ELSE 0 END) AS 'column4'  
    ,SUM(CASE WHEN (datediff(year, tr_2_informationreceived, DateAdd(year, -1, GetDate())) = 0 AND tr_2_informationreceived <= DateAdd(year, -1, GetDate()))THEN 1 ELSE 0 END) AS 'column5'  
    ,SUM(CASE WHEN (datediff(year, tr_2_informationreceived, DateAdd(year, -1, GetDate())) = 0)THEN 1 ELSE 0 END) AS 'column6'  
    FROM [v_taxreturns]
    WHERE [client_active]=(1)
	AND [deleted] IS NULL
 )returnsrec


UNION SELECT 3 as [column_ID],'Number of Returns Delivered' as [column1], [column3], [column4], [column5], [column6]
from
(
    SELECT SUM(CASE WHEN datediff(dd, tr_3_delivered, getdate()) = 0 THEN 1 ELSE 0 END) AS 'column3'  
    ,SUM(CASE WHEN (datediff(year, tr_3_delivered, getdate()) = 0 AND tr_3_delivered <= getdate())THEN 1 ELSE 0 END) AS 'column4'  
    ,SUM(CASE WHEN (datediff(year, tr_3_delivered, DateAdd(year, -1, GetDate())) = 0 AND tr_3_delivered <= DateAdd(year, -1, GetDate()))THEN 1 ELSE 0 END) AS 'column5'  
    ,SUM(CASE WHEN (datediff(year, tr_3_delivered, DateAdd(year, -1, GetDate())) = 0)THEN 1 ELSE 0 END) AS 'column6'  
    FROM [v_taxreturns]
    WHERE [client_active]=(1)
	AND [deleted] IS NULL
 )returnsdev


UNION SELECT 4 as [column_ID],'Number of Returns in Office' as [column1], [column3], [column4], [column5], [column6]
from
(
    SELECT (SUM(CASE WHEN datediff(dd, tr_2_informationreceived, getdate()) = 0 THEN 1 ELSE 0 END) - SUM(CASE WHEN datediff(dd, tr_3_delivered, getdate()) = 0 THEN 1 ELSE 0 END)) AS 'column3'  
    ,(SUM(CASE WHEN (datediff(year, tr_2_informationreceived, getdate()) = 0 AND tr_2_informationreceived <= getdate())THEN 1 ELSE 0 END) - SUM(CASE WHEN (datediff(year, tr_3_delivered, getdate()) = 0 AND tr_3_delivered <= getdate())THEN 1 ELSE 0 END)) AS 'column4'  
    ,(SUM(CASE WHEN (datediff(year, tr_2_informationreceived, DateAdd(year, -1, GetDate())) = 0 AND tr_2_informationreceived <= DateAdd(year, -1, GetDate()))THEN 1 ELSE 0 END) - SUM(CASE WHEN (datediff(year, tr_3_delivered, DateAdd(year, -1, GetDate())) = 0 AND tr_3_delivered <= DateAdd(year, -1, GetDate()))THEN 1 ELSE 0 END)) AS 'column5'  
    ,(SUM(CASE WHEN (datediff(year, tr_2_informationreceived, DateAdd(year, -1, GetDate())) = 0)THEN 1 ELSE 0 END) - SUM(CASE WHEN (datediff(year, tr_3_delivered, DateAdd(year, -1, GetDate())) = 0)THEN 1 ELSE 0 END)) AS 'column6'  
    FROM [v_taxreturns]
    WHERE [client_active]=(1)
	AND [deleted] IS NULL
 )returnsleft


UNION SELECT 3 as [column_ID],'Number of Returns Delivered' as [column1], [column3], [column4], 0 as [column5], 0 as[column6]
from
(
    SELECT SUM(CASE WHEN (datediff(dd, tr_3_delivered, getdate()) = 0 AND [tr_status]NOT IN('2','3')) THEN 1 ELSE 0 END) AS 'column3'  
    ,SUM(CASE WHEN (((datediff(year, tr_3_delivered, getdate()) = 0 AND tr_3_delivered <= getdate())) AND [tr_status]NOT IN('2','3'))THEN 1 ELSE 0 END) AS 'column4'  

    FROM [v_taxreturns]
    WHERE [client_active]=(1)
	AND [deleted] IS NULL
 )returnsincomplete



UNION SELECT 5 as [column_ID],'Number of Returns Delivered Not Completed' as [column1], 0 as [column3], 0 as [column4], 0 as [column5], 0 as [column6]


<!---

UNION SELECT 6 as [column_ID],'Number of Returns to be Entered (Ind.)' as [column1], 'test33' as [column3], 'test34' as [column4], 'test35' as [column5], 'test36' as [column6]


UNION SELECT 7 as [column_ID],'Number of Returns to be Entered (Bus.)' as [column1], 'test39' as [column3], 'test40' as [column4], 'test41' as [column5], 'test42' as [column6]


UNION SELECT 8 as [column_ID],'Number of Returns Missing Information' as [column1], 'test45' as [column3], 'test46' as [column4], 'test47' as [column5], 'test48' as [column6]


UNION SELECT 9 as [column_ID],'Number of Returns to be Reviewed' as [column1], 'test51' as [column3], 'test52' as [column4], 'test53' as [column5], 'test54' as [column6]
UNION SELECT 10 as [column_ID],'Number of Returns to be Assembled' as [column1], 'test57' as [column3], 'test58' as [column4], 'test59' as [column5], 'test60' as [column6]
UNION SELECT 11 as [column_ID],'Total Returns In Office' as [column1],  'test63' as [column3], 'test64' as [column4], 'test65' as [column5], 'test66' as [column6]
UNION SELECT 12 as [column_ID],'Oldest Date of Information Received (Ind.)' as [column1],  'test68' as [column3], 'test69' as [column4], 'test70' as [column5], 'test71' as [column6]
UNION SELECT 13 as [column_ID],'Oldest Date of Information Received (Bus.)' as [column1],  'test75' as [column3], 'test76' as [column4], 'test77' as [column5], 'test78' as [column6]
UNION SELECT 14 as [column_ID],'Number of Days Until April 15th' as [column1], 'test81' as [column3], 'test82' as [column4], 'test83' as [column5], 'test84' as [column6]

--->
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"COLUMN_ID":"'&COLUMN_ID&'"
								,"COLUMN1":"'&COLUMN1&'"
								,"COLUMN3":"'&COLUMN3&'"
								,"COLUMN4":"'&COLUMN4&'"
								,"COLUMN5":"'&COLUMN5&'"
								,"COLUMN6":"'&COLUMN6&'"
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