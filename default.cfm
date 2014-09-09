<link rel="icon" href="favicon.png" type="image/png" />
<link rel="shortcut icon" href="favicon.ico" />
<cfparam name="url.admin" default="0">
<cfif url.admin neq 1 >
<cflocation url="/AWS/_practicemanagement/workinprogress.cfm?user_id=#Session.user.id#">
</cfif>
