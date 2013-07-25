<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<!---cfajaxproxy cfc="clientMaintenance" jsclassname="cm"/--->
<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_returntypes">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_returntypes'</cfquery>
<cfquery dbtype="query" name="q_m_of_task">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='m_of_task'</cfquery>
<cfquery dbtype="query" name="q_cl_type">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='cl_type'</cfquery>
<cfquery dbtype="query" name="q_p_paycheckfrequency">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='p_paycheckfrequency'</cfquery>
<cfquery dbtype="query" name="q_p_prtaxdepositschedule">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='p_prtaxdepositschedule'</cfquery>
<cfquery dbtype="query" name="q_a_financialstatementfreq">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='a_financialstatementfreq'</cfquery>
<cfquery dbtype="query" name="q_a_software">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='a_software'</cfquery>
<cfquery dbtype="query" name="q_a_coType">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='co_type'</cfquery>
<cfquery dbtype="query" name="m_mct_group">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='m_mct_group'</cfquery>
<cfquery dbtype="query" name="global_consultingcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_consultingcategory'</cfquery>
<cfquery dbtype="query" name="global_clientgroup">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_clientgroup'</cfquery>
<!--- Load Labels --->


<!---Page Start--->
<!--- THINGS TO DO

Related Clients
Label State Info Loading

--->
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">

<!---Head & Supporting Documents--->
<head>
<meta "charset=utf-8" />
<title>Client Maintenance</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="../assets/module/menu/menu.css"/>
<link rel="stylesheet" type="text/css" href="../assets/module/fileUpload/assets/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="../assets/module/jtable/themes/metro/green/jtable.min.css">
<link rel="stylesheet" type="text/css" href="../assets/module/chosen/chosen.css">
<link rel="stylesheet" type="text/css" href="../assets/module/jqMessage/jqmessage.css">
<link rel="stylesheet" type="text/css" href="../assets/css/aws.css"/>
<link rel="stylesheet" type="text/css" href="clientMaintenance.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="../assets/module/jtable/jquery.jtable.min.js"></script>
<script type="text/javascript" src="../assets/module/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="../assets/module/jqMessage/jqmessage.jquery.js"></script>
<script type="text/javascript" src="../assets/module/jqValid/jqValid.jquery.js"></script>
<!---script type="text/javascript" src="../assets/module/fileUpload/assets/require/require.js" data-main="../assets/module/fileUpload/assets/main.js"></script--->
<script type="text/javascript" src="../assets/js/aws.js"></script>
<script type="text/javascript" src="clientMaintenance.js"></script>
</head>

<!---Body Start --->
<body onLoad=" ">
<!---Group Trackers for Changes--->
<input type="hidden" id="cf_isLoaded" value="0"/><!---Custom Fields --->
<input type="hidden" id="t_isLoaded" value="0"/><!--- Services Taxes --->
<input type="hidden" id="p_isLoaded" value="0"/><!--- Services Payroll --->
<input type="hidden" id="a_isLoaded" value="0"/><!--- Services Accounting --->
<input type="hidden" id="co_isLoaded" value="0"/><!---Contacts --->
<input type="hidden" id="m_pt_isLoaded" value="0"/><!---Maintance Payroll Taxes--->
<input type="hidden" id="m_pc_isLoaded" value="0"/><!---Maintance Payroll Checks--->
<input type="hidden" id="m_mct_isLoaded" value="0"/><!---Maintance Accounting and Consulting Tasks --->
<input type="hidden" id="m_tsl_isLoaded" value="0"/><!---Maintance Tax Status Listing --->
<input type="hidden" id="m_fs_isLoaded" value="0"/><!--- Maintance Fiancial Statements--->
<input type="hidden" id="m_of_isLoaded" value="0"/><!--- Maintance Other Filings --->
<input type="hidden" id="s_isLoaded" value="0"/><!--- State Information --->
<input type="hidden" id="sl_isLoaded" value="0"/><!---State Labels--->
<input type="hidden" id="cl_id" value="0"/><!--- Current CLIENT LOADED 0 is none--->
<input type="hidden" id="cl_fieldid" value="0"  /><!---  Current Custom Field Loaded --->
<input type="hidden" name="co_id" id="co_id" value="0" /><!--- Current Contact Loaded --->
<!--- NOT USED YET--->
<input type="hidden" id="m_fs_id" value="0" /><!--- Current Finincial Statement Loaded --->
<input type="hidden" id="m_mct_id" value="0" /><!--- Current Accounting and Consulting --->
<input type="hidden" id="m_pc_id" value="0" /><!--- Current Payroll Checks loaded --->
<input type="hidden" id="m_pt_id" value="0" /><!--- Current Payroll taxes loaded --->
<input type="hidden" id="m_tsl_id" value="0" /><!--- Current Taxes Status Listing loaded --->
<input type="hidden" id="m_of_id" value="0" /><!--- Current Other Filings loaded --->
<input type="hidden" id="s_id" value="0" /><!--- State Information Loaded --->

