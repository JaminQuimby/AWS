<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_clientmanagement">
<cfset page.location="clientmaintenance">
<cfset page.formid=1>
<cfset page.title="Client Maintenance">
<cfset page.menuLeft="Client,Services,Contacts,Maintenance,Activity,State Information,Related Clients">
<cfset page.trackers="task_id,client_id,co_id,si_id,fds_id,mc_id,pc_id,pt_id,tr_id,of_id,cl_fieldid,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3,isLoaded_group3,isLoaded_group6,isLoaded_group6_1,isLoaded_group7,isLoaded_group8">
<!DOCTYPE html> 
<html>
<cfinclude template="../assets/inc/header.cfm">
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_otherfilingtype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_otherfilingtype'</cfquery>
<cfquery dbtype="query" name="global_businesstype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_businesstype'</cfquery>
<cfquery dbtype="query" name="global_timespans">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_timespans'</cfquery>
<cfquery dbtype="query" name="global_software">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_software'</cfquery>
<cfquery dbtype="query" name="global_contacttype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_contacttype'</cfquery>
<cfquery dbtype="query" name="global_consultingcategory">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_consultingcategory'</cfquery>
<cfquery dbtype="query" name="global_clientgroup">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_clientgroup'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<!--- Load Labels --->
<!---Page Start--->
<!--- THINGS TO DO

ACTIVITY (CLIENT DATA)

--->


<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3,group4,group5,group6,group7,group8');">Add</a>
</div></div></div>

<!---Group 1 --->
<div id="group1" class="gf-checkbox">
<h3>Client</h3>
<div>
<div><label for="g1_name">Client Name</label><input id="g1_name" type="text" class="valid_off" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_spouse">Spouse</label><input id="g1_spouse" type="text"/></div>
<div><label for="g1_salutation">Salutation</label><input id="g1_salutation" type="text" class="valid_off" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_type">Type</label><select id="g1_type" type="text"  data-placeholder="Choose type of client..." onChange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select a field'});"><option value="0">&nbsp;</option><cfoutput query="global_businesstype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_since">Client Since</label><input id="g1_since" type="text" class="valid_off date" onChange="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});" onBlur="jqValid({'type':'date','object':this,'message':'Date format should be MM/DD/YYYY'});"/></div>
<div><label for="g1_trade_name">Trade Name</label><input id="g1_trade_name" type="text" /></div>
<div><label for="g1_referred_by">Referred By</label><input id="g1_referred_by"  type="text"/></div>
<div><input id="g1_active"  type="checkbox" /><label for="g1_active">Active</label></div>
<div><input id="g1_credit_hold"  type="checkbox" /><label for="g1_credit_hold">Credit Hold</label></div>
<div><label for="g1_notes">Notes</label><textarea id="g1_notes" cols="4" rows="4" ></textarea></div>
</div>

<!---Group 1 Sub 1--->
<h4 onClick="_grid1_1();">Saved Custom Fields</h4>
<div>
<div><label for="g1_g1_filter">Filter</label><input id="g1_g1_filter" onBlur="_grid1_1();" onKeyPress="if(event.keyCode==13){_grid1_1();}"/></div>
<div id="grid1_1" class="tblGrid"></div>
<a href="#" class="button optional" onClick='$("#group1").accordion({active:2});$("#isLoaded_group1_2").val(1);'>Add</a>
</div>

<!---Group 1 Sub 2--->
<h4 onClick="$('#isLoaded_group1_2').val(1)">Custom Fields</h4>
<div>
<div><label for="g1_g2_fieldname">Field Name</label><input id="g1_g2_fieldname" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_g2_fieldvalue">Field Value</label><input id="g1_g2_fieldvalue" type="text" /></div>
</div>

<!---Group 1 Sub 3--->
<h4 onClick="$('#isLoaded_group1_3').val(1)">Groups</h4>
<div>
<div><label for="g1_g3_group">Groups</label><select id="g1_g3_group" multiple="multiple" data-placeholder="Select Some Client Groups."><option value="0">&nbsp;</option><cfoutput query="global_clientgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>

</div>

<!--- Group 2 --->
<div id="group2" class="gf-checkbox">
<h3>Services</h3><div></div>

<!---Group 2 Sub 1--->
<h4 onClick='_loadData({"id":"client_id","group":"group2_1","page":"clientmaintenance"});$("#isLoaded_group2_1").val(1);'>Taxes</h4>
<div>
<div><input type="checkbox" id="g2_g1_taxservices" /><label for="g2_g1_taxservices">Tax Services</label></div>
<div><label for="g2_g1_formtype">Form Type</label><select id="g2_g1_formtype" data-placeholder="Select a Company Type."><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" id="g2_g1_businessc" /><label for="g2_g1_businessc">Business (C)</label></div>
<div><input type="checkbox" id="g2_g1_rentalpropertye" /><label for="g2_g1_rentalpropertye">Rental Property (E)</label></div>
<div><input type="checkbox" id="g2_g1_disregardedentity" /><label for="g2_g1_disregardedentity">Disregarded Entity</label></div>
<div><input type="checkbox" id="g2_g1_personalproperty" /><label for="g2_g1_personalproperty">Personal Property</label></div>
</div>

