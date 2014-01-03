<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfparam name="url.task_id" default="0">
<cfparam name="url.nav" default="1">
<cfset page.module="_taxation">
<cfset page.location="notices">
<cfset page.formid=8>
<cfset page.title="Notices">
<cfset page.menuLeft="General,Notice">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group2,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../assets/inc/header.cfm">
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
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_noticenumber">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_noticenumber'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_noticemethods">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_noticemethods'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu2/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3');">Add</a>
</div></div></div>

<!---Deviations
deliverymethod

Fields that had to moved to different groups
Missing Information
Missing Info Received
Fees
Paid

date noticed received
due date for response
--->

<!--- Group 1--->
<div id="group1" class="gf-checkbox">
<h3>Add Notice Matter</h3>
<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id">Clients*</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'client_id','group':'assetCreditHold','page':'acctingconsulting'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switch">Credit Hold*</label></div>
<div><label for="g1_mattername">Matter Name*</label><input type="text" id="g1_mattername"></div>
<div><label for="g1_matterstatus">Matter Status*</label><select id="g1_matterstatus"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<!-- <div style="margin-top:5px;"><a href="#" class="button optional" onClick="_grid1();_toggle('entrance2');_hide('entrance,group2,group3');">Add Notice</a></div> -->
</div>
</div>

<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">Notice</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
</div>
</div>
<h4 onClick='_loadData({"id":"subtask1_id","group":"group2","page":"notices"});$("#isLoaded_group2").val(1);'>Add Notice</h4>
<div>
<div><label for="g2_matter">Matter Name</label><input type="text" id="g2_matter" class="readonly" readonly></div>
<div><label for="g2_noticestatus">Notice Status</label><select id="g2_noticestatus"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_priority">Priority</label><input type="text" id="g2_priority" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" id="g2_estimatedtime" ></div>
<div><label for="g2_missinginformation"><input id="g2_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g2_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g2_missinginforeceived" ></div>
<div><label for="g2_fees">Fees</label><input type="text" id="g2_fees" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g2_deliverymethod">Delivery Method</label><select id="g2_deliverymethod" ><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_paid">Paid</label><select id="g2_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>
<!--- GROUP 2_1 --->
<h4 onClick='_loadData({"id":"subtask1_id","group":"group2_1","page":"notices"});$("#isLoaded_group2_1").val(1);'>Details</h4>
<div>
<div><label for="g2_1_noticenumber">Notice Number*</label><select id="g2_1_noticenumber"><option value="0">&nbsp;</option><cfoutput query="global_noticenumber"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_noticedate">Notice Date*</label><input type="text" class="date" id="g2_1_noticedate"></div>
<div><label for="g2_1_taxyear">Tax Year*</label><select  id="g2_1_taxyear"><option value="0">&nbsp;</option><cfoutput query="global_years"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_taxform">Tax Form*</label><select id="g2_1_taxform"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_methodreceived">Method Recieved*</label><select id="g2_1_methodreceived"><option value="0">&nbsp;</option><cfoutput query="global_noticemethods"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_datenoticereceived">Date Notice Received</label><input type="text" class="date" id="g2_1_datenoticereceived"></div>
<div><label for="g2_1_duedateforresponse">Due Date For Response</label><input type="text" class="date" id="g2_1_duedateforresponse"></div>

</div>
<!--- GROUP 2_2 --->
<h4 onClick='_loadData({"id":"subtask1_id","group":"group2_2","page":"notices"});$("#isLoaded_group2_2").val(1);'>Correspondence</h4>
<div>
<div><label for="g2_2_responsecompleted">Response Completed</label><input type="text" class="date" id="g2_2_responsecompleted"></div>
<div><label for="g2_2_responsecompletedby">Response Completed By</label><select id="g2_2_responsecompletedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_reviewrequired"><input id="g2_2_reviewrequired" type="checkbox" class="ios-switch">Review Required</label></div>
<div><label for="g2_2_reviewassignedto">Review Assigned To</label><select id="g2_2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_reviewcompleted">Review Completed</label><input type="text" class="date" id="g2_2_reviewcompleted"></div>
<div><label for="g2_2_responsesubmitted">Response Submitted</label><input type="text" class="date" id="g2_2_responsesubmitted"></div>
<div><label for="g2_2_irsstateresponserecieved">IRS/State Response Recieved</label><input type="text" class="date" id="g2_2_irsstateresponserecieved"></div>
</div>
</div>

<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>