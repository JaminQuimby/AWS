<cfcomponent output="false">
<cffunction name="f_resetPassword" access="remote" output="false">

<cfargument name ="email" type="string" required="yes">
<cfargument name ="uid" type="string" required="no" default="">
<cfargument name ="password" type="string" required="no" default="" >

<cftry>
<cfset e = arguments.email>
<cfset u = arguments.uid>
<cfset p = arguments.password>




<cfif len(u) gt 0> 
	<cfset base=ToString( ToBinary(u) )/>


<cfif ListGetAt(base,2,':') neq e>
	<cfset myResult='{"result":"OK","message":"Account Locked Code 1 - Please contact support@awsionline.com."}'/>
	<cfreturn myResult />
	<cfabort/>
</cfif>

<cfif listlen(base,':') neq 2>
	<cfset myResult='{"result":"OK","message":"Account Locked Code 2 - Please contact support@awsionline.com."}'/>
	<cfreturn myResult />
	<cfabort/>
</cfif>

<cfif listlen(base,':') eq 2>
	<cfset u =ListGetAt(base,1,':') />
	<cfset e =ListGetAt(base,2,':') />
</cfif>

</cfif>




<cfquery datasource="#Session.organization.name#" name="fquery" >
DECLARE 
@r varchar(8000),
@s numeric(4),
@e varchar(500),
@u nvarchar(36),
@p varchar(20),
@m bit,
@uuid AS UNIQUEIDENTIFIER
SET @e = <cfqueryparam cfsqltype="cf_sql_varchar" value="#e#">
SET @u = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u#">
SET @p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#p#">
SET @m =(0)


<cfif Len(u) eq 0>
SET @s = (SELECT TOP(1)ISNULL(DATEDIFF(MINUTE,[alt_password_timeout],GETDATE()),1500)FROM[ctrl_users]WHERE[email]=@e )


IF (@s >=(430))
BEGIN
<!---/*You can Reset your Password*/--->
UPDATE[ctrl_users]
SET[alt_password]=NEWID(),[alt_password_timeout]=GETDATE()
WHERE[user_id]=(SELECT TOP(1)[user_id]FROM[ctrl_users]WHERE[email]=@e )
SET @r=(SELECT TOP(1)[alt_password]FROM[ctrl_users]WHERE[email]=@e )
SET @m='1'
END
IF (@s <=(430))
BEGIN
<!---/*You must wait before you can reset your password*/--->
SET @r='You must wait 8 hours before you can reset your password again.';
END


</cfif>
<cfif Len(u) neq 0>
SET @uuid = CAST(@u AS uniqueidentifier)
SET @s = (SELECT TOP(1)ISNULL(DATEDIFF(MINUTE,[alt_password_timeout],GETDATE()),1500)FROM[ctrl_users]WHERE[email]=@e AND [alt_password]=@uuid)


IF(@s <=(430))
BEGIN
UPDATE[ctrl_users]
SET[alt_password]= null,
[alt_password_timeout]=null,
[password]=@p
WHERE[alt_password]=@uuid and @s <=(430) and email = @e

SET @r='<p>Your password has been reset.</p><p>&nbsp;</p><p><a href="https://#CGI.SERVER_NAME#" class="button">Return to Login</a></p>'
END

IF(@s >=(430) or @s is null)
BEGIN
SET @r='<p>Your password link has timed out please contact support@awsionline.com.</p><p>&nbsp;</p><p><a href="https://#CGI.SERVER_NAME#" class="button">Return to Login</a></p>'
END

</cfif>

SELECT ISNULL(@r,'<p>Your password reset failed please contact support@awsionline.com.</p><p><a href="https://#CGI.SERVER_NAME#" class="button">Return to Login</a></p>')as[response],@m AS[mail]
</cfquery>



<cfoutput query="fquery">
<cfif mail eq "1">
<cfmail 
   from="reset@awsionline.com" 
   to="#ARGUMENTS.email#" 
   username="reset@awsionline.com" password="AWSI2014" server="smtpout.secureserver.net" port="465" useSSL="yes"
   subject="Password Reset Request" 
   type="text/html" > 
<p>
 This email is being sent in response to a password reset request for AWSIOnline.
</p>
<p>
 To reset the password for #ARGUMENTS.email#, please click the link below:
 </p>
  <p>
  <cfset enc = response &':'& ARGUMENTS.email >
 Password Reset: <a href="https://#CGI.SERVER_NAME#/?r=#URLEncodedFormat(ToBase64(enc))#&e=#ARGUMENTS.email#">https://#CGI.SERVER_NAME#/?r=#URLEncodedFormat(ToBase64(enc))#&e=#ARGUMENTS.email#</a>
 </p>
<p>
 Please do not respond to this email address it is not monitored.
 </p>
 <p>
 This request is valid for 24 hours. If you did not request to reset your password, please email support@awsionline.com
</p>
<cfset myResult={"result":"OK","URL":"emailed","message":"
<p>A password reset link has been emailed to your email address on file.</p>
<p>If you do not have access to your email address please contact AWSI Online Support.</p>
<p>&nbsp;</p>
<p><a href='https://#CGI.SERVER_NAME#' class='button'>Return to Login</a></p>"}>
</cfmail>  
</cfif>

<cfif mail eq "0">
<cfset myResult={"result":"OK","message":"#response#"}>
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