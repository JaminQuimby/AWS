<!--- Required for AJAX --->
<cfset page.module="_taxation">
<cfset page.location="financialtaxplanning">
<cfset page.formid=9>
<cfset page.title="Finanical &amp; Tax Planning">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id">
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
<cfquery dbtype="query" name="global_financialcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_financialcategory'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu"><cfinclude template="/assets/module/menu2/menu.cfm"></nav>
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
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link" onClick="_schk('client_id')"></i> Client</label><select id="client_id" disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_run.load_assets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
<div><label for="g1_category">Category</label><select id="g1_category"><option value="0">&nbsp;</option><cfoutput query="global_financialcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate" ></div>
<div><label for="g1_priority">Priority</label><input type="text" maxlength="2" id="g1_priority" placeholder="0" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" maxlength="6"placeholder="0" id="g1_estimatedtime" ></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_requestforservices">Request For Services</label><input type="text" class="date" id="g1_requestforservices" ></div>
<div><label for="g1_informationrequested">Information Requested</label><input type="text" class="date" id="g1_informationrequested" ></div>
<div><label for="g1_informationreceived">Information Received</label><input type="text" class="date" id="g1_informationreceived" ></div>
<div><label for="g1_informationcompiled">Information Compiled</label><input type="text" class="date" id="g1_informationcompiled" ></div>
<div><label for="g1_reportcompleted">Report Completed</label><input type="text" class="date" id="g1_reportcompleted" ></div>
<div><label for="g1_finalclientmeeting">Final Client Meeting</label><input type="text" class="date" id="g1_finalclientmeeting" ></div>
<div><label for="g1_missinginformation"><input id="g1_missinginformation" type="checkbox" class="ios-switch">Missing Information</label></div>
<div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" maxlength="10" placeholder="0" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
<div><label for="g1_paid">Payment Status</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
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