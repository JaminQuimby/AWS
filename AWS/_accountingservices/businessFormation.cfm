<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_accountingservices">
<cfset page.location="businessformation">
<cfset page.formid=3>
<cfset page.title="Business Formation">
<cfset page.menuLeft="General,Comment">
<cfset page.trackers="bf_id,comment_id">
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
<cfoutput><h3>#page.title# Search #session.user.id#</h3></cfoutput><div>
<div><label for="g1_filter">Filter</label><input id="g1_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div><label for="g1_clientname">Client Name</label><select id="g1_clientname" data-placeholder="Select a Client."><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_status">Status</label><select id="g1_status" data-placeholder="Select Status."><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto" data-placeholder="Assign To."><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_owners">Owners</label><input type="text" id="g1_owners" /></div>
<div><label for="g1_activity">Activity</label><input type="text" id="g1_activity" /></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});" /></div>

<div><label for="g1_dateinitiated" >Date Initiated</label><input type="text" id="g1_dateinitiated" class="date"/></div>
<div><label for="g1_articlessubmitted" >Articles Submitted</label><input type="text" id="g1_articlessubmitted" class="date"/></div>
<div><label for="g1_articlesapproved" >Articles Approved</label><input type="text" id="g1_articlesapproved" class="date"/></div>
<div><label for="g1_tradenamesubmitted" >Trade Name Submitted</label><input type="text" id="g1_tradenamesubmitted" class="date"/></div>
<div><label for="g1_tradenamereceived" >Trade Name Received</label><input type="text" id="g1_tradenamereceived" class="date"/></div>
<div><label for="g1_minutesbylawsdraft" >Minutes Bylaws Draft</label><input type="text" id="g1_minutesbylawsdraft" class="date"/></div>
<div><label for="g1_minutesbylawsfinal" >Minutes Bylaws Final</label><input type="text" id="g1_minutesbylawsfinal" class="date"/></div>
<div><label for="g1_tinss4submitted" >TIN SS-4 Submitted</label><input type="text" id="g1_tinss4submitted" class="date"/></div>
<div><label for="g1_tinreceived" >TIN Received</label><input type="text" id="g1_tinreceived" class="date"/></div>

<div><label for="g1_poa2848signed" >POA 2848 Signed</label><input type="text" id="g1_poa2848signed" class="date"/></div>
<div><label for="g1_statecrasubmitted" >State CRA Submitted</label><input type="text" id="g1_statecrasubmitted" class="date"/></div>
<div><label for="g1_statecrareceived" >State CRA Received</label><input type="text" id="g1_statecrareceived" class="date"/></div>
<div><label for="g1_scorp2553submitted" >S-Corp 2553 Submitted</label><input type="text" id="g1_scorp2553submitted" class="date"/></div>
<div><label for="g1_scorp2553received" >S-Corp 2553 Received</label><input type="text" id="g1_scorp2553received" class="date"/></div>
<div><label for="g1_corp8832submitted" >Corp 8832 Submitted</label><input type="text" id="g1_corp8832submitted" class="date"/></div>
<div><label for="g1_corp8832received" >Corp 8832 Received</label><input type="text" id="g1_corp8832received" class="date"/></div>
<div><label for="g1_501c3submitted" >501(c)3 Submitted</label><input type="text" id="g1_501c3submitted" class="date"/></div>
<div><label for="g1_501creceived" >501(c)3 Received</label><input type="text" id="g1_501creceived" class="date"/></div>
<div><label for="g1_minutescompleted" >Minutes Complete</label><input type="text" id="g1_minutescompleted" class="date"/></div>

<div><label for="g1_dissolutionrequested" >Dissolution Requested</label><input type="text" id="g1_dissolutionrequested" class="date"/></div>
<div><label for="g1_dissolutionsubmitted" >Dissolution Submitted</label><input type="text" id="g1_dissolutionsubmitted" class="date"/></div>
<div><label for="g1_disolutioncompleted" >Disolution Completed</label><input type="text" id="g1_disolutioncompleted" class="date"/></div>
<div><label for="g1_otheractivity">Other Activity</label><input type="text" id="g1_otheractivity" class="date"/></div>
<div><label for="g1_otherstarted" >Other Started</label><input type="text" id="g1_otherstarted" class="date"/></div>
<div><label for="g1_othercompleted" >Other Completed</label><input type="text" id="g1_othercompleted" class="date"/></div>
<div><label for="g1_recoardbookordered" >Recoard Book Ordered</label><input type="text" id="g1_recoardbookordered" class="date"/></div>

<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime" class="date"/></div>
<div><label for="g1_duedate" >Due Date</label><input type="text" id="g1_duedate" class="date"/></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees"/></div>
<div><label for="g1_paid">Paid</label><select id="g1_paid" data-placeholder="Paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>
</div>

<div id="group2" class="gf-checkbox">
<h3>Comments</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1})'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g2_commentdate">Date</label><input type="text" class="date" id="g2_commentdate"/></div>
<div><label for="g2_commenttext">Comment</label><textarea type="text" id="g2_commenttext"></textarea></div>
</div>
</div>
<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>