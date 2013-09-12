<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_taxation">
<cfset page.location="taxationnotices">
<cfset page.formid=8>
<cfset page.title="Notices">
<cfset page.menuLeft="General,Notice,Comment">
<cfset page.trackers="nm_id,n_id,isLoaded_group2,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3,isLoaded_group3,comment_id">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 0, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[form_id]='#page.formid#'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_noticenumber">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_noticenumber'</cfquery>
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
</div></div></div>
<!--- Group 1--->
<div id="group1" class="gf-checkbox">
<h3>Add Notice Matter</h3>
<div>
<div><label for="client_id">Client Name</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_mattername">Matter Name</label><input type="text" id="g1_mattername"></div>
<div><label for="g1_matterstatus">Matter Status</label><select id="g1_matterstatus"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<!-- <div style="margin-top:5px;"><a href="#" class="button optional" onClick="_grid1();_toggle('entrance2');_hide('entrance,group2,group3');">Add Notice</a></div> -->
</div>
</div>

<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">Notice</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
</div>
</div>
<h4>Add Notice</h4>
<div>
<div><label for="g2_matter">Matter</label><select id="g2_matter"><option value="0">&nbsp;</option></select></div>
<div><label for="g2_assignedto">Assigned To</label><select id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_noticestatus">Notice Status</label><select id="g2_noticestatus"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_priority">Priority</label><input type="text" id="g2_priority" ></div>
<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" id="g2_estimatedtime" ></div>
</div>
<!--- GROUP 2_1 --->
<h4 onClick='_loadData({"id":"n_id","group":"group2_1","page":"taxationnotices"});$("#isLoaded_group2_1").val(1);'>Details</h4>
<div>
<div><label for="g2_1_noticenumber">Notice Number</label><select id="g2_1_noticenumber"><option value="0">&nbsp;</option><cfoutput query="global_noticenumber"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_noticedate">Notice Date</label><input type="text" class="date" id="g2_1_noticedate"></div>
<div><label for="g2_1_taxform">Tax Form</label><select id="g2_1_taxform"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_1_taxyear">Tax Year</label><select id="g2_1_taxyear"><option value="0">&nbsp;</option></select></div>
<div><label for="g2_1_methodreceived">Method Recieved</label><select id="g2_1_methodreceived"><option value="0">&nbsp;</option></select></div>
<div><label for="g2_1_fees">Fees</label><input type="text" id="g2_1_fees"></div>
<div><label for="g2_1_paid">Paid</label><select id="g2_1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
<!--- GROUP 2_2 --->
<h4 onClick='_loadData({"id":"n_id","group":"group2_2","page":"taxationnotices"});$("#isLoaded_group2_2").val(1);'>Correspondence</h4>
<div>
<div><label for="g2_2_datenoticereceived">Date Notice Received</label><input type="text" class="date" id="g2_2_datenoticereceived"></div>
<div><label for="g2_2_duedateforresponse">Due Date For Response</label><input type="text" class="date" id="g2_2_duedateforresponse"></div>
<div><label for="g2_2_responsecompleted">Response Completed</label><input type="text" class="date" id="g2_2_responsecompleted"></div>
<div><label for="g2_2_responsecompletedby">Response Completed By</label><select id="g2_responsecompletedby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input id="g2_2_reviewrequired" type="checkbox"><label for="g2_2_reviewrequired">Review Required</label></div>
<div><label for="g2_2_reviewassignedto">Review Assigned To</label><select id="g2_2_reviewassignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_2_reviewcompleted">Review Completed</label><input type="text" class="date" id="g2_2_reviewcompleted"></div>
<div><label for="g2_2_responsesubmitted">Response Submitted</label><input type="text" class="date" id="g2_2_responsesubmitted"></div>
<div><label for="g2_2_irsstateresponserecieved">IRS/State Response Recieved</label><input type="text" class="date" id="g2_2_irsstateresponserecieved"></div>
</div>
<!--- GROUP 2_3 --->
<h4 onClick='_loadData({"id":"n_id","group":"group2_3","page":"taxationnotices"});$("#isLoaded_group2_3").val(1);'>Missing</h4>
<div>
<div><input id="g2_3_missinginformation" type="checkbox"><label for="g2_3_missinginformation">Missing Information</label></div>
<div><label for="g2_3_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g2_3_missinginforeceived" ></div>
</div>
</div>

<!--- Comments --->
<div id="group3" class="gf-checkbox">
<h3 onClick="_grid3();">Comments</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group3").accordion({active:1});$("#isLoaded_group3").val(1);'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g3_commentdate">Date</label><input type="text" class="date" id="g3_commentdate"/></div>
<div><label for="g3_commenttext">Comment</label><textarea type="text" id="g3_commenttext"></textarea></div>
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