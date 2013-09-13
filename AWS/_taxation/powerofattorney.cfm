<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_taxation">
<cfset page.location="powerofattorney">
<cfset page.formid=7>
<cfset page.title="Power of Attorney">
<cfset page.menuLeft="General,Comment">
<cfset page.trackers="task_id,isLoaded_group2,comment_id">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 0, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[form_id]='#page.formid#'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_years">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_years'</cfquery>
<cfquery dbtype="query" name="global_taxmatters">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxmatters'</cfquery>
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
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2');">Add</a>
</div></div></div>
<!--- Group 1--->
<div id="group1" class="gf-checkbox">
<h3>Add A New Power Of Attorney</h3>
<div>
<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taxyears">Tax Years</label><select  id="g1_taxyears" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_years"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taxforms">Tax Forms</label><select  id="g1_taxforms" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taxmatters">Tax Matters</label><select  id="g1_taxmatters" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_taxmatters"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_preparers">Preparers</label><select  id="g1_preparers" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_datesignedbyclient">Date Signed By Client</label><input type="text" class="date" id="g1_datesignedbyclient"></div>
<div><label for="g1_datesenttoirs">Date Sent to IRS</label><input type="text" class="date" id="g1_datesenttoirs" ></div>
<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></select></div>
<div><label for="g1_dateofrevocation">Date of Revocation</label><input type="text" class="date" id="g1_dateofrevocation" ></div>
</div>
</div>
<!--- Comments --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">Comments</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);'>Add</a>
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