<cfif session.user.plugins neq "">
<cfif ListContains(session.user.plugins, "100")>
<cfinclude template="jUpload/upload.cfm">
</cfif>
</cfif>