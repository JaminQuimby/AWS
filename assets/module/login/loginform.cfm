<cfsetting showDebugOutput="No">
<cfset Session.organization.name=UCase("AWS_"&ListFirst(cgi.server_name, "."))>
<cfif  Session.organization.name eq "AWS_sandbox">
<cfset Session.organization.name=UCase("AWS_CJ")>
</cfif>
<cfparam name="URL.r" default="">
<cfparam name="URL.e" default="">
<cfparam name="URL.returnFormat" default="html">
<cfparam name="URL.time" default="false">
<cfparam name="URL.keepalive" default="false">
<cfif URL.returnFormat eq 'json'>{Result:"ERROR","Message":"Not Logged In","group":"error"}<cfabort></cfif>
<cfif URL.time eq true><cfoutput></cfoutput><cfabort></cfif>
<cfif URL.keepalive eq true><cfoutput></cfoutput><cfabort></cfif>
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Accountants' Workflow Solution - Login</title>
<cfoutput>
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/aws.css"/>
</cfoutput>
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.min.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<script type="application/javascript">
_run={
	reset_password:function(params){
options={"e":"","u":""}
if($("#a_password").val()==$("#b_password").val()){c_password=$("#a_password").val()}
$.extend(true,options,params);
$.ajax({
  type: 'GET',
  url:'/assets/module/login/mail.cfc?method=f_resetPassword',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({
    "email":""+options['e']+"",
    "uid":""+options['u']+"",
    "password":""+c_password+""
        })
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
<div>
<table >
<tr>
  <td style="padding:30px"><img src="#this.url#/assets/images/logo_aws.png" alt="Accountants' Workflow Solutions"></td>
  <td style="padding:30px"><div  style="display:inline-block;">
<cfoutput>


<cfif Len(URL.r)gt 1 and Len(URL.e)gt 1>
<H2>Please Enter a new Password</H2>
<div class="message">
 <label for="a_password">Password:</label>
 <input type="password" id="a_password" placeholder="&##xf023;  Password" >
 <label for="b_password">Verify Password:</label>
 <input type="password" id="b_password" placeholder="&##xf023;  Password" >
 <div class="buttonbox"><input type="button" value="Save" onClick='_run.reset_password({"u":"#URL.r#","e":"#URL.e#"})'></div>
</div> 
<cfelse>
<H2>Please Log In</H2>
<div class="message">
<form action="#CGI.script_name#?#CGI.query_string#" method="Post">
 <label for="j_username">Email:</label>
 <input name="j_username" type="email" id="j_username" placeholder="&##xf0e0;  Email Address" >
 <label for="j_password">Password:</label>
 <input type="password" name="j_password" id="j_password" placeholder="&##xf023;  Password" >
<div class="buttonbox"><input type="submit" value="Log In"> | <a href="##" onClick="_run.reset_password({"e":""+$("##j_username").val()+""})">Forgot Password</a></div>
</form>
</div>
</cfif>
</cfoutput>
</div></td>
 </tr>
</table> 
</cfoutput>
</body>
</html>