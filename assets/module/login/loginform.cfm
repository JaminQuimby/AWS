<cfsetting showDebugOutput="No">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>login</title>
<link rel="stylesheet" type="text/css" href="../../../AWS/assets/css/aws.css"/>

<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.min.css"/>
</head>

<body>
<style>
input { font-family: 'FontAwesome'; } 

</style>
<div style="margin:100px;">
<H2>Please Log In</H2>

<cfoutput>    <form action="#CGI.script_name#?#CGI.query_string#" method="Post">
        <label for="j_username">Email:</label>
        <input name="j_username" type="email" id="j_username" placeholder="&##xf0e0;  Email Address" >
        <label for="j_password">Password:</label>
  <input type="password" name="j_password" id="j_password" placeholder="&##xf023;  Password" >
<div class="buttonbox">
 <input type="submit" value="Log In"> | <a href="##">Forgot Password</a>
 </div>
    </form>
</cfoutput>
</div>
</body>
</html>