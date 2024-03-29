<!--- Required for AJAX --->
<cfset page.module="_taxation">
<cfset page.location="taxreturns">
<cfset page.formid=6>
<cfset page.title="Tax Returns">
<cfset page.menuLeft="General,States,Schedule">
<cfset page.trackers="task_id,subtask1_id,subtask2_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5,isLoaded_group2,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3,isLoaded_group3,isLoaded_group3_1">
<cfset page.footer="1">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="/assets/inc/header.cfm">
<cfif URL.task_id gt 0>
<cfoutput>
<script>
$(document).ready(function(){
$('##task_id').val('#URL.task_id#');
_toggle("group1,largeMenu");
_hide("entrance");$("##content").removeClass();
$("##content").addClass("contentbig");
_loadData({"id":"task_id","group":"group1","page":"#page.location#"});
})
</script>
</cfoutput>
<cfelseif URL.client_id gt 0>
<cfoutput>
<script>
$(document).ready(function(){
$('##task_id').val('#URL.task_id#');
$('##client_id').val('#URL.client_id#');
_addNewTask();
_toggle("group1,largeMenu");
_hide("entrance");$("##content").removeClass();
$("##content").addClass("contentbig");
_loadData({"id":"task_id","group":"group1","page":"#page.location#"});
})
</script>
</cfoutput>
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>

<!--- Load Labels --->
<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm">
</nav>
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group1()'>Add</a></cfif>
</div></div></div>
<!--- GROUP1 --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
	<div><label for="client_id"><i class="fa fa-lock link" ></i> Client</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'client_id','group':'assetCreditHold','page':'taxreturns'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
    <div><label for="g1_taxyear"><i class="fa fa-lock link" ></i> Tax Year</label><select  id="g1_taxyear"><option value="0">&nbsp;</option><cfoutput query="global_years"><cfif optionvalue_id neq year(now())><option value="#optionvalue_id#">#optionname#</option><cfelse><option value="#optionvalue_id#" selected="selected">#optionname#</option></cfif></cfoutput></select></div>
	<div><label for="g1_taxform"><i class="fa fa-lock link" ></i> Tax Form</label><select  id="g1_taxform"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_status">Status</label><select id="g1_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
 	<div><label for="g1_g3_multistatereturn"><input id="g1_g3_multistatereturn" type="checkbox" class="ios-switch">Multistate Return</label></div> 
    <div><label for="g1_notrequired"><input id="g1_notrequired" type="checkbox" class="ios-switch">Not Required</label></div>
	<div><label for="g1_reason">Reason</label><input type="text" maxlength="100" id="g1_reason" ></div>
	<div><label for="g1_currentfees">Current Fees</label><input type="text" maxlength="10" id="g1_currentfees" placeholder="0"></div>
	<div><label for="g1_priorfees">Prior Fees</label><input type="text" maxlength="10" id="g1_priorfees" placeholder="0"></div>
	<div><label for="g1_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_filingdeadline"></div>
	<div><label for="g1_extensionrequested">Extension Requested</label><input type="text" class="date" id="g1_extensionrequested" ></div>
	<div><label for="g1_extensiondone">Extension Completed</label><input type="text" class="date" id="g1_extensiondone" ></div>
	<div><label for="g1_priority">Priority</label><input type="text" maxlength="2" id="g1_priority" placeholder="0"   class="valid_off" onblur="jqValid({'type':'rationalNumbers','object':this,'message':'This field must be a whole number.'});"></div>
	<div><label for="g1_esttime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_esttime" ></div>
	<div><label for="g1_g2_informationreceived">Information Received</label><input type="text" class="date" id="g1_g2_informationreceived" ></div>
	<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
	<div><label for="g1_missinginformation"><input id="g1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
    <div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>    
