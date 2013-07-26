<!---START OF MENU --->
<!---Payroll and Taxes --->
<cfoutput>
<ul class="menuH">
  <li><a class="arrow">Payroll &amp; Taxes</a>
    <ul class="_payrolltaxes">
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrollReporting.cfm">Reporting</a></li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrollPayrollChecks.cfm">Payroll Checks</a></li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrollPayrollTaxes.cfm">Payroll Tax Retuns</a></li>
      <li><a href="#Application.url#/AWS/_payrolltaxes/payrollOtherFilingsRequirements.cfm">Other Filing Requirements</a></li>
    </ul>
  </li>
  <!---Accounting Services --->
  <li><a class="arrow">Accounting Services</a>
    <ul class="_accountingservices">
      <li><a href="#Application.url#/AWS/_accountingservices/Reporting.cfm">Reporting</a></li>
      <li><a href="#Application.url#/AWS/_accountingservices/businessFormation.cfm">Business Formation</a></li>
      <li><a href="#Application.url#/AWS/_accountingservices/acctConsultingTasks.cfm">Accounting &amp; Consulting Tasks</a></li>
      <li><a href="#Application.url#/AWS/_accountingservices/financialStatements.cfm">Financial Statements</a></li>
    </ul>
  </li>
  <!---Taxation --->
  <li><a class="arrow">Taxation</a>
    <ul class="_taxation">
      <li><a href="#Application.url#/AWS/_taxsation/taxationReporting.cfm">Reporting</a></li>
      <li><a href="#Application.url#/AWS/_taxsation/taxationFinancialTaxPlanning.cfm">Financial &amp; Tax Planning</a></li>
      <li><a href="#Application.url#/AWS/_taxsation/taxationNotices.cfm">Notices</a></li>
      <li><a href="#Application.url#/AWS/_taxsation/taxationPowerofAttorney.cfm">Power of Attorney</a></li>
      <li><a href="#Application.url#/AWS/_taxsation/taxationTaxReturns.cfm">Tax Returns</a></li>
    </ul>
  </li>
  <!---Client Management --->
  <li><a class="arrow">Client Management</a>
    <ul class="_clientmanagement">
      <li><a href="#Application.url#/AWS/_clientManagement/clientReporting.cfm">Reporting</a></li>
      <li><a href="#Application.url#/AWS/_clientManagement/clientAdministrativeTasks.cfm">Administrative Tasks</a></li>
      <li><a href="#Application.url#/AWS/_clientManagement/clientMaintenance.cfm">Client Maintenance</a></li>
      <li><a href="#Application.url#/AWS/_clientManagement/clientCommunications.cfm">Communication</a></li>
      <li><a href="#Application.url#/AWS/_clientManagement/clientDocumentTrackingLog.cfm">Document Tracking Log</a></li>
    </ul>
  </li>
  <!---Practice Management --->
  <li><a class="arrow">Practice Management</a>
    <ul class="_practicemanagement dropToLeft">
      <li><a href="#Application.url#/AWS/_PracticeManagement/practiceWorkInProgress.cfm">Work in Progress</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/practiceEmployeeDashboard.cfm">Employee Dashboard</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/practiceEmployeeContactInformation.cfm">Employee Contact Information</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/practiceMaintenance.cfm">AWS Maintenance</a></li>
      <li><a href="#Application.url#/AWS/_PracticeManagement/practiceTimeBilling.cfm">Time &amp; Billing</a></li>
    </ul>
</li>
<!--- USER SETTINGS --->
<li style="position:fixed; right:0px"><a class="arrow">#session.user.name#</a>
<ul class="practiceManagement dropToRight">
<li><a href="##">Profile</a></li>
<li><form action="#CGI.script_name#?#CGI.query_string#" method="post"><input type="hidden" name="logout" value="logout" /><a href="##" onclick="parentNode.submit()">Logout </a></form>
</li>
</ul>
</li>
</ul>
</cfoutput>
<!--- END OF MENU--->