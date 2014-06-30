<!--- Required for AJAX --->
<cfset page.module="_clientmanagement">
<cfset page.location="clientmaintenance">
<cfset page.formid=1>
<cfset page.title="Client Maintenance">
<cfset page.menuLeft="Client,Services,Contacts,Task Management,State Information,Related Clients">
<cfset page.trackers="task_id,client_id,co_id,si_id,fds_id,mc_id,pc_id,pt_id,tr_id,of_id,cl_fieldid,isLoaded_group1_2,isLoaded_group1_3,isLoaded_group2_1,isLoaded_group2_2,isLoaded_group2_3,isLoaded_group3,isLoaded_group5,isLoaded_group5_1,isLoaded_group6">
<cfset page.plugins.disable="102">
<cfset page.footer="1">
<!DOCTYPE html> 
<html>
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
<cfquery dbtype="query" name="global_month">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_month'</cfquery>
<cfquery dbtype="query" name="global_state">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_stateabbreviation">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_state'</cfquery>
<cfquery dbtype="query" name="global_taxservices">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_taxservices'</cfquery>
<cfquery dbtype="query" name="global_otherfilingtype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_otherfilingtype'</cfquery>
<cfquery dbtype="query" name="global_clienttype">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_clienttype'</cfquery>
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

<script type="text/javascript">

//----------------------------------------------------------------------------
//
//  $Id: TextMarkup.js 16224 2011-10-03 21:29:50Z vbuzuev $ 
//
// Project -------------------------------------------------------------------
//
//  DYMO Label Framework
//
// Content -------------------------------------------------------------------
//
//  DYMO Label Framework JavaScript Library Samples: QR-code
//
//----------------------------------------------------------------------------
//
//  Copyright (c), 2011, Sanford, L.P. All Rights Reserved.
//
//----------------------------------------------------------------------------


