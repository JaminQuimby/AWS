<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_accountingservices">
<cfset page.location="financialstatements">
<cfset page.formid=5>
<cfset page.title="Financial Statements">
<cfset page.menuLeft="General,SubTasks">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5,isLoaded_group1_6,isLoaded_group1_7,isLoaded_group1_8,isLoaded_group1_9,isLoaded_group1_10,isLoaded_group1_11,isLoaded_group2">


<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 0, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_financialstatmentsubtask">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_financialstatmentsubtask'</cfquery>
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
<div id="entrance" class="gf-checkbox">
	<cfoutput><h3>#page.title# Search</h3></cfoutput>
	<div>
		<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
		<!--- Entrace Grid --->
		<div class="tblGrid" id="grid1"></div>
		<div class="buttonbox">
			<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3');">Add</a>
		</div>
	</div>
</div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
	<h3>General</h3>
	<div>
  		<div><label for="client_id">Client</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_year">Year</label><input type="text" id="g1_year"/></div>
		<div><label for="g1_month">Month</label><select id="g1_month"><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_periodend">Period End</label><input type="text" id="g1_periodend" class="date"/></div>
		<!--- Required --->	<div><label for="g1_status">Status</label><select id="g1_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<!--- Required --->	<div><label for="g1_duedate">Due Date</label><input type="text" id="g1_duedate" class="date" /></div>
		<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority"  /></div>
		<div><label for="g1_esttime">Est. Time</label><input type="text" id="g1_esttime"  /></div>
		<div><input type="checkbox" id="g1_missinginfo"><label for="g1_missinginfo">Missing Info</label></div>
		<div><label for="g1_mireceived">MI Received</label><input type="text"id="g1_mireceived" class="date"/></div>
		<div><input type="checkbox" id="g1_compilemi"/><label for="g1_compilemi">Compile MI</label></div>
		<div><label for="g1_cmireceived">CMI Received</label><input type="text" id="g1_cmireceived" class="date"/></div>
		<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees"  /></div>
		<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus" ><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod" ><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	</div>
    
	<h4 onClick='_loadData({"id":"task_id","group":"group1_1","page":"financialstatements"});$("#isLoaded_group1_1").val(1);'>Obtain Info</h4>   
	<div>
		<div><label for="g1_g1_assignedto">Assigned to</label><select id="g1_g1_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g1_datecompleted">Date Completed</label><input type="text" id="g1_g1_datecompleted" class="date"/></div>
		<div><label for="g1_g1_completedby">Competed By</label><select id="g1_g1_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g1_estimatedtime">Estimated Time</label><input type="text" id="g1_g1_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_2","page":"financialstatements"});$("#isLoaded_group1_2").val(1);'>Sort</h4>
	<div>
		<div><label for="g1_g2_assignedto">Assigned to</label><select id="g1_g2_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g2_datecompleted">Date Completed</label><input type="text" id="g1_g2_datecompleted" class="date"/></div>
		<div><label for="g1_g2_completedby">Competed By</label><select id="g1_g2_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g2_estimatedtime">Estimated Time</label><input type="text" id="g1_g2_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_3","page":"financialstatements"});$("#isLoaded_group1_3").val(1);'>Checks</h4>
	<div>
		<div><label for="g1_g3_assignedto">Assigned to</label><select id="g1_g3_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g3_datecompleted">Date Completed</label><input type="text" id="g1_g3_datecompleted" class="date"/></div>
		<div><label for="g1_g3_completedby">Competed By</label><select id="g1_g3_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g3_estimatedtime">Estimated Time</label><input type="text" id="g1_g3_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_4","page":"financialstatements"});$("#isLoaded_group1_4").val(1);'>Sales</h4>
	<div>
		<div><label for="g1_g4_assignedto">Assigned to</label><select id="g1_g4_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g4_datecompleted">Date Completed</label><input type="text" id="g1_g4_datecompleted" class="date"/></div>
		<div><label for="g1_g4_completedby">Competed By</label><select id="g1_g4_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g4_estimatedtime">Estimated Time</label><input type="text" id="g1_g4_estimatedtime" /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_5","page":"financialstatements"});$("#isLoaded_group1_5").val(1);'>Entry</h4>
	<div>
		<div><label for="g1_g5_assignedto">Assigned to</label><select id="g1_g5_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g5_datecompleted">Date Completed</label><input type="text" id="g1_g5_datecompleted" class="date"/></div>
		<div><label for="g1_g5_completedby">Competed By</label><select id="g1_g5_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g5_estimatedtime">Estimated Time</label><input type="text" id="g1_g5_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_6","page":"financialstatements"});$("#isLoaded_group1_6").val(1);'>Bank Reconcile</h4>
	<div>
		<div><label for="g1_g6_assignedto">Assigned to</label><select id="g1_g6_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g6_datecompleted">Date Completed</label><input type="text" id="g1_g6_datecompleted" class="date"/></div>
		<div><label for="g1_g6_completedby">Competed By</label><select id="g1_g6_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g6_estimatedtime">Estimated Time</label><input type="text" id="g1_g6_estimatedtime"/></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_7","page":"financialstatements"});$("#isLoaded_group1_7").val(1);'>Compile</h4>
	<div>
		<div><label for="g1_g7_assignedto">Assigned to</label><select id="g1_g7_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g7_datecompleted">Date Completed</label><input type="text" id="g1_g7_datecompleted" class="date"/></div>
		<div><label for="g1_g7_completedby">Competed By</label><select id="g1_g7_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g7_estimatedtime">Estimated Time</label><input type="text" id="g1_g7_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_8","page":"financialstatements"});$("#isLoaded_group1_8").val(1);'>Review</h4>
	<div>
		<div><label for="g1_g8_assignedto">Assigned to</label><select id="g1_g8_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g8_datecompleted">Date Completed</label><input type="text" id="g1_g8_datecompleted" class="date"/></div>
		<div><label for="g1_g8_completedby">Competed By</label><select id="g1_g8_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g8_estimatedtime">Estimated Time</label><input type="text" id="g1_g8_estimatedtime" /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_9","page":"financialstatements"});$("#isLoaded_group1_9").val(1);'>Assembly</h4>
	<div>
		<div><label for="g1_g9_assignedto">Assigned to</label><select id="g1_g9_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g9_datecompleted">Date Completed</label><input type="text" id="g1_g9_datecompleted" class="date"/></div>
		<div><label for="g1_g9_completedby">Competed By</label><select id="g1_g9_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g9_estimatedtime">Estimated Time</label><input type="text" id="g1_g9_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_10","page":"financialstatements"});$("#isLoaded_group1_10").val(1);'>Delivery</h4>
	<div>
		<div><label for="g1_g10_assignedto">Assigned to</label><select id="g1_g10_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g10_datecompleted">Date Completed</label><input type="text" id="g1_g10_datecompleted"  class="date"/></div>
		<div><label for="g1_g10_completedby">Competed By</label><select id="g1_g10_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g10_estimatedtime">Estimated Time</label><input type="text" id="g1_g10_estimatedtime"  /></div>
	</div>
	<h4 onClick='_loadData({"id":"task_id","group":"group1_11","page":"financialstatements"});$("#isLoaded_group1_11").val(1);'>Accountant's Rpt</h4>
	<div>
		<div><label for="g1_g11_assignedto">Assigned to</label><select id="g1_g11_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g11_datecompleted">Date Completed</label><input type="text" id="g1_g11_datecompleted" class="date"/></div>
		<div><label for="g1_g11_completedby">Competed By</label><select id="g1_g11_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g11_estimatedtime">Estimated Time</label><input type="text" id="g1_g11_estimatedtime"  /></div>
	</div>
</div>

<!--- SubTasks Group --->
<div id="group2" class="gf-checkbox" >
	<h3 onClick="_grid2();">Subtasks</h3>
	<div>
		<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
		<div class="tblGrid" id="grid2"></div>
		<div class="buttonbox">
		<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
		</div>
	</div>
	<h4>Add Subtask</h4>
    <div>
    	<div><label for="g2_subtask">SubTask</label><select id="g2_subtask" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_financialstatmentsubtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_sequence">Sequence</label><input type="text" id="g2_sequence"  /></div>
		<div><label for="g2_status">Status</label><select id="g2_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_duedate">Due Date</label><input type="text" id="g2_duedate" class="date"/></div>
		<div><label for="g2_completed">Completed</label><input type="text" id="g2_completed"  class="date" /></div>
		<div><label for="g2_notes">Notes</label><textarea id="g2_notes" ></textarea></div>
	</div>
</div>

<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
</div>
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>