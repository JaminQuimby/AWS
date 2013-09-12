<cfoutput>
<cfif session.user.plugins neq "">
<cfif ListContains(session.user.plugins, "100")>
<li><a href="##" #IIF( i eq 1, DE("class='highlight'"), DE("") )# onclick="$('.gf-checkbox').hide();$('##group100').show();_highlight(this);_group100();">Documents</a></li>
</cfif>
</cfif>
</cfoutput>
