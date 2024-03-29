<!--- Required for AJAX --->
<cfset page.module="_accountingservices">
<cfset page.location="financialstatements">
<cfset page.formid=5>
<cfset page.title="Financial Statements">
<cfset page.menuLeft="General,SubTasks">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5,isLoaded_group1_6,isLoaded_group1_7,isLoaded_group1_8,isLoaded_group1_9,isLoaded_group1_10,isLoaded_group1_11,isLoaded_group2">
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
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_financialstatmentsubtask">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_financialstatmentsubtask'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>
<cfquery dbtype="query" name="global_financialgroup">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_financialgroup'</cfquery>


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
		<div id="g1_searchOptions"></div><div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
		<div class="buttonbox">
			<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group1()'>Add</a></cfif>
		</div>
	</div>
</div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
	<h3>General</h3>
	<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link" ></i> Client</label><select id="client_id" disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_run.load_assets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>    
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
<div><label for="g1_year"><i class="fa fa-lock link" ></i> Year</label><select id="g1_year" disabled="disabled"><option value="0">&nbsp;</option><cfoutput query="global_years"><cfif optionvalue_id neq year(now())><option value="#optionvalue_id#">#optionname#</option><cfelse><option value="#optionvalue_id#" selected="selected">#optionname#</option></cfif></cfoutput></select></div>
<div><label for="g1_month"><i class="fa fa-lock link" ></i> Period</label><select id="g1_month" disabled="disabled"><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_periodend"><i class="fa fa-lock link" ></i> Period End</label><input type="text" id="g1_periodend" disabled="disabled" class="date"/></div>
<div><label for="g1_status">Status</label><select id="g1_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_duedate">Due Date</label><input type="text" id="g1_duedate" class="date" /></div>
<div><label for="g1_priority">Priority</label><input type="text" placeholder="0" id="g1_priority" maxlength="2" class="valid_off" onblur="jqValid({'type':'rationalNumbers','object':this,'message':'This field must be a whole number.'});"  /></div>
<div><label for="g1_esttime">Estimated Time</label><input type="text" id="g1_esttime"  maxlength="6" placeholder="0" /></div>
<div><label for="g1_missinginfo"><input id="g1_missinginfo" type="checkbox" class="ios-switch">Missing Info</label></div>
<div><label for="g1_mireceived">Missing Information Received</label><input type="text"id="g1_mireceived" class="date"/></div>
<div><label for="g1_compilemi"><input id="g1_compilemi" type="checkbox" class="ios-switch">Missing Information - Compiled</label></div>
<div><label for="g1_cmireceived">Missing Information Received - Compiled</label><input type="text" id="g1_cmireceived" class="date"/></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" maxlength="10" placeholder="0"></span></div>
<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus" ><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod" ><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
    
	<h4 onClick='_run.load_group1_1();'>Obtain Information | <span id="g1_g1_head1"></span> | <span id="g1_g1_head2"></span></h4>   
	<div>
		<div><label for="g1_g1_assignedto">Assigned to</label><select id="g1_g1_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g1_datecompleted">Date Completed</label><input type="text" id="g1_g1_datecompleted" class="date"/></div>
		<div><label for="g1_g1_completedby">Completed By</label><select id="g1_g1_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g1_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g1_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_2();'>Sort | <span id="g1_g2_head1"></span> | <span id="g1_g2_head2"></span></h4>
	<div>
		<div><label for="g1_g2_assignedto">Assigned to</label><select id="g1_g2_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g2_datecompleted">Date Completed</label><input type="text" id="g1_g2_datecompleted" class="date"/></div>
		<div><label for="g1_g2_completedby">Completed By</label><select id="g1_g2_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g2_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g2_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_3();'>Checks | <span id="g1_g3_head1"></span> | <span id="g1_g3_head2"></span></h4>
	<div>
		<div><label for="g1_g3_assignedto">Assigned to</label><select id="g1_g3_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g3_datecompleted">Date Completed</label><input type="text" id="g1_g3_datecompleted" class="date"/></div>
		<div><label for="g1_g3_completedby">Completed By</label><select id="g1_g3_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g3_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g3_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_4();'>Sales | <span id="g1_g4_head1"></span> | <span id="g1_g4_head2"></span></h4>
	<div>
		<div><label for="g1_g4_assignedto">Assigned to</label><select id="g1_g4_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g4_datecompleted">Date Completed</label><input type="text" id="g1_g4_datecompleted" class="date"/></div>
		<div><label for="g1_g4_completedby">Completed By</label><select id="g1_g4_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g4_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g4_estimatedtime" /></div>
	</div>
	<h4 onClick='_run.load_group1_5();'>Entry | <span id="g1_g5_head1"></span> | <span id="g1_g5_head2"></span></h4>
	<div>
		<div><label for="g1_g5_assignedto">Assigned to</label><select id="g1_g5_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g5_datecompleted">Date Completed</label><input type="text" id="g1_g5_datecompleted" class="date"/></div>
		<div><label for="g1_g5_completedby">Completed By</label><select id="g1_g5_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g5_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g5_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_6();'>Bank Reconciliation | <span id="g1_g6_head1"></span> | <span id="g1_g6_head2"></span></h4>
	<div>
		<div><label for="g1_g6_assignedto">Assigned to</label><select id="g1_g6_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g6_datecompleted">Date Completed</label><input type="text" id="g1_g6_datecompleted" class="date"/></div>
		<div><label for="g1_g6_completedby">Completed By</label><select id="g1_g6_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g6_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g6_estimatedtime"/></div>
	</div>
	<h4 onClick='_run.load_group1_7();'>Compilations | <span id="g1_g7_head1"></span> | <span id="g1_g7_head2"></span></h4>
	<div>
		<div><label for="g1_g7_assignedto">Assigned to</label><select id="g1_g7_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g7_datecompleted">Date Completed</label><input type="text" id="g1_g7_datecompleted" class="date"/></div>
		<div><label for="g1_g7_completedby">Completed By</label><select id="g1_g7_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g7_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g7_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_8();'>Review | <span id="g1_g8_head1"></span> | <span id="g1_g8_head2"></span></h4>
	<div>
		<div><label for="g1_g8_assignedto">Assigned to</label><select id="g1_g8_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g8_datecompleted">Date Completed</label><input type="text" id="g1_g8_datecompleted" class="date"/></div>
		<div><label for="g1_g8_completedby">Completed By</label><select id="g1_g8_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g8_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g8_estimatedtime" /></div>
	</div>
	<h4 onClick='_run.load_group1_9();'>Assembly | <span id="g1_g9_head1"></span> | <span id="g1_g9_head2"></span></h4>
	<div>
		<div><label for="g1_g9_assignedto">Assigned to</label><select id="g1_g9_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g9_datecompleted">Date Completed</label><input type="text" id="g1_g9_datecompleted" class="date"/></div>
		<div><label for="g1_g9_completedby">Completed By</label><select id="g1_g9_completedby" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g9_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g9_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_10();'>Delivery | <span id="g1_g10_head1"></span> | <span id="g1_g10_head2"></span></h4>
	<div>
		<div><label for="g1_g10_assignedto">Assigned to</label><select id="g1_g10_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g10_datecompleted">Date Completed</label><input type="text" id="g1_g10_datecompleted"  class="date"/></div>
		<div><label for="g1_g10_completedby">Completed By</label><select id="g1_g10_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g10_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g10_estimatedtime"  /></div>
	</div>
	<h4 onClick='_run.load_group1_11();'>Accountant's Report | <span id="g1_g11_head1"></span> | <span id="g1_g11_head2"></span></h4>
	<div>
		<div><label for="g1_g11_assignedto">Assigned to</label><select id="g1_g11_assignedto" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g11_datecompleted">Date Completed</label><input type="text" id="g1_g11_datecompleted" class="date"/></div>
		<div><label for="g1_g11_completedby">Completed By</label><select id="g1_g11_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g1_g11_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g1_g11_estimatedtime"  /></div>
	</div>
