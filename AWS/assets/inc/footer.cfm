<!---This document is included
jqMessage Required
--->
<cfparam name="page.footer" default="1">
<cfquery datasource="AWS" name="userroles">
SELECT[m_payrolltaxes],[m_accountingservices],[m_taxation],[m_clientmanagement],[g_delete]FROM[v_staffinitials]WHERE[user_id]=<cfqueryparam value="#Session.user.id#"/>
</cfquery>

<cfif page.footer neq 0>
<cfswitch expression="#page.module#">
<cfcase value="_accountingservices"><cfif userroles.m_accountingservices eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_clientmanagement"><cfif userroles.m_clientmanagement eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_maintenance"><cfif Session.user.role eq 1><cfset page.footer = 1></cfif></cfcase>
<cfcase value="_payrolltaxes"><cfif userroles.m_payrolltaxes eq 0><cfset page.footer = 0></cfif></cfcase>
<cfcase value="_taxation"><cfif userroles.m_taxation eq 0><cfset page.footer = 0></cfif></cfcase>
<cfdefaultcase><cfset page.footer = 0></cfdefaultcase>
</cfswitch> 
</cfif>

<cfif page.footer eq 1>
<footer id="footer">
<div class="buttonbox">
<cfoutput>
<a href="##" onclick="_saveData();" class="button">Save</a> | <a href="#this.url##CGI.SCRIPT_NAME#">Cancel</a>
</cfoutput>
</div>
<div><div id="progressbar"></div></div>
</footer>
</cfif>