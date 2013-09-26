<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_practicemanagement">
<cfset page.location="employeedashboard">
<cfset page.formid=15>
<cfset page.title="Employee Dashboard">
<cfset page.menuLeft="All Modules,Payroll & Taxes,Accounting Services,Notices,Taxation,Client Management">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="100,101">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../assets/inc/header.cfm">


<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>

<!---TRACKERS--->

<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu');">Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
        <h3>All Modules</h3>
 		<div>
 		<div><label for="g7_filter">Filter</label><input id="g7_filter" onBlur="_grid7();" onKeyPress="if(event.keyCode==13){_grid7();}"/></div>
		<div class="tblGrid" id="grid7"></div>
 		</div>
</div>


<div id="group2" class="gf-checkbox">
<h3>Payroll & Taxes</h3><div></div>
<!--- GROUP 2 SUB 1 PAYROLL CHECKS --->
	<h4 onClick='_grid2_1();'>Payroll Checks</h4>
	<div>
		<div><label for="g2_1_filter">Filter</label><input id="g2_1_filter" onBlur="_grid2_1();" onKeyPress="if(event.keyCode==13){_grid2_1();}"/></div>	
		<div class="tblGrid" id="grid2_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_payrolltaxes/payrollchecks.cfm'">Add</a></cfoutput>
		</div>
	</div>

<!--- GROUP 2 SUB 2 PAYROLL TAXES --->
	<h4 onClick='_grid2_2();'>Payroll Taxes</h4>
	<div>
		<div><label for="g2_2_filter">Filter</label><input id="g2_2_filter" onBlur="_grid2_2();" onKeyPress="if(event.keyCode==13){_grid2_2();}"/></div>
		<div class="tblGrid" id="grid2_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_payrolltaxes/payrolltaxes.cfm'">Add</a></cfoutput>
		</div>
	</div>



<!--- GROUP 2 SUB 3 OTHER FILINGS --->
	<h4 onClick='_grid2_3();'>Other Filings</h4>
	<div>
		<div><label for="g2_3_filter">Filter</label><input id="g2_3_filter" onBlur="_grid2_3();" onKeyPress="if(event.keyCode==13){_grid2_3();}"/></div>
		<div class="tblGrid" id="grid2_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_payrolltaxes/otherfilings.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>


<div id="group3" class="gf-checkbox">
 <h3>Accounting & Consulting</h3><div></div>
	
	<!--- GROUP 3 SUB 1 Business Formation --->
	<h4 onClick='_grid3_1();'>Business Formation</h4>
		<div>
		<div><label for="g3_1_filter">Filter</label><input id="g3_1_filter" onBlur="_grid3_1();" onKeyPress="if(event.keyCode==13){_grid3_1();}"/></div>
		<div class="tblGrid" id="grid3_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/businessformation.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 3 SUB 2 Accounting & Consulting --->
	<h4 onClick='_grid3_2();'>Accounting &amp; Consulting</h4>
		<div>
		<div><label for="g3_2_filter">Filter</label><input id="g3_2_filter" onBlur="_grid3_2();" onKeyPress="if(event.keyCode==13){_grid3_2();}"/></div>
		<div class="tblGrid" id="grid3_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/acctConsultingTasks.cfm'">Add</a></cfoutput>
		</div>
	</div>



	<!--- GROUP 3 SUB 3 Financial Statements --->
	<h4 onClick='_grid3_3();'>Financial Statements</h4>
		<div>
		<div><label for="g3_3_filter">Filter</label><input id="g3_3_filter" onBlur="_grid3_3();" onKeyPress="if(event.keyCode==13){_grid3_3();}"/></div>
		<div class="tblGrid" id="grid3_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>



<div id="group4" class="gf-checkbox">
 <h3>Notices</h3><div></div>	
	<!--- GROUP 4 SUB 1 Notices--->
	<h4 onClick='_grid4_1();'>Notices</h4>
		<div>
		<div><label for="g4_1_filter">Filter</label><input id="g4_1_filter" onBlur="_grid4_1();" onKeyPress="if(event.keyCode==13){_grid4_1();}"/></div>
		<div class="tblGrid" id="grid4_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/notices.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 2 Notices for review --->
	<h4 onClick='_grid4_2();'>Notices For Review</h4>
		<div>
		<div><label for="g4_2_filter">Filter</label><input id="g4_2_filter" onBlur="_grid4_2();" onKeyPress="if(event.keyCode==13){_grid4_2();}"/></div>
		<div class="tblGrid" id="grid4_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/notices.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>


