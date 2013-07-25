<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfajaxproxy cfc="acctConsultingTasks" jsclassname="act"/>
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Accounting Consulting Tasks'</cfquery>

<!--- Load Select Options for each dropdown--->
<!---<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>--->



<!---Page Start--->

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">

<!---Head & Supporting Documents--->
<head>
<meta "charset=utf-8" />
<title>AWS - Client Maintenance</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="../assets/module/menu/menu.css"/>
<link rel="stylesheet" type="text/css" href="../assets/module/fileUpload/assets/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="../assets/css/aws.css"/>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="../assets/module/fileUpload/assets/require/require.js" data-main="../assets/module/fileUpload/assets/main.js"></script>
<script type="text/javascript" src="../assets/js/aws.js"></script>
<script type="text/javascript" src="../accountingServices/businessFormation.js"></script>
</head>

<!---Body Start --->
<body onLoad=" ">


<!--- HORIZONTAL MENUS --->
<nav id="topMenu"><cfinclude template="../assets/module/menu/menu.cfm"></nav>
<!--- VERTICAL MENUS --->
<div class="menus">
<!--- SMALL MENU --->
<nav id="smallMenu" style="display:inherit;">
<h1 class="accountingServices">&nbsp;</h1>
</nav>

<!--- LARGE MENU --->
<nav id="largeMenu" style="display:none;">
<h1 class="accountingServices">Business Formation</h1>
<ul id="menuLeft"><li><a onclick="toggle('group1');hide('group2,group3,entrance');highlight(this);" class="highlight">General</a></li>
<ul id="menuLeft"><li><a onclick="toggle('group2');hide('group1,group3,entrance');highlight(this);" class="highlight">Comments</a></li>
<ul id="menuLeft"><li><a onclick="toggle('group3');hide('group1,group2,entrance');highlight(this);" class="highlight">Documents</a></li>

</ul>
<div class="buttonbox">
<a onclick="saveData();" class="button">Save</a> | <a href="#" onClick="resetDocument()">Cancel</a><br/>
</div>
</nav>
</div>


<!---PAGE CONTENTS--->
<div id="content" class="contentsmall">

<!--- CLIENT DETAIL GRID --->
<div id="entrance">
<h3>Clients with active tasks</h3>
<div>
<label for="cd_filter">Filter</label><input name="cd_filter" id="cd_filter" onBlur="getClient(this.value);"/>
<!--- DATA LOAD START --->
<table class="bordered" id="gridTasks"><thead><tr></tr></thead><tbody><tr></tr></tbody><tfoot><tr><th><a href="#" onClick="toggle('group1,largeMenu');hide('group2,group3,entrance,smallMenu');document.getElementById('content').className='contentbig';">Add</a></th></tr></tfoot></table>
<!--- DATA LOAD END --->
</div>
</div>

<!--- General --->
<div id="group1" style="display:none;" class="gf-checkbox">
<h3>General</h3><div></div>
</div>
<!--- Subtask --->
<div id="group2" style="display:none;" class="gf-checkbox">
<h3>Subtasks</h3><div></div>
</div>
<!--- Comments --->
<div id="group3" style="display:none;" class="gf-checkbox">
<h3>Comments</h3><div></div>
</div>

</div>
</body>
</html>