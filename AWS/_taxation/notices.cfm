<!--- Required for AJAX --->
<cfset page.module="_taxation">
<cfset page.location="notices">
<cfset page.formid=8>
<cfset page.title="Notices">
<cfset page.menuLeft="Matter Detail,Notice">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group2,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3">
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
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'ORDER BY[optionname]</cfquery>
<cfquery dbtype="query" name="global_noticenumber">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_noticenumber'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_noticemethods">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_noticemethods'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='_run.new_group1()'>Add</a>
</div></div></div>

<!--- Group 1--->
<div id="group1" class="gf-checkbox">
<h3>Add Notice Matter</h3>
<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link" onClick="_schk('client_id')"></i> Client</label><select id="client_id"  disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_run.load_assets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
<div><label for="g1_mattername"><i class="fa fa-lock link" onClick="_schk('g1_mattername')"></i> Matter Name</label><input type="text" id="g1_mattername" disabled="disabled"> </div>
<div><label for="g1_matterstatus"><i onClick="_schk('g1_matterstatus')"></i> Matter Status</label><select id="g1_matterstatus" ><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>

<div id="group2" class="gf-checkbox">
<h3 onClick="_run.load_group2();">Notices</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='_run.new_group2()'>Add</a>
</div>
</div>

<!--- GROUP 2_1 --->
<h4 onClick='_run.load_group2_1();'>Add Notice</h4>
<div>
<div><label for="g2_1_matter">Matter Name</label><input type="text" id="g2_1_matter" class="readonly" readonly></div>
<div><label for="g2_1_noticestatus">Notice Status</label><select id="g2_1_noticestatus"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_assignedto">Assigned To</label><select id="g2_1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_priority">Priority</label><input type="text" placeholder="0" id="g2_1_priority" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g2_1_estimatedtime">Estimated Time</label><input type="text" placeholder="0" id="g2_1_estimatedtime" ></div>
<div><label for="g2_1_missinginformation"><input id="g2_1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g2_1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g2_1_missinginforeceived" ></div>
<div><label for="g2_1_fees">Fees</label><input type="text" id="g2_1_fees" class="valid_off" placeholder="0" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g2_1_deliverymethod">Delivery Method</label><select id="g2_1_deliverymethod" ><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_paid">Payment Status</label><select id="g2_1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<!--- GROUP 2_2 --->
<h4 onClick='_run.load_group2_2();'>Details</h4>
<div class="subtask1_id">
<div><label for="g2_2_noticenumber"><i class="fa fa-lock link" onClick="_schk('g2_2_noticenumber')"></i> Notice Number</label><select disabled="disabled" id="g2_2_noticenumber"><option value="0">&nbsp;</option><cfoutput query="global_noticenumber"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_noticedate"><i class="fa fa-lock link" onClick="_schk('g2_2_noticedate')"></i> Notice Date</label><input type="text" class="date" id="g2_2_noticedate" disabled="disabled"></div>
<div><label for="g2_2_taxyear"><i class="fa fa-lock link" onClick="_schk('g2_2_taxyear')"></i> Tax Year</label><select disabled="disabled" id="g2_2_taxyear"><option value="0">&nbsp;</option><cfoutput query="global_years"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_taxform"><i class="fa fa-lock link" onClick="_schk('g2_2_taxform')"></i> Tax Form</label><select disabled="disabled" id="g2_2_taxform"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_methodreceived"><i class="fa fa-lock link" onClick="_schk('g2_2_methodreceived')"></i> Method Recieved</label><select disabled="disabled" id="g2_2_methodreceived"><option value="0">&nbsp;</option><cfoutput query="global_noticemethods"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_datenoticereceived">Date Notice Received</label><input type="text" class="date" id="g2_2_datenoticereceived"></div>
<div><label for="g2_2_duedateforresponse">Due Date For Response</label><input type="text" class="date" id="g2_2_duedateforresponse"></div>

</div>
<!--- GROUP 2_3 --->
<h4 onClick='_run.load_group2_3();'>Correspondence</h4>
<div>
<div><label for="g2_3_responsecompleted">Response Completed</label><input type="text" class="date" id="g2_3_responsecompleted"></div>
<div><label for="g2_3_responsecompletedby">Completed By</label><select id="g2_3_responsecompletedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_3_reviewrequired"><input id="g2_3_reviewrequired" type="checkbox" class="ios-switch">Review Required</label></div>
<div><label for="g2_3_reviewassignedto">Review Assigned To</label><select id="g2_3_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_3_reviewcompleted">Review Completed</label><input type="text" class="date" id="g2_3_reviewcompleted"></div>
<div><label for="g2_3_responsesubmitted">Response Submitted</label><input type="text" class="date" id="g2_3_responsesubmitted"></div>
<div><label for="g2_3_irsstateresponserecieved">IRS/State Response Recieved</label><input type="text" class="date" id="g2_3_irsstateresponserecieved"></div>
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