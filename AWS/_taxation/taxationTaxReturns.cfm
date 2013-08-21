<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_taxation">
<cfset page.location="taxationtaxreturns">
<cfset page.formid=6>
<cfset page.title="Tax Returns">
<cfset page.menuLeft="General,States,Schedule,Comment">
<cfset page.trackers="tr_id,trst_id,trsc_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group2,isLoaded_group3,isLoaded_group4,comment_id">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="q_p_prtaxdepositschedule">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='p_prtaxdepositschedule'</cfquery>

<!--- Load Labels --->

global_taxservices
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="../assets/inc/header.cfm">
<body onLoad=" ">
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>

<!--- ENTRANCE --->
<div id="entrance">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3,group4');">Add</a>
</div></div></div>
<!--- FIELD DATA --->

<!--- GROUP1 --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>

<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" ></div>
<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold</label></div>
<div><label for="g1_taxyear">Tax Year</label><input type="text" id="g1_taxyear" ></div>
<div><label for="g1_currentfees">Current Fees</label><input type="text" id="g1_currentfees" ></div>
<div><label for="g1_extensionrequested">Extension Requested</label><input type="text" class="date" id="g1_extensionrequested" ></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" ></div>
<div><label for="g1_taxform">Tax Form</label><select  id="g1_taxform"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_priorfees">Prior Fees</label><input type="text" id="g1_priorfees" ></div>
<div><label for="g1_extensiondone">Extension Done</label><input type="text" class="date" id="g1_extensiondone" ></div>
<div><label for="g1_esttime">Estimated Time</label><input type="text" id="g1_esttime" ></div>
<div><input id="g1_notrequired" type="checkbox"><label for="g1_notrequired">Not Required</label></div>
<div><label for="g1_reason">Reason</label><input type="text" id="g1_reason" ></div>
<div><label for="g1_esttime">PPTR Est Time</label><input type="text" id="g1_esttime" ></div>

