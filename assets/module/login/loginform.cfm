<cfsetting showDebugOutput="No">
<cfset Session.organization.name=UCase("AWS_"&ListFirst(cgi.server_name, "."))>

<cfparam name="URL.r" default="">
<cfparam name="URL.e" default="">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>login</title>
<cfoutput>
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/aws.css"/>
</cfoutput>
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.min.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="application/javascript">
_run={
	reset_password:function(params){
options={"r":"","e":""}		
$.ajax({
  type: 'GET',
  url:'/assets/module/login/mail.cfc?method=f_resetPassword',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"email":""+$("#j_username").val()+""})
  },
  success:function(json){var d=$.parseJSON(json);$('.message').html('<br/>'+d.message);},   
  error:function(json){  var d=$.parseJSON(json);$('.message').html('<br/>'+d.message);}    
  });
}}

</script>
</head>

<body>
<style>
input { font-family: 'FontAwesome'; } 
</style>
<cfoutput>
<div style="display:inline-block; margin:30px;"><img src="#this.url#/assets/images/logo_workflow4accountants.png" alt="AWS Online" width="75%"></div>
</cfoutput>
<div  style="display:inline-block;">
<H1>Workflow 4 Accountants</H1>
<br/>

<cfoutput>


#Session.organization.name#

<cfif Len(URL.r)gt 1 and Len(URL.e)gt 1>
<H2>Please Enter a new Password</H2>
<div class="message">
 <label for="a_password">Password:</label>
 <input type="password" id="a_password" placeholder="&##xf023;  Password" >
 <label for="b_password">Verify Password:</label>
 <input type="password" id="b_password" placeholder="&##xf023;  Password" >
 <div class="buttonbox"><input type="button" value="Save" onClick='_run.reset_password({"UID":"#URL.r#","e":"#URL.e#"})'></div>
</div> 
<cfelse>
<H2>Please Log In</H2>
<div class="message">
<form action="#CGI.script_name#?#CGI.query_string#" method="Post">
 <label for="j_username">Email:</label>
 <input name="j_username" type="email" id="j_username" placeholder="&##xf0e0;  Email Address" >
 <label for="j_password">Password:</label>
 <input type="password" name="j_password" id="j_password" placeholder="&##xf023;  Password" >
<div class="buttonbox"><input type="submit" value="Log In"> | <a href="##" onClick="_run.reset_password()">Forgot Password</a></div>
</form>
</div>
</cfif>
</cfoutput>
</div>
</body>
</html>