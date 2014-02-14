<cfsetting showDebugOutput="No">
<cfheader name="Access-Control-Allow-Origin" value="*">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>login</title>
<link rel="stylesheet" type="text/css" href="../../../AWS/assets/css/aws.css"/>
<link rel="stylesheet" type="text/css" href="../../../AWS/assets/css/loginform.css"/>

</head>

<body>

<div style="margin:100px;">
<H2>Please Log In</H2>
<cfoutput>
    <form action="#CGI.script_name#?#CGI.query_string#" method="Post">
        <label for="j_username">user name:</label>
        <input name="j_username" type="email" id="j_username" >
        <label for="j_password">password:</label>
  <input type="password" name="j_password" id="j_password" >
<div class="buttonbox">
 <input type="submit" value="Log In"> | <a href="##">forgot password</a>
 </div>
    </form>
</cfoutput>
</div>
</body>
</html>