(function()
{
    // stores loaded label info
    var barcodeLabel;
    var barcodeAsImageLabel;


    // called when the document completly loaded
    function onload()
    {
        var printersSelect = document.getElementById('printersSelect');
        var printButton = document.getElementById('printButton');
        var printAsImageButton = ''//document.getElementById('printAsImageButton');
        var printAsImageCanvasButton = ''//document.getElementById('printAsImageCanvasButton');
        var printAsImageCanvas2Button = ''//document.getElementById('printAsImageCanvas2Button');
        
        
        // loads all supported printers into a combo box 
        function loadPrinters()
        {
            var printers = dymo.label.framework.getLabelWriterPrinters();
            if (printers.length == 0)
            {
               // alert("No DYMO printers are installed. Install DYMO printers.");
			   $("#printersSelect").hide()
			   $("#printAsImageCanvas2Button").hide()
                return;
            }

            for (var i = 0; i < printers.length; i++)
            {
                var printer = printers[i];

                var printerName = printer.name;

                var option = document.createElement('option');
                option.value = printerName;
                option.appendChild(document.createTextNode(printerName));
                printersSelect.appendChild(option);
				$("#printersSelect").trigger("chosen:updated");
            }
        }



        printButton.onclick = function()
        {
            try
            {
                if (!barcodeLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                barcodeLabel.setObjectText('Barcode', 'http://developers.dymo.com');

                barcodeLabel.print(printersSelect.value);
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        printAsImageButton.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                $.get("qr.base64", function(qr)
                {
                    try
                    {
                        barcodeAsImageLabel.setObjectText('Image', qr);

                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                }, "text");
                

            }
            catch(e)
            {
                alert(e.message || e);
            }
        }


        printAsImageCanvasButton.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                var img = new Image();
                img.onload = function()
                {
                    try
                    {
                        var canvas = document.createElement('canvas');
                        canvas.width = img.width;                     
                        canvas.height = img.height;

                        var context = canvas.getContext('2d');
                        context.drawImage(img, 0, 0);

                        var dataUrl = canvas.toDataURL('image/png');
                        var pngBase64 = dataUrl.substr('data:image/png;base64,'.length);

                        barcodeAsImageLabel.setObjectText('Image', pngBase64);
                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                };
                img.onerror = function()
                {
                    alert('Unable to load "qr.png"');                    
                };
                img.src = 'qr.png';
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        printAsImageCanvas2Button.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                var img = new Image();
                img.crossOrigin = 'anonymous';
                img.onload = function()
                {
                    try
                    {
                        var canvas = document.createElement('canvas');
                        canvas.width = img.width;                     
                        canvas.height = img.height;

                        var context = canvas.getContext('2d');
                        context.drawImage(img, 0, 0);

                        var dataUrl = canvas.toDataURL('image/png');
                        var pngBase64 = dataUrl.substr('data:image/png;base64,'.length);

                        barcodeAsImageLabel.setObjectText('Image', pngBase64);
                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                };
                img.onerror = function()
                {
                    alert('Unable to load qr-code image');                    
                };
                img.src = 'https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=http%3A//developers.dymo.com&choe=UTF-8';
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        function loadLabelFromWeb()
        {                     
            // use jQuery API to load labels

            $.get("Barcode.label", function(labelXml)
           {
                barcodeLabel =  dymo.label.framework.openLabelXml(labelXml);
            }, "text");

            $.get("BarcodeAsImage.label", function(labelXml)
           {
               barcodeAsImageLabel =  dymo.label.framework.openLabelXml(labelXml);
            }, "text");
        }
        
        loadLabelFromWeb();

        // load printers list on startup
        loadPrinters();
    };

    // register onload event
    if (window.addEventListener)
        window.addEventListener("load", onload, false);
    else if (window.attachEvent)
        window.attachEvent("onload", onload);
    else
        window.onload = onload;

} ());

</script>
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
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_run.load_group1();" onKeyPress="if(event.keyCode==13){_run.load_group1();}"/></div>
<!--- Entrace Grid --->
<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick="_run.new_group1()">Add</a></cfif>
</div></div></div>

<!---Group 1 --->
<div id="group1" class="gf-checkbox">
<h3>Client</h3>
<div>
<div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
<div><label for="g1_name"><i class="fa fa-lock link" ></i> Client Name</label><input id="g1_name" type="text" onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});" /></div>
<div><label for="g1_spouse">Spouse</label><input id="g1_spouse" maxlength="40" type="text"/></div>
<div><label for="g1_salutation"><i class="fa fa-lock link" ></i> Salutation</label><input id="g1_salutation" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_type"><i class="fa fa-lock link" ></i> Type</label><select id="g1_type" type="text"  data-placeholder="Choose type of client..."  onChange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select a field'});"><option value="0">&nbsp;</option><cfoutput query="global_clienttype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g1_since"><i class="fa fa-lock link" ></i> Client Since</label><input id="g1_since" type="text" class="valid_off date"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_trade_name">Trade Name</label><input id="g1_trade_name" maxlength="100" type="text" /></div>
<div><label for="g1_referred_by">Referred By</label><input id="g1_referred_by" maxlength="40" type="text"/></div>
<div><label for="g1_active"><input id="g1_active" type="checkbox" class="ios-switch">Active</label></div>
<div><label for="g1_credit_hold"><input id="g1_credit_hold" type="checkbox" class="ios-switchb">Credit Hold</label></div>
<div><label for="g1_notes">Notes</label><textarea id="g1_notes" cols="4" rows="4" ></textarea></div>
</div>

<!---Group 1 Sub 1--->
<h4 onClick="_run.load_group1_1();">Saved Custom Fields</h4>
<div>
<div><label for="g1_g1_filter">Filter</label><input id="g1_g1_filter" onBlur="_run.load_group1_1();" onKeyPress="if(event.keyCode==13){_run.load_group1_1();}"/></div>
<div id="grid1_1" class="tblGrid"></div>
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group1_1();'>Add</a></cfif>
</div>

<!---Group 1 Sub 2--->
<h4 onClick="_run.load_group1_2();">Custom Fields</h4>
<div>
<div><label for="g1_g2_fieldname">Field Name</label><input id="g1_g2_fieldname" maxlength="100" type="text" class="valid_off"  onBlur="jqValid({'type':'empty','object':this,'message':'Cannot be empty.'});"/></div>
<div><label for="g1_g2_fieldvalue">Field Value</label><input id="g1_g2_fieldvalue" maxlength="100" type="text" /></div>
<div><label for="g1_g2_fieldglobal"><input id="g1_g2_fieldglobal" type="checkbox" class="ios-switch">Global</label></div>
</div>

<!---Group 1 Sub 3--->
<h4 onClick="_run.load_group1_3();">Groups</h4>
<div>
<div><label for="g1_g3_group">Groups</label><select id="g1_g3_group" multiple="multiple" data-placeholder="Select Some Client Groups."><option value="0">&nbsp;</option><cfoutput query="global_clientgroup"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>

<!--- Group 2 --->
<div id="group2" class="gf-checkbox">
<h3>Services</h3><div></div>

<!---Group 2 Sub 1--->
<h4 onClick='_run.load_group2_1();'>Taxes</h4>
<div>
<div><label for="g2_g1_taxservices"><input id="g2_g1_taxservices" type="checkbox" class="ios-switch">Tax Services</label></div>
<div><label for="g2_g1_formtype">Form Type</label><select id="g2_g1_formtype" data-placeholder="Select a Company Type."><option value="0">&nbsp;</option><cfoutput query="global_taxservices"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g1_businessc"><input id="g2_g1_businessc" type="checkbox" class="ios-switch">Business (C)</label></div>
<div><label for="g2_g1_rentalpropertye"><input id="g2_g1_rentalpropertye" type="checkbox" class="ios-switch">Rental Property (E)</label></div>
<div><label for="g2_g1_disregardedentity"><input id="g2_g1_disregardedentity" type="checkbox" class="ios-switch">Disregarded Entity</label></div>
<div><label for="g2_g1_personalproperty"><input id="g2_g1_personalproperty" type="checkbox" class="ios-switch">Personal Property</label></div>
</div>

<!---Group 2 Sub 2--->
<h4 onClick='_run.load_group2_2();'>Payroll</h4>
<div>
<div><label for="g2_g2_payrollpreparation"><input id="g2_g2_payrollpreparation" type="checkbox" class="ios-switch">Payroll Preparation</label></div>
<div><label for="g2_g2_paycheckfrequency">Paycheck Frequency</label><select id="g2_g2_paycheckfrequency" data-placeholder="Select a Paycheck Frequency."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g2_payrolltaxservices"><input id="g2_g2_payrolltaxservices" type="checkbox" class="ios-switch">Payroll Tax Services</label></div>
<div><label for="g2_g2_prtaxdepositschedule">P/R Tax Deposit Schedule</label><select id="g2_g2_prtaxdepositschedule" data-placeholder="Select a Tax Deposit Schedule."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g2_1099preparation"><input id="g2_g2_1099preparation" type="checkbox" class="ios-switch">1099 Payroll Preparation</label></div>
<div><label for="g2_g2_ein">EIN</label><input id="g2_g2_ein" maxlength="30" type="text"/></div>
<div><label for="g2_g2_pin">PIN</label><input id="g2_g2_pin" maxlength="30" type="text"/></div>
<div><label for="g2_g2_password">Password</label><input id="g2_g2_password" maxlength="30" type="text"/></div>
</div>

<!---Group 2 Sub 3--->
<h4 onClick='_run.load_group2_3();'>Accounting</h4>
<div>
<div><label for="g2_g3_accountingServices"><input id="g2_g3_accountingServices" type="checkbox" class="ios-switch">Accounting Services</label></div>
<div><label for="g2_g3_bookkeeping"><input id="g2_g3_bookkeeping" type="checkbox" class="ios-switch">Bookkeeping</label></div>
<div><label for="g2_g3_compilation"><input id="g2_g3_compilation" type="checkbox" class="ios-switch">Compilation</label></div>
<div><label for="g2_g3_review"><input id="g2_g3_review" type="checkbox" class="ios-switch">Review</label></div>
<div><label for="g2_g3_audit"><input id="g2_g3_audit" type="checkbox" class="ios-switch">Audit</label></div>
<div><label for="g2_g3_financialstatementfreq">Financial Statement Freq</label><select id="g2_g3_financialstatementfreq" data-placeholder="Select a Financial Statment Freq."><option value="0">&nbsp;</option><cfoutput query="global_timespans"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_fiscalyearend">Fiscal Year End</label><input id="g2_g3_fiscalyearend" type="text" class="date"/></div>
<div><label for="g2_g3_software">Software</label><select id="g2_g3_software" data-placeholder="Select a Software"><option value="0">&nbsp;</option><cfoutput query="global_software"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g2_g3_version">Version</label><input id="g2_g3_version" maxlength="30" type="text"/></div>
<div><label for="g2_g3_username">User Name</label><input id="g2_g3_username" maxlength="30" type="text"/></div>
<div><label for="g2_g3_accountingpassword">Password</label><input id="g2_g3_accountingpassword" maxlength="30" type="text"/></div>
</div>
</div>

<!--- GROUP 3 --->
<div id="group3" class="gf-checkbox">
<h3 onClick="_run.load_group3();">Saved Contacts</h3>
<div>
<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_run.load_group3();" onKeyPress="if(event.keyCode==13){_run.load_group3();}"/></div>
<div class="tblGrid" id="grid3"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group3()'>Add</a></cfif>
</div>
</div>
<h4 onclick="_run.load_group3();">Contact</h4>
<div>
<div><label for="printersSelect">Dymo</label><select id="printersSelect"></select></div><button id="printButton">Print</button>
<div><label for="g3_type">Type</label><select id="g3_type"><option value="0">&nbsp;</option><cfoutput query="global_contacttype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_name">Contact Name</label><input id="g3_name" type="text" /></div>
<div><label for="g3_title">Title</label><input id="g3_title" type="text"/></div>
<div><label for="g3_address1">Street #1</label><input id="g3_address1" maxlength="50" type="text"/></div>
<div><label for="g3_address2">Street #2</label><input id="g3_address2" maxlength="50" type="text"/></div>
<div><label for="g3_city">City</label><input id="g3_city" maxlength="25" type="text" /></div>
<div><label for="g3_state">State</label><select id="g3_state"><option value="0">&nbsp;</option><cfoutput query="global_stateabbreviation"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g3_zip">Zip</label><input type="number" pattern="[0-9]*" maxlength="10" required id="g3_zip" /></div>
<div><label for="g3_phone1">Primary Phone Number</label><input id="g3_phone1" type="tel" maxlength="14" class="phone"   onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});" /></div>
<div><label for="g3_ext1">Ext 1</label><input type="text" id="g3_ext1" maxlength="5"></div>
<div><label for="g3_phone2">Secondary Phone</label><input id="g3_phone2" type="tel" maxlength="14" class="phone"   onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});" /></div>
<div><label for="g3_ext2">Ext 2</label><input type="text" id="g3_ext2" maxlength="5"></div>
<div><label for="g3_phone3">Mobile</label><input id="g3_phone3" type="tel" maxlength="14" class="phone"    onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});" /></div>
<div><label for="g3_phone4">Pager</label><input id="g3_phone4" type="tel" maxlength="14" class="phone"     onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});" /></div>
<div><label for="g3_phone5">Fax</label><input id="g3_phone5" type="tel" maxlength="14" class="phone"       onChange="jqValid({'type':'phone','object':this,'message':'Not a valid phone number.'});" /></div>
<div><label for="g3_email1">Primary Email</label><input id="g3_email1" maxlength="50" type="email"/></div>
<div><label for="g3_email2">Secondary Email</label><input id="g3_email2" maxlength="50" type="email"/></div>
<div><label for="g3_website">Website</label><input type="url" id="g3_website" maxlength="100" /></div>
<div><label for="g3_effectivedate">Effective Date</label><input type="text" id="g3_effectivedate" class="date"/></div>
<div><label for="g3_acctsoftwareupdate"><input id="g3_acctsoftwareupdate" type="checkbox" class="ios-switch">Updated in accounting software</label></div>
<div><label for="g3_taxupdate"><input id="g3_taxupdate" type="checkbox" class="ios-switch">Update in tax software</label></div>
<div><label style="float:left;width:70px" ><input id="g3_customvalue" type="checkbox" class="ios-switch" /></label><input type="text" id="g3_customlabel" maxlength="50" class="customlabel"/></div>
</div>
</div>

