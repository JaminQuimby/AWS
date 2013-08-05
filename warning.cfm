<cfsetting enablecfoutputonly="yes">
<!---
|| BEGIN HEADER ||
	
	|| Properties ||
	Author:		Dave Carabetta
	Created:	2/12/2002
	File Name:	warning.cfm
	
	|| Responsibilities ||
	Popup window that alerts the user they have not done anything during the time interval specified
	on the parent page. It gives the option of selecting to stay logged in or loggin out. If no selection
	is made during the time interval set on the onLoad handler, they are automatically logged out.
	
	|| Functional Changes ||
	
	
|| END HEADER ||
--->

<!--- ||OUTPUT || --->
<cfoutput>
<html>
<head>
	<title>Timeout Warning</title>
	<script language="JavaScript" type="text/javascript">
    <!--
    function stayPut() {
		opener.resetTimer();
		opener.focus();
		self.close();
	}
	
	function logout() {
		opener.focus();
		opener.location.href = 'login.cfm';
		self.close();
	}
    //-->
    </script>
</head>

<body bgcolor="##FFFFFF" onLoad="setTimeout('logout()', 10000);">
<font face="arial,helvetica" size="2">
Due to inactivity, you are about to be logged out. If you wish to stay logged in, click "Yes" below. If you select "No" or do not 
respond to this screen within 30 seconds, you will automatically be logged out for security reasons.

<p><div align="center"><a href="javascript:stayPut();">Yes</a>&nbsp;&nbsp;&nbsp;<a href="javascript:logout();">No</a></div></p>
</font>

</body>
</html>
</cfoutput>
<cfsetting enablecfoutputonly="no">