</div>
<!--- GROUP1 SUBGROUP1 --->
<h4 onClick='_run.load_group1_1()'>Appointment</h4>
<div>
	<div><label for="g1_g1_dropoffappointment">Drop Off Appointment</label><input type="text" class="datetime" id="g1_g1_dropoffappointment" ></div>
	<div><label for="g1_g1_dropoffappointmentlength">Appointment Length</label><input type="text" maxlength="4" id="g1_g1_dropoffappointmentlength" ></div>
	<div><label for="g1_g1_dropoffappointmentwith">Appointment With</label><select id="g1_g1_dropoffappointmentwith"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g1_whileyouwaitappt"><input id="g1_g1_whileyouwaitappt" type="checkbox" class="ios-switch">While You Wait Appointment</label></div>
    <div><label for="g1_g1_pickupappointment">Pick Up Appointment</label><input type="text" class="datetime" id="g1_g1_pickupappointment" ></div>
	<div><label for="g1_g1_pickupappointmentlength">Appointment Length</label><input type="text" maxlength="4" id="g1_g1_pickupappointmentlength" ></div>
	<div><label for="g1_g1_pickupappointmentwith">Appointment With</label><select id="g1_g1_pickupappointmentwith"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
<!--- GROUP1 SUBGROUP2 --->
<h4 onClick='_run.load_group1_2()'>Preparation</h4>
<div>
	<div><label for="g1_g2_assignedto">Assigned To</label><select id="g1_g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g2_preparedby">Prepared By</label><select id="g1_g2_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g2_readyforreview">Ready For Review</label><input type="text" class="date" id="g1_g2_readyforreview" ></div>
</div>

<!--- GROUP1 SUBGROUP3 --->
<h4 onClick='_run.load_group1_3()'>Review</h4>
<div>
	<div><label for="g1_g2_reviewassignedto">Assigned To</label><select id="g1_g2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g2_reviewed">Reviewed</label><input type="text" class="date" id="g1_g2_reviewed" ></div>
	<div><label for="g1_g2_reviewedby">Reviewed By</label><select id="g1_g2_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g2_reviewedwithnotes">Reviewed With Notes</label><input type="text" class="date" id="g1_g2_reviewedwithnotes" ></div>
	<div><label for="g1_g2_completed">Completed</label><input type="text" class="date" id="g1_g2_completed" ></div>
</div>

<!--- GROUP1 SUBGROUP4 --->
<h4 onClick='_run.load_group1_4()'>Assembly &amp; Delivery</h4>
<div>
	<div><label for="g1_g3_assemblereturn">Assemble Return</label><input type="text" class="date" id="g1_g3_assemblereturn" ></div>
	<div><label for="g1_g3_contacted">Contacted</label><input type="text" class="date" id="g1_g3_contacted" ></div>
	<div><label for="g1_g3_messageleft"><input id="g1_g3_messageleft" type="checkbox" class="ios-switch">Message Left</label></div>
   	<div><label for="g1_g3_emailed"><input id="g1_g3_emailed" type="checkbox" class="ios-switch">Emailed</label></div>
	<div><label for="g1_g3_missingsignatures"><input id="g1_g3_missingsignatures" type="checkbox" class="ios-switch">Missing Signatures</label></div>
    <div><label for="g1_g3_delivered">Delivered</label><input type="text" class="date" id="g1_g3_delivered" ></div>
    <div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod"><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<!--- GROUP1 SUBGROUP5 --->
