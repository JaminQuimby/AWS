<cfcomponent output="true">

<!--- LOAD SELECT BOXES --->
<cffunction name="f_resetPassword" access="remote" output="true">
<cfargument name="email" type="string" required="yes">
<cfargument name="uid" type="uuid" required="no">

<cftransaction action="begin">

<cfquery datasource="AWS" name="fquery" >
UPDATE[ctrl_users]
SET[alt_password]=NEWID()
,[alt_password_timeout]=GETDATE()
WHERE[user_id]=(SELECT TOP(1)[user_id]FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">)
SELECT TOP(1)[alt_password]FROM[ctrl_users]WHERE[email]=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">
</cfquery>

<cfmail 
   from="jamin@qutera.com" 
   to="jamin@qutera.com" 
   username="jamin@qutera.com" password="Monkey1_" server="smtp.office365.com" port="587" useTLS="yes"
   subject="Password Reset Request" 
   type="text/html" > 
   

                This message was sent by an automatic mailer:<br />
                Please do not respond to this email address it is not monitored.<br />
                Password Reset: #this.url#/?reset=#fquery.alt_password#<br />
       
   
   </cfmail>     

<cfset myResult='{"Result":"OK"}'>
<cfreturn myResult>

</cftransaction>
</cffunction>
</cfcomponent>