<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_payrolltaxes">
<cfset page.location="payrollpayrolltaxes">
<cfset page.formid=13>
<cfset page.title="Payroll Taxes">
<cfset page.menuLeft="General,Comment">
<cfset page.trackers="pt_id,isLoaded_group1_1,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group1_4,isLoaded_group1_5,isLoaded_group1_6,comment_isLoaded,comment_id">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_returntypes">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_returntypes'</cfquery>



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
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2');">Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_year">Year</label><input type="text" id="g1_year"></div>
<div><label for="g1_month">Month</label><select id="g1_month"></option><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput><option value="0">&nbsp;</option></select></div>
<div><label for="g1_type">Return Type</label><select id="g1_type"></option><option value="0">&nbsp;</option><cfoutput query="global_returntypes"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
<div><label for="g1_lastpay">Last Pay</label><input type="text" class="date" id="g1_lastpay"></div>
<div><label for="g1_priority">Priority</label><input type="text"  id="g1_priority" ></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text"  id="g1_estimatedtime" ></div>
<div><input id="g1_missinginformation" type="checkbox"><label for="g1_missinginformation">Missing Information</label></div>
<div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" ></div>
<div><label for="g1_paymentstatus">Payment Status</label><select id="g1_paymentstatus"></option><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod"></option><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>
<!---Subgroup 1--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_1","page":"payrollpayrolltaxes"});$("#isLoaded_group1_1").val(1);'>Obtain Info</h4>
<div>
<div><label for="g1_g1_assignedto">Assigned To</label><select id="g1_g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_completed">Completed</label><input type="text" class="date" id="g1_g1_completed" ></div>
<div><label for="g1_g1_completedby">Response Completed By</label><select id="g1_g1_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g1_estimatedtime">Estimated Time</label><input type="text"  id="g1_g1_estimatedtime" ></div>
</div>

<!---Subgroup 2--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_2","page":"payrollpayrolltaxes"});$("#isLoaded_group1_2").val(1);'>Entry</h4>
<div>
<div><label for="g1_g2_assignedto">Assigned To</label><select id="g1_g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g2_completed">Completed</label><input type="text" class="date" id="g1_g2_completed" ></div>
<div><label for="g1_g2_completedby">Response Completed By</label><select id="g1_g2_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g2_estimatedtime">Estimated Time</label><input type="text"  id="g1_g2_estimatedtime" ></div>
</div>

<!---Subgroup 3--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_3","page":"payrollpayrolltaxes"});$("#isLoaded_group1_3").val(1);'>Reconciliation</h4>
<div>
<div><label for="g1_g3_assignedto">Assigned To</label><select id="g1_g3_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_completed">Completed</label><input type="text" class="date" id="g1_g3_completed" ></div>
<div><label for="g1_g3_completedby">Response Completed By</label><select id="g1_g3_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g3_estimatedtime">Estimated Time</label><input type="text"  id="g1_g3_estimatedtime" ></div>
</div>

<!---Subgroup 4--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_4","page":"payrollpayrolltaxes"});$("#isLoaded_group1_4").val(1);'>Review</h4>
<div>
<div><label for="g1_g4_assignedto">Assigned To</label><select id="g1_g4_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g4_completed">Completed</label><input type="text" class="date" id="g1_g4_completed" ></div>
<div><label for="g1_g4_completedby">Response Completed By</label><select id="g1_g4_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g4_estimatedtime">Estimated Time</label><input type="text"  id="g1_g4_estimatedtime" ></div>
</div>

<!---Subgroup 5--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_5","page":"payrollpayrolltaxes"});$("#isLoaded_group1_5").val(1);'>Assembly</h4>
<div>
<div><label for="g1_g5_assignedto">Assigned To</label><select id="g1_g5_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g5_completed">Completed</label><input type="text" class="date" id="g1_g5_completed" ></div>
<div><label for="g1_g5_completedby">Response Completed By</label><select id="g1_g5_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g5_estimatedtime">Estimated Time</label><input type="text"  id="g1_g5_estimatedtime" ></div>
</div>

<!---Subgroup 6--->
<h4 onClick='_loadData({"id":"pt_id","group":"group1_6","page":"payrollpayrolltaxes"});$("#isLoaded_group1_6").val(1);'>Delivery</h4>
<div>
<div><label for="g1_g6_assignedto">Assigned To</label><select id="g1_g6_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g6_completed">Completed</label><input type="text" class="date" id="g1_g6_completed" ></div>
<div><label for="g1_g6_completedby">Response Completed By</label><select id="g1_g6_completedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_g6_estimatedtime">Estimated Time</label><input type="text"  id="g1_g6_estimatedtime" ></div>
</div>
</div>


<!--- Comments --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">Comments</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#comment_isLoaded").val(1);'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g2_commentdate">Date</label><input type="text" class="date" id="g2_commentdate"/></div>
<div><label for="g2_commenttext">Comment</label><textarea type="text" id="g2_commenttext"></textarea></div>
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