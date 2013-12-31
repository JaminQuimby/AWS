<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_practicemanagement">
<cfset page.location="employeedashboard">
<cfset page.formid=15>
<cfset page.title="Employee Dashboard">
<cfset page.menuLeft="Payroll & Taxes,Accounting Services,Notices,Taxation,Client Management">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<cfinclude template="../assets/inc/header.cfm">
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname],[optionDescription]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>

<body>
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu2/menu.cfm"></nav>


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid0();" onKeyPress="if(event.keyCode==13){_grid0();}"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid0"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu');">Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">
<!--- GROUP 1 SUB 1 PAYROLL CHECKS --->
	<h4 onClick='_grid1_1();'>Payroll Checks</h4>
	<div><div style="float:right; display:block;"><a href="#" class="accordianopen">Expand All</a><a class="accordianclose">Collapse All</a></div>
		<div><label for="g1_1_filter">Filter</label><input id="g1_1_filter" onBlur="_grid1_1();" onKeyPress="if(event.keyCode==13){_grid1_1();}"/></div>	
		<div class="tblGrid" id="grid1_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/payrollchecks.cfm'">Add</a></cfoutput>
		</div>
    </div>

<!--- GROUP 1 SUB 2 PAYROLL TAXES --->
	<h4 onClick='_grid1_2();'>Payroll Taxes</h4>
	<div>
		<div><label for="g1_2_filter">Filter</label><input id="g1_2_filter" onBlur="_grid1_2();" onKeyPress="if(event.keyCode==13){_grid1_2();}"/></div>
		<div class="tblGrid" id="grid1_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/payrolltaxes.cfm'">Add</a></cfoutput>
		</div>
	</div>

<!--- GROUP 1 SUB 3 OTHER FILINGS --->
	<h4 onClick='_grid1_3();'>Other Filings</h4>
		<div>
		<div><label for="g1_3_filter">Filter</label><input id="g1_3_filter" onBlur="_grid1_3();" onKeyPress="if(event.keyCode==13){_grid1_3();}"/></div>
		<div class="tblGrid" id="grid1_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_payrolltaxes/otherfilings.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>


<div id="group2" class="gf-checkbox">	
	<!--- GROUP 2 SUB 1 Business Formation --->
	<h4 onClick='_grid2_1();'>Business Formation</h4>
		<div>
		<div><label for="g2_1_filter">Filter</label><input id="g2_1_filter" onBlur="_grid2_1();" onKeyPress="if(event.keyCode==13){_grid2_1();}"/></div>
		<div class="tblGrid" id="grid2_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/businessformation.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 2 SUB 2 Accounting & Consulting --->
	<h4 onClick='_grid2_2();'>Accounting &amp; Consulting</h4>
		<div>
		<div><label for="g2_2_filter">Filter</label><input id="g2_2_filter" onBlur="_grid2_2();" onKeyPress="if(event.keyCode==13){_grid2_2();}"/></div>
		<div class="tblGrid" id="grid2_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/acctingconsulting.cfm'">Add</a></cfoutput>
		</div>
	</div>



	<!--- GROUP 2 SUB 3 Financial Statements --->
	<h4 onClick='_grid2_3();'>Financial Statements</h4>
		<div>
		<div><label for="g2_3_filter">Filter</label><input id="g2_3_filter" onBlur="_grid2_3();" onKeyPress="if(event.keyCode==13){_grid2_3();}"/></div>
		<div class="tblGrid" id="grid2_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>



<div id="group3" class="gf-checkbox">
	<!--- GROUP 3 SUB 1 Notices--->
	<h4 onClick='_grid3_1();'>Notices</h4>
		<div>
		<div><label for="g3_1_filter">Filter</label><input id="g3_1_filter" onBlur="_grid3_1();" onKeyPress="if(event.keyCode==13){_grid3_1();}"/></div>
		<div class="tblGrid" id="grid3_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/notices.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 3 SUB 2 Notices for review --->
	<h4 onClick='_grid3_2();'>Notices For Review</h4>
		<div>
		<div><label for="g3_2_filter">Filter</label><input id="g3_2_filter" onBlur="_grid3_2();" onKeyPress="if(event.keyCode==13){_grid3_2();}"/></div>
		<div class="tblGrid" id="grid3_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/notices.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>


