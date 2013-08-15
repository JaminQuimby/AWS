<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_taxation">
<cfset page.location="taxationtaxreturns">
<cfset page.title="Tax Returns">
<cfset page.menuLeft="General,SubTasks,Comment">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
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

<div id="group1"  class="gf-checkbox">

<h3>Tax Returns</h3>
<div>
<div><label for="g1_client">Clients</label><input type="text" id="g1_client" readonly class="readonly"></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" readonly class="readonly"></div>
<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold</label></div>

<div><label for="g1_taxyear">Tax Year</label><input type="text" id="g1_taxyear" readonly class="readonly"></div>

<div><label for="g1_currentfees">Current Fees</label><input type="text" id="g1_currentfees" readonly class="readonly"></div>
<div><label for="g1_extensionrequested">Extension Requested</label><input type="text" id="g1_Extension Requested" readonly class="readonly"></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" readonly class="readonly"></div>
<div><label for="g1_taxform">Tax Form</label><select  id="g1_taxform"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"></select></div>
<div><label for="g1_priorfees">Prior Fees</label><input type="text" id="g1_priorfees" readonly class="readonly"></div>
<div><label for="g1_extensiondone">Extension Done</label><input type="date" id="g1_extensiondone" readonly class="readonly"></div>
<div><label for="g1_esttime">Estimated Time</label><input type="text" id="g1_esttime" readonly class="readonly"></div>
<div><input id="g1_notrequired" type="checkbox"><label for="g1_notrequired">Not Required</label></div>
<div><label for="g1_reason">Reason</label><input type="text" id="g1_reason" readonly class="readonly"></div>
<div><label for="g1_pptresttime">PPTR Est Time</label><input type="text" id="g1_pptresttime" readonly class="readonly"></div>

</div>
</div>

<!--- Subtask --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2">General</h3>
<div>
<h4>PREPARATION</h4>
<div><label for="g2_informationrecieved">Information Recieved</label><input type="date" id="g2_informationreceived" readonly class="readonly"></div>
<div><label for="g2_filingdeadline">Filing Deadline</label><input type="date" id="g2_filingdeadline" readonly class="readonly"></div>
<div><label for="g2_duedate"></label>Due Date<input type="date" id="g2_duedate" readonly class="readonly"></div>
<div><label for="g2_appointment"><b><ul>Appointment</ul></b></label><input type="text" id="g2_appointment" readonly class="readonly"></div>
<div><input id="g2_missinginformation" type="checkbox"><label for="g2_missinginformation">Missing Information</label></div>
<div><label for="g2_missinginforeceived"></label>Missing Info Recieved<input type="text" id="g2_missinginforeceived" readonly class="readonly"></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_preparedby">Prepared By</label><select id="g2_preparedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_readyforreview">Ready for Review</label><input type="date" id="g2_readyforreview" readonly class="readonly"></div>
<div><label for="g2_reviewassignedto">Review Assigned To</label><select id="g2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_reviewed">Reviewed</label><input type="date" id="g2_reviewed" readonly class="readonly"></div>
<div><label for="g2_reviewedby">Reviewed By</label><select id="g2_reviewedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_reviewedwithnotes">Reviewed With Notes</label><input type="date" id="g2_reviewedwithnotes" readonly class="readonly"></div>
<div><label for="g2_completed">Completed</label><input type="date" id="g2_completed" readonly class="readonly"></div>

</div>
<div>
<h4>ASSEMBLY & DELIVERY</h4>
<div><label for="g2_assemblereturn">Assembly Return</label><input type="text" id="g2_assemblereturn" readonly class="readonly"></div>
<div><label for="g2_contacted">Contacted</label><input type="date" id="g2_contacted" readonly class="readonly"></div>
<div><input id="g2_messageleft" type="checkbox"><label for="g2_messageleft">Message Left</label></div>
<div><input id="g2_emailed" type="checkbox"><label for="g2_emailed">Emailed</label></div>
<div><input id="g2_missingSignatures" type="checkbox"><label for="g2_missingsignatures">Missing Signatures</label></div>
<div><label for="g2_delivered">Delivered</label><input type="date" id="g2_delivered" readonly class="readonly"></div>


</div>
</div>

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>