<!--- Group 4 --->
<div id="group4" class="gf-checkbox">
<h3>Maintenance</h3><div></div>



<!--- Accounting &amp; Consulting Tasks --->
<h4 onClick='_run.load_group4_1(); '>Accounting &amp; Consulting Tasks</h4>
<div>
<div class="tblGrid" id="grid4_1"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_1();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Administrative Tasks --->
<h4  onClick='_run.load_group4_2();'>Administrative Tasks</h4>
<div>
<div class="tblGrid" id="grid4_2"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_2();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Business Formation --->
<h4 onClick='_run.load_group4_3();'>Business Formation</h4>
<div>
<div class="tblGrid" id="grid4_3"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_3();">Add</a></cfoutput></cfif>
</div>
</div>

<!--- Communications --->
<h4 onClick='_run.load_group4_4();'>Communications</h4>
<div>
<div class="tblGrid" id="grid4_4"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_4();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Financial &amp; Tax Planning --->
<h4 onClick='_run.load_group4_5();'>Financial &amp; Tax Planning</h4>
<div>
<div class="tblGrid" id="grid4_5"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_5();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Financial Statements --->
<h4 onClick='_run.load_group4_6();'>Financial Statements</h4>
<div>
<div class="tblGrid" id="grid4_6"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_6();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Notices  --->
<h4 onClick='_run.load_group4_7();'>Notices</h4>
<div>
<div class="tblGrid" id="grid4_7"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_7();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  OTHER FILINGS --->
<h4 onClick='_run.load_group4_8();'>Other Filings</h4>
<div>
<div class="tblGrid" id="grid4_8"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_8();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Payroll Checks --->
<h4 onClick='_run.load_group4_9();'>Payroll Checks</h4>
<div>
<div class="tblGrid" id="grid4_9"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_9();">Add</a></cfoutput></cfif>
</div>
</div>

