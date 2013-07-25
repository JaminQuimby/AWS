<cfsetting showDebugOutput="No">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>AWS</title>
<link rel="stylesheet" type="text/css" href="AWS/assets/css/aws.css"/>
<link rel="stylesheet" type="text/css" href="AWS/assets/module/menu/menu.css"/>
</head>

<body>

<!--- HORIZONTAL MENUS --->
<nav id="topMenu"><cfinclude template="AWS/assets/module/menu/menu.cfm"></nav>


    <form action="#CGI.script_name#?#CGI.query_string#" method="Post">
<input type="submit" Name="Logout" value="Logout"> 
    </form>
    
    
</body>
</html>