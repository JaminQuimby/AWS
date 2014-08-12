<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_PracticeManagement">
<cfset page.location="timebillingreport">
<cfset page.formid=102>
<cfset page.title="Time &amp; Billing">
<cfset page.type="report">
<cfif Session.user.role eq 0>
<cfset page.menuLeft="Payroll Checks,Payroll Taxes,Other Filings,Business Formation,Accounting &amp; Consulting,Financial Statements,Financial &amp; Tax Planning,Notices,Tax Returns,PPTR,State Tax Returns,State PPTR,Communications">
</cfif>
<cfif Session.user.role eq 1>
<cfset page.menuLeft="Payroll Checks,Payroll Taxes,Other Filings,Business Formation,Accounting &amp; Consulting,Financial Statements,Financial &amp; Tax Planning,Notices,Tax Returns,PPTR,State Tax Returns,State PPTR,Communications,Lock Billing">
</cfif>

<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">
<html xmlns="http://www.w3.org/1999/xhtml">

<cfinclude template="/assets/inc/header.cfm">
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>

<body onLoad="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2,group3,group4,group5,group6,group7,group8,group9,group10,group11,group12,group13');">
<!--- Load Left Menus --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>


 <div id="group1" class="gf-checkbox">
	<h3>Time &amp; Billing Payroll Checks</h3>
	<div>
		<div><label for="g1_filter">Filter</label><input id="g1_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
		<div id="g1_searchOptions"></div><div class="tblGrid" id="grid1"></div>
    </div>
 </div>
 
  <div id="group2" class="gf-checkbox">
	<h3>Time &amp; Billing Payroll Taxes</h3>
	<div>
		<div><label for="g2_filter">Filter</label><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></div>
		<div class="tblGrid" id="grid2"></div>
    </div>
 </div>
 
  <div id="group3" class="gf-checkbox">
	<h3>Time &amp; Billing Other Filings</h3>
	<div>
		<div><label for="g3_filter">Filter</label><input id="g3_filter" onBlur="_grid3();" onKeyPress="if(event.keyCode==13){_grid3();}"/></div>
		<div class="tblGrid" id="grid3"></div>
    </div>
 </div>
 
  <div id="group4" class="gf-checkbox">
	<h3>Time &amp; Billing Business Formation</h3>
	<div>
		<div><label for="g4_filter">Filter</label><input id="g4_filter" onBlur="_grid4();" onKeyPress="if(event.keyCode==13){_grid4();}"/></div>
		<div class="tblGrid" id="grid4"></div>
    </div>
 </div>
 
  <div id="group5" class="gf-checkbox">
	<h3>Time &amp; Billing Accounting &amp; Consulting</h3>
	<div>
		<div><label for="g5_filter">Filter</label><input id="g5_filter" onBlur="_grid5();" onKeyPress="if(event.keyCode==13){_grid5();}"/></div>
		<div class="tblGrid" id="grid5"></div>
    </div>
 </div>
 
  <div id="group6" class="gf-checkbox">
	<h3>Time &amp; Billing Financial Statements</h3>
	<div>
		<div><label for="g6_filter">Filter</label><input id="g6_filter" onBlur="_grid6();" onKeyPress="if(event.keyCode==13){_grid6();}"/></div>
		<div class="tblGrid" id="grid6"></div>
    </div>
 </div>
 
  <div id="group7" class="gf-checkbox">
	<h3>Time &amp; Billing Financial &amp; Consulting</h3>
	<div>
		<div><label for="g7_filter">Filter</label><input id="g7_filter" onBlur="_grid7();" onKeyPress="if(event.keyCode==13){_grid7();}"/></div>
		<div class="tblGrid" id="grid7"></div>
    </div>
 </div>
 
  <div id="group8" class="gf-checkbox">
	<h3>Time &amp; Billing Notices</h3>
	<div>
		<div><label for="g8_filter">Filter</label><input id="g8_filter" onBlur="_grid8();" onKeyPress="if(event.keyCode==13){_grid8();}"/></div>
		<div class="tblGrid" id="grid8"></div>
    </div>
 </div>
 
  <div id="group9" class="gf-checkbox">
	<h3>Time &amp; Billing Tax Returns</h3>
	<div>
		<div><label for="g9_filter">Filter</label><input id="g9_filter" onBlur="_grid9();" onKeyPress="if(event.keyCode==13){_grid9();}"/></div>
		<div class="tblGrid" id="grid9"></div>
    </div>
 </div>
 
  <div id="group10" class="gf-checkbox">
	<h3>Time &amp; Billing PPTR</h3>
	<div>
		<div><label for="g10_filter">Filter</label><input id="g10_filter" onBlur="_grid10();" onKeyPress="if(event.keyCode==13){_grid10();}"/></div>
		<div class="tblGrid" id="grid10"></div>
    </div>
 </div>
 
  <div id="group11" class="gf-checkbox">
	<h3>Time &amp; Billing State Tax Returns</h3>
	<div>
		<div><label for="g11_filter">Filter</label><input id="g11_filter" onBlur="_grid11();" onKeyPress="if(event.keyCode==13){_grid11();}"/></div>
		<div class="tblGrid" id="grid11"></div>
    </div>
 </div>
 
  <div id="group12" class="gf-checkbox">
	<h3>Time &amp; Billing State PPTR</h3>
	<div>
		<div><label for="g12_filter">Filter</label><input id="g12_filter" onBlur="_grid12();" onKeyPress="if(event.keyCode==13){_grid12();}"/></div>
		<div class="tblGrid" id="grid12"></div>
    </div>
 </div>
  
  <div id="group13" class="gf-checkbox">
	<h3>Time &amp; Billing Communications</h3>
	<div>
		<div><label for="g13_filter">Filter</label><input id="g13_filter" onBlur="_grid13();" onKeyPress="if(event.keyCode==13){_grid13();}"/></div>
		<div class="tblGrid" id="grid13"></div>
    </div>
 </div>    
 
  <div id="group14" class="gf-checkbox">
	<h3>Lock Billing</h3>
	<div>
		<div class="buttonbox"><input type="submit" value="Lock Billing" onClick=""></div>
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