<cfparam name="page.plugins.disable" default="">
<cfoutput>
<cfif session.user.plugins neq "">
<cfif ListContains(session.user.plugins, "100") AND NOT ListContains(page.plugins.disable,'100')>
<li><a href="##" #IIF( i eq 100, DE("class='highlight'"), DE("") )# onclick="$('.gf-checkbox').hide();$('##group100').show();_highlight(this);_group100();">Documents</a></li>
</cfif>
<cfif ListContains(session.user.plugins, "101") AND NOT ListContains(page.plugins.disable,'101')>
<li><a href="##" #IIF( i eq 101, DE("class='highlight'"), DE("") )# onclick="$('.gf-checkbox').hide();$('##group101').show();_highlight(this);_group101();">Comments</a></li>
</cfif>
</cfif>
</cfoutput>
