<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_accountingservices">
<cfset page.location="businessformation">
<cfset page.formid=3>
<cfset page.title="Business Formation">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5">
<!--- TO DO
Add Subtasks: 
	Remove Other Subtask 5 and distribute into Subtask, based on corporate type 
     --->
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='#page.title#'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1 ORDER BY[client_name]</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
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
<!--- ENTRANCE --->
<div id="entrance"class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput><div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance');">Add</a>
</div></div></div>
<!--- FIELD DATA --->

<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
	<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_status">Status</label><select id="g1_status" data-placeholder="Select Status."><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto" data-placeholder="Assign To."><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_owners">Owners</label><input type="text" id="g1_owners" /></div>
	<div><label for="g1_activity">Activity</label><input type="text" id="g1_activity" /></div>
	<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});" /></div>
	<div><label for="g1_dateinitiated" >Date Initiated</label><input type="text" id="g1_dateinitiated" class="date"/></div>
	<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime"/></div>
	<div><label for="g1_duedate" >Due Date</label><input type="text" id="g1_duedate" class="date"/></div>
	<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees"/></div>
	<div><label for="g1_paid">Payment Status</label><select id="g1_paid" ><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<!---Subgroup 1--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_1","page":"businessformation"});$("#isLoaded_group1_1").val(1);'>Articles</h4>
<div>
	<div><label for="g1_g1_articlessubmitted" >Articles Submitted</label><input type="text" id="g1_g1_articlessubmitted" class="date"/></div>
	<div><label for="g1_g1_articlesapproved" >Articles Approved</label><input type="text" id="g1_g1_articlesapproved" class="date"/></div>
</div>


<!---Subgroup 2--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_2","page":"businessformation"});$("#isLoaded_group1_2").val(1);'>Trade Names</h4>
<div>
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
	<div><label for="g1_g4_dissolutionrequested" >Dissolution Requested</label><input type="text" id="g1_g4_dissolutionrequested" class="date"/></div>
	<div><label for="g1_g4_dissolutionsubmitted" >Dissolution Submitted</label><input type="text" id="g1_g4_dissolutionsubmitted" class="date"/></div>
	<div><label for="g1_g4_disolutioncompleted" >Disolution Completed</label><input type="text" id="g1_g4_disolutioncompleted" class="date"/></div>
</div>

<!---Subgroup 5--->
<h4 onClick='_loadData({"id":"task_id","group":"group1_5","page":"businessformation"});$("#isLoaded_group1_5").val(1);'>Other</h4>
<div>
	<div><label for="g1_g5_businesstype">Business Type</label><select id="g1_g5_businesstype"><option value="0">&nbsp;</option></select></div>
	<div><label for="g1_g5_businesscreceived" >Received</label><input type="text" id="g1_g5_businesscreceived" class="date"/></div>
	<div><label for="g1_g5_businesssubmitted" >Submitted</label><input type="text" id="g1_g5_businesssubmitted" class="date"/></div>
	<div><label for="g1_g5_otheractivity">Other Activity</label><input type="text" id="g1_g5_otheractivity" class="date"/></div>
	<div><label for="g1_g5_otherstarted" >Other Started</label><input type="text" id="g1_g5_otherstarted" class="date"/></div>
	<div><label for="g1_g5_othercompleted" >Other Completed</label><input type="text" id="g1_g5_othercompleted" class="date"/></div>
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