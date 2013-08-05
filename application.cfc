  <!--- 3/18/2012 Predefined Application Basics ~ Jamin Quimby --->
  <!--- 7/26/2013 Added Base Path ~ Jamin Quimby --->
    <cfcomponent displayname="AWS_REGISTER" output="true" hint="Component for AWS Registration">   
     
    <!--- Set up the application. --->
    <cfset this.applicationtimeout = CreateTimeSpan( 0, 0, 30, 0 ) />	
	<cfset this.sessiontimeout = createTimeSpan( 0, 0, 29, 59 ) />
    <cfset this.name = "AWS" />
    <cfset this.sessionmanagement = true />
<!---
	<cfset Application.path = "/AWS/" />
--->
  <cfset Application.path =  getDirectoryFromPath( getCurrentTemplatePath() )> 
  <cfset Application.url="https://"&CGI.SERVER_NAME>
    <cfset Application.uploadsDirectory = (Application.path  & "\bin\uploads\")>

     
    <!--- Define the page request properties. --->
    <cfsetting
    requesttimeout="20"
    showdebugoutput="true"
	 />

    
    <cffunction
    name="OnApplicationStart"
    access="public"
    returntype="boolean"
    output="false"
    hint="Fires when the application is first created.">

	

    <!--- Return out. --->
    <cfreturn true />
    </cffunction>
     
     
    <cffunction
    name="OnSessionStart"
    access="public"
    returntype="void"
    output="false"
    hint="Fires when the session is first created.">
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
     
    <cffunction
    name="OnRequestStart"
    access="public"

    output="true"
    hint="Fires at first part of page processing.">
 <!--- Define Login Requirements--->
  <cfargument name = "request" required="true"/>     
    
<cfif IsDefined("Form.logout")> 
<cfset StructClear(form)>
<cfset StructClear(session.user)>
</cfif> 


<cfif isDefined("FORM.J_USERNAME") and  isDefined("FORM.J_PASSWORD")>
<cfif FORM.J_USERNAME IS "" OR FORM.J_PASSWORD IS ""> 
<cfoutput><h2>You must enter text in both the User Name and Password fields.</h2></cfoutput>
<cfinclude template="assets/module/login/loginform.cfm">
<cfabort>
<cfelse> 
<cfquery name="loginQuery" dataSource="AWS" cachedwithin="#CreateTimeSpan(0, 0, 0, 0)#">
SELECT[ctrl_users].[user_id],[ctrl_users].[name],[ctrl_users].[role],[ctrl_organization].[orgName]
FROM[ctrl_users]
LEFT OUTER JOIN[ctrl_organization] ON[ctrl_users].[org_id]=[ctrl_organization].[org_id]
WHERE([ctrl_users].[email]=<cfqueryparam value="#FORM.J_USERNAME#" CFSQLTYPE="CF_SQL_VARCHAR">)
AND([ctrl_users].[password]=<cfqueryparam value="#FORM.J_PASSWORD#" CFSQLTYPE="CF_SQL_VARCHAR">)
</cfquery>

<cfif loginQuery.recordCount eq 1>
<cfset Session.user.id = loginQuery.user_id>
<cfset Session.user.name = loginQuery.name>
<cfset Session.user.email = FORM.J_USERNAME>
<cfset Session.user.role = loginQuery.role>
<cfset Session.user.organization = loginQuery.orgName>
</cfif>
<cfif loginQuery.recordCount eq 0>

</cfif>
</cfif> 
</cfif>


 <cfif NOT isDefined('Session.user.ID')>     
<cfinclude template="assets/module/login/loginform.cfm">
<cfabort>
</cfif>
           


  
<cfif structKeyExists( url, "init" )>
<cfset this.onApplicationStart()>
</cfif>
 		
    <!--- Define arguments. --->
     
    <!--- Return out. --->
    <cfreturn true />
    </cffunction>
     
     
    <cffunction
    name="OnRequest"
    access="public"
    returntype="void"
    output="true"
    hint="Fires after pre page processing is complete.">
     
    <!--- Define arguments. --->
    <cfargument
    name="TargetPage"
    type="string"
    required="true"
    />
     
    <!--- Include the requested page. --->
    <cfinclude template="#ARGUMENTS.TargetPage#" />
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
     
    <cffunction
    name="OnRequestEnd"
    access="public"
    returntype="void"
    output="true"
    hint="Fires after the page processing is complete.">
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
     
    <cffunction
    name="OnSessionEnd"
    access="public"
    returntype="void"
    output="false"
    hint="Fires when the session is terminated.">
     
    <!--- Define arguments. --->
    <cfargument
    name="SessionScope"
    type="struct"
    required="true"
    />
     
    <cfargument
    name="ApplicationScope"
    type="struct"
    required="false"
    default="#StructNew()#"
    />
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
     
    <cffunction
    name="OnApplicationEnd"
    access="public"
    returntype="void"
    output="false"
    hint="Fires when the application is terminated.">
     
    <!--- Define arguments. --->
    <cfargument
    name="ApplicationScope"
    type="struct"
    required="false"
    default="#StructNew()#"
    />
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
     
    <cffunction
    name="OnError"
    access="public"
    returntype="void"
    output="true"
    hint="Fires when an exception occures that is not caught by a try/catch.">
     
    <!--- Define arguments. --->
    <cfargument
    name="Exception"
    type="any"
    required="true"
    />
     
    <cfargument
    name="EventName"
    type="string"
    required="false"
    default=""
    />
     
    <!--- Return out. --->
    <cfreturn />
    </cffunction>
     
    </cfcomponent>