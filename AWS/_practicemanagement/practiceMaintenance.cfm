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
<div id="entrance" class="gf-checkbox">
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
<!--- GROUP1 SUBGROUP1 --->
<h4>Accounting Software</h4>
</div>
<div><label for="g1_g1_softwarename">Software Name</label><input type="text" id="g1_g1_softwarename" ></div>
</div>
<!--- GROUP1 SUBGROUP2 --->
<h4>Administrative Task Categories</h4>
<div>
<div><label for="g1_g2_category">Category</label><input type="text" id="g1_g2_category" ></div>
<div><label for="g1_g2_description">Description</label><input type="text" id="g1_g2_description" ></div>
</div>
<!--- GROUP1 SUBGROUP3 --->
<h4>Client Groups</h4>
<div>
<div><label for="g1_g3_groupname">Group Name</label><input type="text" id="g1_g3_groupname" ></div>
</div>
<!--- GROUP1 SUBGROUP4 --->
<h4>Financial & Tax Planning Categories</h4>
<div>
<div><label for="g1_g4_pfpcategory">PFP Category</label><input type="text" id="g1_g4_pfpcategory" ></div>
<div><label for="g1_g4_description">Description</label><input type="text" id="g1_g4_description" ></div>
</div>
<!--- GROUP1 SUBGROUP5 --->
<h4>Financial Statement SubTask Groups</h4>
<div>
<div><label for="g1_g5_subtaskgroup">Subtask Group</label><input type="text" id="g1_g5_subtaskgroup" ></div>
</div>
<!--- GROUP1 SUBGROUP6 --->
<h4>Financial Statement Subtasks</h4>
<div>
<div><label for="g1_g6_task">Task</label><input type="text" id="g1_g6_task" ></div>
<div><label for="g1_g6_sequence">Sequence</label><input type="text" id="g1_g6_sequence" ></div>
<div><label for="g1_g6_subtaskgroup">Subtask Group</label><input type="text" id="g1_g6_subtaskgroup" ></div>
<div><label for="g1_g6_dependency">Dependency</label><input type="text" id="g1_g6_dependency" ></div>
</div>
<!--- GROUP1 SUBGROUP7 --->
<h4>Accounting &amp; Consulting Categories</h4>
<div>
<div><label for="g1_g7_consultingcategory">Consulting Category</label><input type="text" id="g1_g7_consultingcategory" ></div>
<div><label for="g1_g7_description">Description</label><input type="text" id="g1_g7_description" ></div>
<div><label for="g1_g7_priority">Priority</label><input type="text" id="g1_g7_priority" ></div>
<div><label for="g1_g7_estimatedtime">Estimated Time</label><input type="text" id="g1_g7_estimatedtime" ></div>
</div>
<!--- GROUP1 SUBGROUP8 --->
<h4>Accounting &amp; Consulting Groups</h4>
<div>
<div><label for="g1_g8_consultinggroup">Consulting Group</label><input type="text" id="g1_g8_consultinggroup" ></div>
</div>
<!--- GROUP1 SUBGROUP9 --->
<h4>Accounting &amp; Consulting SubTasks</h4>
<div>
<div><label for="g1_g9_task">Task</label><input type="text" id="g1_g9_task" ></div>
<div><label for="g1_g9_sequence">Sequence</label><input type="text" id="g1_g9_sequence" ></div>
<div><label for="g1_g9_group">Group</label><input type="text" id="g1_g9_group" ></div>
<div><label for="g1_g9_dependency">Dependency</label><input type="text" id="g1_g9_dependency" ></div>
</div>
<!--- GROUP1 SUBGROUP10 --->
<h4>Notice Numbers</h4>
<div>
<div><label for="g1_g10_noticenumbers">Notice Numbers</label><input type="text" id="g1_g10_noticenumbers" ></div>
<div><label for="g1_g10_description">Description</label><input type="text" id="g1_g10_description" ></div>
<div><label for="g1_g10_instructions">Instructions</label><input type="text" id="g1_g10_instructions" ></div>
</div>
<!--- GROUP1 SUBGROUP11 --->
<h4>Other Filing Forms</h4>
<div>
<div><label for="g1_g11_state">State</label><input type="text" id="g1_g11_state" ></div>
<div><label for="g1_g11_form">Form</label><input type="text" id="g1_g11_form" ></div>
<div><label for="g1_g11_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_g11_filingdeadline" ></div>
<div><label for="g1_g11_extensiondeadline">Extension Deadline</label><input type="text" class="date" id="g1_g11_extensiondeadline" ></div>
<div><label for="g1_g11_description">Description</label><input type="text" id="g1_g11_description" ></div>
</div>
<!--- GROUP1 SUBGROUP12 --->
<h4>Other Filing Types</h4>
<div>
<div><label for="g1_g12_type">Type</label><input type="text" id="g1_g12_type" ></div>
<div><label for="g1_g12_description">Description</label><input type="text" id="g1_g12_description" ></div>
</div>
<!--- GROUP1 SUBGROUP13 --->
<h4>Payroll Frequencies</h4>
<div>
<div><label for="g1_g13_paryrollfrequencies">Payroll Frequencies</label><input type="text" id="g1_g13_paryrollfrequencies" ></div>
</div>
<!--- GROUP1 SUBGROUP14 --->
<h4>Payroll Tax Return Types</h4>
<div>
<div><label for="g1_g14_returntype">Return Type</label><input type="text" id="g1_g14_returntype" ></div>
<div><label for="g1_g14_id">ID</label><input type="text" id="g1_g14_id" ></div>
</div>
<!--- GROUP1 SUBGROUP15 --->
<h4>POA Tax Matters</h4>
<div>
<div><label for="g1_g15_taxmatters">Tax Matters</label><input type="text" id="g1_g15_taxmatters" ></div>
</div>
<!--- GROUP1 SUBGROUP16 --->
<h4>State / Country Listing</h4>
<div>
<div><label for="g1_g16_state">State</label><input type="text" id="g1_g16_state" ></div>
<div><label for="g1_g16_abbreviations">Abbreviations</label><input type="text" id="g1_g16_abbreviations" ></div>
</div>
<!--- GROUP1 SUBGROUP17 --->
<h4>State Tax Form Types</h4>
<div>
<div><label for="g1_g17_state">State</label><input type="text" id="g1_g17_state" ></div>
<div><label for="g1_g17_form">Form</label><input type="text" id="g1_g17_form" ></div>
<div><label for="g1_g17_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_g17_filingdeadline" ></div>
<div><label for="g1_g17_extensiondeadline">Extension Deadline</label><input type="text" class="date" id="g1_g17_extensiondeadline" ></div>
<div><label for="g1_g17_description">Description</label><input type="text" id="g1_g17_description" ></div>
</div>
<!--- GROUP1 SUBGROUP18 --->
<h4>Tax Form Schedules</h4>
<div>
<div><label for="g1_g18_taxform">Tax Form</label><input type="text" id="g1_g18_taxform" ></div>
<div><label for="g1_g18_schedule">Schedule</label><input type="text" id="g1_g18_schedule" ></div>
<div><label for="g1_g18_description">Description</label><input type="text" id="g1_g18_description" ></div>
</div>
<!--- GROUP1 SUBGROUP19 --->
<h4>Tax Form Types</h4>
<div>
<div><label for="g1_g19_formnumber">Form Number</label><input type="text" id="g1_g19_formnumber" ></div>
<div><label for="g1_g19_formdescription">Form Description</label><input type="text" id="g1_g19_formdescription" ></div>
<div><label for="g1_g19_filingdeadline">Filing Deadline</label><input type="text" class="date" id="g1_g19_filingdeadline" ></div>
</div>
<!--- GROUP1 SUBGROUP20 --->
<h4>Tax Service - Field Names</h4>
<div>
<div><label for="g1_g20_taxservicefield1">Tax Service Field 1</label><input type="text" id="g1_g20_taxservicefield1" ></div>
<div><label for="g1_g20_taxservicefield2">Tax Service Field 2</label><input type="text" id="g1_g20_taxservicefield2" ></div>
<div><label for="g1_g20_taxservicefield3">Tax Service Field 3</label><input type="text" id="g1_g20_taxservicefield3" ></div>
<div><label for="g1_g20_taxservicefield4">Tax Service Field 4</label><input type="text" id="g1_g20_taxservicefield4" ></div>
</div>
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
<div id="group3" class="gf-checkbox">
<h3>Maintenance</h3>
<div></div>
<h4>Employee Information</h4>
<div>
<div><label for="g3_name">Name</label><input type="text" id="g3_name" ></div>
<div><label for="g3_spouse">Spouse</label><input type="text" id="g3_spouse" ></div>
<div><input id="g3_active" type="checkbox"><label for="g3_active">Active</label></div>
<div><label for="g3_initials">Initials</label><input type="text" id="g3_initials" ></div>
<div><label for="g3_birthday">Birthday</label><input type="text" class="date" id="g3_birthday" ></div>
<div><label for="g3_address">Address</label><input type="text" id="g3_address" ></div>
<div><label for="g3_city">City</label><input type="text" id="g3_city" ></div>
<div><label for="g3_state">State</label><select id="g3_state"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option></select></div>
<div><label for="g3_homephone">Home Phone</label><input type="text" id="g3_homephone" ></div>
<div><label for="g3_mobilephone">Mobile Phone</label><input type="text" id="g3_mobilephone" ></div>
<div><label for="g3_workphone">Work Phone</label><input type="text" id="g3_workphone" ></div>
<div><label for="g3_ext">Ext</label><input type="text" id="g3_ext" ></div>
<div><label for="g3_email1">Email 1</label><input type="text" id="g3_email1" ></div>
<div><label for="g3_email2">Email 2</label><input type="text" id="g3_email2" ></div>
<div><label for="g3_website">Web Site</label><input type="text" id="g3_website" ></div>
<div><label for="g3_childsname1">Child's Name</label><input type="text" id="g3_childsname1" ></div>
<div><label for="g3_childsname2">Child's Name</label><input type="text" id="g3_childsname2" ></div>
<div><label for="g3_childsname3">Child's Name</label><input type="text" id="g3_childsname3" ></div>
<div><label for="g3_cafnumber">CAF #</label><input type="text" id="g3_cafnumber" ></div>
<div><label for="g3_ptin">PTIN</label><input type="text" id="g3_ptin" ></div>
<div><label for="g3_emgcontact">Emg Contact</label><input type="text" id="g3_emgcontact" ></div>
<div><label for="g3_relationship">Relationship</label><input type="text" id="g3_relationship" ></div>
<div><label for="g3_emgphone">Emg Phone</label><input type="text" id="g3_emgphone" ></div>
</div>
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


