

<cfif session.user.plugins neq "">
<cfif ListContains(session.user.plugins, "100")>
<cfinclude template="/assets/plugins/jUpload/upload.cfm">
</cfif>
<cfif ListContains(session.user.plugins, "101")>
<cfinclude template="/assets/plugins/jComment/comment.cfm">
</cfif>
<cfif ListContains(session.user.plugins, "102")>
<cfinclude template="/assets/plugins/jTimeBilling/timebilling.cfm">
</cfif>
</cfif>