</div>

<!--- SubTasks Group --->
<div id="group2" class="gf-checkbox" >
	<h3 onClick="_run.load_group2();">Subtasks</h3>
	<div>
    	<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_run.load_group2();" onKeyPress="if(event.keyCode==13){_run.load_group2();}"/></div>
        <div><label for="g2_group">Group</label><select id="g2_group"><option value="0">&nbsp;</option><cfoutput query="global_financialgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select>
       		 <a href="#" class="button optional" onClick='_run.new_clone1()'>Clone</a>
        </div>
        <div><label for="g2_history">History</label><select id="g2_history"><option value="0">&nbsp;</option><option value="0">&nbsp;</option></select>
       		 <a href="#" class="button optional" onClick='_run.new_clone2()'>Clone</a>
        </div>
		<div id="g2_searchOptions"></div><div class="tblGrid" id="grid2"></div>
		<div class="buttonbox">
		<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group2();'>Add</a></cfif>
		</div>
	</div>
	<h4>Subtask Detail</h4>
    <div>
    	<div><label for="g2_subtask"><i class="fa fa-lock link" ></i> SubTask</label><select id="g2_subtask" disabled="disabled" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="global_financialstatmentsubtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_subtaskcustom"><i class="fa fa-lock link" ></i> Custom Subtask</label><input type="text" disabled="disabled" id="g2_subtaskcustom" /></div>
		<div><label for="g2_sequence"><i class="fa fa-lock link" ></i> Sequence</label><input type="text" disabled="disabled" maxlength="6" id="g2_sequence" /></div>
		<div><label for="g2_status"><i class="fa fa-lock link" ></i> Status</label><select id="g2_status" disabled="disabled"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    	<div><label for="g2_dependencies">Dependencies</label><select id="g2_dependencies" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_financialstatmentsubtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>		
        <div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g2_duedate">Due Date</label><input type="text" id="g2_duedate" class="date"/></div>
		<div><label for="g2_completed">Completed</label><input type="text" id="g2_completed"  class="date" /></div>
		<div><label for="g2_notes">Notes</label><textarea id="g2_notes" cols="4" rows="4"  maxlength="1000" ></textarea></div>
		<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" maxlength="6" placeholder="0" id="g2_estimatedtime"></div>
		<div><label for="g2_actualtime">Actual Time</label><input type="text" maxlength="6" placeholder="0" id="g2_actualtime"></div>
	</div>
</div>

<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
</div>
</div>
<!---Start of footer--->
<cfinclude template="/assets/inc/footer.cfm" />
</body>
</html>