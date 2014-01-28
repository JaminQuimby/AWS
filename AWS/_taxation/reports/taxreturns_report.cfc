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
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_2_informationreceived]
,[tr_2_assignedto]
,[tr_priorfees]
,CONVERT(VARCHAR(10),[tr_1_dropoffappointment], 101)AS[tr_1_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_1_pickupappointment], 101)AS[tr_1_pickupappointment]
,[tr_missinginfo]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate]
,CONVERT(VARCHAR(10),[tr_2_readyforreview], 101)AS[tr_2_readyforreview]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,[tr_3_missingsignatures]
,CONVERT(VARCHAR(10),[tr_3_assemblereturn], 101)AS[tr_3_assemblereturn]
,CONVERT(VARCHAR(10),[tr_3_contacted], 101)AS[tr_3_contacted]
,[tr_2_preparedby]
,CONVERT(VARCHAR(10),[tr_2_reviewedwithnotes], 101)AS[tr_2_reviewedwithnotes]
,CONVERT(VARCHAR(10),[tr_2_completed], 101)AS[tr_2_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,CONVERT(VARCHAR(10),[tr_filingdeadline], 101)AS[tr_filingdeadline]
,[tr_4_required]
,CONVERT(VARCHAR(10),[tr_4_extended], 101)AS[tr_4_extended]
,CONVERT(VARCHAR(10),[tr_4_rfr], 101)AS[tr_4_rfr]
,CONVERT(VARCHAR(10),[tr_4_completed], 101)AS[tr_4_completed]
,CONVERT(VARCHAR(10),[tr_4_delivered], 101)AS[tr_4_delivered]
,[tr_4_currentfees]
,[tr_currentfees]
,[tr_paid]
,[client_type]
,[client_name]
,[client_id]
FROM[v_taxreturns]

    
<cfset sqllist = "tr_currentfees,tr_esttime,tr_extensiondone,tr_extensionrequested,tr_notrequired,tr_priority,tr_priorfees,tr_taxform,tr_taxyear,tr_duedate,tr_filingdeadline,tr_missinginfo,tr_missinginforeceived,tr_deliverymethod,tr_paid,tr_reason,tr_1_dropoffappointment,tr_1_dropoffappointmentlength,tr_1_dropoffappointmentwith,tr_1_whileyouwaitappt,tr_1_pickupappointment,tr_1_pickupappointmentlength,tr_1_pickupappointmentwith,tr_2_assignedto,tr_2_completed,tr_2_informationreceived,tr_2_preparedby,tr_2_readyforreview,tr_2_reviewassignedto,tr_2_reviewed,tr_2_reviewedby,tr_2_reviewedwithnotes,tr_3_assemblereturn,tr_3_contacted,tr_3_delivered,tr_3_emailed,tr_3_messageleft,tr_3_missingsignatures,tr_3_multistatereturn,tr_4_assignedto,tr_4_completed,tr_4_currentfees,tr_4_delivered,tr_4_extended,tr_4_paid,tr_4_pptresttime,tr_4_priorfees,tr_4_required,tr_4_rfr,tr_4_extensionrequested,tr_4_completedby,tr_4_reviewassigned,tr_4_reviewed,tr_4_reviewedby">
<cfset key="tr_">
<cfif IsJSON(SerializeJSON(#ARGUMENTS.search#))>
<cfset data=#ARGUMENTS.search#>
<cfif ArrayLen(data.b) gt 0>
WHERE(1)=(1)
<cfloop array="#data.b#" index="i">
	<cfif #i.t# eq "NONE">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "AND">AND((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
	<cfif #i.t# eq "OR">OR((1)=(1)
		<cfloop array="#i.g#" index="g">
			<cfloop list="#sqllist#" index="list">
                	<cfif list eq key&g.n><cfif #g.v# neq "null">AND[#list#]='#g.v#'<cfelse>AND[#list#]IS NULL</cfif></cfif>
                    <cfif list&'_less' eq key&g.n>AND[#list#]<='#g.v#'</cfif>
					<cfif list&'_more' eq key&g.n>AND[#list#]>='#g.v#'</cfif>
					<cfif list&'_not' eq key&g.n><cfif #g.v# neq "null">AND[#list#]<>'#g.v#'<cfelse>AND[#list#]IS NOT NULL</cfif></cfif>
			</cfloop>
		</cfloop>)
	</cfif>
</cfloop>
</cfif>
</cfif>

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
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_2_ASSIGNEDTO":"'&TR_2_ASSIGNEDTO&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_1_DROPOFFAPPOINTMENT":"'&TR_1_DROPOFFAPPOINTMENT&'"
								,"TR_1_PICKUPAPPOINTMENT":"'&TR_1_PICKUPAPPOINTMENT&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
								,"TR_EXTENSIONREQUESTED":"'&TR_EXTENSIONREQUESTED&'"
								,"TR_EXTENSIONDONE":"'&TR_EXTENSIONDONE&'"
								,"TR_3_MISSINGSIGNATURES":"'&TR_3_MISSINGSIGNATURES&'"
								,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"
								,"TR_3_CONTACTED":"'&TR_3_CONTACTED&'"
								,"TR_2_PREPAREDBY":"'&TR_2_PREPAREDBY&'"
								,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_FILINGDEADLINE":"'&TR_FILINGDEADLINE&'"
								,"TR_4_REQUIRED":"'&TR_4_REQUIRED&'"
								,"TR_4_EXTENDED":"'&TR_4_EXTENDED&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"
								,"TR_4_CURRENTFEES":"'&TR_4_CURRENTFEES&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_PAID":"'&TR_PAID&'"
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
,CONVERT(VARCHAR(10),[tr_2_informationreceived], 101)AS[tr_2_informationreceived]
,[tr_2_assignedto]
,[tr_priorfees]
,CONVERT(VARCHAR(10),[tr_1_dropoffappointment], 101)AS[tr_1_dropoffappointment]
,CONVERT(VARCHAR(10),[tr_1_pickupappointment], 101)AS[tr_1_pickupappointment]
,[tr_missinginfo]
,CONVERT(VARCHAR(10),[tr_missinginforeceived], 101)AS[tr_missinginforeceived]
,CONVERT(VARCHAR(10),[tr_duedate], 101)AS[tr_duedate]
,CONVERT(VARCHAR(10),[tr_2_readyforreview], 101)AS[tr_2_readyforreview]
,CONVERT(VARCHAR(10),[tr_extensionrequested], 101)AS[tr_extensionrequested]
,CONVERT(VARCHAR(10),[tr_extensiondone], 101)AS[tr_extensiondone]
,[tr_3_missingsignatures]
,CONVERT(VARCHAR(10),[tr_3_assemblereturn], 101)AS[tr_3_assemblereturn]
,CONVERT(VARCHAR(10),[tr_3_contacted], 101)AS[tr_3_contacted]
,[tr_2_preparedby]
,CONVERT(VARCHAR(10),[tr_2_reviewedwithnotes], 101)AS[tr_2_reviewedwithnotes]
,CONVERT(VARCHAR(10),[tr_2_completed], 101)AS[tr_2_completed]
,CONVERT(VARCHAR(10),[tr_3_delivered], 101)AS[tr_3_delivered]
,CONVERT(VARCHAR(10),[tr_filingdeadline], 101)AS[tr_filingdeadline]
,[tr_4_required]
,CONVERT(VARCHAR(10),[tr_4_extended], 101)AS[tr_4_extended]
,CONVERT(VARCHAR(10),[tr_4_rfr], 101)AS[tr_4_rfr]
,CONVERT(VARCHAR(10),[tr_4_completed], 101)AS[tr_4_completed]
,CONVERT(VARCHAR(10),[tr_4_delivered], 101)AS[tr_4_delivered]
,[tr_4_currentfees]
,[trst_state]
,[trst_primary]
,CONVERT(VARCHAR(10),[trst_completed], 101)AS[trst_completed]
,[tr_currentfees]
,[tr_paid]
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
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_2_ASSIGNEDTO":"'&TR_2_ASSIGNEDTO&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_1_DROPOFFAPPOINTMENT":"'&TR_1_DROPOFFAPPOINTMENT&'"
								,"TR_1_PICKUPAPPOINTMENT":"'&TR_1_PICKUPAPPOINTMENT&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
								,"TR_EXTENSIONREQUESTED":"'&TR_EXTENSIONREQUESTED&'"
								,"TR_EXTENSIONDONE":"'&TR_EXTENSIONDONE&'"
								,"TR_3_MISSINGSIGNATURES":"'&TR_3_MISSINGSIGNATURES&'"
								,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"
								,"TR_3_CONTACTED":"'&TR_3_CONTACTED&'"
								,"TR_2_PREPAREDBY":"'&TR_2_PREPAREDBY&'"
								,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_FILINGDEADLINE":"'&TR_FILINGDEADLINE&'"
								,"TR_4_REQUIRED":"'&TR_4_REQUIRED&'"
								,"TR_4_EXTENDED":"'&TR_4_EXTENDED&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"
								,"TR_4_CURRENTFEES":"'&TR_4_CURRENTFEES&'"
								,"TRST_STATE":"'&TRST_STATE&'"
								,"TRST_PRIMARY":"'&TRST_PRIMARY&'"
								,"TRST_COMPLETED":"'&TRST_COMPLETED&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_PAID":"'&TR_PAID&'"
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