<!--- VERTICAL MENUS --->
<div class="menus">
<!--- SMALL MENU --->
<nav id="smallMenu" style="display:inherit;">
<h1 class="clientManagement">&nbsp;</h1>

</nav>
<!--- LARGE MENU --->
<nav id="largeMenu" style="display:none;">
<h1 class="clientManagement">Client Maintenance</h1>
<ul id="menuLeft"><li><a onclick="_toggle('client');_hide('entrance,services,contacts,maintenance,state,rclients,upload');_highlight(this);" class="_highlight">Client</a></li>
<li><a onclick="_toggle('services');_hide('entrance,client,contacts,maintenance,state,rclients,upload');_highlight(this);">Services</a></li>
<li><a onclick="_toggle('contacts');_hide('entrance,client,services,maintenance,state,rclients,upload');_highlight(this);_gridContacts();">Contacts</a></li>
<li><a onclick="_toggle('maintenance');_hide('entrance,client,contacts,services,state,rclients,upload');_highlight(this);">Maintenance</a></li>
<li><a onclick="_toggle('state');_hide('entrance,client,contacts,services,maintenance,rclients,upload');_highlight(this);_gridStateinformation();">State Information</a></li>
<li><a onclick="_toggle('rclients');_hide('entrance,client,contacts,services,maintenance,state,upload');_highlight(this);">Related Clients</a></li>
<li><a onclick="_toggle('upload');_hide('entrance,client,contacts,services,maintenance,state,rclients');_highlight(this);">Documents</a></li>
</ul>
</nav>
</div>

<!---PAGE CONTENTS--->
<div id="content" class="contentsmall">
<!--- HORIZONTAL MENUS --->
<nav id="topMenu"><cfinclude template="../assets/module/menu/menu.cfm"></nav>
<!--- CLIENT DETAIL GRID --->
<div id="entrance">

<h3>Clients Search</h3>
<div>
<div><label for="cl_filter">Filter</label><input name="cl_filter" id="cl_filter" onBlur="loadGridClient(0);"/></div>
<!--- Client Grid --->
<div class="tblGrid" id="gridClients1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('client,largeMenu');_hide('entrance,upload,contacts,services,maintenance,state,rclients');">Add</a>
</div>
</div>

</div>

<!--- CLIENT TAB --->
<div  id="client" style="display:none;" class="gf-checkbox">

<h3>Client</h3>
<div>
<div><label for="cl_name">Client Name</label><input name="cl_name" id="cl_name" type="text" class="valid_off" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="cl_spouse">Spouse</label><input name="cl_spouse" id="cl_spouse" type="text"/></div>
<div><label for="cl_salutation">Salutation</label><input name="cl_salutation" id="cl_salutation" type="text" class="valid_off" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="cl_type">Type</label><select name="cl_type" id="cl_type" type="text"  data-placeholder="Choose type of client..."><option value="0">&nbsp;</option><cfoutput query="q_cl_type"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="cl_since">Client Since</label><input name="cl_since" id="cl_since" type="text" class="valid_off" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="cl_trade_name">Trade Name</label><input name="cl_trade_name" id="cl_trade_name" type="text" /></div>
<div><label for="cl_referred_by">Referred By</label><input name="cl_referred_by" id="cl_referred_by"  type="text"/></div>
<div><label for="cl_dms_reference">DMS Reference</label><input name="cl_dms_reference" id="cl_dms_reference" type="text"/></div>
<div><input name="cl_active" id="cl_active"  type="checkbox" /><label for="cl_active">Active</label></div>
<div><input name="cl_credit_hold" id="cl_credit_hold"  type="checkbox" /><label for="cl_credit_hold">Credit Hold</label></div>
<div><label for="cl_notes">Notes</label><textarea name="cl_notes" id="cl_notes" cols="4" rows="4" ></textarea></div>
</div>

