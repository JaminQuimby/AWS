<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfajaxproxy cfc="maintenance" jsclassname="m"/>
<!--- Load ALL Select Options for this page--->
<!--- Load Select Options for each dropdown--->
<!---Page Start--->

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">

<!---Head & Supporting Documents--->
<head>
<meta "charset=utf-8" >
<title>AWS Maintenance</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../assets/module/menu/menu.css">
<link rel="stylesheet" type="text/css" href="../assets/module/fileUpload/assets/css/demo.css">
<link rel="stylesheet" type="text/css" href="../assets/module/jtable/themes/metro/blue/jtable.min.css">
<link rel="stylesheet" type="text/css" href="../assets/css/aws.css">
<link rel="stylesheet" type="text/css" href="maintenance.css">


<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="../assets/module/fileUpload/assets/require/require.js" data-main="../assets/module/fileUpload/assets/main.js"></script>
<script type="text/javascript" src="../assets/module/jtable/jquery.jtable.min.js"></script>
<script type="text/javascript" src="../assets/js/aws.js"></script>
<script type="text/javascript" src="maintenance.js"></script>

</head>
<!--- TO DO LIST

1. Staff Initials need to be multi select

--->
<!---Body Start --->
<body onLoad=" ">


<!--- HORIZONTAL MENUS --->
<nav id="topMenu"><cfinclude template="../assets/module/menu/menu.cfm"></nav>
<!--- VERTICAL MENUS --->

<div class="menus">
<!--- SMALL MENU 
	<nav id="smallMenu" style="display:inherit;">
	<h1 class="accountingServices">&nbsp;</h1>
	</nav>
--->

<!--- LARGE MENU --->
<nav id="largeMenu">
<h1 class="accountingServices">Accounting &amp; Consulting Tasks</h1>

<ul id="menuLeft">
<li><a onclick="toggle('group1');hide('group2,group3,group4');highlight(this);" class="highlight">Table Maintenance</a></li>
<li><a onclick="toggle('group2');hide('group1,group3,group4');highlight(this);">Historical Data</a></li>
<li><a onclick="toggle('group3');hide('group1,group2,group4');highlight(this);">Maintenance</a></li>
<li><a onclick="toggle('group4');hide('group1,group2,group3');highlight(this);">Time &amp; Billing</a></li>
</ul>
</nav>
</div>


<!---PAGE CONTENTS--->
<div id="content" class="contentbig">

<!--- DETAIL GRID 
<div id="entrance">
<h3>Entrance</h3><div></div>
</div>
--->

<!--- Table Maintenance --->
<div id="group1"  class="gf-checkbox">

<h3>Table Maintenance</h3><div></div>
<h4>Accounting Software</h4><div><div id="accountingSoftware"></div></div>
<h4>Administrative Task Categories</h4><div></div>
<h4>Client Groups</h4><div></div>
<h4>Financial & Tax Planning Categories</h4><div></div>
<h4>Financial Statement SubTask Groups</h4><div></div>
<h4>Financial Statement Subtasks</h4><div></div>
<h4>Accounting &amp; Consulting Categories</h4><div></div>
<h4>Accounting &amp; Consulting Groups</h4><div></div>
<h4>Accounting &amp; Consulting SubTasks</h4><div></div>
<h4>Notice Numbers</h4><div></div>
<h4>Other Filing Forms</h4><div></div>
<h4>Other Filing Types</h4><div></div>
<h4>Payroll Frequencies</h4><div></div>
<h4>Payroll Tax Return Types</h4><div></div>
<h4>POA Tax Matters</h4><div></div>
<h4>State / Country Listing</h4><div></div>
<h4>State Tax Form Types</h4><div></div>
<h4>Tax Form Schedules</h4><div></div>
<h4>Tax Form Types</h4><div></div>
<h4>Tax Service - Field Names</h4><div></div>
</div>

<!--- Historical Data --->
<div id="group2" style="display:none;" class="gf-checkbox">

<h3>Historical Data</h3><div></div>
<h4>Administrative Tasks</h4><div></div>
<h4>Business Formation</h4><div></div>
<h4>Communications</h4><div></div>
<h4>Client Maintenance</h4><div></div>
<h4>Financial Statements</h4><div></div>
<h4>Accounting &amp; Consulting Tasks</h4><div></div>
<h4>Notice Matters</h4><div></div>
<h4>Other Filings</h4><div></div>
<h4>Payroll Checks</h4><div></div>
<h4>Payroll Tax Returns</h4><div></div>
<h4>Tax Returns</h4><div></div>


</div>
<!--- Maintenance --->
<div id="group3" style="display:none;" class="gf-checkbox">
<h3>Maintenance</h3><div></div>
<h4>Employee Information</h4><div></div>
<h4>Change System Password</h4><div></div>
<h4>Change User Settings</h4><div></div>
<h4>View User History</h4><div></div>


</div>
<!--- Time &amp; Billing --->
<div id="group4" style="display:none;" class="gf-checkbox">
<h3>Time &amp; Billing</h3><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
<h4></h4><div></div>
</div>



</div>
<footer><div class="buttonbox">
<a onclick="saveData();" class="button">Save</a> | <a href="#" onClick="resetDocument()">Cancel</a><br>
</div><div id="progressbar">&nbsp;</div><div id="notices">&nbsp;</div></footer>
</body>
</html>