<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfparam name="url.task_id" default="0">
<cfparam name="url.nav" default="1">
<cfset page.module="_clientmanagement">
<cfset page.location="administrativetasks">
<cfset page.formid=4>
<cfset page.title="Administrative Tasks">
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
<cfquery dbtype="query" name="global_admintaskcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_admintaskcategory'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
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
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,group2');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<!--- Group 1 --->
<!---Deviations
add Work Initiated 
--->
<div id="group1" class="gf-checkbox">
	<h3>General</h3>
	<div>
		<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
		<div><label for="client_id">Clients*</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'client_id','group':'assetCreditHold','page':'acctingconsulting'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
        <div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold*</label></div>
		<div><label for="g1_category">Category*</label><select id="g1_category" data-placeholder="Select a Category."><option value="0">&nbsp;</option><cfoutput query="global_admintaskcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_taskdescription">Task Description*</label><textarea id="g1_taskdescription" maxlength="1000" ></textarea></div>
		<div><label for="g1_instructions">Instructions</label><textarea id="g1_instructions" maxlength="1000" ></textarea></div>
		<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate" /></div>
		<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"/></div>
		<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime" /></div>
		<div><label for="g1_daterequested">Date Requested</label><input type="text" class="date" id="g1_daterequested" /></div>
		<div><label for="g1_completed">Completed</label><input type="text" class="date" id="g1_completed" /></div>
		<div><label for="g1_workinitiated">Work Initiated</label><input type="text" class="date" id="g1_workinitiated" /></div>
        <div><label for="g1_requestedby">Requested By</label><select id="g1_requestedby" data-placeholder="Requested By."><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
        <div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"  multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_status">Status</label><select id="g1_status" data-placeholder="Select Status."><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_datestarted">Date Started</label><input type="text" class="date"id="g1_datestarted" /></div>
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