<cfsetting showDebugOutput="No">
<cfoutput>
_pluginURL=function(params){switch(params){<cfloop index="i" list="#session.user.plugins#">case"group#i#":return _pluginURL#i#();break;</cfloop>}};
_pluginLoadData=function(params){switch(params){<cfloop index="i" list="#session.user.plugins#">case"GROUP#i#":_pluginLoadData#i#();break;</cfloop>}};
_pluginSaveData=function(params){<cfloop index="i" list="#session.user.plugins#">_pluginSaveDataCB({'group':'group#i#'});</cfloop>};

_pluginSaveDataCB=function(params){	
var options={"group":""}
$.extend(true, options, params);
switch(options['group']){
case"group0":_saveDataCB({'group':'saved'});break;
<cfloop index="i" list="#session.user.plugins#">case"group#i#":_pluginSaveData#i#();break;</cfloop>
default:alert('Plugin data could not be saved.');break;}};
</cfoutput>