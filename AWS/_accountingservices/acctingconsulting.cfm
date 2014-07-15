<!--- Required for AJAX --->
<cfset page.module="_accountingservices">
<cfset page.location="acctingconsulting">
<cfset page.formid=2>
<cfset page.title="Accounting and Consulting Tasks">
<cfset page.menuLeft="General,SubTasks">
<cfset page.trackers="task_id,subtask1_id,subtask_isLoaded">
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
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_consultingcategory">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_consultingcategory'</cfquery>
<cfquery dbtype="query" name="global_acctsubtasks">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_acctsubtasks'</cfquery>
<cfquery dbtype="query" name="global_acctgroup">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_acctgroup'</cfquery>

<body>
<!--- Load Left Menus and trackers --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu"><cfinclude template="/assets/module/menu2/menu.cfm"></nav>


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group1()'>Add</a></cfif>
</div></div></div>
<!--- FIELD DATA --->

<!--- General --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link"></i> Client</label><select id="client_id" disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
<div><label for="g1_consultingcategory"><i class="fa fa-lock link"></i> Consulting Category</label><select id="g1_consultingcategory" disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'g1_consultingcategory','group':'assetCategory','page':'acctingconsulting'});"><option value="0">&nbsp;</option><cfoutput query="global_consultingcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taskdescription"><i class="fa fa-lock link"></i> Task Description</label><textarea  id="g1_taskdescription" disabled="disabled" cols="4" rows="4"  maxlength="1000" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});" ></textarea></div>
<div><label for="g1_assignedto">Assigned To</label><select  id="g1_assignedto" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_status">Status</label><select id="g1_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0" >&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate" ></div>
<div><label for="g1_priority">Priority</label><input type="text" maxlength="2" id="g1_priority" placeholder="0" class="valid_off" onblur="jqValid({'type':'rationalNumbers','object':this,'message':'This field must be a whole number.'});"></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_estimatedtime"></div>
<div><label for="g1_requestforservices">Request for Services</label><input class="date" type="text" id="g1_requestforservices" ></div>
<div><label for="g1_workinitiated">Work Initiated</label><input type="text" class="date" id="g1_workinitiated" ></div>
<div><label for="g1_projectcompleted">Project Completed</label><input type="text" class="date" id="g1_projectcompleted" ></div>
<div><label for="g1_informationreceived">Information Received</label><input type="text" class="date" id="g1_informationreceived" ></div>
<div><label for="g1_missinginfo"><input id="g1_missinginfo" type="checkbox" class="ios-switch">Missing Info</label></div>
<div><label for="g1_missinginforeceived">Missing Information Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" maxlength="10" placeholder="0" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});" ></div>
<div><label for="g1_paid">Payment Status</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>
<!--- Subtask --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2()">Subtasks</h3>
<div>
    	<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
        <div><label for="g2_acctgroup">Group</label><select id="g2_acctgroup"><option value="0">&nbsp;</option><cfoutput query="global_acctgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select>
        <a href="#" class="button optional" onClick='jqMessage({message: "Warning: Would you like to import the selected group?.", "type":"warning", autoClose: false,buttons:[{"name":"Save","on_click":"_saveDataCB({\"group\":\"group2_duplicate\"});_grid2();","class":"optional"},{"name":"Exit","on_click":"","class":"optional"}]})'>Duplicate</a>
        </div>
<div id="g2_searchOptions"></div><div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group2();'>Add</a></cfif>
</div>
</div>
<h4 onClick='_run.load_group2();'>Subtask Detail</h4>
<div>
<div><label for="g2_subtask"><i class="fa fa-lock link" ></i> Subtask</label><select  id="g2_subtask"><option value="0">&nbsp;</option><cfoutput query="global_acctsubtasks"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_subtaskcustom"><i class="fa fa-lock link" ></i> Custom Subtask</label><input type="text" id="g2_subtaskcustom" /></div>
<div><label for="g2_sequence"><i class="fa fa-lock link" ></i> Sequence</label><input maxlength="3" type="text" id="g2_sequence" ></div>
<div><label for="g2_status"><i class="fa fa-lock link" ></i> Status</label><select  id="g2_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_duedate">Due Date</label><input type="text" id="g2_duedate" class="date" ></div>
<div><label for="g2_completed">Completed</label><input type="text" id="g2_completed" class="date" ></div>
<div><label for="g2_dependancy">Dependencies</label><select  id="g2_dependancy" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_acctsubtasks"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g2_estimatedtime" ></div>
<div><label for="g2_actualtime">Actual Time</label><input type="text" maxlength="6" id="g2_actualtime"></div>
<div><label for="g2_note">Notes</label><textarea  id="g2_note" cols="4" rows="4"  maxlength="1000" ></textarea></div>
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