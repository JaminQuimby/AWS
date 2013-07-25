<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfajaxproxy cfc="acctConsultingTasks" jsclassname="act"/>
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 0, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Accounting Consulting Tasks'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="q_global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="q_global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_consultingcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_consultingcategory'</cfquery>
<!---Page Start--->

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">

<!---Head & Supporting Documents--->
<head>
<meta "charset=utf-8" >
<title>Accounting &amp; Consulting Tasks</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../assets/module/menu/menu.css">
<link rel="stylesheet" type="text/css" href="../assets/module/fileUpload/assets/css/demo.css">
<link rel="stylesheet" type="text/css" href="../assets/css/aws.css">
<link rel="stylesheet" type="text/css" href="acctConsultingTasks.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="../assets/module/fileUpload/assets/require/require.js" data-main="../assets/module/fileUpload/assets/main.js"></script>
<script type="text/javascript" src="../assets/js/aws.js"></script>
<script type="text/javascript" src="acctConsultingTasks.js"></script>
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
<!--- SMALL MENU --->
	<nav id="smallMenu" style="display:inherit;">
	<h1 class="accountingServices">&nbsp;</h1>
	</nav>

<!--- LARGE MENU --->
<nav id="largeMenu" style="display:none;">
<h1 class="accountingServices">Accounting &amp; Consulting Tasks</h1>

<ul id="menuLeft">
<li><a onclick="toggle('group1');hide('group2,group3,group4');highlight(this);" class="highlight">General</a></li>
<li><a onclick="toggle('group2');hide('group1,group3,group4');highlight(this);">Sub Tasks</a></li>
<li><a onclick="toggle('group3');hide('group1,group2,group4');highlight(this);">Comments</a></li>
<li><a onclick="toggle('group4');hide('group1,group2,group3');highlight(this);">Documents</a></li>
</ul>
</nav>
</div>


<!---PAGE CONTENTS--->
<div id="content" class="contentsmall">
<!--- CLIENT DETAIL GRID --->
<div id="entrance">
<h3>Clients with active tasks</h3>
<div>
<label for="cd_filter">Filter</label><input name="cd_filter" id="cd_filter" onBlur="getClient(this.value);">
<!--- DATA LOAD START --->
<table class="bordered" id="gridTasks"><thead><tr></tr></thead><tbody><tr></tr></tbody><tfoot><tr><th><a href="#" onClick="document.getElementById('content').className='contentbig';toggle('group1,largeMenu');hide('entrance,group2,group3,group4,smallMenu');">Add</a></th></tr></tfoot></table>
<!--- DATA LOAD END --->
</div>
</div>

<!--- General --->
<div id="group1" style="display:none;" class="gf-checkbox">
<h3>General</h3>
<div>

<h4>Developer Note:[Table Management Consulting Tasks]</h4>
<div><label for="g1_client">Clients</label><select name="g1_client" id="g1_client"  onBlur="valid('rationalNumbers',this,'You must select an option.');"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" name="g1_spouse"></div>
<div><input name="g1_credithold" id="g1_credithold"  type="checkbox"><label for="g1_credithold">Credit Hold</label></div>
<div><label for="g1_consultingcategory">Consulting Category</label><select name="g1_consultingcategory" id="g1_consultingcategory"  onBlur="valid('rationalNumbers',this,'You must select an option.');"><option value="0">&nbsp;</option><cfoutput query="global_consultingcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_taskdescription">Task Description</label><textarea name="g1_taskdescription" id="g1_taskdescription" cols="4" rows="4" onBlur="valid('empty',this,'Cannot be empty.');" ></textarea></div>
<div><label for="g1_priority">Priority</label><input type="text" id="g1_priority" name="g1_priority" onBlur="valid('empty',this,'Cannot be empty.');"></div>
<div><label for="g1_assignedto">Assigned To</label><select name="g1_assignedto" id="g1_assignedto"  onBlur="valid('rationalNumbers',this,'You must select an option.');"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_status">Status</label><select name="g1_status" id="g1_status" onBlur="valid('rationalNumbers',this,'You must select an option.');"><option value="0" >&nbsp;</option><cfoutput query="q_global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_requestforservices">Request for Services</label><input type="text" id="g1_requestforservices" name="g1_requestforservices"></div>
<div><label for="g1_workinitiated">Work Initiated</label><input type="text" id="g1_workinitiated" name="g1_workinitiated"></div>
<div><label for="g1_duedate">Due Date</label><input type="text" id="g1_duedate" name="g1_duedate"></div>
<div><label for="g1_projectcompleted">Project Completed</label><input type="text" id="g1_projectcompleted" name="g1_projectcompleted"></div>
<div><label for="g1_estimatedtime">Estimated Time</label><input type="text" id="g1_estimatedtime" name="g1_estimatedtime"></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" name="g1_fees"></div>
<div><label for="g1_paid">Paid</label><select name="g1_paid" id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="q_global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