<h4 onClick="_gridCustomfields();">Saved Custom Fields</h4>
<div>
<div><label for="cf_filter">Filter</label><input name="cf_filter" id="cf_filter" type="text" onBlur="loadGridCustomFields(0);"/></div>
<div id="gridCustomFields1" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onclick="">Add</a>
</div>
</div>

<h4 onClick="$('#cf_isLoaded').val(1)">Custom Fields</h4>
<div>
<div><label for="cl_fieldname">Field Name</label><input name="cl_fieldname" id="cl_fieldname" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="cl_fieldvalue">Field Value</label><input name="cl_fieldvalue" id="cl_fieldvalue" type="text" /></div>
</div>

<h4>Groups</h4>
<div>
<div><label for="cl_group">Groups</label><select name="cl_group" id="cl_group" multiple="multiple" data-placeholder="Select Some Client Groups."><option value="0">&nbsp;</option><cfoutput query="global_clientgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>



<!--- SERVICES TAB --->
<div id="services" style="display:none;"class="gf-checkbox">
<h3>Services</h3><div></div>
<h4 onClick="_loadData({'id':'cl_id','group':'taxes'});$('#t_isLoaded').val(1)">Taxes</h4>
<div>
<div><input type="checkbox" name="t_taxservices" id="t_taxservices" /><label for="t_taxservices">Tax Services</label></div>
<div><label for="t_formtype">Form Type</label><select name="t_formtype" id="t_formtype" data-placeholder="Select a Company Type."><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" name="t_businessc" id="t_businessc" /><label for="t_businessc">Business (C)</label></div>
<div><input type="checkbox" name="t_rentalpropertye" id="t_rentalpropertye" /><label for="t_rentalpropertye">Rental Property (E)</label></div>
<div><input type="checkbox" name="t_disregardedentity" id="t_disregardedentity" /><label for="t_disregardedentity">Disregarded Entity</label></div>
<div><input type="checkbox" name="t_personalproperty" id="t_personalproperty" /><label for="t_personalproperty">Personal Property</label></div>
</div>

<h4 onClick="_loadData({'id':'cl_id','group':'payroll'});$('#p_isLoaded').val(1)">Payroll</h4>
<div>
<div><input type="checkbox" name="p_payrollpreparation" id="p_payrollpreparation" /><label for="p_payrollpreparation">Payroll Preparation</label></div>
<div><label for="p_paycheckfrequency">Paycheck Frequency</label><select name="p_paycheckfrequency" id="p_paycheckfrequency" data-placeholder="Select a Paycheck Frequency."><option value="0">&nbsp;</option><cfoutput query="q_p_paycheckfrequency"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" name="p_payrollTaxServices" id="p_payrolltaxservices" /><label for="p_payrolltaxservices">Payroll Tax Services</label></div>
<div><label for="p_prtaxdepositschedule">P/R Tax Deposit Schedule</label><select name="p_prtaxdepositschedule" id="p_prtaxdepositschedule" data-placeholder="Select a Tax Deposit Schedule."><option value="0">&nbsp;</option><cfoutput query="q_p_prtaxdepositschedule"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" name="p_1099preparation" id="p_1099preparation" /><label for="p_1099preparation">1099 Payroll Preparation</label></div>
<div><label for="p_ein">EIN</label><input name="p_ein" id="p_ein" type="text"/></div>
<div><label for="p_pin">PIN</label><input name="p_pin" id="p_pin" type="text"/></div>
<div><label for="p_password">Password</label><input name="p_password" id="p_password" type="text"/></div>
</div>

