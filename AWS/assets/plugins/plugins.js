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
		return 'file_id,file_id,g100_name,g100_description,g100_year,g100_month,g100_day';
		break;
	}
};

_pluginSaveData=function(params){
var options={
	"group":""
	}
$.extend(true, options, params);//turn options into array

var list ='#session.user.plugins#';
var plugin = list.split(",");

for(var i=0; i < valueArray.length; i++){
 alert(plugin[i])
}

}

_pluginSaveDataCB=function(params){	
var options={
	"group":""
	}
$.extend(true, options, params);//turn options into array
    switch(options['group']){
 	   
case"plugins":




break;

 		case"GROUP100":
        
        var json='{"DATA":[["'+
		$("##file_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##g100_day").val()+'","'+
		$("##g100_description").val()+'","'+
		$("##g100_month").val()+'","'+
		$("##g100_name").val()+'","'+
		$("##g100_year").val()+'","'+
		'"]]}'
        alert('saving data	1')
		if($("##isLoaded_group100").val()!=0){
         alert('saving data 2')
		_saveData({payload:$.parseJSON(json),page:"upload","plugin":"group100"});
       
		}
        
        else{
        
        jqMessage({message: "Your data has been saved.",type: "success",autoClose: true});
        
        }

		
		return 'file_id,file_id,g100_name,g100_description,g100_year,g100_month,g100_day';
		
		
		break;
	}
};