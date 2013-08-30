<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_clientmanagement">
<cfset page.location="clientcommunications">
<cfset page.formid=12>
<cfset page.title="Client Communications">
<cfset page.menuLeft="General,Comment">
<cfset page.trackers="co_id,comment_isLoaded,comment_id">

<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<!--- Load Select Options for each dropdown--->
<cfquery dbtype="query" name="q_global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>

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


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2');">Add</a>
</div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">

<h3>General</h3>
<div>
<div><label for="client_id">Client</label><select id="client_id"  onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'});_loadData({'id':'client_id','group':'assetSpouse','page':'clientcommunications'});"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_spouse">Spouse</label><input type="text" id="g1_spouse" class="readonly" readonly="readonly" ></div>
<div><label for="g1_date">Date</label><input type="text" class="time" id="g1_date"></div>
<div><label for="g1_takenby">Taken By</label><select id="g1_takenby"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_for">For</label><select id="g1_for"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><input id="g1_credithold" type="checkbox"><label for="g1_credithold">Credit Hold</label></div>
<div><label for="g1_caller">Caller</label><input type="text" id="g1_caller" ></div>
<div><label for="g1_duedate">Due Date</label><input type="text" class="date" id="g1_duedate"></div>
<div><label for="g1_telephone">Telephone</label><input type="text" id="g1_telephone"></div>
<div><label for="g1_ext">Ext</label><input type="text" id="g1_ext"></div>
<div><label for="g1_faxnumber">Fax Number</label><input type="text" id="g1_faxnumber"></div>
<div><label for="g1_emailaddress">Email</label><input type="text" id="g1_emailaddress"></div>
<div><input id="g1_voicemail" type="checkbox"><label for="g1_voicemail">Voice Mail</label></div>
<div><input id="g1_personalcontact" type="checkbox"><label for="g1_personalcontact">Personal Contact</label></div>
<div><input id="g1_textmessage" type="checkbox"><label for="g1_textmessage">Text Message</label></div>
<div><input id="g1_email" type="checkbox"><label for="g1_email">Email</label></div>
<div><input id="g1_mail" type="checkbox"><label for="g1_mail">Mail</label></div>
<div><input id="g1_fax" type="checkbox"><label for="g1_fax">Fax</label></div>
<div><label for="g1_briefmessage">Brief Message</label><input type="text" id="g1_briefmessage" ></div>
<div><input id="g1_responsenotneeded" type="checkbox"><label for="g1_responsenotneeded">Response Not Needed</label></div>
<div><input id="g1_returnedcall" type="checkbox"><label for="g1_returnedcall">Returned Call</label></div>
<div><input id="g1_completed" type="checkbox"><label for="g1_completed">Completed</label></div>
<div><label for="g1_fees">Fees</label><input type="text" id="g1_fees"></div>
<div><label for="g1_paid">Paid</label><select id="g1_paid"><option value="0">&nbsp;</option><cfoutput query="q_global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>

<!--- Comments --->
<div id="group2" class="gf-checkbox">
<h3>Comments</h3>
<div>
<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();"/></div>
<div class="tblGrid" id="grid2"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group2").accordion({active:1});$("#comment_isLoaded").val(1);'>Add</a>
</div>
</div>
<h4>Add Comment</h4>
<div>
<div><label for="g2_commentdate">Date</label><input type="text" class="date" id="g2_commentdate"/></div>
<div><label for="g2_commenttext">Comment</label><textarea type="text" id="g2_commenttext"></textarea></div>
</div>
</div>



<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>