<h4 onClick="_loadData({'id':'cl_id','group':'accounting'});$('#a_isLoaded').val(1)">Accounting</h4>
<div>
<div><input type="checkbox" name="a_accountingServices" id="a_accountingServices" /><label for="a_accountingServices">Accounting Services</label></div>
<div><input type="checkbox" name="a_bookkeeping" id="a_bookkeeping" /><label for="a_bookkeeping">Bookkeeping</label></div>
<div><input type="checkbox" name="a_compilation" id="a_compilation" /><label for="a_compilation">Compilation</label></div>
<div><input type="checkbox" name="a_review" id="a_review" /><label for="a_review">Review</label></div>
<div><input type="checkbox" name="a_audit" id="a_audit" /><label for="a_audit">Audit</label></div>
<div><label for="a_financialstatementfreq">Financial Statement Freq</label><select name="a_financialstatementfreq" id="a_financialstatementfreq" data-placeholder="Select a Financial Statment Freq."><option value="0">&nbsp;</option><cfoutput query="q_a_financialstatementfreq"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="a_fiscalyearend">Fiscal Year End</label><input name="a_fiscalyearend" id="a_fiscalyearend" type="text"/></div>
<div><label for="a_software">Software</label><select name="a_software" id="a_software" data-placeholder="Select a Software"><option value="0">&nbsp;</option><cfoutput query="q_a_software"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="a_version">Version</label><input name="a_version" id="a_version" type="text"/></div>
<div><label for="a_username">User Name</label><input name="a_username" id="a_username" type="text"/></div>
<div><label for="a_accountingpassword">Password</label><input name="a_accountingpassword" id="a_accountingpassword" type="text"/></div>
</div>
</div>

<!--- CONTACTS TAB --->
<div id="contacts" style="display:none;"class="gf-checkbox">

<h3>Saved Contacts</h3>
<div id="loadContacts">
<div><label for="co_filter">Filter</label><input name="co_filter" id="co_filter" onBlur="loadGridContacts(0);"/></div>
<!--- SET GRID CONTACTS --->
<div id="gridContacts1" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onclick="">Add</a>
</div>
</div>

<h4 onClick="$('#co_isLoaded').val(1)">Contacts</h4>
<div id="dataContacts">
<div><label for="co_type">Type</label><select id="co_type"><cfoutput query="q_a_coType"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="co_name">Contact Name</label><input name="co_name" id="co_name" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="co_address1">Street #1</label><input name="co_address1" id="co_address1" type="text"/></div>
<div><label for="co_address2">Street #2</label><input name="co_address2" id="co_address2" type="text"/></div>
<div><label for="co_city">City</label><input name="co_city" id="co_city"type="text" /></div>
<div><label for="co_state">State</label><input name="co_state" id="co_state" type="text"/></div>
<div><label for="co_zip">Zip</label><input type="number" pattern="[0-9]*" maxlength="5" required name="co_zip" id="co_zip" /></div>
<div><label for="co_phone1">Phone 1</label><input  name="co_phone1" id="co_phone1" type="tel"/></div>
<div><label for="co_phone2">Phone 2</label><input  name="co_phone2" id="co_phone2" type="tel"/></div>
<div><label for="co_phone3">Mobile</label><input  name="co_phone3" id="co_phone3" type="tel"/></div>
<div><label for="co_phone4">Pager</label><input  name="co_phone4" id="co_phone4" type="tel"/></div>
<div><label for="co_phone5">Fax</label><input  name="co_phone5" id="co_phone5" type="tel"/></div>
<div><label for="co_email1">Email 1</label><input  name="co_email1" id="co_email1" type="email"/></div>
<div><label for="co_email2">Email 2</label><input  name="co_email2" id="co_email2" type="email"/></div>
<div><label for="co_website">Website</label><input type="url" name="co_website" id="co_website" /></div>
<div><label for="co_effectivedate">Effective Date</label><input type="text" name="co_effectivedate" id="co_effectivedate"/></div>
<div><input type="checkbox" name="co_acctsoftwareupdate" id="co_acctsoftwareupdate" /><label for="co_acctsoftwareupdate">updated in accounting software</label></div>
<div><input type="checkbox" name="co_taxupdate" id="co_taxupdate" /><label for="co_taxupdate">update In tax software</label></div>
<div><input type="checkbox" name="co_customvalue" id="co_customvalue" /><label for="co_customvalue"><input type="text" name="co_customlabel" id="co_customlabel" class="customlabel"/></label></div>
</div>
</div>