<!---  Payroll Taxes --->
<h4 onClick='_run.load_group4_10();'>Payroll Taxes</h4>
<div>
<div class="tblGrid" id="grid4_10"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_10();">Add</a></cfoutput></cfif>
</div>
</div>


<!---  Power of Attorney --->
<h4 onClick='_run.load_group4_11();'>Personal Property Tax Returns</h4>
<div>
<div class="tblGrid" id="grid4_11"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_11();">Add</a></cfoutput></cfif>
</div>
</div>

<!--- PERSONAL PROPERTY Tax Returns --->
<h4 onClick='_run.load_group4_12();'>Power of Attorney</h4>
<div>
<div class="tblGrid" id="grid4_12"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_12();">Add</a></cfoutput></cfif>
</div>
</div>


<!---  Tax Returns --->
<h4 onClick='_run.load_group4_13();'>Tax Returns</h4>
<div>
<div class="tblGrid" id="grid4_13"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><cfoutput><a href="##" class="button optional" onClick="_run.new_group4_13();">Add</a></cfoutput></cfif>
</div>
</div>

</div>
<!--- GROUP 5--->
<div id="group5" class="gf-checkbox">
<h3 onClick="_run.load_group5();">Saved State Information</h3>
<div>
<div><label for="g5_filter">Filter</label><input id="g5_filter" onBlur="_run.load_group5();" onKeyPress="if(event.keyCode==13){_run.load_group5();}"/></div>
<div class="tblGrid" id="grid5"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group5();'>Add</a></cfif>
</div>
</div>
<h4 onclick="_run.load_group5();">State Information</h4>
<div>
<div><label for="g5_state">State</label><select id="g5_state" data-placeholder="Select a State."><option value="0">&nbsp;</option><cfoutput query="global_state"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g5_revenue"><input id="g5_revenue" type="checkbox" class="ios-switch">Revenue</label></div>
<div><label for="g5_employees"><input id="g5_employees" type="checkbox" class="ios-switch">Employees</label></div>
<div><label for="g5_property"><input id="g5_property" type="checkbox" class="ios-switch">Property</label></div>
<div><label for="g5_nexus"><input id="g5_nexus" type="checkbox" class="ios-switch">NEXUS</label></div>
<div><label for="g5_reason">Reason</label><input id="g5_reason" maxlength="50" /></div>
<div><label for="g5_registered"><input id="g5_registered" type="checkbox" class="ios-switch">Registered</label></div>
<div style="height:30px"><label style="float:left;width:70px;"><input id="g5_value1" maxlength="30" type="checkbox" class="ios-switch"></label><label for="g5_value1"style="height:25px;padding:5px"></label></div><!---label for="g5_value1" id="g5_label1"></label--->
<div style="height:30px"><label style="float:left;width:70px;"><input id="g5_value2" maxlength="30" type="checkbox" class="ios-switch"></label><label for="g5_value2"style="height:25px;padding:5px"></label></div><!---label for="g5_value2" id="g5_label2"></label--->
<div style="height:30px"><label style="float:left;width:70px;"><input id="g5_value3" maxlength="30" type="checkbox" class="ios-switch"></label><label for="g5_value3"style="height:25px;padding:5px"></label></div><!---label for="g5_value3" id="g5_label3"></label--->
<div style="height:30px"><label style="float:left;width:70px;"><input id="g5_value4" maxlength="30" type="checkbox" class="ios-switch"></label><label for="g5_value4"style="height:25px;padding:5px"></label></div><!---label for="g5_value4" id="g5_label4"></label--->
</div>