<!---Group 2 Sub 2--->
<h4 onClick='_loadData({"id":"client_id","group":"group2_2","page":"clientmaintenance"});$("#isLoaded_group2_2").val(1);'>Payroll</h4>
<div>
<div><input type="checkbox" id="g2_g2_payrollpreparation" /><label for="g2_g2_payrollpreparation">Payroll Preparation</label></div>
<div><label for="g2_g2_paycheckfrequency">Paycheck Frequency</label><select id="g2_g2_paycheckfrequency" data-placeholder="Select a Paycheck Frequency."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" id="g2_g2_payrolltaxservices" /><label for="g2_g2_payrolltaxservices">Payroll Tax Services</label></div>
<div><label for="g2_g2_prtaxdepositschedule">P/R Tax Deposit Schedule</label><select id="g2_g2_prtaxdepositschedule" data-placeholder="Select a Tax Deposit Schedule."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" id="g2_g2_1099preparation" /><label for="g2_g2_1099preparation">1099 Payroll Preparation</label></div>
<div><label for="g2_g2_ein">EIN</label><input id="g2_g2_ein" type="text"/></div>
<div><label for="g2_g2_pin">PIN</label><input id="g2_g2_pin" type="text"/></div>
<div><label for="g2_g2_password">Password</label><input id="g2_g2_password" type="text"/></div>
</div>

<!---Group 2 Sub 3--->
<h4 onClick='_loadData({"id":"client_id","group":"group2_3","page":"clientmaintenance"});$("#isLoaded_group2_3").val(1);'>Accounting</h4>
<div>
<div><input type="checkbox" id="g2_g3_accountingServices" /><label for="g2_g3_accountingServices">Accounting Services</label></div>
<div><input type="checkbox" id="g2_g3_bookkeeping" /><label for="g2_g3_bookkeeping">Bookkeeping</label></div>
<div><input type="checkbox" id="g2_g3_compilation" /><label for="g2_g3_compilation">Compilation</label></div>
<div><input type="checkbox" id="g2_g3_review" /><label for="g2_g3_review">Review</label></div>
<div><input type="checkbox" id="g2_g3_audit" /><label for="g2_g3_audit">Audit</label></div>
<div><label for="g2_g3_financialstatementfreq">Financial Statement Freq</label><select id="g2_g3_financialstatementfreq" data-placeholder="Select a Financial Statment Freq."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_fiscalyearend">Fiscal Year End</label><input id="g2_g3_fiscalyearend" type="text" class="date"/></div>
<div><label for="g2_g3_software">Software</label><select id="g2_g3_software" data-placeholder="Select a Software"><option value="0">&nbsp;</option><cfoutput query="global_software"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_version">Version</label><input id="g2_g3_version" type="text"/></div>
<div><label for="g2_g3_username">User Name</label><input id="g2_g3_username" type="text"/></div>
<div><label for="g2_g3_accountingpassword">Password</label><input id="g2_g3_accountingpassword" type="text"/></div>
</div>
</div>

<!--- GROUP 3 --->
<div id="group3" class="gf-checkbox">
<h3 onClick="_grid3();">Saved Contacts</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();" onKeyPress="if(event.keyCode==13){_grid3();}"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group3").accordion({active:1});$("#isLoaded_group3").val(1);'>Add</a>
</div>
</div>
<h4 onclick="_group3();">Contact</h4>
<div>
<div><label for="g3_type">Type</label><select id="g3_type"><option value="0">&nbsp;</option><cfoutput query="global_contacttype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_name">Contact Name</label><input id="g3_name" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g3_address1">Street #1</label><input id="g3_address1" type="text"/></div>
<div><label for="g3_address2">Street #2</label><input id="g3_address2" type="text"/></div>
<div><label for="g3_city">City</label><input id="g3_city" type="text" /></div>
<div><label for="g3_state">State</label><select id="g3_state"><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_zip">Zip</label><input type="number" pattern="[0-9]*" maxlength="5" required id="g3_zip" /></div>
<div><label for="g3_phone1">Phone 1</label><input id="g3_phone1" type="tel"/></div>
<div><label for="g3_phone2">Phone 2</label><input id="g3_phone2" type="tel"/></div>
<div><label for="g3_phone3">Mobile</label><input id="g3_phone3" type="tel"/></div>
<div><label for="g3_phone4">Pager</label><input id="g3_phone4" type="tel"/></div>
<div><label for="g3_phone5">Fax</label><input id="g3_phone5" type="tel"/></div>
<div><label for="g3_email1">Email 1</label><input id="g3_email1" type="email"/></div>
<div><label for="g3_email2">Email 2</label><input id="g3_email2" type="email"/></div>
<div><label for="g3_website">Website</label><input type="url" id="g3_website" /></div>
<div><label for="g3_effectivedate">Effective Date</label><input type="text" id="g3_effectivedate" class="date"/></div>
<div><input type="checkbox" id="g3_acctsoftwareupdate" /><label for="g3_acctsoftwareupdate">Updated in accounting software</label></div>
<div><input type="checkbox" id="g3_taxupdate" /><label for="g3_taxupdate">Update in tax software</label></div>
<div><input type="checkbox" id="g3_customvalue" /><label for="g3_customvalue"><input type="text" id="g3_customlabel" class="customlabel"/></label></div>
</div>
</div>

