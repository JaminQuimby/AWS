<!---START OF MENU --->
<!---Payroll and Taxes --->

<ul class="menuH">
  <li><a class="arrow">Payroll &amp; Taxes</a>
    <ul class="payrollTaxes">
      <li><a href="#">Reporting</a></li>
      <li><a href="#">Payroll Checks</a></li>
      <li><a href="#">Payroll Tax Retuns</a></li>
      <li><a href="#">Other Filing Requirements</a></li>
    </ul>
  </li>
  <!---Accounting Services --->
  <li><a class="arrow">Accounting Services</a>
    <ul class="accountingServices">
      <li><a href="../../../_accountingservices/Reporting.cfm">Reporting</a></li>
      <li><a href="../../../_accountingservices/businessFormation.cfm">Business Formation</a></li>
      <li><a href="../../../_accountingservices/acctConsultingTasks.cfm">Accounting &amp; Consulting Tasks</a></li>
      <li><a href="../../../_accountingservices/financialStatements.cfm">Financial Statements</a></li>
    </ul>
  </li>
  <!---Taxation --->
  <li><a class="arrow">Taxation</a>
    <ul class="taxation">
      <li><a href="#">Reporting</a></li>
      <li><a href="#">Financial &amp; Tax Planning</a></li>
      <li><a href="#">Notices</a></li>
      <li><a href="#">Power of Attorney</a></li>
      <li><a href="#">Tax Returns</a></li>
    </ul>
  </li>
  <!---Client Management --->
  <li><a class="arrow">Client Management</a>
    <ul class="clientManagement">
      <li><a href="#">Reporting</a></li>
      <li><a href="#">Administrative Tasks</a></li>
      <li><cfoutput><a href="https://#CGI.SERVER_NAME#/AWS/clientManagement/clientMaintenance.cfm">Client Maintenance</a></cfoutput></li>
      <li><a href="#">Communication</a></li>
      <li><a href="#">Document Tracking Log</a></li>
    </ul>
  </li>
  <!---Practice Management --->
  <li><a class="arrow">Practice Management</a>
    <ul class="practiceManagement dropToLeft">
      <li><a href="#">Work in Progress</a></li>
      <li><a href="#">Employee Dashboard</a></li>
      <li><a href="#">Employee Contact Information</a></li>
      <li><a href="#">AWS Maintenance</a></li>
      <li><a href="#">Time &amp; Billing</a></li>
    </ul>
</li>
<!--- USER SETTINGS --->
<li style="position:fixed; right:0px"><a class="arrow"><cfoutput>#session.user.name#</cfoutput></a>
<ul class="practiceManagement dropToRight">
<li><a href="#">Profile</a></li>
<li><cfoutput><form action="#CGI.script_name#?#CGI.query_string#" method="post"><input type="hidden" name="logout" value="logout" /><a href="##" onclick="parentNode.submit()">Logout </a></form></cfoutput>
</li>
</ul>

</li>
</ul>


<!--- END OF MENU--->