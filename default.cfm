<cfparam name="url.admin" default="0">
<cfif url.admin neq 1>
<cflocation url="/AWS/_practicemanagement/workinprogress.cfm?user_id=#Session.user.id#">
</cfif>

<html>
    <head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

<script>

var j = {
   toggle		:function(s){var a=s.split(",");for(var i=0;i<a.length;i++){$('#'+a[i]).toggle()}}
  ,hide			:function(s){var a=s.split(",");for(var i=0;i<a.length;i++){$('#'+a[i]).hide()}}
  ,rightTrim	:function(s){var a=/^([\w\W]*)(\b\s*)$/;if(a.test(s)){s=s.replace(a,'$1')}return s}
  ,leftTrim		:function(s){var a=/^(\s*)(\b[\w\W]*)$/;if(a.test(s)){s=s.replace(a,'$2')}return s}
  
  
  }

</script>

<button onClick="j.toggle('test3')" value="test">test1</button>
<button onClick="j.hide('test3')" value="test">test2</button>
<button onClick="" id="test3" value="test">test3</button>
<cfdump var='#cgi#'>