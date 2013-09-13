<!---START OF MENU --->
<!---Payroll and Taxes --->
<cfoutput>
<ul class="menuH">
  <li><a class="arrow">Payroll &amp; Taxes</a>
    <ul class="_payrolltaxes">
      <li><a class="arrow" >Reporting</a>
       <ul class="_payrolltaxes">
       <li><a href="#Application.url#/AWS/_payrolltaxes/reports/payroll_report.cfm">Payroll</a></li>
       <li><a href="#Application.url#/AWS/_payrolltaxes/reports/otherfilings_report.cfm">Other Filings</a></li>
       </ul>
      </li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrollchecks.cfm">Payroll Checks</a></li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrolltaxes.cfm">Payroll Tax Retuns</a></li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/otherfilings.cfm">Other Filing Requirements</a></li>
    </ul>
  </li>
  <!---Accounting Services --->
  <li><a class="arrow">Accounting Services</a>
    <ul class="_accountingservices">
      <li><a class="arrow">Reporting</a>
		<ul class="_accountingservices">
       <li><a href="#Application.url#/AWS/_accountingservices/reports/businessformation_report.cfm">Business Formation</a></li>
       <li><a href="#Application.url#/AWS/_accountingservices/reports/acctingconsulting_report.cfm">Accounting &amp; Consulting</a></li>
       <li><a href="#Application.url#/AWS/_accountingservices/reports/financialstatements_report.cfm">Financial Statements</a></li>
       </ul>
      </li>
      <li><a href="#Application.url#/AWS/_accountingservices/businessformation.cfm">Business Formation</a></li>
      <li><a href="#Application.url#/AWS/_accountingservices/acctconsultingtasks.cfm">Accounting &amp; Consulting Tasks</a></li>
      <li><a href="#Application.url#/AWS/_accountingservices/financialstatements.cfm">Financial Statements</a></li>
    </ul>
  </li>
  <!---Taxation --->
  <li><a class="arrow">Taxation</a>
    <ul class="_taxation">
      <li><a class="arrow">Reporting</a>
      		<ul class="_taxation">
       <li><a href="#Application.url#/AWS/_taxation/reports/financialtaxplanning_report.cfm">Financial &amp Tax Planning</a></li>
       <li><a href="#Application.url#/AWS/_taxation/reports/notices_report.cfm">Notices</a></li>
       <li><a href="#Application.url#/AWS/_taxation/reports/powerofattorney_report.cfm">Power of Attorney</a></li>
       <li><a href="#Application.url#/AWS/_taxation/reports/taxreturns_report.cfm">Tax Returns</a></li>
       </ul>
      </li>
      <li><a href="#Application.url#/AWS/_taxation/financialtaxplanning.cfm">Financial &amp; Tax Planning</a></li>
      <li><a href="#Application.url#/AWS/_taxation/notices.cfm">Notices</a></li>
      <li><a href="#Application.url#/AWS/_taxation/powerofattorney.cfm">Power of Attorney</a></li>
      <li><a href="#Application.url#/AWS/_taxation/taxreturns.cfm">Tax Returns</a></li>
    </ul>
  </li>
  <!---Client Management --->
  <li><a class="arrow">Client Management</a>
    <ul class="_clientmanagement">
      <li><a class="arrow">Reporting</a>
      		<ul class="_clientmanagement">
       <li><a href="#Application.url#/AWS/_clientmanagement/reports/administrativetasks_report.cfm">Administrative Tasks</a></li>
       <li><a href="#Application.url#/AWS/_clientmanagement/reports/communications_report.cfm">Communications</a></li>
       <li><a href="#Application.url#/AWS/_clientmanagement/reports/clientlisting_report.cfm">Client Listing</a></li>
       </ul>
      </li>
      <li><a href="#Application.url#/AWS/_clientmanagement/administrativetasks.cfm">Administrative Tasks</a></li>
      <li><a href="#Application.url#/AWS/_clientmanagement/clientmaintenance.cfm">Client Maintenance</a></li>
      <li><a href="#Application.url#/AWS/_clientmanagement/communications.cfm">Communication</a></li>
      <li><a href="#Application.url#/AWS/_clientmanagement/documenttracking.cfm">Document Tracking Log</a></li>
    </ul>
  </li>
  <!---Practice Management --->
  <li><a class="arrow">Practice Management</a>
    <ul class="_practicemanagement dropToLeft">
      <li><a href="#Application.url#/AWS/_PracticeManagement/workinprogress.cfm">Work in Progress</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/employeedashboard.cfm">Employee Dashboard</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/employeecontactinfo.cfm">Employee Contact Information</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/maintenance.cfm">AWS Maintenance</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/timebilling.cfm">Time &amp; Billing</a></li>
    </ul>
</li>

<!--- USER SETTINGS --->
<li style="position:fixed; right:0px">
	<a class="arrow">#session.user.name#</a>
	<ul class="_practicemanagement dropToRight">
		<li><a href="##">Profile</a></li>
		<li><form action="#CGI.script_name#?#CGI.query_string#" method="post"><input type="hidden" name="logout" value="logout" /><a href="##" onclick="parentNode.submit()">Logout </a></form></li>
	</ul>
</li>
</ul>
</cfoutput>
<!--- END OF MENU--->