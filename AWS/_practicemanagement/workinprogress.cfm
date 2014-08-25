<!--- Required for AJAX --->
<cfset page.module="_practicemanagement">
<cfset page.location="workinprogress">
<cfset page.formid=11>
<cfset page.title="Work in Progress">
<cfset page.menuLeft="Work in Progress">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="/assets/inc/header.cfm">
<style>
#grid1 > div.jtable-main-container > table.jtable > tbody > tr > td:not(:first-child) {
    text-align: right !important;
}
#grid1 > div.jtable-main-container > table.jtable > thead > tr > th {
    text-align: center !important;
}
</style>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_clientgroup">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_clientgroup'</cfquery>
<cfinclude template="/assets/inc/pagemenu.cfm">
<body onLoad="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3,group4,group5,group6,group7,group8,group9,group10,group11,group12,group13'); ">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>

<!--- ENTRANCE --->

  <div id="group1" class="gf-checkbox">
  <h3 onClick="_run.load_group1();">Total Time</h3>
	<div>
 
<table>
<tr>
  <td>
  	<div><label for="client_id"> Client</label><select id="client_id" onchange="_grid1();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g1_duedate">Due on or before</label><input type="text" class="date" id="g1_duedate" onchange="_grid1();"></div>
    <div><label for="g1_assignedto">Employee</label><select id="g1_assignedto" onchange="_grid1();"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_group">Group</label><select id="g1_group" onchange="_grid1();"><option value="0">&nbsp;</option><cfoutput query="global_clientgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	
</td>
  <td style="position:absolute; right:30px;"><cfoutput><img src="#this.url#/assets/images/aws_logo_3.PNG" alt="Accountants' Workflow Solutions"></cfoutput></td>

</tr>
</table>    
    <div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
    </div>

  <h3 onClick="_run.load_group2();">Accounting &amp; Consulting</h3>
  	<div><div class="tblGrid" id="grid2"></div></div>

  <h3 onClick="_run.load_group3();">Administrative Tasks</h3>
	<div><div class="tblGrid" id="grid3"></div></div>

  <h3 onClick="_run.load_group4();">Business Formation</h3>
	<div><div class="tblGrid" id="grid4"></div></div>

  <h3 onClick="_run.load_group5();">Communications</h3>
	<div><div class="tblGrid" id="grid5"></div></div>

  <h3 onClick="_run.load_group6();">Financial &amp; Tax Planning</h3>
	<div><div class="tblGrid" id="grid6"></div></div>

  <h3 onClick="_run.load_group7();">Financial Statements</h3>
	<div><div class="tblGrid" id="grid7"></div></div>

  <h3 onClick="_run.load_group8();">Notices</h3>
	<div><div class="tblGrid" id="grid8"></div></div>

  <h3 onClick="_run.load_group9();">Other Fililngs</h3>
	<div><div class="tblGrid" id="grid9"></div></div>

  <h3 onClick="_run.load_group10();">Payroll Checks</h3>
	<div><div class="tblGrid" id="grid10"></div></div>

  <h3 onClick="_run.load_group11();">Payroll Taxes</h3>
	<div><div class="tblGrid" id="grid11"></div></div>

  <h3 onClick="_run.load_group12();">Personal Property Tax Returns</h3>
	<div><div class="tblGrid" id="grid12"></div></div>

  <h3 onClick="_run.load_group13();">Tax Returns</h3>
	<div><div class="tblGrid" id="grid13"></div></div>
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