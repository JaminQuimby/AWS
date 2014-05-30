$(document).ready(function(){_grid1();});

var _run={
	  new_group1:function(){document.getElementById("content").className="contentbig";_loadit({"query":{"COLUMNS":["G1_STATUS"],"DATA":[[4]]},"list":"g1_status","page":"acctingconsulting"});_toggle("group1,largeMenu");_hide("entrance,smallMenu");_addNewTask();}
	 ,load_group1:function(){_grid1();}
	 ,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"administrativetasks"});}
}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"administrativetasks.cfc",
	"title":"Client Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.CAS_ID+"',page:'administrativetasks',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_ID:{list:false,edit:false}
		,CLIENT_NAME:{title:'Client Name'}
		,CAS_COMPLETED:{title:'Completed',width:'2%'}
		,CAS_STATUSTEXT:{title:'Status',width:'2%'}
		,CAS_PRIORITY:{title:'Priority',width:"1%"}
		,CAS_ASSIGNEDTOTEXT:{title:'Assigned To'}
		,CAS_DUEDATE:{title:'Due Date',width:"1%"}
		,CAS_ESTTIME:{title:'Estimated Time'}
		,CAS_CATEGORYTEXT:{title:'Category'}
		,CAS_TASKDESC:{title:'Task Description'}					
		},			
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1","formid":"4"}',
	"functions":'$("#task_id").val(record.CAS_ID);$("#client_id").val(record.CLIENT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"administrativetasks"});'
	})};


//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Load Group1*/case "CAS_ID":var list='task_id,client_id,g1_assignedto,g1_category,g1_completed,g1_daterequested,g1_datestarted,g1_duedate,g1_estimatedtime,g1_instructions,g1_priority,g1_requestedby,g1_status,g1_taskdescription,g1_workinitiated';_loadit({"query":query,"list":list});_run.load_assets();break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
	
case'':_saveDataCB({'group':'group1'});break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_category").val()+'","'+
$("#g1_completed").val()+'","'+
$("#g1_daterequested").val()+'","'+
$("#g1_datestarted").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_instructions").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_requestedby").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_taskdescription").val()+'","'+
$("#g1_workinitiated").val()+'","'+
'"]]}'

if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_category").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Category",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Category');}
	}
else if ($("#g1_taskdescription").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Task Description",type: "error",autoClose: false});
	if(debug){window.console.log('Missing  Task Description');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({"group":"group1","payload":$.parseJSON(json),page:"administrativetasks"});
	if(debug){window.console.log('Start Saving Administrative Tasks');}	
	}	
	


break;
/*Start Saving Plugins*/
case"plugins":
$('#task_id').val(options['id']);_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in administrativetasks.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}catch(err){jqMessage({message: "Error :"+err+" ",type: "Error",autoClose: true});}};

// JavaScript Document// JavaScript Document