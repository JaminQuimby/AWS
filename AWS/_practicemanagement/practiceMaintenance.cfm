<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_practicemanagement">
<cfset page.location="practicemaintenance">
<cfset page.title="Maintenance">
<cfset page.menuLeft="General,SubTasks,Comment">
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<!--- Load Select Options for each dropdown--->
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

<!---TRACKERS--->
<input type="hidden" id="client_id" value="0"/><!--- Client ID --->

<!--- ENTRANCE --->
<div id="entrance">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="fss_filter">Filter</label><input id="fss_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('client,largeMenu');_hide('entrance,upload,contacts,services,maintenance,state,rclients');">Add</a>
</div></div></div>
<!--- FIELD DATA --->


<!--- END FIELD DATA --->

<div id="group1"  class="gf-checkbox">
<h3>Table Maintenance</h3>
<div></div>
<h4>Accounting Software</h4>
</div></div>
<h4>Administrative Task Categories</h4>
<div></div>
<h4>Client Groups</h4>
<div></div>
<h4>Financial & Tax Planning Categories</h4>
<div></div>
<h4>Financial Statement SubTask Groups</h4>
<div></div>
<h4>Financial Statement Subtasks</h4>
<div></div>
<h4>Accounting &amp; Consulting Categories</h4>
<div></div>
<h4>Accounting &amp; Consulting Groups</h4>
<div></div>
<h4>Accounting &amp; Consulting SubTasks</h4>
<div></div>
<h4>Notice Numbers</h4>
<div></div>
<h4>Other Filing Forms</h4>
<div></div>
<h4>Other Filing Types</h4>
<div></div>
<h4>Payroll Frequencies</h4>
<div></div>
<h4>Payroll Tax Return Types</h4>
<div></div>
<h4>POA Tax Matters</h4>
<div></div>
<h4>State / Country Listing</h4>
<div></div>
<h4>State Tax Form Types</h4>
<div></div>
<h4>Tax Form Schedules</h4>
<div></div>
<h4>Tax Form Types</h4>
<div></div>
<h4>Tax Service - Field Names</h4>
<div></div>
</div>

<!--- Historical Data --->
<div id="group2" style="display:none;" class="gf-checkbox">
<h3>Historical Data</h3>
<div></div>
<h4>Administrative Tasks</h4>
<div></div>
<h4>Business Formation</h4>
<div></div>
<h4>Communications</h4>
<div></div>
<h4>Client Maintenance</h4>
<div></div>
<h4>Financial Statements</h4>
<div></div>
<h4>Accounting &amp; Consulting Tasks</h4>
<div></div>
<h4>Notice Matters</h4>
<div></div>
<h4>Other Filings</h4>
<div></div>
<h4>Payroll Checks</h4>
<div></div>
<h4>Payroll Tax Returns</h4>
<div></div>
<h4>Tax Returns</h4>
<div></div>


</div>
<!--- Maintenance --->
<div id="group3" style="display:none;" class="gf-checkbox">
<h3>Maintenance</h3>
<div></div>
<h4>Employee Information</h4>
<div></div>
<h4>Change System Password</h4>
<div></div>
<h4>Change User Settings</h4>
<div></div>
<h4>View User History</h4>
<div></div>


</div>
<!--- Time &amp; Billing --->
<div id="group4" style="display:none;" class="gf-checkbox">
<h3>Time &amp; Billing</h3><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
</div>

<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>


