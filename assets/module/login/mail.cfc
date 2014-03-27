<cfcomponent output="true">
<cffunction name="f_resetPassword" access="remote" output="true">
<cfargument name="email" type="string" required="yes">
<cfargument name="uid" type="uuid" required="no">
<cftry>

<cfquery datasource="AWS" name="fquery" >
IF(SELECT TOP(1)COUNT([email])FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">)=1
BEGIN
IF(SELECT TOP(1)ISNULL(DATEDIFF(MINUTE,[alt_password_timeout],GETDATE()),1500)FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">) >= '1440'
BEGIN
<!---/*You can Reset your Password*/--->
UPDATE[ctrl_users]
SET[alt_password]=NEWID(),[alt_password_timeout]=GETDATE()
WHERE[user_id]=(SELECT TOP(1)[user_id]FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">)
SELECT TOP(1)[alt_password]FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">
END
ELSE
BEGIN
<!---/*You must wait before you can reset your password*/--->
SELECT'You must wait 24 hours before you can reset your password again.'AS[message]
END
END
ELSE
BEGIN
<!--- User not found: Log Fail Attempt?--->
SELECT'Fail'AS[message]
END


</cfquery>
<cfoutput query="fquery">
<cfif ListFindNoCase( fquery.ColumnList, "alt_password" )>
<cfmail 
   from="reset@awsionline.com" 
   to="#ARGUMENTS.email#" 
   username="reset@awsionline.com" password="AWSI2014" server="smtp.awsionline.com" port="587" useTLS="yes"
   subject="Password Reset Request" 
   type="text/html" > 
<p>
 This email is being sent in response to a password reset request for AWSIOnline.<br/>
 To reset the password for #ARGUMENTS.email#, please click the link below:<br />
 Please do not respond to this email address it is not monitored.<br />
 
 Password Reset: https://#CGI.SERVER_NAME#/?r=#URLEncodedFormat(alt_password)#&e=#ARGUMENTS.email# <br />
 
 This request is valid for 24 hours. If you did not request to reset your password, please email support@awsionline.com<br />
</p>
<cfset myResult='{"result":"OK","URL":"https://#CGI.SERVER_NAME#/?r=#URLEncodedFormat(alt_password)#&e=#ARGUMENTS.email#"}'>
</cfmail>  
</cfif>


<cfif NOT ListFindNoCase( fquery.ColumnList, "alt_password" )>
<cfset myResult='{"result":"Fail","message":"#Message#"}'>
</cfif>
   


<cfreturn myResult>
 </cfoutput>

<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"result":"Error","records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>