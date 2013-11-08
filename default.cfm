<cfsetting showDebugOutput="No">
<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="">
<cfset page.location="">
<cfset page.formid=0>
<cfset page.title="Home">
<cfset page.menuLeft="">
<cfset page.trackers="">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>AWS</title>
<link rel="stylesheet" type="text/css" href="AWS/assets/css/aws.css"/>
<link rel="stylesheet" type="text/css" href="AWS/assets/module/menu/menu.css"/>
<style>
.splash{}
.splash li{ display:inline-block;vertical-align:top;}
.group1{margin-left:15px;text-align:center;}
.group1 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group1 li a{background-color:#F60000;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group1 li a:hover{background-color:#E33C0F;}
.group2{margin-left:15px;text-align:center;}
.group2 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group2 li a{background-color:#1E344E;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group2 li a:hover{background-color:#0D92CD;}
.group3{margin-left:15px;text-align:center;}
.group3 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group3 li a{border-color:#6B1301;background-color:#e46c0a;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group3 li a:hover{background-color:#FFF200;}
.group4{margin-left:15px;text-align:center;}
.group4 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group4 li a{border-color:#154728;background-color:#247639;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group4 li a:hover{background-color:#22B14C;}
.group5{margin-left:15px;text-align:center;}
.group5 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group5 li a{border-color:#8C8C8C;background-color:#a6a6a6;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group5 li a:hover{background-color:#BFBFBF;}
.group6{margin-left:15px;text-align:center;}
.group6 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group6 li a{background-color:#F60000;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group6 li a:hover{background-color:#E33C0F;}
.group7{margin-left:15px;text-align:center;}
.group7 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group7 li a{background-color:#1E344E;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group7 li a:hover{background-color:#0D92CD;}
.group8{margin-left:15px;text-align:center;}
.group8 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group8 li a{border-color:#6B1301;background-color:#e46c0a;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group8 li a:hover{background-color:#FFF200;}
.group9{margin-left:15px;text-align:center;}
.group9 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group9 li a{border-color:#154728;background-color:#247639;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group9 li a:hover{background-color:#22B14C;}
.group10{margin-left:15px;text-align:center;}
.group10 li{align-items:center;justify-content:center;display:flex;border-top:1px solid #fff;}
.group10 li a{border-color:#8C8C8C;background-color:#a6a6a6;align-items:center;justify-content:center;display:flex;height:50px;margin:auto 0;width:150px;cursor:pointer;color:white;}
.group10 li a:hover{background-color:#BFBFBF;}

</style>

</head>

<body>

<!--- Load Left Menus and trackers --->
<cfinclude template="/assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->

<div id="content" class="contentsmall"><nav id="topMenu">

<cfinclude template="/assets/module/menu/menu.cfm">

</nav>


<!--- ENTRANCE --->
<div id="entrance" class="gf-checkbox">



<img src="assets/images/logo_workflow4accountants.PNG" width="269" height="112" alt="Workflow 4 Accountants">
<cfoutput>
<img src="/assets/img/bgnoise.png">
</cfoutput>
<br/>
<ul class="splash">
  <li>

<ul class="group1">
<li>Payroll &amp;Taxes</li>
      <li><a class="arrow" >Reporting</a>

<li><a href="AWS/_payrolltaxes/payrollchecks.cfm">Payroll Checks</a></li>
<li><a href="AWS/_payrolltaxes/payrolltaxes.cfm">Payroll Tax Returns</a></li>
<li><a href="AWS/_payrolltaxes/otherfilings.cfm">Other Filing Requirements</a></li>
</ul>
</li><li>

<ul class="group2">
<li>Accounting Services</li>
      <li><a class="arrow">Reporting</a>

<li><a href="AWS/_accountingservices/businessformation.cfm">Business Formation</a></li>
<li><a href="AWS/_accountingservices/acctingconsulting.cfm">Accounting &amp; Consulting Tasks</a></li>
<li><a href="AWS/_accountingservices/financialstatements.cfm">Financial Statements</a></li>
</ul>
</li><li>

<ul class="group3">
<li>Taxation</li>
      <li><a class="arrow">Reporting</a>

<li><a href="AWS/_taxation/financialtaxplanning.cfm">Financial &amp; Tax Planning</a></li>
<li><a href="AWS/_taxation/notices.cfm">Notices</a></li>
<li><a href="AWS/_taxation/powerofattorney.cfm">Power of Attorney</a></li>
<li><a href="AWS/_taxation/taxreturns.cfm">Tax Returns</a></li>
</ul>
</li><li>

<ul class="group4">
<li>Client Management</li>
      <li><a class="arrow">Reporting</a>
<li><a href="AWS/_clientmanagement/administrativetasks.cfm">Administrative Tasks</a></li>
<li><a href="AWS/_clientmanagement/clientmaintenance.cfm">Client Maintenance</a></li>
<li><a href="AWS/_clientmanagement/communications.cfm">Communications</a></li>
<li><a href="AWS/_clientmanagement/documenttracking.cfm">Document Tracking Log</a></li>
</ul>
</li><li>

<ul class="group5">
<li>Practice Management</li>
<li><a href="#">Work in Progress</a></li>
<li><a href="AWS/_PracticeManagement/employeedashboard.cfm">Employee Dashboard</a></li>
<li><a href="AWS/_PracticeManagement/employeecontactinfo.cfm">Employee Contact Information</a></li>
<li><a class="arrow">AWS Maintenance</a></li>
<li><a href="AWS/assets/plugins/jTimeBilling/timebillingreport.cfm">Time &amp; Billing</a></li>
</ul>
</li><li>

<ul class="group6">
<li><a href="AWS/_payrolltaxes/reports/payrollchecks_report.cfm">Payroll Checks</a></li>
<li><a href="AWS/_payrolltaxes/reports/payrolltaxes_report.cfm">Payroll Taxes</a></li>
<li><a href="AWS/_payrolltaxes/reports/otherfilings_report.cfm">Other Filings</a></li>
</ul>
</li><li>

<ul class="group7">
<li><a href="AWS/_accountingservices/reports/businessformation_report.cfm">Business Formation</a></li>
<li><a href="AWS/_accountingservices/reports/acctingconsulting_report.cfm">Accounting &amp; Consulting</a></li>
<li><a href="AWS/_accountingservices/reports/financialstatements_report.cfm">Financial Statements</a></li>
</ul>
</li><li>

<ul class="group8">
<li><a href="AWS/_taxation/reports/financialtaxplanning_report.cfm">Financial &amp Tax Planning</a></li>
<li><a href="AWS/_taxation/reports/notices_report.cfm">Notices</a></li>
<li><a href="AWS/_taxation/reports/powerofattorney_report.cfm">Power of Attorney</a></li>
<li><a href="AWS/_taxation/reports/taxreturns_report.cfm">Tax Returns</a></li>
</ul>
</li><li>

<ul class="group9">
<li><a href="#this.url#/AWS/_clientmanagement/reports/administrativetasks_report.cfm">Administrative Tasks</a></li>
<li><a href="#this.url#/AWS/_clientmanagement/reports/communications_report.cfm">Communications</a></li>
<li><a href="#this.url#/AWS/_clientmanagement/reports/clientmaintenance_report.cfm">Client Maintenance</a></li>
</ul>
</li><li>

<ul class="group10">
<li><a href="AWS/_PracticeManagement/_maintenance/table.cfm">Table Maintenance</a></li>
<li><a href="AWS/_PracticeManagement/_maintenance/historical.cfm">Historical Data</a></li>
</ul>
</ul>


</div></div>
   <span class="ui-icon ui-icon-arrowthick-1-n">a</span>
</body>
</html>