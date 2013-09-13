<cfsetting showDebugOutput="No">
<cfoutput>
_pluginURL=function(params){	
	switch(params){
		case"group100":
		return "https://"+window.location.hostname+"/AWS/assets/plugins/jUpload/";
		break;
}};

_pluginLoadData=function(params){	
	switch(params){
 		case"GROUP100":
		return 'file_id,file_id,g100_name,g100_description,g100_year,g100_month,g100_day';
		break;
}};

_pluginSaveData=function(params){
	var options={"group":""};
	var list ='#session.user.plugins#,0';
	var plugin = list.split(',');
	$.extend(true, options, params);
	for(var i=0;i < plugin.length;i++){
	_pluginSaveDataCB({'group':'group'+plugin[i]+''}); 
}};

_pluginSaveDataCB=function(params){	
var options={"group":""}
$.extend(true, options, params);
switch(options['group']){
case"group0":_saveDataCB({'group':'saved'});break;
case"group100":var json='{"DATA":[["'+
		$("##file_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##g100_day").val()+'","'+
		$("##g100_description").val()+'","'+
		$("##g100_month").val()+'","'+
		$("##g100_name").val()+'","'+
		$("##g100_year").val()+'","'+
		'"]]}'
		if($("##isLoaded_group100").val()!=0){
			_saveData({"group":"group100",payload:$.parseJSON(json),page:"upload",plugin:"group100"})}
		else{jqMessage({message: "Your data has been saved.",type: "success",autoClose: true})}
		break;
		default:alert('Plugin data could not be saved.'); break;
}};
</cfoutput>