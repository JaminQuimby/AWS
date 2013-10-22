<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_taxation">
<cfset page.location="financialtaxplanning">
<cfset page.formid=9>
<cfset page.title="Finanical Tax Planning">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../assets/inc/header.cfm">
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div><label for="client_id">Client</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_category">Category</label><select id="g1_category"><option value="0">&nbsp;</option></select></div>
<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
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
 <div><label for="g1_paid">Paid</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
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