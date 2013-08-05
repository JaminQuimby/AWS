<!---This document is included
jqMessage Required
--->
<footer id="footer">
<div class="buttonbox">
<cfoutput>
<a href="##" onclick="_saveData();" class="button">Save</a> | <a href="##" onClick='jqMessage({message: "Warning: Do you wish to quit without saving? ",type: "warning",autoClose: true,duration: 5});'>Cancel</a>
</cfoutput>
</div>
<div><div id="progressbar"></div></div>
</footer>