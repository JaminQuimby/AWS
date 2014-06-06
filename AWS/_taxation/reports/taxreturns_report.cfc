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
<cfargument name="clientid" type="numeric" required="no">
<cfargument name="formid" type="numeric" required="no">

<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Grid 1 Entrance --->
<cfcase value="group0">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[tr_id]
,[tr_taxyear]
,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'d','#Session.localization.language#') 
,[tr_2_assignedtoTEXT]
,FORMAT(tr_priorfees, 'C', 'en-us')AS[tr_priorfees]
,[tr_2_reviewassignedtoTEXT] 
,[tr_2_reviewed]=FORMAT(tr_2_reviewed,'d','#Session.localization.language#') 
,[tr_deliverymethodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_delivery'AND[tr_deliverymethod]=[optionvalue_id])
,[tr_3_multistatereturn]
,[tr_missinginfo]
,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'d','#Session.localization.language#') 
,[tr_duedate]=FORMAT(tr_duedate,'d','#Session.localization.language#') 
,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'d','#Session.localization.language#') 
,[tr_extensionrequested]=FORMAT(tr_extensionrequested,'d','#Session.localization.language#') 
,[tr_extensiondone]=FORMAT(tr_extensiondone,'d','#Session.localization.language#') 
,[tr_3_missingsignatures]
,[tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'d','#Session.localization.language#') 
,[tr_3_contacted]=FORMAT(tr_3_contacted,'d','#Session.localization.language#') 
,[tr_2_preparedby]
,[tr_2_preparedbyTEXT]
,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'d','#Session.localization.language#') 
,[tr_2_completed]=FORMAT(tr_2_completed,'d','#Session.localization.language#') 
,[tr_3_delivered]=FORMAT(tr_3_delivered,'d','#Session.localization.language#') 
,[tr_filingdeadline]=FORMAT(tr_filingdeadline,'d','#Session.localization.language#') 
,[tr_4_required]
,[tr_4_extended]=FORMAT(tr_4_extended,'d','#Session.localization.language#') 
,[tr_4_rfr]=FORMAT(tr_4_rfr,'d','#Session.localization.language#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'d','#Session.localization.language#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'d','#Session.localization.language#') 
,FORMAT(tr_4_currentfees, 'C', 'en-us')AS[tr_4_currentfees]
,FORMAT(tr_currentfees, 'C', 'en-us')AS[tr_currentfees]
,[tr_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[tr_paid]=[optionvalue_id])
,[client_name]
,[client_id]
,[tr_4_completed]=FORMAT(tr_4_completed,'d','#Session.localization.language#')
,[tr_4_delivered]=FORMAT(tr_4_delivered,'d','#Session.localization.language#')
,[tr_priority]
,[tr_esttime]
FROM[v_taxreturns]
<cfset sqllist = "tr_currentfees,tr_esttime,tr_extensiondone,tr_extensionrequested,tr_notrequired,tr_priority,tr_priorfees,tr_taxform,tr_taxyear,tr_duedate,tr_filingdeadline,tr_missinginfo,tr_missinginforeceived,tr_deliverymethod,tr_paid,tr_reason,tr_1_dropoffappointment,tr_1_dropoffappointmentlength,tr_1_dropoffappointmentwith,tr_1_whileyouwaitappt,tr_1_pickupappointment,tr_1_pickupappointmentlength,tr_1_pickupappointmentwith,tr_2_assignedto,tr_2_completed,tr_2_informationreceived,tr_2_preparedby,tr_2_readyforreview,tr_2_reviewassignedtotext,tr_2_reviewed,tr_2_reviewedby,tr_2_reviewedwithnotes,tr_3_assemblereturn,tr_3_contacted,tr_3_delivered,tr_3_emailed,tr_3_messageleft,tr_3_missingsignatures,tr_3_multistatereturn,tr_4_assignedto,tr_4_completed,tr_4_currentfees,tr_4_delivered,tr_4_extended,tr_4_paid,tr_4_pptresttime,tr_4_priorfees,tr_4_required,tr_4_rfr,tr_4_extensionrequested,tr_4_completedby,tr_4_reviewassigned,tr_4_reviewed,tr_4_reviewedby">
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
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
								,"TR_DUEDATE":"'&TR_DUEDATE&'"
								,"TR_2_ASSIGNEDTOTEXT":"'&TR_2_ASSIGNEDTOTEXT&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
								,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
								,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
								,"TR_2_REVIEWASSIGNEDTOTEXT":"'&TR_2_REVIEWASSIGNEDTOTEXT&'"
								,"TR_2_REVIEWED":"'&TR_2_REVIEWED&'"
								,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
								,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
								,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"
								,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"
								,"TR_DELIVERYMETHODTEXT":"'&TR_DELIVERYMETHODTEXT&'"
								,"TR_PRIORFEES":"'&TR_PRIORFEES&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_PAIDTEXT":"'&TR_PAIDTEXT&'"
								,"TR_EXTENSIONREQUESTED":"'&TR_EXTENSIONREQUESTED&'"
								,"TR_EXTENSIONDONE":"'&TR_EXTENSIONDONE&'"
								,"TR_3_MULTISTATERETURN":"'&TR_3_MULTISTATERETURN&'"
								,"TR_4_REQUIRED":"'&TR_4_REQUIRED&'"		
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"		
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"		
								,"TR_PRIORITY":"'&TR_PRIORITY&'"		
								,"TR_ESTTIME":"'&TR_ESTTIME&'"														
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
<cfquery datasource="#Session.organization.name#" name="fquery">
SELECT[trst_id]
,[tr_id]
,[tr_taxyear]
,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'d','#Session.localization.language#') 
,[tr_2_assignedtoTEXT]
,FORMAT(tr_priorfees, 'C', 'en-us')AS[tr_priorfees]
,[tr_1_dropoffappointment]=FORMAT(tr_1_dropoffappointment,'d','#Session.localization.language#') 
,[tr_1_pickupappointment]=FORMAT(tr_1_pickupappointment,'d','#Session.localization.language#') 
,[tr_missinginfo]
,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'d','#Session.localization.language#') 
,[tr_duedate]=FORMAT(tr_duedate,'d','#Session.localization.language#') 
,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'d','#Session.localization.language#') 
,[tr_extensionrequested]=FORMAT(tr_extensionrequested,'d','#Session.localization.language#') 
,[tr_extensiondone]=FORMAT(tr_extensiondone,'d','#Session.localization.language#') 
,[tr_3_missingsignatures]
,[tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'d','#Session.localization.language#') 
,[tr_3_contacted]=FORMAT(tr_3_contacted,'d','#Session.localization.language#') 
,[tr_2_preparedbyTEXT]
,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'d','#Session.localization.language#') 
,[tr_2_completed]=FORMAT(tr_2_completed,'d','#Session.localization.language#') 
,[tr_3_delivered]=FORMAT(tr_3_delivered,'d','#Session.localization.language#') 
,[tr_filingdeadline]=FORMAT(tr_filingdeadline,'d','#Session.localization.language#') 
,[tr_4_required]
,[tr_4_extended]=FORMAT(tr_4_extended,'d','#Session.localization.language#') 
,[tr_4_rfr]=FORMAT(tr_4_rfr,'d','#Session.localization.language#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'d','#Session.localization.language#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'d','#Session.localization.language#') 
,FORMAT(tr_4_currentfees, 'C', 'en-us')AS[tr_4_currentfees]
,trst_stateTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[trst_state]=[optionvalue_id])
,[trst_primary]
,CONVERT(VARCHAR(8),[trst_completed], 1)AS[trst_completed]
,FORMAT(tr_4_currentfees, 'C', 'en-us')AS[tr_currentfees]
,[tr_paidTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_paid'AND[tr_paid]=[optionvalue_id])
,[client_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[client_type]=[optionvalue_id])
,[client_name]
,[client_id]
FROM[V_TAXRETURNS_STATE]
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
								,"CLIENT_TYPETEXT":"'&CLIENT_TYPETEXT&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
								,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
								,"TR_2_ASSIGNEDTOTEXT":"'&TR_2_ASSIGNEDTOTEXT&'"
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
								,"TR_2_PREPAREDBYTEXT":"'&TR_2_PREPAREDBYTEXT&'"
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
								,"TRST_STATETEXT":"'&TRST_STATETEXT&'"
								,"TRST_PRIMARY":"'&TRST_PRIMARY&'"
								,"TRST_COMPLETED":"'&TRST_COMPLETED&'"
								,"TR_CURRENTFEES":"'&TR_CURRENTFEES&'"
								,"TR_PAIDTEXT":"'&TR_PAIDTEXT&'"
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