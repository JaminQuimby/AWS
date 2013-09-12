_pluginURL=function(params){	
	switch(params){
 		case"group100":
		return "https://"+window.location.hostname+"/AWS/assets/plugins/jUpload/";
		break;
	}
};

_pluginLoadData=function(params){	
	switch(params){
 		case"GROUP100":
		return 'file_id,file_id,g100_name,g100_description';
		break;
	}
};

_pluginSaveData=function(params){	
	switch(params){
 		case"GROUP100":
		
var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#fds_id").val()+'","'+
$("#g3_commentdate").val()+'","'+
$("#g3_commenttext").val()+'","'+
'"]]}'

if($("#comment_isLoaded").val()!=0){
_saveData({payload:$.parseJSON(json),page:"upload","plugin":"group100"});
}else{_saveDataCB({'group':'group4'})}
		
		return 'file_id,file_id,g100_name,g100_description';
		
		
		break;
	}
};