<!--- Required for AJAX --->
<cfset page.module="_clientmanagement">
<cfset page.location="communications">
<cfset page.formid=12>
<cfset page.title="Client Communications">
<cfset page.menuLeft="General">
<cfset page.trackers="task_id">
<cfset page.footer="1">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="/assets/inc/header.cfm">
<cfif URL.task_id gt 0>
<cfoutput>
<script>
$(document).ready(function(){
$('##task_id').val('#URL.task_id#');
_toggle("group1,largeMenu");
_hide("entrance");$("##content").removeClass();
$("##content").addClass("contentbig");
_loadData({"id":"task_id","group":"group1","page":"#page.location#"});
})
</script>
</cfoutput>
</cfif>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="global_status">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_status'</cfquery>
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
<cfquery dbtype="query" name="global_delivery">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_delivery'</cfquery>
<cfquery dbtype="query" name="global_comcontactmethods">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_comcontactmethods'</cfquery>
<body>
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>
<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="_run.new_group1();">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<h3>General</h3>
<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
	<div><label for="client_id"><i class="fa fa-lock link" onClick="_schk('client_id')"></i> Client</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadAssets();"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_credithold"><input id="g1_credithold" type="checkbox" class="ios-switchb" disabled="disabled">Credit Hold</label></div>
	<div><label for="g1_date"><i class="fa fa-lock link" onClick="_schk('g1_date')"></i> Date and Time</label><input type="text" class="datetime" id="g1_date"></div>
	<div><label for="g1_caller"><i class="fa fa-lock link" onClick="_schk('g1_caller')"></i> Caller</label><input type="text" id="g1_caller" maxlength="40" ></div>
	<div><label for="g1_takenby"><i class="fa fa-lock link" onClick="_schk('g1_takenby')"></i> Taken By</label><select id="g1_takenby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_contactmethod"><i class="fa fa-lock link" onClick="_schk('g1_contactmethod')"></i> Contact Methods</label><select id="g1_contactmethod" multiple="multiple"><option value="0">&nbsp;</option><cfoutput query="global_comcontactmethods"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_briefmessage"><i class="fa fa-lock link" onClick="_schk('g1_briefmessage')"></i> Brief Message</label><textarea type="text" id="g1_briefmessage" cols="4" rows="4"  maxlength="1000"></textarea></div>
	<div><label for="g1_status">Status</label><select id="g1_status"><option value="0">&nbsp;</option><cfoutput query="global_status"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_telephone">Telephone</label><input type="text" id="g1_telephone" maxlength="13" type="tel" class="phone"   onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});"></div>
	<div><label for="g1_ext">Ext</label><input type="text" id="g1_ext" maxlength="5"></div>
	<div><label for="g1_faxnumber">Fax Number</label><input type="text" maxlength="13" id="g1_faxnumber" type="tel" class="phone"   onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});"></div>
	<div><label for="g1_emailaddress">Email</label><input type="text" maxlength="50" id="g1_emailaddress"></div>
  	<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
    <div><label for="g1_for">For</label><select id="g1_for"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g1_responseneeded"><input id="g1_responseneeded" type="checkbox" class="ios-switch">Response Needed</label></div>
    <div><label for="g1_returnedcall"><input id="g1_returnedcall" type="checkbox" class="ios-switch">Returned Call</label></div>
    <div><label for="g1_fees">Fees</label><input type="text" id="g1_fees" maxlength="10" class="valid_off" placeholder="0" onblur="jqValid({'type':'numeric','object':this,'message':'This field must be a number.'});"></div>
	<div><label for="g1_paid">Payment Status</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g1_deliverymethod">Delivery Method</label><select id="g1_deliverymethod"><option value="0">&nbsp;</option><cfoutput query="global_delivery"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
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