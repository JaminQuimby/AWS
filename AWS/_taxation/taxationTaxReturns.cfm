<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_taxation">
<cfset page.location="taxationtaxreturns">
<cfset page.title="Tax Returns">
<cfset page.menuLeft="General,SubTasks,Comment">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
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

<!---TRACKERS--->
<input type="hidden" id="client_id" value="0"/><!--- Client ID --->

<!--- ENTRANCE --->
<div id="entrance">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="fss_filter">Filter</label><input id="fss_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('client,largeMenu');_hide('entrance,upload,contacts,services,maintenance,state,rclients');">Add</a>
</div></div></div>
<!--- FIELD DATA --->

<div id="group1" class="gf-checkbox">

<h3>General</h3>
<div>
<div><label for="g1_client">Clients</label><input type="text" id="g1_client" ></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" ></div>
<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold</label></div>

<div><label for="g1_taxyear">Tax Year</label><input type="text" id="g1_taxyear" ></div>

<div><label for="g1_currentfees">Current Fees</label><input type="text" id="g1_currentfees" ></div>
<div><label for="g1_extensionrequested">Extension Requested</label><input type="text" id="g1_Extension Requested" ></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" ></div>
<div><label for="g1_taxform">Tax Form</label><select  id="g1_taxform"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"></select></div>
<div><label for="g1_priorfees">Prior Fees</label><input type="text" id="g1_priorfees" ></div>
<div><label for="g1_extensiondone">Extension Done</label><input type="text" class="date" id="g1_extensiondone" ></div>
<div><label for="g1_esttime">Estimated Time</label><input type="text" id="g1_esttime" ></div>
<div><input id="g1_notrequired" type="checkbox"><label for="g1_notrequired">Not Required</label></div>
<div><label for="g1_reason">Reason</label><input type="text" id="g1_reason" ></div>
<div><label for="g1_pptresttime">PPTR Est Time</label><input type="text" id="g1_pptresttime" ></div>
</div>



<div>
<h4>PREPARATION</h4>
<div><label for="g1_informationrecieved">Information Recieved</label><input type="text" class="date" id="g1_informationreceived" ></div>
<div><label for="g1_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_filingdeadline"></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
<div><label for="g1_appointment">Appointment</label><input type="text" id="g1_appointment" ></div>
<div><input id="g1_missinginformation" type="checkbox"><label for="g1_missinginformation">Missing Information</label></div>
<div><label for="g1_missinginforeceived">Missing Info Recieved</label><input type="text" id="g1_missinginforeceived" ></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_preparedby">Prepared By</label><select id="g1_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_readyforreview">Ready for Review</label><input type="text" class="date" id="g1_readyforreview" ></div>
<div><label for="g1_reviewassignedto">Review Assigned To</label><select id="g1_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_reviewed">Reviewed</label><input type="text" class="date" id="g1_reviewed" ></div>
<div><label for="g1_reviewedby">Reviewed By</label><select id="g1_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_reviewedwithnotes">Reviewed With Notes</label><input type="text" class="date" id="g1_reviewedwithnotes" ></div>
<div><label for="g1_completed">Completed</label><input type="text" class="date" id="g1_completed" ></div>

</div>
<div>
<h4>ASSEMBLY & DELIVERY</h4>
<div><label for="g1_assemblereturn">Assemble Return</label><input type="text" id="g1_assemblereturn" ></div>
<div><label for="g1_contacted">Contacted</label><input type="text" class="date" id="g1_contacted" ></div>
<div><input id="g1_messageleft" type="checkbox"><label for="g1_messageleft">Message Left</label></div>
<div><input id="g1_emailed" type="checkbox"><label for="g1_emailed">Emailed</label></div>
<div><input id="g1_missingSignatures" type="checkbox"><label for="g1_missingsignatures">Missing Signatures</label></div>
<div><label for="g1_delivered">Delivered</label><input type="text" class="date" id="g1_delivered" ></div>
<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod"><option value="0">&nbsp;</option></select></div>
<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus"><option value="0">&nbsp;</option></select></div>
<div><input id="g1_multistatereturn" type="checkbox"><label for="g1_multistatereturn">Multistate Return</label></div>
</div>

<h4>PERSONAL PROPERTY TAX</h4>
<div>
<div><input id="g1_pptrrequired" type="checkbox"><label for="g1_pptrrequired">PPTR Required</label></div>
<div><label for="g1_pptrassignedto">PPTR Assigned To</label><select id="g1_pptrassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_pptrextended">PPTR Extended</label><input type="text" class="date" id="g1_pptrextended" ></div>
<div><label for="g1_pptrrfr">PPTR RFR</label><input type="text" id="g1_pptrrfr" ></div>
<div><label for="g1_completed">PPTR Completed</label><input type="text" class="date" id="g1_completed" ></div>
<div><label for="g1_delivered">PPTR Delivered</label><input type="text" class="date" id="g1_delivered" ></div>
<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus"><option value="0">&nbsp;</option></select></div>
<div><label for="g1_currentfees">PPTR Current Fees</label><input type="text" id="g1_currentfees" ></div>
<div><label for="g1_priorfees">PPTR Prior Fees</label><input type="text" id="g1_priorfees" ></div>


</div>
</div>

<!--- States --->
<div id="group2" class="gf-checkbox">
<h3>States</h3>
<div><label for="g2_state">State</label><select id="g2_state"><option value="0">&nbsp;</option></select></div>
<div><input id="g2_primary" type="checkbox"><label for="g2_primary">Primary</label></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_reviewassignedto">Review Assigned To</label><select id="g1_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_completed">Completed</label><input type="text" class="date" id="g1_completed" ></div>
</div>
<!--- Schedule --->
<div id="group3" class="gf-checkbox">
<h3>Schedule</h3>
<div><label for="g3_schedule">Schedule</label><select id="g3_schedule"><option value="0">&nbsp;</option></select></div>
<div><label for="g3_status">Status</label><select id="g3_status"><option value="0">&nbsp;</option></select></div>
<div><label for="g3_assignedto">Assigned To</label><select id="g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_reviewassignedto">Review Assigned To</label><select id="g3_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>








<!--- Comments --->
<div id="group4" class="gf-checkbox">
<h3>Comments</h3>
<div>
<div><label for="g4_filter">Filter</label><input id="g4_filter" onBlur="_grid4();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#comment_isLoaded").val(1);'>Add</a>
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