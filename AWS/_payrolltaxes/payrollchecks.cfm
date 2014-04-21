<!--- Required for AJAX --->
<cfset page.module="_payrolltaxes">
<cfset page.location="payrollchecks">
<cfset page.formid=10>
<cfset page.title="Payroll Checks">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5">
<cfset page.footer="1">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">

<cfinclude template="/assets/inc/header.cfm">
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>

<cfif URL.task_id gt 0>
<cfoutput>
<script>
$(document).ready(function(){
$('##task_id').val('#URL.task_id#');
_toggle("group1");
_hide("entrance");$("##content").removeClass();
$("##content").addClass("contentbig");
_loadData({"id":"task_id","group":"group1","page":"#page.location#"});
})
</script>
</cfoutput>
</cfif>

<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='_run.new_group1()'>Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link" onClick="_schk('client_id')"></i> Clients</label><select id="client_id" disabled="disable" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadAssets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" disabled="disable" type="checkbox" class="ios-switchb" d>Credit Hold</label></div>
<div><label for="g1_year"><i class="fa fa-lock link" onClick="_schk('g1_year')"></i> Year</label><select id="g1_year" disabled="disable"><option value="0">&nbsp;</option><cfoutput query="global_years"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_payenddate"><i class="fa fa-lock link" onClick="_schk('g1_payenddate')"></i> Pay End Date</label><input type="text" class="date" id="g1_payenddate" disabled="disable" ></div>
<div><label for="g1_paydate"><i class="fa fa-lock link" onClick="_schk('g1_paydate')"></i> Pay Date</label><input type="text" class="date" id="g1_paydate" disabled="disable"></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
<div><label for="g1_missinginformation"><input id="g1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
<div><label for="g1_altfrequency"><input id="g1_altfrequency" type="checkbox" class="ios-switch">Alt Frequency</label></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" maxlength="4" placeholder="0" id="g1_estimatedtime" ></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" placeholder="0" maxlength="10" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod"><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
<!---Subgroup 1--->
<h4 onClick='_run.load_group1_1();'>Obtain Info | <span id="g1_g1_head1"></span> | <span id="g1_g1_head2"></span></h4>
<div>
<div><label for="g1_g1_assignedto">Assigned To</label><select id="g1_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_completed">Completed</label><input type="text" class="date" id="g1_g1_completed" ></div>
<div><label for="g1_g1_completedby">Completed By</label><select id="g1_g1_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_estimatedtime">Estimated Time</label><input type="text" placeholder="0" maxlength="4" id="g1_g1_estimatedtime" ></div>
</div>

<!---Subgroup 2--->
<h4 onClick='_run.load_group1_2();'>Preparation | <span id="g1_g2_head1"></span> | <span id="g1_g2_head2"></span></h4>
<div>
<div><label for="g1_g2_assignedto">Assigned To</label><select id="g1_g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g2_completed">Completed</label><input type="text" class="date" id="g1_g2_completed" ></div>
<div><label for="g1_g2_completedby">Completed By</label><select id="g1_g2_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g2_estimatedtime">Estimated Time</label><input type="text" placeholder="0" maxlength="4" id="g1_g2_estimatedtime" ></div>
</div>

<!---Subgroup 3--->
<h4 onClick='_run.load_group1_3();'>Review | <span id="g1_g3_head1"></span> | <span id="g1_g3_head2"></span></h4>
<div>
<div><label for="g1_g3_assignedto">Assigned To</label><select id="g1_g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_completed">Completed</label><input type="text" class="date" id="g1_g3_completed" ></div>
<div><label for="g1_g3_completedby">Completed By</label><select id="g1_g3_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_estimatedtime">Estimated Time</label><input type="text" placeholder="0" maxlength="4" id="g1_g3_estimatedtime" ></div>
</div>

<!---Subgroup 4--->
<h4 onClick='_run.load_group1_4();'>Assembly | <span id="g1_g4_head1"></span> | <span id="g1_g4_head2"></span></h4>
<div>
<div><label for="g1_g4_assignedto">Assigned To</label><select id="g1_g4_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g4_completed">Completed</label><input type="text" class="date" id="g1_g4_completed" ></div>
<div><label for="g1_g4_completedby">Completed By</label><select id="g1_g4_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g4_estimatedtime">Estimated Time</label><input type="text" placeholder="0" maxlength="4" id="g1_g4_estimatedtime" ></div>
</div>

<!---Subgroup 5--->
<h4 onClick='_run.load_group1_5();'>Delivery | <span id="g1_g5_head1"></span> | <span id="g1_g5_head2"></span></h4>
<div>
<div><label for="g1_g5_assignedto">Assigned To</label><select id="g1_g5_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g5_completed">Completed</label><input type="text" class="date" id="g1_g5_completed" ></div>
<div><label for="g1_g5_completedby">Completed By</label><select id="g1_g5_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g5_estimatedtime">Estimated Time</label><input type="text" placeholder="0" maxlength="4" id="g1_g5_estimatedtime" ></div>
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