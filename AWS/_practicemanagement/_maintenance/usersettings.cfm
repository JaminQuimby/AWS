<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfparam name="url.task_id" default="0">
<cfparam name="url.nav" default="0">
<cfset page.module="_maintenance">
<cfset page.location="usersettings">
<cfset page.formid=0>
<cfset page.title="User Settings">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">

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
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery datasource="#Session.organization.name#" name="global_users">SELECT[user_id]AS[optionvalue_id],[name]AS[optionname]FROM[v_staffinitials]ORDER BY[name]</cfquery>
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
		<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
		<div class="buttonbox">
			<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3');">Add</a>
		</div>
	</div>
</div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
	<h3>General</h3>
	<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>


<div><label for="g1_payrolltaxes"><input id="g1_payrolltaxes" type="checkbox" class="ios-switch">Payroll Taxes</label></div>
<div><label for="g1_accountingservices"><input id="g1_accountingservices" type="checkbox" class="ios-switch">Accounting Services</label></div>
<div><label for="g1_taxation"><input id="g1_taxation" type="checkbox" class="ios-switch">Taxation</label></div>
<div><label for="g1_clientmanagement"><input id="g1_clientmanagement" type="checkbox" class="ios-switch">Client Management</label></div>
<div><label for="g1_maintenance"><input id="g1_maintenance" type="checkbox" class="ios-switch">Maintenance</label></div>
<div><label for="g1_delete"><input id="g1_delete" type="checkbox" class="ios-switch">Delete Rights</label></div>
</div>

</div>


<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">
<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->

<cfinclude template="/assets/inc/footer.cfm" />
</body>
</html>