<h4 onclick="_run.load_group5_1();">State Labels</h4>
<div>
<div><label for="g5_g1_label1">Label 1</label><input type="text" id="g5_g1_label1"/></div>
<div><label for="g5_g1_label2">Label 2</label><input type="text" id="g5_g1_label2"/></div>
<div><label for="g5_g1_label3">Label 3</label><input type="text" id="g5_g1_label3"/></div>
<div><label for="g5_g1_label4">Label 4</label><input type="text" id="g5_g1_label4"/></div>
</div>
</div>

<!--- GROUP 6 --->
<div id="group6" class="gf-checkbox" >
<h3 onClick="_run.load_group6()">Related Client Details</h3>
<div>
<div><label for="g6_filter">Filter</label><input id="g6_filter" onBlur="_run.new_group6();"  onKeyPress="if(event.keyCode==13){_run.load_group6();}"/></div>
<!--- SET GRID CONTACTS --->
<div id="grid6" class="tblGrid"></div>
<div class="buttonbox">
<cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='_run.new_group6();'>Add</a></cfif>
</div>
</div>
<h4 onclick="_run.load_group6_1();">Related Clients</h4>
<div>
<div><label for="g6_group">Groups</label><select id="g6_group" multiple="multiple" data-placeholder="Select Some Client Groups."><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
</div>
</div>
<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">
</div>
<!---Start of footer--->
<cfinclude template="/assets/inc/footer.cfm" />
<embed id="_DymoLabelFrameworkJslPlugin" width="1" hidden="" height="1" type="application/x-dymolabel">
</body>
</html>