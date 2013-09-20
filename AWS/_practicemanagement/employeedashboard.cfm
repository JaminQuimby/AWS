<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_practicemanagement">
<cfset page.location="employeedashboard">
<cfset page.title="Employee Dashboard">
<cfset page.menuLeft="General,Payroll & Taxes,Accounting Services,Notices,Taxation,Client Management,All Modules">
<cfset page.trackers="task_id">
<cfset page.plugins.disable='100,101'>

<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<cfquery name="selectClients" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>

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

<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu');">Add</a></div></div></div>
<!--- FIELD DATA --->
<div id="group1" class="gf-checkbox">


</div>


<div id="group2" class="gf-checkbox">
<h3>Payroll & Taxes</h3><div></div>



<!--- GROUP 2 SUB 1 PAYROLL CHECKS --->
<h4 onClick='_grid2_1();'>Payroll Checks</h4>
<div>
<div class="tblGrid" id="grid2_1"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_payrolltaxes/payrollchecks.cfm'">Add</a></cfoutput>
</div>
</div>

<!--- GROUP 2 SUB 2 PAYROLL TAXES --->
<h4 onClick='_grid2_2();'>Payroll Taxes</h4>
<div>
<div class="tblGrid" id="grid2_2"></div>
<div class="buttonbox">
<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_payrolltaxes/payrolltaxes.cfm'">Add</a></cfoutput>
</div>
</div>



<!--- GROUP 2 SUB 3 OTHER FILINGS --->
<h4 onClick='_grid2_3();'>Other Filings</h4>
<div>
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
		<div class="tblGrid" id="grid3_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/businessformation.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 3 SUB 2 Accounting & Consulting --->
	<h4 onClick='_grid3_2();'>Accounting & Consulting</h4>
		<div>
		<div class="tblGrid" id="grid3_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/acctConsultingTasks.cfm'">Add</a></cfoutput>
		</div>
	</div>



	<!--- GROUP 3 SUB 3 Financial Statements --->
	<h4 onClick='_grid3_3();'>Financial Statements</h4>
		<div>
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
		<div class="tblGrid" id="grid4_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/notices.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 4 SUB 2 Notices for review --->
	<h4 onClick='_grid4_2();'>Notices For Review</h4>
		<div>
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
		<div class="tblGrid" id="grid5_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 2 Missing Information --->
	<h4 onClick='_grid5_2();'>Missing Information</h4>
		<div>
		<div class="tblGrid" id="grid5_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 3 Ready for Review --->
	<h4 onClick='_grid5_3();'>Ready for Review</h4>
		<div>
		<div class="tblGrid" id="grid5_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 4 Assembly & Delivery --->
	<h4 onClick='_grid5_4();'>Assembly & Delivery</h4>
		<div>
		<div class="tblGrid" id="grid5_4"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 5 State Tax Returns --->
	<h4 onClick='_grid5_5();'>State Tax Returns</h4>
		<div>
		<div class="tblGrid" id="grid5_5"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_taxation/taxreturns.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 5 SUB 6 Financial Tax Planning --->
	<h4 onClick='_grid5_6();'>Financial Tax Planning</h4>
		<div>
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
		<div class="tblGrid" id="grid6_1"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_clientmanagement/administrativetasks.cfm'">Add</a></cfoutput>
		</div>
	</div>

	<!--- GROUP 6 SUB 2 Communications --->
	<h4 onClick='_grid6_2();'>Communications</h4>
		<div>
		<div class="tblGrid" id="grid6_2"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/acctConsultingTasks.cfm'">Add</a></cfoutput>
		</div>
	</div>



	<!--- GROUP 6 SUB 3 Document Tracking Log --->
	<h4 onClick='_grid6_3();'>Document Tracking Log</h4>
		<div>
		<div class="tblGrid" id="grid6_3"></div>
		<div class="buttonbox">
		<cfoutput><a href="##" class="button optional" onClick="window.location='#Application.url#/AWS/_accountingservices/financialStatements.cfm'">Add</a></cfoutput>
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