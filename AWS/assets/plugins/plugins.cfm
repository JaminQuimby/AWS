<cfif session.user.plugins neq "">
<cfif ListContains(session.user.plugins, "100")>
<cfinclude template="jUpload/upload.cfm">
</cfif>
<cfif ListContains(session.user.plugins, "101")>
<cfinclude template="jComment/comment.cfm">
</cfif>
<cfif ListContains(session.user.plugins, "102")>
<cfinclude template="jTimeBilling/timebilling.cfm">
</cfif>
</cfif>