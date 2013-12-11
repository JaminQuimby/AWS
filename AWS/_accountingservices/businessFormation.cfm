<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfparam name="url.task_id" default="0">
<cfparam name="url.nav" default="1">
<cfset page.module="_accountingservices">
<cfset page.location="businessformation">
<cfset page.formid=3>
<cfset page.title="Business Formation">
<cfset page.menuLeft="General,Subtask">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5,isLoaded_group2">
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
<cfquery dbtype="query" name="global_businesstype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_businesstype'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu2/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance"class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput><div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<!--- fields that werent in the original
filingdeadline
extensiondeadline
extensionrequested
extensioncompleted
missinginformation
missinginforeceived
articles assignedto
articles drafted
articles approved estimated time

--->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
	<div><label for="client_id">Client*</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold*</label></div>
	<div><label for="g1_owners">Owners*</label><input type="text" id="g1_owners"  /></div>
	<div><label for="g1_activity">Activity*</label><input type="text" id="g1_activity" /></div>	
    <div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto" data-placeholder="Assign To."><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>   
    
    <div><label for="g1_status">Status</label><select id="g1_status" data-placeholder="Select Status."><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_duedate" >Due Date</label><input type="text" id="g1_duedate" class="date"/></div>

	<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});" /></div>
	<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime"/></div>
	<div><label for="g1_filingdeadline" >Filing Deadline</label><input type="text" id="g1_filingdeadline" class="date"/></div>
	<div><label for="g1_dateinitiated" >Date Initiated</label><input type="text" id="g1_dateinitiated" class="date"/></div>

	<div><label for="g1_extensiondeadline" >Extension Deadline</label><input type="text" id="g1_extensiondeadline" class="date"/></div>
	<div><label for="g1_extensionrequested" >Extension Requested</label><input type="text" id="g1_extensionrequested" class="date"/></div>
	<div><label for="g1_extensioncompleted" >Extension Completed</label><input type="text" id="g1_extensioncompleted" class="date"/></div>

	<div><input id="g1_missinginformation" type="checkbox"><label for="g1_missinginformation">Missing Information</label></div>
	<div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
	
	<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" class="valid_off" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});" /></div>
	<div><label for="g1_paid">Payment Status</label><select id="g1_paid" ><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<!---Subgroup 1--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_1","page":"businessformation"});$("#isLoaded_group1_1").val(1);'>Articles</h4>
<div>
    <div><label for="g1_g1_assignedto">Assigned To</label><select id="g1_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>   
	<div><label for="g1_g1_articlesdrafted" >Articles Drafted</label><input type="text" id="g1_g1_articlessubmitted" class="date"/></div>
	<div><label for="g1_g1_articlessubmitted" >Articles Submitted</label><input type="text" id="g1_g1_articlessubmitted" class="date"/></div>
	<div><label for="g1_g1_articlesapproved" >Articles Approved</label><input type="text" id="g1_g1_articlesapproved" class="date"/></div>
	<div><label for="g1_g1_estimatedtime" >Articles Approved Estimated Time</label><input type="text" id="g1_g1_estimatedtime" class="date"/></div>
</div>

<!---Subgroup 2--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_2","page":"businessformation"});$("#isLoaded_group1_2").val(1);'>Trade Names</h4>
<div>
    <div><label for="g1_g2_assignedto">Assigned To</label><select id="g1_g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>   
	<div><label for="g1_g2_tradenamesubmitted" >Trade Name Submitted</label><input type="text" id="g1_g2_tradenamesubmitted" class="date"/></div>
	<div><label for="g1_g2_tradenamereceived" >Trade Name Received</label><input type="text" id="g1_g2_tradenamereceived" class="date"/></div>
</div>


<!---Subgroup 3--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_3","page":"businessformation"});$("#isLoaded_group1_3").val(1);'>Minutes</h4>
<div>
	<div><label for="g1_g3_minutesbylawsdraft" >Minutes Bylaws Draft</label><input type="text" id="g1_g3_minutesbylawsdraft" class="date"/></div>
	<div><label for="g1_g3_minutesbylawsfinal" >Minutes Bylaws Final</label><input type="text" id="g1_g3_minutesbylawsfinal" class="date"/></div>
	<div><label for="g1_g3_minutescompleted" >Minutes Complete</label><input type="text" id="g1_g3_minutescompleted" class="date"/></div>
</div>

<!---Subgroup 4--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_4","page":"businessformation"});$("#isLoaded_group1_4").val(1);'>Dissolution</h4>
<div>
    <div><label for="g1_g3_assignedto">Assigned To</label><select id="g1_g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>   
	<div><label for="g1_g4_dissolutionrequested" >Dissolution Requested</label><input type="text" id="g1_g4_dissolutionrequested" class="date"/></div>
	<div><label for="g1_g4_dissolutionsubmitted" >Dissolution Submitted</label><input type="text" id="g1_g4_dissolutionsubmitted" class="date"/></div>
	<div><label for="g1_g4_disolutioncompleted" >Disolution Completed</label><input type="text" id="g1_g4_disolutioncompleted" class="date"/></div>
</div>

<!---Subgroup 5--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_5","page":"businessformation"});$("#isLoaded_group1_5").val(1);'>Other</h4>
<div>
	<div><label for="g1_g5_businesstype">Business Type</label><select id="g1_g5_businesstype"><option value="0">&nbsp;</option><cfoutput query="global_businesstype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_g5_businesscreceived" >Received</label><input type="text" id="g1_g5_businesscreceived" class="date"/></div>
	<div><label for="g1_g5_businesssubmitted" >Submitted</label><input type="text" id="g1_g5_businesssubmitted" class="date"/></div>
	<div><label for="g1_g5_otheractivity">Other Activity</label><input type="text" id="g1_g5_otheractivity" class="date"/></div>
	<div><label for="g1_g5_otherstarted" >Other Started</label><input type="text" id="g1_g5_otherstarted" class="date"/></div>
	<div><label for="g1_g5_othercompleted" >Other Completed</label><input type="text" id="g1_g5_othercompleted" class="date"/></div>
</div>
</div>


<!--- SubTasks Group --->
<div id="group2" class="gf-checkbox" >
	<h3 onClick="_grid2();">Subtasks</h3>
	<div>
    	<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
		<div class="tblGrid" id="grid2"></div>
		<div class="buttonbox">
		<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
		</div>
	</div>
	<h4>Add Subtask</h4>
    <div>
    	<div><label for="g2_task">Task Name</label><input type="text" id="g2_task"  /></div>
		<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_dateinitiated">Date Initiated</label><input type="text" id="g2_dateinitiated" class="date"/></div>
		<div><label for="g2_completed">Date Completed</label><input type="text" id="g2_completed"  class="date" /></div>
		<div><label for="g2_esttime">Estimated Time </label><input type="text" id="g2_esttime"  /></div>
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