<h4 onClick='_run.load_group1_5()'>Personal Property Tax</h4>
<div>
	<div><label for="g1_g4_required"><input id="g1_g4_required" type="checkbox" class="ios-switch">PPTR Required</label></div>
    <div><label for="g1_g4_extended">PPTR Extension Completed</label><input type="text" class="date" id="g1_g4_extended" ></div>
	<div><label for="g1_g4_extensionrequested">PPTR Extension Requested</label><input type="text" class="date" id="g1_g4_extensionrequested" ></div>
	<div><label for="g1_g4_status">PPTR Status</label><select id="g1_g4_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g4_assignedto">PPTR Assigned To</label><select id="g1_g4_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g4_rfr">PPTR Ready For Review</label><input type="text" class="date" id="g1_g4_rfr" ></div>
    <div><label for="g1_g4_completedby">PPTR Completed By</label><select id="g1_g4_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g1_g4_reviewassigned">PPTR Review Assigned To</label><select id="g1_g4_reviewassigned"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g1_g4_reviewed"><input id="g1_g4_reviewed" type="checkbox" class="ios-switch">PPTR Reviewed</label></div>
    <div><label for="g1_g4_reviewedby">PPTR Reviewed By</label><select id="g1_g4_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g1_g4_completed">PPTR Completed</label><input type="text" class="date" id="g1_g4_completed" ></div>
	<div><label for="g1_g4_delivered">PPTR Delivered</label><input type="text" class="date" id="g1_g4_delivered" ></div>
	<div><label for="g1_g4_currentfees">PPTR Current Fees</label><input type="text" maxlength="10" id="g1_g4_currentfees"></div>
	<div><label for="g1_g4_priorfees">PPTR Prior Fees</label><input type="text" maxlength="10" id="g1_g4_priorfees"></div>
	<div><label for="g1_g4_paymentstatus">Payment Status</label><select id="g1_g4_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g4_pptresttime">PPTR Est Time</label><input type="text" maxlength="6" id="g1_g4_pptresttime" ></div>
</div>
</div>
<!--- GROUP2 --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">States</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox"><cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group2()'>Add</a></cfif></div>
</div>
<h3 onClick='_run.load_group2()'>Add States</h3>
<div>
<div><label for="g2_state">State</label><select id="g2_state" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadSelect({'selectName':'global_taxreturnsstateforms','selectObject':'g2_requiredforms','option1':$('#g2_state').val(),'page':'taxreturns'});"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_requiredforms">Required Forms</label><select  id="g2_requiredforms" multiple="multiple"><option value="0">&nbsp;</option></select></div>
<div><label for="g2_primary"><input id="g2_primary" type="checkbox" class="ios-switch">Primary</label></div>
<div><label for="g2_status">Status</label><select id="g2_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_reviewassignedto">Review Assigned To</label><select id="g2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_completed">Completed</label><input type="text" class="date" id="g2_completed" ></div>
</div>
<!--- GROUP2 SUBGROUP1 --->
<h4 onClick='_run.load_group2_1()'>Preparation</h4>
<div>
<div><label for="g2_g1_informationreceived">Information Received</label><input type="text" class="date" id="g2_g1_informationreceived" ></div>
<div><label for="g2_g1_duedate">Due Date</label><input type="text" class="date" id="g2_g1_duedate"></div>
<div><label for="g2_g1_missinginformation"><input id="g2_g1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g2_g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g2_g1_missinginforeceived" ></div>
<div><label for="g2_g1_assignedto">Assigned To</label><select id="g2_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g1_preparedby">Prepared By</label><select id="g2_g1_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g1_readyforreview">Ready For Review</label><input type="text" class="date" id="g2_g1_readyforreview" ></div>
<div><label for="g2_g1_reviewassignedto">Review Assigned To</label><select id="g2_g1_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g1_reviewed">Reviewed</label><input type="text" class="date" id="g2_g1_reviewed" ></div>
<div><label for="g2_g1_reviewedby">Reviewed By</label><select id="g2_g1_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g1_reviewedwithnotes">Reviewed With Notes</label><input type="text" class="date" id="g2_g1_reviewedwithnotes" ></div>
<div><label for="g2_g1_completed">Completed</label><input type="text" class="date" id="g2_g1_completed" ></div>
</div>
<!--- GROUP2 SUBGROUP2 --->
<h4 onClick='_run.load_group2_2()'>Assembly &amp; Delivery</h4>
<div>
<div><label for="g2_g2_assemblereturn">Assemble Return</label><input type="text" class="date" id="g2_g2_assemblereturn" ></div>
<div><label for="g2_g2_contacted">Contacted</label><input type="text" class="date" id="g2_g2_contacted" ></div>
<div><label for="g2_g2_messageleft"><input id="g2_g2_messageleft" type="checkbox" class="ios-switch">Message Left</label></div>
<div><label for="g2_g2_emailed"><input id="g2_g2_emailed" type="checkbox" class="ios-switch">Emailed</label></div>
<div><label for="g2_g2_missingsignatures"><input id="g2_g2_missingsignatures" type="checkbox" class="ios-switch">Missing Signatures</label></div>
<div><label for="g2_g2_delivered">Delivered</label><input type="text" class="date" id="g2_g2_delivered" ></div>
<div><label for="g2_g2_deliverymethod">Delivery Method</label><select id="g2_g2_deliverymethod"><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g2_paymentstatus">Payment Status</label><select id="g2_g2_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g2_currentfees">Current Fees</label><input type="text" maxlength="10" id="g2_g2_currentfees"></div>
<div><label for="g2_g2_priorfees">Prior Fees</label><input type="text" maxlength="10" id="g2_g2_priorfees" ></div>
</div>
<!--- GROUP2 SUBGROUP3 --->
<h4 onClick='_run.load_group2_3()'>Personal Property Tax</h4>
<div>
<div><label for="g2_g3_required"><input id="g2_g3_required" type="checkbox" class="ios-switch">PPTR Required</label></div>
<div><label for="g2_g3_assignedto">PPTR Assigned To</label><select id="g2_g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_extended">PPTR Extended</label><input type="text" class="date" id="g2_g3_extended" ></div>
<div><label for="g2_g3_rfr">PPTR RFR</label><input type="text" class="date" id="g2_g3_rfr" ></div>
<div><label for="g2_g3_completed">PPTR Completed</label><input type="text" class="date" id="g2_g3_completed" ></div>
<div><label for="g2_g3_delivered">PPTR Delivered</label><input type="text" class="date" id="g2_g3_delivered" ></div>
<div><label for="g2_g3_paymentstatus">Payment Status</label><select id="g2_g3_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_currentfees">PPTR Current Fees</label><input type="text" maxlength="10" id="g2_g3_currentfees"></div>
<div><label for="g2_g3_priorfees">PPTR Prior Fees</label><input type="text" maxlength="10" id="g2_g3_priorfees"></div>
</div>
</div>

