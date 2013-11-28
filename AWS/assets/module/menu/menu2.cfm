<cfoutput>

<div class="navbar navbar-default navbar-static-top" role="navigation" style="   background: none repeat scroll 0 0 ##EFEFEF;
    border-bottom: 1px solid ##BBBBBB;
    float: none;
    height: 36px;
    list-style: none outside none;
    margin: 0;
    padding: 0;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 8000;">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="##"><span class="glyphicon glyphicon-home"></span></a>
    
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    <ul class="nav navbar-nav">
     
       <!---Payroll & Taxes --->
<li class="dropdown"><a href="##" class="dropdown-toggle" data-toggle="dropdown">Payroll &amp; Taxes <b class="caret"></b></a>
<ul class="_payrolltaxes dropdown-menu">
       <li><a href="#this.url#/AWS/_payrolltaxes/reports/payrollchecks_report.cfm">Payroll Check Reports</a></li>
       <li><a href="#this.url#/AWS/_payrolltaxes/reports/payrolltaxes_report.cfm">Payroll Tax Reports</a></li>
       <li><a href="#this.url#/AWS/_payrolltaxes/reports/otherfilings_report.cfm">Other Filing Reports</a></li>
      <li class="divider"></li>
      <li><a href="#this.url#/AWS/_payrolltaxes/payrollchecks.cfm">Payroll Checks</a></li>
      <li><a href="#this.url#/AWS/_payrolltaxes/payrolltaxes.cfm">Payroll Taxes</a></li>
      <li><a href="#this.url#/AWS/_payrolltaxes/otherfilings.cfm">Other Filings</a></li>
    </ul>
  </li>
   <!---Taxation --->
       <li class="dropdown"><a href="##" class="dropdown-toggle" data-toggle="dropdown">Taxation <b class="caret"></b></a>
      <ul class="dropdown-menu _taxation">
       <li><a href="#this.url#/AWS/_taxation/reports/financialtaxplanning_report.cfm">Financial &amp Tax Planning Reports</a></li>
       <li><a href="#this.url#/AWS/_taxation/reports/notices_report.cfm">Notices Reports</a></li>
       <li><a href="#this.url#/AWS/_taxation/reports/powerofattorney_report.cfm">Power of Attorney Reports</a></li>
       <li><a href="#this.url#/AWS/_taxation/reports/taxreturns_report.cfm">Tax Returns Reports</a></li>
      <li class="divider"></li>
      <li><a href="#this.url#/AWS/_taxation/financialtaxplanning.cfm">Financial &amp; Tax Planning</a></li>
      <li><a href="#this.url#/AWS/_taxation/notices.cfm">Notice Matter</a></li>
      <li><a href="#this.url#/AWS/_taxation/powerofattorney.cfm">Power of Attorney</a></li>
      <li><a href="#this.url#/AWS/_taxation/taxreturns.cfm">Tax Returns</a></li>
    </ul>
</li>
  <!---Client Management --->
<li class="dropdown"><a href="##" class="dropdown-toggle" data-toggle="dropdown">Client Management <b class="caret"></b></a>
    <ul class="dropdown-menu _clientmanagement">
    <li><a href="#this.url#/AWS/_clientmanagement/reports/administrativetasks_report.cfm">Administrative Task Reports</a></li>
    <li><a href="#this.url#/AWS/_clientmanagement/reports/communications_report.cfm">Communications Reports</a></li>
    <li><a href="#this.url#/AWS/_clientmanagement/reports/clientmaintenance_report.cfm">Client Maintenance Reports</a></li>
  	<li class="divider"></li>
    <li><a href="#this.url#/AWS/_clientmanagement/administrativetasks.cfm">Administrative Tasks</a></li>
    <li><a href="#this.url#/AWS/_clientmanagement/clientmaintenance.cfm">Client Maintenance</a></li>
    <li><a href="#this.url#/AWS/_clientmanagement/communications.cfm">Communication</a></li>
    <li><a href="#this.url#/AWS/_clientmanagement/documenttracking.cfm">Document Tracking Log</a></li>
    </ul>
</li>

  <!---Accounting Services --->
       <li class="dropdown">
      <a href="##" class="dropdown-toggle" data-toggle="dropdown">Accounting Services <b class="caret"></b></a>
    <ul class="dropdown-menu _accountingservices">
       <li><a href="#this.url#/AWS/_accountingservices/reports/businessformation_report.cfm">Business Formation Reports</a></li>
       <li><a href="#this.url#/AWS/_accountingservices/reports/acctingconsulting_report.cfm">Accounting &amp; Consulting Reports</a></li>
       <li><a href="#this.url#/AWS/_accountingservices/reports/financialstatements_report.cfm">Financial Statements Reports</a></li>
	<li class="divider"></li>
      <li><a href="#this.url#/AWS/_accountingservices/businessformation.cfm">Business Formation</a></li>
      <li><a href="#this.url#/AWS/_accountingservices/acctingconsulting.cfm">Accounting &amp; Consulting Tasks</a></li>
      <li><a href="#this.url#/AWS/_accountingservices/financialstatements.cfm">Financial Statements</a></li>
    </ul>
  </li>
  
  <!---Practice Management --->
<li class="dropdown"><a href="##" class="dropdown-toggle" data-toggle="dropdown">Practice Management <b class="caret"></b></a>
   	<ul class="dropdown-menu _practicemanagement">
    <li><a href="#this.url#/AWS/_PracticeManagement/workinprogress.cfm">Work in Progress</a></li>
    <li><a href="#this.url#/AWS/_PracticeManagement/employeedashboard.cfm">Employee Dashboard</a></li>
    <li><a href="#this.url#/AWS/_PracticeManagement/employeecontactinfo.cfm">Employee Contact Information</a></li>
	<li class="divider"></li>
    <li><a href="#this.url#/AWS/_PracticeManagement/_maintenance/table.cfm">Table Maintenance</a></li>
    <li><a href="#this.url#/AWS/_PracticeManagement/_maintenance/historical.cfm">Historical Data</a></li>
    <li><a href="#this.url#/AWS/assets/plugins/jTimeBilling/timebillingreport.cfm">Time &amp; Billing</a></li>
    </ul>
</li>
    </ul>
<!--- NAV BAR RIGHT SIDE --->
    <ul class="nav navbar-nav navbar-right">
      <li class="dropdown">
        <a href="##" class="dropdown-toggle" data-toggle="dropdown">#session.user.name# <b class="caret"></b></a>
        <ul class="dropdown-menu">
	<li><a href="##">Profile</a></li>
		<li><form action="#CGI.script_name#?#CGI.query_string#" method="post"><input type="hidden" name="logout" value="logout" /><a href="##" onclick="parentNode.submit()">Logout </a></form></li>

        </ul>
      </li>
    </ul>
  </div><!-- /.navbar-collapse -->
</div>

</cfoutput>