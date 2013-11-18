<cfcomponent output="true">
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
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_1_informationreceived], 101)AS[tr_1_informationreceived]
,[tr_1_assignedto]
,[tr_priorfees]
,CONVERT(VARCHAR(10),[tr_4_dropoffappointment], 101)AS[tr_4_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_4_pickupappointment], 101)AS[tr_4_pickupappointment]
,[tr_1_missinginfo]
,CONVERT(VARCHAR(10),[tr_1_missinginforeceived], 101)AS[tr_1_missinginforeceived]
,CONVERT(VARCHAR(10),[tr_1_duedate], 101)AS[tr_1_duedate]
,CONVERT(VARCHAR(10),[tr_1_readyforreview], 101)AS[tr_1_readyforreview]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,[tr_2_missingsignatures]
,CONVERT(VARCHAR(10),[tr_2_assemblereturn], 101)AS[tr_2_assemblereturn]
,CONVERT(VARCHAR(10),[tr_2_contacted], 101)AS[tr_2_contacted]
,[tr_1_preparedby]
,CONVERT(VARCHAR(10),[tr_1_reviewedwithnotes], 101)AS[tr_1_reviewedwithnotes]
,CONVERT(VARCHAR(10),[tr_1_completed], 101)AS[tr_1_completed]
,CONVERT(VARCHAR(10),[tr_2_delivered], 101)AS[tr_2_delivered]
,CONVERT(VARCHAR(10),[tr_1_filingdeadline], 101)AS[tr_1_filingdeadline]
,[tr_3_required]
,CONVERT(VARCHAR(10),[tr_3_extended], 101)AS[tr_3_extended]
,CONVERT(VARCHAR(10),[tr_3_rfr], 101)AS[tr_3_rfr]
,CONVERT(VARCHAR(10),[tr_3_completed], 101)AS[tr_3_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,[tr_3_currentfees]
,[tr_currentfees]
,[tr_2_paid]
,[client_type]
,[client_name]
,[client_id]
FROM[v_taxreturns]
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
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CLIENT_TYPE":"'&CLIENT_TYPE&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_1_INFORMATIONRECEIVED":"'&TR_1_INFORMATIONRECEIVED&'"
								,"TR_1_ASSIGNEDTO":"'&TR_1_ASSIGNEDTO&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_4_DROPOFFAPPOINTMENT":"'&TR_4_DROPOFFAPPOINTMENT&'"
								,"TR_4_PICKUPAPPOINTMENT":"'&TR_4_PICKUPAPPOINTMENT&'"
								,"TR_1_MISSINGINFO":"'&TR_1_MISSINGINFO&'"
								,"TR_1_MISSINGINFORECEIVED":"'&TR_1_MISSINGINFORECEIVED&'"
								,"TR_1_DUEDATE":"'&TR_1_DUEDATE&'"
								,"TR_1_READYFORREVIEW":"'&TR_1_READYFORREVIEW&'"
								,"TR_EXTENSIONREQUESTED":"'&TR_EXTENSIONREQUESTED&'"
								,"TR_EXTENSIONDONE":"'&TR_EXTENSIONDONE&'"
								,"TR_2_MISSINGSIGNATURES":"'&TR_2_MISSINGSIGNATURES&'"
								,"TR_2_ASSEMBLERETURN":"'&TR_2_ASSEMBLERETURN&'"
								,"TR_2_CONTACTED":"'&TR_2_CONTACTED&'"
								,"TR_1_PREPAREDBY":"'&TR_1_PREPAREDBY&'"
								,"TR_1_REVIEWEDWITHNOTES":"'&TR_1_REVIEWEDWITHNOTES&'"
								,"TR_1_COMPLETED":"'&TR_1_COMPLETED&'"
								,"TR_2_DELIVERED":"'&TR_2_DELIVERED&'"
								,"TR_1_FILINGDEADLINE":"'&TR_1_FILINGDEADLINE&'"
								,"TR_3_REQUIRED":"'&TR_3_REQUIRED&'"
								,"TR_3_EXTENDED":"'&TR_3_EXTENDED&'"
								,"TR_3_RFR":"'&TR_3_RFR&'"
								,"TR_3_COMPLETED":"'&TR_3_COMPLETED&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_3_CURRENTFEES":"'&TR_3_CURRENTFEES&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_2_PAID":"'&TR_2_PAID&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- Grid 2 Entrance --->
<cfcase value="group2">
<cftry>
<cfquery datasource="AWS" name="fquery">
SELECT[trst_id]
,[tr_id]
,[tr_taxyear]
,[tr_taxform]
,CONVERT(VARCHAR(10),[tr_1_informationreceived], 101)AS[tr_1_informationreceived]
,[tr_1_assignedto]
,[tr_priorfees]
,CONVERT(VARCHAR(10),[tr_4_dropoffappointment], 101)AS[tr_4_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_4_pickupappointment], 101)AS[tr_4_pickupappointment]
,[tr_1_missinginfo]
,CONVERT(VARCHAR(10),[tr_1_missinginforeceived], 101)AS[tr_1_missinginforeceived]
,CONVERT(VARCHAR(10),[tr_1_duedate], 101)AS[tr_1_duedate]
,CONVERT(VARCHAR(10),[tr_1_readyforreview], 101)AS[tr_1_readyforreview]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,[tr_2_missingsignatures]
,CONVERT(VARCHAR(10),[tr_2_assemblereturn], 101)AS[tr_2_assemblereturn]
,CONVERT(VARCHAR(10),[tr_2_contacted], 101)AS[tr_2_contacted]
,[tr_1_preparedby]
,CONVERT(VARCHAR(10),[tr_1_reviewedwithnotes], 101)AS[tr_1_reviewedwithnotes]
,CONVERT(VARCHAR(10),[tr_1_completed], 101)AS[tr_1_completed]
,CONVERT(VARCHAR(10),[tr_2_delivered], 101)AS[tr_2_delivered]
,CONVERT(VARCHAR(10),[tr_1_filingdeadline], 101)AS[tr_1_filingdeadline]
,[tr_3_required]
,CONVERT(VARCHAR(10),[tr_3_extended], 101)AS[tr_3_extended]
,CONVERT(VARCHAR(10),[tr_3_rfr], 101)AS[tr_3_rfr]
,CONVERT(VARCHAR(10),[tr_3_completed], 101)AS[tr_3_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,[tr_3_currentfees]
,[trst_state]
,[trst_primary]
,CONVERT(VARCHAR(10),[trst_completed], 101)AS[trst_completed]
,[tr_currentfees]
,[tr_2_paid]
,[client_type]
,[client_name]
,[client_id]
FROM[v_TAXRETURNS_STATE]
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
<cfset queryResult=queryResult&'{"TRST_ID":"'&TRST_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CLIENT_TYPE":"'&CLIENT_TYPE&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_1_INFORMATIONRECEIVED":"'&TR_1_INFORMATIONRECEIVED&'"
								,"TR_1_ASSIGNEDTO":"'&TR_1_ASSIGNEDTO&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_4_DROPOFFAPPOINTMENT":"'&TR_4_DROPOFFAPPOINTMENT&'"
								,"TR_4_PICKUPAPPOINTMENT":"'&TR_4_PICKUPAPPOINTMENT&'"
								,"TR_1_MISSINGINFO":"'&TR_1_MISSINGINFO&'"
								,"TR_1_MISSINGINFORECEIVED":"'&TR_1_MISSINGINFORECEIVED&'"
								,"TR_1_DUEDATE":"'&TR_1_DUEDATE&'"
								,"TR_1_READYFORREVIEW":"'&TR_1_READYFORREVIEW&'"
								,"TR_EXTENSIONREQUESTED":"'&TR_EXTENSIONREQUESTED&'"
								,"TR_EXTENSIONDONE":"'&TR_EXTENSIONDONE&'"
								,"TR_2_MISSINGSIGNATURES":"'&TR_2_MISSINGSIGNATURES&'"
								,"TR_2_ASSEMBLERETURN":"'&TR_2_ASSEMBLERETURN&'"
								,"TR_2_CONTACTED":"'&TR_2_CONTACTED&'"
								,"TR_1_PREPAREDBY":"'&TR_1_PREPAREDBY&'"
								,"TR_1_REVIEWEDWITHNOTES":"'&TR_1_REVIEWEDWITHNOTES&'"
								,"TR_1_COMPLETED":"'&TR_1_COMPLETED&'"
								,"TR_2_DELIVERED":"'&TR_2_DELIVERED&'"
								,"TR_1_FILINGDEADLINE":"'&TR_1_FILINGDEADLINE&'"
								,"TR_3_REQUIRED":"'&TR_3_REQUIRED&'"
								,"TR_3_EXTENDED":"'&TR_3_EXTENDED&'"
								,"TR_3_RFR":"'&TR_3_RFR&'"
								,"TR_3_COMPLETED":"'&TR_3_COMPLETED&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_3_CURRENTFEES":"'&TR_3_CURRENTFEES&'"
								,"TRST_STATE":"'&TRST_STATE&'"
								,"TRST_PRIMARY":"'&TRST_PRIMARY&'"
								,"TRST_COMPLETED":"'&TRST_COMPLETED&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_2_PAID":"'&TR_2_PAID&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>
</cfswitch>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>