</div>
</div>
<!--- Subtask --->
<div id="group2" style="display:none;" class="gf-checkbox">
<h3>Subtasks</h3>
<div>
<h4>Developer Note:[Table Management Consulting SubTasks]</h4>

<div><br>management consulting id = [SELECT [Management Consulting Tasks].[Management Consulting ID] FROM [Management Consulting Tasks]; ]</div>
<div><label for="g2_sequence">Sequence</label><input type="text" id="g2_sequence" name="g2_sequence"></div>
<div><br>SubTask =SELECT [Management Consulting Subtasks].Task FROM [Management Consulting Subtasks] ORDER BY [Management Consulting Subtasks].[Task];</div>
<div><label for="g2_status">Status</label><select name="g2_status" id="g2_status"><option value="0">&nbsp;</option><cfoutput query="q_global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_assignedto">Assigned To</label><select name="g2_assignedto" id="g2_assignedto"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_duedate">Due Date</label><input type="text" id="g2_duedate" name="g2_duedate"></div>
<div><label for="g2_completed">Completed</label><input type="text" id="g2_completed" name="g2_completed"></div>
<div><br>Dependancys =SELECT [Management Consulting Subtasks].Task FROM [Management Consulting Subtasks] ORDER BY [Management Consulting Subtasks].[Task];</div>
<div><label for="g2_estimatedtime">Estimated Time</label><input type="text" id="g2_estimatedtime" name="g2_estimatedtime"></div>
<div><label for="g2_actualtime">Actual Time</label><input type="text" id="g2_actualtime" name="g2_actualtime"></div>
<div><label for="g2_note">Notes</label><textarea name="g3_note" id="g3_note" cols="4" rows="4"></textarea></div>


</div>
</div>
<!--- Comments --->
<div id="group3" style="display:none;" class="gf-checkbox">
<h3>Comments</h3>
<div>

<div><label for="cd_filter">Filter</label><input name="cd_filter" id="cd_filter" onBlur="getClient(this.value);"></div>
<!--- DATA LOAD START --->
<div><table class="bordered" id="gridNotes"><thead><tr></tr></thead><tbody><tr></tr></tbody><tfoot><tr><th><a href="#" onClick="">Add</a></th></tr></tfoot></table></div>
<!--- DATA LOAD END --->


<!---DATE AUTO SET--->
<!---EMPLOYEE AUTO SEND --->
<input type="hidden" id="g_employee" value="#Session.user.id#">
<div><label for="g3_note">Notes</label><textarea name="g3_note" id="g3_note" cols="4" rows="4"></textarea></div>
</div>
</div>
<!--- Documents --->
<div id="group4" style="display:none;" class="gf-checkbox">
<h3>Documents</h3><div></div>
</div>



</div>
<footer><div class="buttonbox">
<a onclick="saveData();" class="button">Save</a> | <a href="#" onClick="resetDocument()">Cancel</a><br>
</div><div id="progressbar">&nbsp;</div><div id="notices">&nbsp;</div></footer>
</body>
</html>