<!--- MAINTANCE TAB --->
<div id="maintenance" style="display:none;"class="gf-checkbox">
<h3>Maintenance</h3><div></div>
<!--- ADD TO FINANCIAL STATEMENTS --->
<h4 onclick="$('#m_fs_isLoaded').val(1);">Financial Statements</h4>
<div>
<div><label for="m_fs_year">Year</label><input name="m_fs_year" id="m_fs_year" onblur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="m_fs_periodend">Period End</label><input name="m_fs_periodend" id="m_fs_periodend" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_fs_month">Month</label><select name="m_fs_month" id="m_fs_month" onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>

<!--- GROUP ??? --->

<div><label for="m_fs_subtaskgroup">SubTask Group</label><select name="m_fs_subtaskgroup" id="m_fs_subtaskgroup" data-placeholder="Select a Subtask Group" onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><option value="#optionvalue_id#">#optionname#</option></select></div>
<div><label for="m_fs_historicalfs">Historical Financial Statements</label><select name="m_fs_historicalfs" id="m_fs_historicalfs" onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><option value="#optionvalue_id#">#optionname#</option></select></div>
</div>

<!--- Accounting &amp; Consulting Tasks --->
<h4 onclick="$('#m_mct_isLoaded').val(1);">Accounting &amp; Consulting Tasks</h4>
<div>
<div><!---This does not save anyware it is only for the button to function---><label for="m_mct_group">Group</label><select name="m_mct_group" id="m_mct_group"onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="m_mct_group"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div class="buttonbox"><a onClick="" class="button optional">Duplicate Group</a></div>
<div><label for="m_mct_category">Category</label><select name="m_mct_category" id="m_mct_category"data-placeholder="Select a Category." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_consultingcategory"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_mct_duedate">Due Date</label><input name="m_mct_duedate" id="m_mct_duedate" type="text"onchange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});" onblur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
</div>

<!--- ADD TO PAYROLL CHECKS --->
<h4 onclick="$('#m_pc_isLoaded').val(1);">Payroll Checks</h4>
<div>
<div><label for="m_pc_year">Year</label><input name="m_pc_year" id="m_pc_year" onblur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="m_pc_payenddate">Pay End Date</label><input name="m_pc_payenddate" id="m_pc_payenddate" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_pc_paydate">Pay Date</label><input name="m_pc_paydate" id="m_pc_paydate" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_pc_duedate">Due Date</label><input name="m_pc_duedate" id="m_pc_duedate" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_pc_inforeceived">Info Received</label><input name="m_pc_inforeceived" id="m_pc_inforeceived" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><input type="checkbox" name="m_pc_missinginfo" id="m_pc_missinginfo" /><label for="m_pc_missinginfo">Missing Info</label></div>
</div>

<!--- ADD TO PAYROLL TAXES --->
<h4 onclick="$('#m_pt_isLoaded').val(1);">Payroll Taxes</h4>
<div>
<div><label for="m_pt_year">Year</label><input name="m_pt_year" id="m_pt_year" onblur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="m_pt_month">Month</label><select name="m_pt_month" id="m_pt_month"onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_pt_returntype">Return Type</label><select name="m_pt_returntype" id="m_pt_returntype" data-placeholder="Select a Return Type." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_returntypes"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_pt_lastpaydate">Last Pay Date</label><input name="m_pt_lastpaydate" id="m_pt_lastpaydate" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_pt_duedate">Due Date</label><input name="m_pt_duedate" id="m_pt_duedate" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_pt_inforeceived">Info Received</label><input name="m_pt_inforeceived" id="m_pt_inforeceived" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><input type="checkbox" name="m_pt_missinginfo" id="m_pt_missinginfo" /><label for="m_pt_missinginfo">Missing Info</label></div>
</div>

<!--- ADD TO TAX STATUS LISTING --->
<h4 onclick="$('#m_tsl_isLoaded').val(1);">Tax Status Listing</h4>
<div>
<div><label for="m_tsl_taxyear">Tax Year</label><input name="m_tsl_taxyear" id="m_tsl_taxyear" onblur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="m_tsl_taxform">Tax Form</label><select name="m_tsl_taxform" id="m_tsl_taxform" data-placeholder="Select a Tax Form." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_tsl_inforeceived">Info Received</label><input name="m_tsl_inforeceived" id="m_tsl_inforeceived" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><input type="checkbox" name="m_tsl_missinginfo" id="m_tsl_missinginfo" /><label for="m_tsl_missinginfo">Missing Info</label></div>
</div>