</div>
<!--- GROUP1 SUBGROUP1 --->
<h4 onClick='$("#isLoaded_group1_1").val(1)'>Preparation</h4>
<div>
<div><label for="g1_g1_informationreceived">Information Received</label><input type="text" class="date" id="g1_g1_informationreceived" ></div>
<div><label for="g1_g1_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_g1_filingdeadline"></div>
<div><label for="g1_g1_duedate">Due Date</label><input type="text" class="date" id="g1_g1_duedate"></div>
<div><input id="g1_g1_missinginformation" type="checkbox"><label for="g1_g1_missinginformation">Missing Information</label></div>
<div><label for="g1_g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_g1_missinginforeceived" ></div>
<div><label for="g1_g1_assignedto">Assigned To</label><select id="g1_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_preparedby">Prepared By</label><select id="g1_g1_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_readyforreview">Ready for Review</label><input type="text" class="date" id="g1_g1_readyforreview" ></div>
<div><label for="g1_g1_reviewassignedto">Review Assigned To</label><select id="g1_g1_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_reviewed">Reviewed</label><input type="text" class="date" id="g1_g1_reviewed" ></div>
<div><label for="g1_g1_reviewedby">Reviewed By</label><select id="g1_g1_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_reviewedwithnotes">Reviewed With Notes</label><input type="text" class="date" id="g1_g1_reviewedwithnotes" ></div>
<div><label for="g1_g1_completed">Completed</label><input type="text" class="date" id="g1_g1_completed" ></div>
</div>
<!--- GROUP1 SUBGROUP2 --->
<h4 onClick='$("#isLoaded_group1_2").val(1)'>Assembly &amp; Delivery</h4>
<div>
<div><label for="g1_g2_assemblereturn">Assemble Return</label><input type="text" id="g1_g2_assemblereturn" ></div>
<div><label for="g1_g2_contacted">Contacted</label><input type="text" class="date" id="g1_g2_contacted" ></div>
<div><input id="g1_g2_messageleft" type="checkbox"><label for="g1_g2_messageleft">Message Left</label></div>
<div><input id="g1_g2_emailed" type="checkbox"><label for="g1_g2_emailed">Emailed</label></div>
<div><input id="g1_g2_missingsignatures" type="checkbox"><label for="g1_g2_missingsignatures">Missing Signatures</label></div>
<div><label for="g1_g2_delivered">Delivered</label><input type="text" class="date" id="g1_g2_delivered" ></div>
<div><label for="g1_g2_deliverymethod">Delivery Method</label><select id="g1_g2_deliverymethod"><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g2_paymentstatus">Payment Status</label><select id="g1_g2_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input id="g1_g2_multistatereturn" type="checkbox"><label for="g1_g2_multistatereturn">Multistate Return</label></div>
</div>
<!--- GROUP1 SUBGROUP3 --->
<h4 onClick='$("#isLoaded_group1_3").val(1)'>Personal Property Tax</h4>
<div>
<div><input id="g1_g3_required" type="checkbox"><label for="g1_g3_required">PPTR Required</label></div>
<div><label for="g1_g3_assignedto">PPTR Assigned To</label><select id="g1_g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_extended">PPTR Extended</label><input type="text" class="date" id="g1_g3_extended" ></div>
<div><label for="g1_g3_rfr">PPTR RFR</label><input type="text" id="g1_g3_rfr" ></div>
<div><label for="g1_g3_completed">PPTR Completed</label><input type="text" class="date" id="g1_g3_completed" ></div>
<div><label for="g1_g3_delivered">PPTR Delivered</label><input type="text" class="date" id="g1_g3_delivered" ></div>
<div><label for="g1_g3_paymentstatus">Payment Status</label><select id="g1_g3_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_currentfees">PPTR Current Fees</label><input type="text" id="g1_g3_currentfees" ></div>
<div><label for="g1_g3_priorfees">PPTR Prior Fees</label><input type="text" id="g1_g3_priorfees" ></div>
</div>
<!--- GROUP1 SUBGROUP4 --->
<h4 onClick='$("#isLoaded_group1_4").val(1)'>Appointment</h4>
<div>
<div><label for="g1_g4_dropoffappointment">Drop Off Appointment</label><input type="text" class="date" id="g1_g4_dropoffappointment" ></div>
<div><label for="g1_g4_dropoffappointmenttime">Appointment Time</label><input type="text" id="g1_g4_dropoffappointmenttime" class="time"></div>
<div><label for="g1_g4_dropoffappointmentlength">Appointment Length</label><input type="text" id="g1_g4_dropoffappointmentlength" ></div>
<div><label for="g1_g4_dropoffappointmentwith">Appointment With</label><select id="g1_g4_dropoffappointmentwith"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input id="g1_g4_whileyouwaitappt" type="checkbox"><label for="g1_g4_whileyouwaitappt">While You Wait Appt</label></div>
<div><label for="g1_g4_pickupappointment">Pick Up Appointment</label><input type="text" class="date" id="g1_g4_pickupappointment" ></div>
<div><label for="g1_g4_pickupappointmenttime">Appointment Time</label><input type="text" id="g1_g4_pickupappointmenttime" class="time"></div>
<div><label for="g1_g4_pickupappointmentlength">Appointment Length</label><input type="text" id="g1_g4_pickupappointmentlength" ></div>
<div><label for="g1_g4_pickupappointmentwith">Appointment With</label><select id="g1_g4_pickupappointmentwith"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>
</div>

<!--- GROUP2 --->
<div id="group2" class="gf-checkbox">
<h3>States</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
</div>
</div>
<h3 onClick='$("#isLoaded_group2").val(1);'>Add States</h3>
<div>
<div><label for="g2_state">State</label><select id="g2_state" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input id="g2_primary" type="checkbox"><label for="g2_primary">Primary</label></div>
<div><label for="g2_status">Status</label><select id="g2_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_reviewassignedto">Review Assigned To</label><select id="g2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_completed">Completed</label><input type="text" class="date" id="g2_completed" ></div>
</div>
</div>
<!--- Group3 --->
<div id="group3" class="gf-checkbox">
<h3>Schedule</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group3").accordion({active:1});$("#isLoaded_group3").val(1);'>Add</a>
</div>
</div>
<h4 onClick='$("#isLoaded_group3").val(1);'>Add Schedule</h4>
<div>
<div><label for="g3_schedule">Schedule</label><select id="g3_schedule" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="q_p_prtaxdepositschedule"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_status">Status</label><select id="g3_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_assignedto">Assigned To</label><select id="g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_reviewassignedto">Review Assigned To</label><select id="g3_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>
<!--- Group4 --->
<div id="group4" class="gf-checkbox">
<h3>Comments</h3>
<div>
<div><label for="g4_filter">Filter</label><input id="g4_filter" onBlur="_grid4();"/></div>
<div class="tblGrid" id="grid4"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group4").accordion({active:1});$("#isLoaded_group4").val(1);'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g4_commentdate">Date</label><input type="text" class="date" id="g4_commentdate"/></div>
<div><label for="g4_commenttext">Comment</label><textarea type="text" id="g4_commenttext"></textarea></div>
</div>
</div>

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>

