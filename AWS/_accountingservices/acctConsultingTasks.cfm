<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_accountingservices">
<cfset page.location="acctconsultingtasks">
<cfset page.formid=2>
<cfset page.title="Accounting and Consulting Tasks">
<cfset page.menuLeft="General,SubTasks,Comment">
<cfset page.trackers="mc_id,mcs_id,comment_id,subtask_isLoaded,comment_isLoaded">


<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 0, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Accounting Consulting Tasks'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="q_global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="q_global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="q_global_consultingcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_consultingcategory'</cfquery>
<cfquery dbtype="query" name="q_global_subtask">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_subtasks'</cfquery>

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="../assets/inc/header.cfm">

<body onLoad="">

<!--- Load Left Menus and trackers --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu"><cfinclude template="../assets/module/menu/menu.cfm"></nav>


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="grid1_filter">Filter</label><input id="grid1_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3');">Add</a>
</div></div></div>
<!--- FIELD DATA --->

<!--- General --->
<div id="group1" style="display:none;" class="gf-checkbox">
<h3>General</h3>
<div>
<!---Developer Note:[Table Management Consulting Tasks]--->
<div><label for="g1_client">Clients</label><select id="g1_client"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'g1_client','group':'assetSpouse','page':'acctconsultingtasks'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" readonly class="readonly"></div>
<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold</label></div>
<div><label for="g1_consultingcategory">Consulting Category</label><select id="g1_consultingcategory" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'g1_consultingcategory','group':'assetCategory','page':'acctconsultingtasks'});"><option value="0">&nbsp;</option><cfoutput query="q_global_consultingcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taskdescription">Task Description</label><textarea  id="g1_taskdescription" cols="4" rows="4" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});" ></textarea></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"></div>
<div><label for="g1_assignedto">Assigned To</label><select  id="g1_assignedto"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_status">Status</label><select id="g1_status" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0" >&nbsp;</option><cfoutput query="q_global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_requestforservices">Request for Services</label><input class="date" type="text" id="g1_requestforservices" ></div>
<div><label for="g1_workinitiated">Work Initiated</label><input type="text" class="date" id="g1_workinitiated" ></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate" ></div>
<div><label for="g1_projectcompleted">Project Completed</label><input type="text" class="date" id="g1_projectcompleted" ></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime"></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" ></div>
<div><label for="g1_paid">Payment Status</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="q_global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>
<!--- Subtask --->
<div id="group2" style="display:none;" class="gf-checkbox">
<h3 onClick="_grid2">Subtasks</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#subtask_isLoaded").val(1);'>Add</a>
</div>
</div>
<h4>Add Subtask</h4>
<div>
<div><label for="g2_sequence">Sequence</label><input type="text" id="g2_sequence" ></div>
<div><label for="g2_subtask">Subtask</label><select  id="g2_subtask"><option value="0">&nbsp;</option><cfoutput query="q_global_subtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_status">Status</label><select  id="g2_status"><option value="0">&nbsp;</option><cfoutput query="q_global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_duedate">Due Date</label><input type="text" id="g2_duedate" class="date" ></div>
<div><label for="g2_completed">Completed</label><input type="text" id="g2_completed" class="date" ></div>
<div><label for="g2_dependancy">Subtask</label><select  id="g2_dependancy" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="q_global_subtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" id="g2_estimatedtime" ></div>
<div><label for="g2_actualtime">Actual Time</label><input type="text" id="g2_actualtime"></div>
<div><label for="g2_note">Notes</label><textarea  id="g2_note" cols="4" rows="4"></textarea></div>
</div>
</div>
<!--- Comments --->
<div id="group3" class="gf-checkbox">
<h3>Comments</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group3").accordion({active:1});$("#comment_isLoaded").val(1);'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g3_commentdate">Date</label><input type="text" class="date" id="g3_commentdate"/></div>
<div><label for="g3_commenttext">Comment</label><textarea type="text" id="g3_commenttext"></textarea></div>
</div>
</div>
<!--- END FIELD DATA --->

<!--- END CONTENTS --->
</div>


<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>