<!--- Group 4 --->
<div id="group4" class="gf-checkbox">
<h3>Maintenance</h3><div></div>



<!--- GROUP 4 SUB 1 ADD TO FINANCIAL STATEMENTS --->
<h4 onClick='_grid4_1();'>Financial Statements</h4>
<div>
<div class="tblGrid" id="grid4_1"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 4 SUB 2 Accounting &amp; Consulting Tasks --->
<h4  onClick='_grid4_2();'>Accounting &amp; Consulting Tasks</h4>
<div>
<div class="tblGrid" id="grid4_2"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/acctingconsulting.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 4 SUB 3 ADD TO PAYROLL CHECKS --->
<h4 onClick='_grid4_3();'>Payroll Checks</h4>
<div>
<div class="tblGrid" id="grid4_3"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/payrollchecks.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 4 SUB 4 ADD TO PAYROLL TAXES --->
<h4 onClick='_grid4_4();'>Payroll Taxes</h4>
<div>
<div class="tblGrid" id="grid4_4"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/payrolltaxes.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 4 SUB 5 ADD TO TAX STATUS LISTING --->
<h4 onClick='_grid4_5();'>Tax Status Listing</h4>
<div>
<div class="tblGrid" id="grid4_5"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 4 SUB 6 OTHER FILINGS --->
<h4 onClick='_grid4_6();'>Other Filings</h4>
<div>
<div class="tblGrid" id="grid4_6"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/payrollOtherFilingsRequirements.cfm'">Add</a></cfoutput>
</div>
</div>
</div>
<!--- GROUP 5--->
<div id="group5" class="gf-checkbox">
</div>


<!--- GROUP 6--->
<div id="group6" class="gf-checkbox">
<h3 onClick="_grid6();">Saved State Information</h3>
<div>
<div><label for="g6_filter">Filter</label><input id="g6_filter" onBlur="_grid6();" onKeyPress="if(event.keyCode==13){_grid6();}"/></div>
<div class="tblGrid" id="grid6"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group6").accordion({active:1});$("#isLoaded_group6").val(1);'>Add</a>
</div>
</div>
<h4 onclick="_group6();">State Information</h4>
<div>
<div><label for="g6_state">State</label><select id="g6_state" data-placeholder="Select a State."><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input type="checkbox" id="g6_revenue" /><label for="g6_revenue">Revenue</label></div>
<div><input type="checkbox" id="g6_employees" /><label for="g6_employees">Employees</label></div>
<div><input type="checkbox" id="g6_property"/><label for="g6_property">Property</label></div>
<div><input type="checkbox" id="g6_nexus" /><label for="g6_nexus">NEXUS</label></div>
<div><label for="g6_reason">Reason</label><input id="g6_reason" /></div>
<div><input type="checkbox" id="g6_registered" /><label for="g6_registered">Registered</label></div>
<div><input type="checkbox" id="g6_value1" /><label for="g6_value1" id="g6_label1"></label></div>
<div><input type="checkbox" id="g6_value2" /><label for="g6_value2" id="g6_label2"></label></div>
<div><input type="checkbox" id="g6_value3" /><label for="g6_value3" id="g6_label3"></label></div>
<div><input type="checkbox" id="g6_value4" /><label for="g6_value4" id="g6_label4"></label></div>
</div>

<h4 onclick="_group6();">State Labels</h4>
<div>
<div><label for="g6_g1_label1">Label 1</label><input type="text" id="g6_g1_label1"/></div>
<div><label for="g6_g1_label2">Label 2</label><input type="text" id="g6_g1_label2"/></div>
<div><label for="g6_g1_label3">Label 3</label><input type="text" id="g6_g1_label3"/></div>
<div><label for="g6_g1_label4">Label 4</label><input type="text" id="g6_g1_label4"/></div>
</div>
</div>


<!--- GROUP 7 --->
<div id="group7" class="gf-checkbox" >

<h3 onClick="_group7()">Related Client Details</h3>
<div>
<div><label for="g7_filter">Filter</label><input id="g7_filter" onBlur="_grid7();"  onKeyPress="if(event.keyCode==13){_grid7();}"/></div>
<!--- SET GRID CONTACTS --->
<div id="grid7" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group7").accordion({active:1});$("#isLoaded_group7").val(1);'>Add</a>
</div>
</div>


<h4 onclick="_group7_1();">Related Clients</h4>
<div>
<div><label for="g7_group">Groups</label><select id="g7_group" multiple="multiple" data-placeholder="Select Some Client Groups."><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>


<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">

</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>