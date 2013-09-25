<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_maintenance">
<cfset page.location="table">
<cfset page.formid=14>
<cfset page.title="Table Maintenance">
<cfset page.menuLeft="General,Options">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group2">
<cfset page.plugins.disable="100,101">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../../assets/inc/header.cfm">
<cfquery name="optionGroup" cachedWithin="#page.cache.users#" datasource="AWS">SELECT[form_id]AS[optionvalue_id],[formName]AS[optionname]FROM[ctrl_forms]ORDER BY[formName]</cfquery>



<body>
<!--- Load Left Menus --->
<cfinclude template="../../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../../assets/module/menu/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance"class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput><div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div><label for="g1_selectLabel" >Select Label</label><input type="text" id="g1_selectLabel" class="readonly" readonly/></div>
<div><label for="g1_selectDescription">Select Description</label><textarea  id="g1_selectDescription" class="readonly" cols="4" rows="4" readonly></textarea></div>
</div>
</div>
<!--- OPTIONS --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2()">Select Options</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);$("#subtask1_id").val(0);'>Add</a>
</div>
</div>
<h4 onClick='$("#isLoaded_group2").val(1);'>Option</h4>
<div>
<div><label for="g2_optionGroup">Form Specific</label><select id="g2_optionGroup"></option><option value="0">&nbsp;</option><cfoutput query="optionGroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_optionName">Option Name</label><input type="text" id="g2_optionName"></div>
<div><label for="g2_optionDescription">Option Description</label><textarea  id="g2_optionDescription" cols="4" rows="4"></textarea></div>
</div>
</div>
<!--- Start Plugins --->
<cfinclude template="../../assets/plugins/plugins.cfm">
<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../../assets/inc/footer.cfm" />
</body>
</html>