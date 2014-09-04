<cfset StructClear(session)>
<cfcookie name="cftoken" expires="now"/>
<cfcookie name="cfid" expires="now"/>
<cflocation url="#this.url#/AWS/_PracticeManagement/workinprogress.cfm" addtoken="false" />
 