<!--- Required for AJAX --->
<cfset page.module="_taxation">
<cfset page.location="powerofattorney">
<cfset page.formid=7>
<cfset page.title="Power of Attorney">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id">
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
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>
<cfquery dbtype="query" name="global_taxmatters">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxmatters'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>

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
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group1()'>Add</a></cfif>
</div></div></div>
<!--- Group 1--->
<div id="group1" class="gf-checkbox">
<h3>Add A New Power Of Attorney</h3>
<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="client_id"><i class="fa fa-lock link" ></i> Client</label><select id="client_id"  disabled="disabled"onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadAssets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
<div><label for="g1_taxyears"><i class="fa fa-lock link" ></i> Tax Years</label><select  id="g1_taxyears"  disabled="disabled"multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_years"><cfif optionvalue_id neq year(now())><option value="#optionvalue_id#">#optionname#</option><cfelse><option value="#optionvalue_id#" selected="selected">#optionname#</option></cfif></cfoutput></select></div>
<div><label for="g1_taxforms"><i class="fa fa-lock link"></i> Tax Forms</label><select  id="g1_taxforms"  disabled="disabled"multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taxmatters"><i class="fa fa-lock link" ></i> Tax Matters</label><select  id="g1_taxmatters"  disabled="disabled"multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_taxmatters"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_preparers"><i class="fa fa-lock link" ></i> Preparers</label><select  id="g1_preparers"   disabled="disabled"multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_datesignedbyclient">Date Signed By Client</label><input type="text" class="date" id="g1_datesignedbyclient"></div>
<div><label for="g1_datesenttoirs">Date Sent to IRS</label><input type="text" class="date" id="g1_datesenttoirs" ></div>
<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></select></div>
<div><label for="g1_dateofrevocation">Date of Revocation</label><input type="text" class="date" id="g1_dateofrevocation" ></div>
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