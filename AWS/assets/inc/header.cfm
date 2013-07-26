<head>
<meta "charset=utf-8" />
<cfoutput><title>#session.title#</title></cfoutput>
<cfinclude template="require.cfm" />
<cfoutput>
<link rel="stylesheet" type="text/css" href="#session.location#.css">
<script type="text/javascript" src="#session.location#.js"></script>
</cfoutput>
</head>