<!--- OTHER FILINGS --->
<h4 onclick="$('#m_of_isLoaded').val(1);">Other Filings</h4>
<div>
<div><label for="m_of_taxyear">Tax Year</label><input name="m_of_taxyear" id="m_of_taxyear" data-placeholder="Select a Tax Year" onblur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="m_of_duedate">Due Date</label><input name="m_of_duedate" id="m_of_duedate" data-placeholder="Select a Due Date." onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="m_of_period">Period</label><select name="m_of_period" id="m_of_period" data-placeholder="Select aPeriod." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_month"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_of_state">State</label><select name="m_of_state" id="m_of_state" data-placeholder="Select a State." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_of_task">Task</label><select name="m_of_task" id="m_of_task" data-placeholder="Select a Task." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><cfoutput query="q_m_of_task"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="m_of_form">Form</label><select name="m_of_form" id="m_of_form" data-placeholder="Select a Form." onBlur="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option'});"><option value="0">&nbsp;</option><option value="#optionvalue_id#">#optionname#</option></select></div>
</div>

</div>
<!--- STATE INFORMATION --->
<div id="state" style="display:none;"class="gf-checkbox">
<h3>Saved State Information</h3>
<div id="loadStateInformation">
<div><label for="co_filter">Filter</label><input name="co_filter" id="co_filter" onBlur="loadGridContacts(0);"/></div>
<!--- SET GRID CONTACTS --->
<div id="gridStateInformation1" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onclick="">Add</a>
</div>
</div>

<h4 onclick="$('#s_isLoaded').val(1);">State Information</h4>
<div>
<div><label for="s_state">Info Received</label><input name="s_state" id="s_state" /></div>
<div><input type="checkbox" name="s_revenue" id="s_revenue" /><label for="s_revenue">Revenue</label></div>
<div><input type="checkbox" name="s_employees" id="s_employees" /><label for="s_employees">Employees</label></div>
<div><input type="checkbox" name="s_property" id="s_property"/><label for="s_property">Property</label></div>
<div><input type="checkbox" name="s_nexus" id="s_nexus" /><label for="s_nexus">NEXUS</label></div>
<div><label for="s_reason">Reason</label><input name="s_reason" id="s_reason" /></div>
<div><input type="checkbox" name="s_registered" id="s_registered" /><label for="s_registered">Registered</label></div>
<div><input type="checkbox" name="s_value1" id="s_value1" /><label for="s_value1" id="s_label1"></label></div>
<div><input type="checkbox" name="s_value2" id="s_value2" /><label for="s_value2" id="s_label2"></label></div>
<div><input type="checkbox" name="s_value3" id="s_value3" /><label for="s_value3" id="s_label3"></label></div>
<div><input type="checkbox" name="s_value4" id="s_value4" /><label for="s_value4" id="s_label4"></label></div>
</div>
<h4 onclick="$('#sl_isLoaded').val(1);_loadData({'id':'cl_id','group':'statelabels'});$('#p_isLoaded').val(1);">State Labels</h4><div>
<div><label for="sl_label1">Label 1</label><input type="text" name="sl_label1" id="sl_label1"/></div>
<div><label for="sl_label2">Label 2</label><input type="text" name="sl_label2" id="sl_label2"/></div>
<div><label for="sl_label3">Label 3</label><input type="text" name="sl_label3" id="sl_label3"/></div>
<div><label for="sl_label4">Label 4</label><input type="text" name="sl_label4" id="sl_label4"/></div>
</div>
</div>
<!--- RELATED CLIENTS TAB --->
<div id="rclients" style="display:none;"class="gf-checkbox">
<h3>Related Clients</h3>
<div></div>
</div>
<!--- UPLOAD FILES TAB --->
<div id="upload" style="display:none;"class="gf-checkbox">
<h3>Upload Files</h3>
<div>
<cfinclude template="../assets/module/fileUpload/upload.cfm">
</div>
</div>


</div>
</div>
<footer>
<div class="buttonbox">
<cfoutput>
<a href="##" onclick="saveData();" class="button">Save</a> | <a href="##" onClick='jqMessage({message: "Warning: Do you wish to quit without saving? ",type: "warning",autoClose: true,duration: 5});'>Cancel</a>
</cfoutput>
</div>

<div><div id="progressbar"></div></div>
</footer>


</body>
</html>