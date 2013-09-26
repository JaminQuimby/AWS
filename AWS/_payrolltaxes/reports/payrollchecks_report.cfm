<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_payrolltaxes_report">
<cfset page.location="payrollchecks_report">
<cfset page.formid=10>
<cfset page.title="Payroll Checks">
<cfset page.menuLeft="Payroll Check Status,Current Employee,Unassigned,Missing Information,Completed Not Billed">
<cfset page.type="report">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="../../assets/inc/header.cfm">

<body onLoad="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3,group4,group5'); ">

<!---PAGE CONTENTS--->
<div id="content" class="contentsmall">
<nav id="topMenu"><cfinclude template="../../assets/module/menu/menu.cfm"></nav>
<!--- Load Left Menus --->
<cfinclude template="../../assets/inc/pagemenu.cfm">
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox"></div>

<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>Payroll Check Status</h3>
<div>

<div><label for="g1_filter">Filter</label><input id="g1_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>

<div class="tblGrid" id="grid1"></div>
<div class="buttonbox"><a href="#" class="button optional" onClick="">Add</a></div>

</div>
</div>

<!--- GROUP 2 --->
<div id="group2" class="gf-checkbox">
<h3 onClick="_grid2();">Payroll Checks Current Employee</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox"><a href="#" class="button optional" onClick=''>Add</a></div>

</div>
</div>



<!--- GROUP 3 --->
<div id="group3" class="gf-checkbox">
<h3 onClick="_grid3();">Payroll Checks Unassigned</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();" onKeyPress="if(event.keyCode==13){_grid3();}"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox"><a href="#" class="button optional" onClick=''>Add</a></div>
</div>
</div>


<!--- GROUP 4 --->
<div id="group4" class="gf-checkbox">
<h3 onClick="_grid4();">Payroll Checks Missing Information</h3>
<div>
<div><label for="g4_filter">Filter</label><input id="g4_filter" onBlur="_grid4();" onKeyPress="if(event.keyCode==13){_grid4();}"/></div>
<div class="tblGrid" id="grid4"></div>
<div class="buttonbox"><a href="#" class="button optional" onClick=''>Add</a></div>
</div>
</div>


<!--- GROUP 5 --->
<div id="group5" class="gf-checkbox">
<h3 onClick="_grid5();">Payroll Checks Completed Not Billed</h3>
<div>
<div><label for="g5_filter">Filter</label><input id="g5_filter" onBlur="_grid5();" onKeyPress="if(event.keyCode==13){_grid5();}"/></div>
<div class="tblGrid" id="grid5"></div>
<div class="buttonbox"><a href="#" class="button optional" onClick=''>Add</a></div>
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