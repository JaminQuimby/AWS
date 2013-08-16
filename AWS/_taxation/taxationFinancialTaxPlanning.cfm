<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_taxation">
<cfset page.location="taxationfinancialtaxplanning">
<cfset page.title="Finanical Tax Planning">
<cfset page.menuLeft="General,SubTasks,Comment">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="q_global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="q_global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
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

<!---TRACKERS--->
<input type="hidden" id="client_id" value="0"/><!--- Client ID --->

<!--- ENTRANCE --->
<div id="entrance">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="fss_filter">Filter</label><input id="fss_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('client,largeMenu');_hide('entrance,upload,contacts,services,maintenance,state,rclients');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div><label for="g1_client">Client</label><select id="g1_client"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_category">Category</label><select id="g1_category"> </select></div>
<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="q_global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" ></div>
<div><label for="g1_requestforservices">Request For Services</label><input type="text" class="date" id="g1_requestforservices" ></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate" ></div>
<div><label for="g1_informationrequested">Information Requested</label><input type="text" class="date" id="g1_informationrequested" ></div>
<div><label for="g1_informationreceived">Information Received</label><input type="text" class="date" id="g1_informationreceived" ></div>
<div><label for="g1_informationcompiled">Information compiled</label><input type="text" class="date" id="g1_informationcompiled" ></div>
<div><input id="g1_missinginformation" type="checkbox"><label for="g1_missinginformation">Missing Information</label></div>
<div><label for="g1_missinginforeceived">Missing Info Received</label><input type="text" class="date" id="g1_missinginforeceived" ></div>
<div><label for="g1_reportcompleted">Report Completed</label><input type="text" class="date" id="g1_reportcompleted" ></div>
<div><label for="g1_finalclientmeeting">Final Client Meeting</label><input type="text" class="date" id="g1_finalclientmeeting" ></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime" ></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" ></div>
 <div><label for="g1_paid">Paid</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="q_global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>

<!--- Comments --->
<div id="group2" class="gf-checkbox">
<h3>Comments</h3>
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
<div><label for="g2_commentemployee">Employee</label><input type="text" id="g2_commentemployee"/></div>
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