<div id="group5" class="gf-checkbox">	
 <h3>Taxation</h3><div></div>
	<!--- GROUP 5 SUB 1 Data Entry--->
	<h4 onClick='_grid5_1();'>Data Entry</h4>
		<div>
		<div><label for="g5_1_filter">Filter</label><input id="g5_1_filter" onBlur="_grid5_1();" onKeyPress="if(event.keyCode==13){_grid5_1();}"/></div>
		<div class="tblGrid" id="grid5_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 2 Missing Information --->
	<h4 onClick='_grid5_2();'>Missing Information</h4>
		<div>
		<div><label for="g5_2_filter">Filter</label><input id="g5_2_filter" onBlur="_grid5_2();" onKeyPress="if(event.keyCode==13){_grid5_2();}"/></div>
		<div class="tblGrid" id="grid5_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 3 Ready for Review --->
	<h4 onClick='_grid5_3();'>Ready for Review</h4>
		<div>
		<div><label for="g5_3_filter">Filter</label><input id="g5_3_filter" onBlur="_grid5_3();" onKeyPress="if(event.keyCode==13){_grid5_3();}"/></div>
		<div class="tblGrid" id="grid5_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 4 Assembly & Delivery --->
	<h4 onClick='_grid5_4();'>Assembly &amp; Delivery</h4>
		<div>
		<div><label for="g5_4_filter">Filter</label><input id="g5_4_filter" onBlur="_grid5_4();" onKeyPress="if(event.keyCode==13){_grid5_4();}"/></div>
		<div class="tblGrid" id="grid5_4"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 5 State Tax Returns --->
	<h4 onClick='_grid5_5();'>State Tax Returns</h4>
		<div>
		<div><label for="g5_5_filter">Filter</label><input id="g5_5_filter" onBlur="_grid5_5();" onKeyPress="if(event.keyCode==13){_grid5_5();}"/></div>
		<div class="tblGrid" id="grid5_5"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 6 Financial Tax Planning --->
	<h4 onClick='_grid5_6();'>Financial Tax Planning</h4>
		<div>
		<div><label for="g5_6_filter">Filter</label><input id="g5_6_filter" onBlur="_grid5_6();" onKeyPress="if(event.keyCode==13){_grid5_6();}"/></div>
		<div class="tblGrid" id="grid5_6"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/financialtaxplanning.cfm'">Add</a></cfoutput>
		</div>        
	</div>
</div>


<div id="group6" class="gf-checkbox">
 <h3>Client Management</h3><div></div>
	
	<!--- GROUP 6 SUB 1 Administrative Tasks --->
	<h4 onClick='_grid6_1();'>Administrative Tasks</h4>
		<div>
		<div><label for="g6_1_filter">Filter</label><input id="g6_1_filter" onBlur="_grid6_1();" onKeyPress="if(event.keyCode==13){_grid6_1();}"/></div>
		<div class="tblGrid" id="grid6_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_clientmanagement/administrativetasks.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 6 SUB 2 Communications --->
	<h4 onClick='_grid6_2();'>Communications</h4>
		<div>
		<div><label for="g6_2_filter">Filter</label><input id="g6_2_filter" onBlur="_grid6_2();" onKeyPress="if(event.keyCode==13){_grid6_2();}"/></div>
		<div class="tblGrid" id="grid6_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/acctConsultingTasks.cfm'">Add</a></cfoutput>
		</div>
	</div>



	<!--- GROUP 6 SUB 3 Document Tracking Log --->
	<h4 onClick='_grid6_3();'>Document Tracking Log</h4>
		<div>
		<div><label for="g6_3_filter">Filter</label><input id="g6_3_filter" onBlur="_grid6_3();" onKeyPress="if(event.keyCode==13){_grid6_3();}"/></div>
		<div class="tblGrid" id="grid6_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>
<!--
<div id="group7" class="gf-checkbox">
        <h3>All Modules</h3>
 		<div>
 		<div><label for="g7_filter">Filter</label><input id="g7_filter" onBlur="_grid7();" onKeyPress="if(event.keyCode==13){_grid7();}"/></div>
		<div class="tblGrid" id="grid7"></div>
 		</div>
 </div>-->


<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">
<!--- FIELD DATA --->


<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>