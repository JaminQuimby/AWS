<cfoutput>
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/menu2/css/default.css" />
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/menu2/css/component.css" />
<script src="#this.url#/AWS/assets/module/menu2/js/modernizr.custom.js"></script>


<div class="container">
<div class="main">
<nav id="cbp-hrmenu" class="cbp-hrmenu">
<ul>  

      
        
        
        <li><a href="##">Practice Management</a>
		<div class="cbp-hrsub _practicemanagement">
		<div class="cbp-hrsub-inner"> 
		<div>
			<h4>Module</h4>
			<ul>
			<li><a href="#this.url#/AWS/_PracticeManagement/workinprogress.cfm">Work in Progress</a></li>
      		<li><a href="#this.url#/AWS/_PracticeManagement/employeecontactinfo.cfm">Employee Contact Information</a></li>
            <li><a href="#this.url#/AWS/assets/plugins/jTimeBilling/timebillingreport.cfm">Time &amp; Billing</a></li>
			</ul>
		</div>
		<div>
			<h4>AWS Maintenance</h4>
			<ul>
		    <li><a href="#this.url#/AWS/_PracticeManagement/_maintenance/table.cfm">Table Maintenance</a></li>
       		<li><a href="#this.url#/AWS/_PracticeManagement/_maintenance/historical.cfm">Historical Data</a></li>
            <cfif Session.user.role eq 1>
            <li><a href="#this.url#/AWS/_PracticeManagement/_maintenance/usersettings.cfm">User Settings</a></li>
            </cfif>
			</ul>
		</div>
   
		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
		</li>
        
        <li><a href="##">Client Management</a>
		<div class="cbp-hrsub _clientmanagement">
		<div class="cbp-hrsub-inner">
        <div>
        	<h4>Module</h4>
			<ul>
			<li><a href="#this.url#/AWS/_clientmanagement/administrativetasks.cfm">Administrative Tasks</a></li>
      		<li><a href="#this.url#/AWS/_clientmanagement/clientmaintenance.cfm">Client Maintenance</a></li>
      		<li><a href="#this.url#/AWS/_clientmanagement/communications.cfm">Communications</a></li>
      		<li><a href="#this.url#/AWS/_clientmanagement/documenttracking.cfm">Document Tracking Log</a></li>
			</ul>
		</div>
		<div>
			<h4>Reporting</h4>
			<ul>
			<li><a href="#this.url#/AWS/_clientmanagement/reports/administrativetasks_report.cfm">Administrative Tasks</a></li>
            <li><a href="#this.url#/AWS/_clientmanagement/reports/clientmaintenance_report.cfm">Client Maintenance</a></li>
       		<li><a href="#this.url#/AWS/_clientmanagement/reports/communications_report.cfm">Communications</a></li>
			</ul>
		</div>
		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
		</li>
        
	
        
        
        
	<li><a href="##">Payroll &amp; Taxes</a>
		<div class="cbp-hrsub _payrolltaxes">
		<div class="cbp-hrsub-inner"> 
        		<div>
			<h4>Module</h4>
			<ul>
			<li><a href="#this.url#/AWS/_payrolltaxes/payrollchecks.cfm">Payroll Checks</a></li>
      		<li><a href="#this.url#/AWS/_payrolltaxes/payrolltaxes.cfm">Payroll Taxes</a></li>
      		<li><a href="#this.url#/AWS/_payrolltaxes/otherfilings.cfm">Other Filings</a></li>
			</ul>
		</div>
		<div>
			<h4>Reporting</h4>
			<ul>
       		<li><a href="#this.url#/AWS/_payrolltaxes/reports/payrollchecks_report.cfm">Payroll Checks</a></li>
       		<li><a href="#this.url#/AWS/_payrolltaxes/reports/payrolltaxes_report.cfm">Payroll Taxes</a></li>
       		<li><a href="#this.url#/AWS/_payrolltaxes/reports/otherfilings_report.cfm">Other Filings</a></li>
			</ul>
		</div>

		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
	</li>
    <li><a href="##">Accounting Services</a>
		<div class="cbp-hrsub _accountingservices">
		<div class="cbp-hrsub-inner"> 
        		<div>
			<h4>Module</h4>
			<ul>
      <li><a href="#this.url#/AWS/_accountingservices/businessformation.cfm">Business Formation</a></li>
      <li><a href="#this.url#/AWS/_accountingservices/acctingconsulting.cfm">Accounting &amp; Consulting Tasks</a></li>
      <li><a href="#this.url#/AWS/_accountingservices/financialstatements.cfm">Financial Statements</a></li>
			</ul>
		</div>
		<div>
			<h4>Reporting</h4>
			<ul>
       <li><a href="#this.url#/AWS/_accountingservices/reports/businessformation_report.cfm">Business Formation</a></li>
       <li><a href="#this.url#/AWS/_accountingservices/reports/acctingconsulting_report.cfm">Accounting &amp; Consulting</a></li>
       <li><a href="#this.url#/AWS/_accountingservices/reports/financialstatements_report.cfm">Financial Statements</a></li>
			</ul>
		</div>

		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
	</li> 
	<li><a href="##">Taxation</a>
		<div class="cbp-hrsub _taxation">
		<div class="cbp-hrsub-inner">
        <div>
			<h4>Module</h4>
			<ul>
			<li><a href="#this.url#/AWS/_taxation/financialtaxplanning.cfm">Financial &amp; Tax Planning</a></li>
      		<li><a href="#this.url#/AWS/_taxation/notices.cfm">Notices</a></li>
      		<li><a href="#this.url#/AWS/_taxation/powerofattorney.cfm">Power of Attorney</a></li>
      		<li><a href="#this.url#/AWS/_taxation/taxreturns.cfm">Tax Returns</a></li>
			</ul>
		</div>
		<div>
			<h4>Reporting</h4>
			<ul>
       		<li><a href="#this.url#/AWS/_taxation/reports/financialtaxplanning_report.cfm">Financial &amp; Tax Planning</a></li>
       		<li><a href="#this.url#/AWS/_taxation/reports/notices_report.cfm">Notices</a></li>
       		<li><a href="#this.url#/AWS/_taxation/reports/powerofattorney_report.cfm">Power of Attorney</a></li>
       		<li><a href="#this.url#/AWS/_taxation/reports/taxreturns_report.cfm">Tax Returns</a></li>
			</ul>
		</div>
		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
	</li>

      <li><a href="##">#session.user.initials#</a>
        <div class="cbp-hrsub _practicemanagement">
		<div class="cbp-hrsub-inner"> 
		<div>
			
			<ul>
            <li><a href="#this.url#/AWS/_PracticeManagement/employeecontactinfo.cfm?userid=#session.user.id#"><h4>About Me</h4></a></li>
			<li><form action="#CGI.script_name#?#CGI.query_string#" method="post"><input type="hidden" name="logout" value="logout" /><a href="##" onclick="parentNode.submit()">Logout </a></form></li>
            </ul>
        </div>
		</div><!-- /cbp-hrsub-inner -->
		</div><!-- /cbp-hrsub -->
        </li>
    
</ul>
</nav>
</div>
</div>
<script src="#this.url#/AWS/assets/module/menu2/js/cbpHorizontalMenu.min.js"></script>
<script>
$(function() {
cbpHorizontalMenu.init();
});
</script></cfoutput>