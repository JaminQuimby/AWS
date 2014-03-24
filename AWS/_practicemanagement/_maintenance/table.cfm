<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_maintenance">
<cfset page.location="table">
<cfset page.formid=14>
<cfset page.title="Table Maintenance">
<cfset page.menuLeft="General,Options">
<cfset page.trackers="task_id,subtask1_id,isLoaded_group2">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="/assets/inc/header.cfm">
<cfquery name="optionGroup" cachedWithin="#page.cache.users#" datasource="AWS">SELECT[form_id]AS[optionvalue_id],[formName]AS[optionname]FROM[ctrl_forms]ORDER BY[formName]</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_acctsubtasks">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_acctsubtasks'</cfquery>
<cfquery dbtype="query" name="global_financialstatmentsubtask">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_financialstatmentsubtask'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance"class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput><div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="_run.new_group1();">Add</a>
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
<h3 onClick="_group2();">Select Options</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_group2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='_run.new_group2()'>Add</a>
</div>
</div>
<h4 onClick='$("#isLoaded_group2").val(1);'>Option</h4>
<div>
<div><label for="g2_optionGroup">Form Specific</label><select id="g2_optionGroup"></option><option value="0">&nbsp;</option><cfoutput query="optionGroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_optionHide">Hide On</label><select id="g2_optionHide"></option><option value="0">&nbsp;</option><cfoutput query="optionGroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

<div><label for="g2_optionName">Option Name</label><input type="text" id="g2_optionName"></div>
<!--- OPTIONS --->
<!---Financial Statement Group--->
<div id="opt_FinancialStatementGroups" style="display:none">
<div><label for="opt_FinancialStatement_Subtasks">Subtasks</label><select id="opt_FinancialStatement_Subtasks" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_financialstatmentsubtask"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
<!---Accounting & Consulting Group --->
<div id="opt_AcctConGroups" style="display:none">
<div><label for="opt_AcctConGroups_Subtasks">Subtasks</label><select id="opt_AcctConGroups_Subtasks" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_acctsubtasks"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="opt_AcctConGroups_Sequence">Sequence</label><input type="text" id="opt_AcctConGroups_Sequence"></div>
<div><label for="opt_AcctConGroups_Group">Group</label><input type="text" id="opt_AcctConGroups_Group"></div>
<div><label for="opt_AcctConGroups_Dependency">Dependency</label><input type="text" id="opt_AcctConGroups_Dependency"></div>
</div>
<!--- Other Filings Forms & Tax Return Forms & --->
<div id="opt_OtherFilings" style="display:none">
<div><label for="opt_State">State</label><select id="opt_State"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="opt_FilingDeadline">Filing Deadline</label><input type="text" id="opt_FilingDeadline"></div>
<div><label for="opt_ExtensionDeadline">Extension Deadline</label><input type="text" id="opt_ExtensionDeadline"></div>
</div>

<!--- Tax Returns Schedules --->
<div id="opt_TaxReturnsSchedule" style="display:none">
<div><label for="opt_Form">Form</label><select id="opt_Form"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

<!--- Global State --->
<div id="opt_globalState" style="display:none">
<div><label for="opt_stateAbbreviations">Abbreviation</label><input type="text" id="opt_stateAbbreviations"></div>
</div>

<!--- Notices --->
<div id="opt_notices" style="display:none">
<div><label for="opt_noticeInstructions">Notice Instructions</label><input type="text" id="opt_noticeInstructions"></div>
</div>

<!--- Financial Statement Subtasks --->
<div id="opt_FinancialStatements" style="display:none">
<div><label for="opt_FinancialStatement_Subtasks_Sequence">Sequence</label><input type="text" id="opt_FinancialStatement_Subtask_Sequence"></div>
<div><label for="opt_FinancialStatement_Subtasks_Group">Group</label><input type="text" id="opt_FinancialStatement_Subtasks_Group"></div>
<div><label for="opt_FinancialStatement_Subtasks_Dependency">Dependency</label><input type="text" id="opt_FinancialStatement_Subtasks_Dependency"></div>
</div>

<!---Accounting & Consulting Categories --->
<div id="opt_AcctConCategories" style="display:none">
<div><label for="opt_AcctConCategories_Description">Description</label><input type="text" id="opt_AcctConCategories_Description"></div>
<div><label for="opt_AcctConCategories_Priority">Priority</label><input type="text" id="opt_AcctConCategories_Priority"></div>
<div><label for="opt_AcctConCategories_EstimatedTime">Estimated Time</label><input type="text" id="opt_AcctConCategories_EstimatedTime"></div>
</div>

<!--- Global Federal Tax Forms --->
<div id="opt_globalFederalTaxForms" style="display:none">
<div><label for="opt_globalFederalTaxForms_Filing_Deadline">Filing Deadline</label><input type="text" id="opt_globalFederalTaxForms_Filing_Deadline"></div>
<div><label for="opt_globalFederalTaxForms_Extension_Deadline">Extension Extension Deadline</label><input type="text" id="opt_globalFederalTaxForms_Extension_Deadline"></div>
</div>


<!--- END Options --->
<div><label for="g2_optionDescription">Option Description</label><textarea  id="g2_optionDescription" cols="4" rows="4"></textarea></div>
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