<!--- Group3 --->
<div id="group3" class="gf-checkbox">
<h3 onClick="_run.load_group3();">Schedule</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();" onKeyPress="if(event.keyCode==13){_grid3();}"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox"><cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group3()'>Add</a></cfif></div>
</div>
<h4 onClick='_run.group3()'>Add Schedule</h4>
<div>
<div><label for="g3_schedule">Schedule</label><select id="g3_schedule" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option></select></div>
<div><label for="g3_status">Status</label><select id="g3_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_assignedto">Assigned To</label><select id="g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_reviewassignedto">Review Assigned To</label><select id="g3_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<h4 onClick='_run.load_group3_1()'>Preparation</h4>
<div>
<div><label for="g3_g1_informationreceived">Information Received</label><input type="text" class="date" id="g3_g1_informationreceived" ></div>
<div><label for="g3_g1_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g3_g1_filingdeadline"></div>
<div><label for="g3_g1_duedate">Due Date</label><input type="text" class="date" id="g3_g1_duedate"></div>
<div><label for="g3_g1_missinginformation"><input id="g3_g1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g3_g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g3_g1_missinginforeceived" ></div>
<div><label for="g3_g1_assignedto">Assigned To</label><select id="g3_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_g1_preparedby">Prepared By</label><select id="g3_g1_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_g1_readyforreview">Ready for Review</label><input type="text" class="date" id="g3_g1_readyforreview" ></div>
<div><label for="g3_g1_reviewassignedto">Review Assigned To</label><select id="g3_g1_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_g1_reviewed">Reviewed</label><input type="text" class="date" id="g3_g1_reviewed" ></div>
<div><label for="g3_g1_reviewedby">Reviewed By</label><select id="g3_g1_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_g1_reviewedwithnotes">Reviewed With Notes</label><input type="text" class="date" id="g3_g1_reviewedwithnotes" ></div>
<div><label for="g3_g1_completed">Completed</label><input type="text" class="date" id="g3_g1_completed" ></div>
</div>
</div>

<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="/assets/inc/footer.cfm" />
</body>
</html>