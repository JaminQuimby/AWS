<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_clientmanagement">
<cfset page.location="documenttracking">
<cfset page.formid=14>
<cfset page.title="Document Tracking">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id,file_id">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../assets/inc/header.cfm">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#page.cache.options#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE([form_id]='#page.formid#'OR[form_id]='0')AND([optionGroup]='#page.formid#'OR[optionGroup]='0')</cfquery>
<cfquery name="selectClients" cachedWithin="#page.cache.clients#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#page.cache.users#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->

<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>

<!---TRACKERS--->

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
<div><label for="g1_date">Date</label><input type="text" class="date" id="g1_date"></div>
<div><label for="g1_staff">Staff</label><select id="g1_staff"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_sender">Sender</label><input type="text" id="g1_sender"></div>
<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<!---<div><label for="form_id" style="display:none">Module</label><select id="form_id" style="display:none"><option value="0" style="display:none">&nbsp;</option></select></div>
<div><label for="file_id" style="visibility:hidden">File</label><select id="file_id" style="visibility:hidden"><option value="0" style="visibility:hidden">&nbsp;</option></select></div>--->
<div><label for="g1_description">Description</label><textarea id="g1_description" ></textarea></div>
<div><input id="g1_fax" type="checkbox"><label for="g1_fax">Fax</label></div>
<div><input id="g1_mail" type="checkbox"><label for="g1_mail">Mail</label></div>
<div><input id="g1_email" type="checkbox"><label for="g1_email">Email</label></div>
<div><input id="g1_delivery" type="checkbox"><label for="g1_delivery">Delivery</label></div>
<div><label for="g1_assignedto">Assigned To</label><select id="g1_assignedto"  multiple="multiple" ><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_routing">Routing</label><textarea id="g1_routing" ></textarea></div>
</div>
</div>

<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">

<!--- FIELD DATA --->


<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>