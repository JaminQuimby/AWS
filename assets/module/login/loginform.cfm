<cfsetting showDebugOutput="No">
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
	reset_password:function(){
$.ajax({
  type: 'GET',
  url:'/assets/module/login/mail.cfc?method=f_resetPassword',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"email":""+$("#j_username").val()+""})
  },
  success:function(json){alert($.parseJSON(json))},   
  error:function(data){alert($.parseJSON(data))}    
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
<H2>Please Log In</H2>


<cfoutput><form action="#CGI.script_name#?#CGI.query_string#" method="Post">
        <label for="j_username">Email:</label>
        <input name="j_username" type="email" id="j_username" placeholder="&##xf0e0;  Email Address" >
        <label for="j_password">Password:</label>
  <input type="password" name="j_password" id="j_password" placeholder="&##xf023;  Password" >
<div class="buttonbox">
 <input type="submit" value="Log In"> | <a href="##" onClick="_run.reset_password()">Forgot Password</a>
 </div>
    </form>
</cfoutput>


</div>
</body>
</html>