<!--- Required for AJAX --->
<cfset page.module="_maintenance">
<cfset page.location="employeecontactinfo">
<cfset page.formid=15>
<cfset page.title="Employee Contact Info">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id,client_id">
<cfset page.plugins.disable="100,101">
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
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>

<!---TRACKERS--->

<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="_run.new_group1()">Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="g1_name">Name</label><input type="text" maxlength="40" id="g1_name" ></div>
<div><label for="g1_initials">Initials</label><input type="text" id="g1_initials" class="readonly" readonly></div>
<div><label for="g1_active"><input id="g1_active" type="checkbox" class="ios-switch">Active</label></div>
<div><label for="g1_address">Address</label><input type="text" maxlength="100" id="g1_address"></div>
<div><label for="g1_city">City</label><input type="text" maxlength="40" id="g1_city"></div>
<div><label for="g1_state">State</label><select id="g1_state"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_zip">Zip Code</label><input type="text" maxlength="10" id="g1_zip"></div>
<div><label for="g1_phone1">Home Phone</label><input type="text" maxlength="14" id="g1_phone1" type="tel" class="phone"   ></div>
<div><label for="g1_phone2">Cell Phone</label><input type="text" maxlength="14" id="g1_phone2" type="tel" class="phone"   ></div>
<div><label for="g1_phone3">Work Phone</label><input type="text" maxlength="14" id="g1_phone3" type="tel" class="phone"   ></div>
<div><label for="g1_ext">Ext</label><input type="text" maxlength="5" id="g1_ext"></div>
<div><label for="g1_email1">Email 1</label><input type="text" maxlength="40" id="g1_email1"></div>
<div><label for="g1_email2">Email 2</label><input type="text" maxlength="40" id="g1_email2"></div>
<div><label for="g1_website1">Web Site</label><input type="text" maxlength="100" id="g1_website1"></div>
<div><label for="g1_cafnum">CAF#</label><input type="text" maxlength="30" id="g1_cafnum"></div>
<div><label for="g1_ptin">PTIN</label><input type="text" maxlength="30" id="g1_ptin"></div>
<div><label for="g1_birthday">Birthday</label><input type="text" class="date" id="g1_birthday"></div>
<div><label for="g1_spousename">Spouse</label><input type="text" maxlength="40" id="g1_spousename"></div>
<div><label for="g1_childname1">Child's Name</label><input type="text" maxlength="40" id="g1_childname1"></div>
<div><label for="g1_childname2">Child's Name</label><input type="text" maxlength="40" id="g1_childname2"></div>
<div><label for="g1_childname3">Child's Name</label><input type="text" maxlength="40" id="g1_childname3"></div>
<div><label for="g1_emergencycontact">Emergency Contact</label><input type="text" maxlength="40" id="g1_emergencycontact"></div>
<div><label for="g1_relationship">Relationship</label><input type="text" maxlength="20" id="g1_relationship"></div>
<div><label for="g1_contactphone">Emergency Phone</label><input type="text" maxlength="14" id="g1_contactphone" type="tel" class="phone"></div>
</div>
</div>
<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">
<!--- FIELD DATA --->
<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="/assets/inc/footer.cfm" />
</body>
</html>