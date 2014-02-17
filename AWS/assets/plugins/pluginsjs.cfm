<cfsetting showDebugOutput="No">
<cfparam name="page.plugins.disable" default="">
<cfoutput>
_pluginURL=function(params){
switch(params){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"group#i#":return _pluginURL#i#();break;</cfif></cfloop>
default:return eval('_pluginURL'+params+'()');break;}

};
_pluginLoadData=function(params){switch(params){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"GROUP#i#":return _pluginLoadData#i#(); break;</cfif></cfloop>}};
_pluginSaveData=function(params){
var options={"group":"","subgroup":""};$.extend(true, options, params);
if(options['subgroup']!=''){_pluginSaveDataCB({'group':'subgroup0','subgroup':''+options['subgroup']+''})};
if(options['subgroup']==''){<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>_pluginSaveDataCB({'group':'group#i#'});</cfif></cfloop>}

}

_pluginSaveDataCB=function(params){	
var options={"group":""}
$.extend(true, options, params);

switch(options['group']){
case"group0":_saveDataCB({'group':'saved'});break;
<cfloop index="i" list="#session.user.plugins#"><cfif !ListContains(#page.plugins.disable#,#i#)>case"group#i#":_pluginSaveData#i#();break;</cfif></cfloop>
case"subgroup0":eval("_pluginSaveData"+options['subgroup']+"()"); break;
default:console.log('Plugin data does not need to be saved for group' + options['group']);break;}};
</cfoutput>