<div id="group4" class="gf-checkbox">	
	<!--- GROUP 4 SUB 1 Data Entry--->
	<h4 onClick='_grid4_1();'>Data Entry</h4>
		<div>
		<div><label for="g4_1_filter">Filter</label><input id="g4_1_filter" onBlur="_grid4_1();" onKeyPress="if(event.keyCode==13){_grid4_1();}"/></div>
		<div class="tblGrid" id="grid4_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 2 Missing Information --->
	<h4 onClick='_grid4_2();'>Missing Information</h4>
		<div>
		<div><label for="g4_2_filter">Filter</label><input id="g4_2_filter" onBlur="_grid4_2();" onKeyPress="if(event.keyCode==13){_grid4_2();}"/></div>
		<div class="tblGrid" id="grid4_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 3 Ready for Review --->
	<h4 onClick='_grid4_3();'>Ready for Review</h4>
		<div>
		<div><label for="g4_3_filter">Filter</label><input id="g4_3_filter" onBlur="_grid4_3();" onKeyPress="if(event.keyCode==13){_grid4_3();}"/></div>
		<div class="tblGrid" id="grid4_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 4 Assembly & Delivery --->
	<h4 onClick='_grid4_4();'>Assembly &amp; Delivery</h4>
		<div>
		<div><label for="g4_4_filter">Filter</label><input id="g4_4_filter" onBlur="_grid4_4();" onKeyPress="if(event.keyCode==13){_grid4_4();}"/></div>
		<div class="tblGrid" id="grid4_4"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 5 State Tax Returns --->
	<h4 onClick='_grid4_5();'>State Tax Returns</h4>
		<div>
		<div><label for="g4_5_filter">Filter</label><input id="g4_5_filter" onBlur="_grid4_5();" onKeyPress="if(event.keyCode==13){_grid4_5();}"/></div>
		<div class="tblGrid" id="grid4_5"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 6 Financial Tax Planning --->
	<h4 onClick='_grid4_6();'>Financial Tax Planning</h4>
		<div>
		<div><label for="g4_6_filter">Filter</label><input id="g4_6_filter" onBlur="_grid4_6();" onKeyPress="if(event.keyCode==13){_grid4_6();}"/></div>
		<div class="tblGrid" id="grid4_6"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_taxation/financialtaxplanning.cfm'">Add</a></cfoutput>
		</div>        
	</div>
</div>


<div id="group5" class="gf-checkbox">	
	<!--- GROUP 5 SUB 1 Administrative Tasks --->
	<h4 onClick='_grid5_1();'>Administrative Tasks</h4>
		<div>
		<div><label for="g5_1_filter">Filter</label><input id="g5_1_filter" onBlur="_grid5_1();" onKeyPress="if(event.keyCode==13){_grid5_1();}"/></div>
		<div class="tblGrid" id="grid5_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_clientmanagement/administrativetasks.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 2 Communications --->
	<h4 onClick='_grid5_2();'>Communications</h4>
		<div>
		<div><label for="g5_2_filter">Filter</label><input id="g5_2_filter" onBlur="_grid5_2();" onKeyPress="if(event.keyCode==13){_grid5_2();}"/></div>
		<div class="tblGrid" id="grid5_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/acctingconsulting.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 3 Document Tracking Log --->
	<h4 onClick='_grid5_3();'>Document Tracking Log</h4>
		<div>
		<div><label for="g5_3_filter">Filter</label><input id="g5_3_filter" onBlur="_grid5_3();" onKeyPress="if(event.keyCode==13){_grid5_3();}"/></div>
		<div class="tblGrid" id="grid5_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#this.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
		</div>
	</div>
</div>


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