<cfsetting showDebugOutput="No">
<cfparam name="page.plugins.disable" default="">
<cfoutput>
_pluginURL=function(params){switch(params){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"group#i#":return _pluginURL#i#();break;</cfif></cfloop>}};
_pluginLoadData=function(params){switch(params){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"GROUP#i#":return _pluginLoadData#i#(); break;</cfif></cfloop>}};
_pluginSaveData=function(params){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>_pluginSaveDataCB({'group':'group#i#'});</cfif></cfloop>};
_pluginSaveDataCB=function(params){	
var options={"group":""}
$.extend(true, options, params);
alert(options['group']);
switch(options['group']){
case"group102_1":alert('Hello ?'); break;
case"group0":_saveDataCB({'group':'saved'});break;
<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"group#i#":_pluginSaveData#i#();break;</cfif></cfloop>
default:alert('Plugin data could not be saved.');break;}};
</cfoutput>