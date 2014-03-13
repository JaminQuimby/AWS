<!---This document is included
jqMessage Required
--->
<cfparam name="page.footer" default="1">
<cfif page.footer neq 0>
<cfswitch expression="#page.module#">
<cfcase value="_accountingservices"><cfif selectRoles.m_accountingservices eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_clientmanagement"><cfif selectRoles.m_clientmanagement eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_maintenance"><cfif Session.user.role eq 1><cfset page.footer = 1></cfif></cfcase>
<cfcase value="_payrolltaxes"><cfif selectRoles.m_payrolltaxes eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_taxation"><cfif selectRoles.m_taxation eq 0><cfset page.footer = 0></cfif></cfcase>
<cfdefaultcase><cfset page.footer = 0></cfdefaultcase>
</cfswitch> 
</cfif>
<cfif page.footer eq 1>
<footer id="footer">
<div class="buttonbox">
<div >
<cfoutput>
<a href="##" onclick="_saveData();" class="button">Save</a> 
<a class="button optional" onclick='jqMessage({message: "Are you sure you wish to close this task? Any unsaved data will be lost. ",type: "warning",autoClose: false,buttons:[{"name":"save","on_click":"_saveData();","class":"button"},{"name":"close","on_click":" window.location = \"#this.url##CGI.SCRIPT_NAME#\" ","class":"button"}]});' >Close</a> 
<a class="button optional" onclick='window.location = "#this.url#/AWS/_clientmanagement/clientmaintenance.cfm?task_id=" + $("##client_id").val() ' style='background-color: ##247639; color:##FFF;'  >Client Maintenance</a>
</cfoutput>
</div>
</div>
</footer>
</cfif>