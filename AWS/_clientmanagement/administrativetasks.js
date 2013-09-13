$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"administrativetasks.cfc",
	"title":"Client Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client'},CAS_DUEDATE:{title:'Due Date'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#task_id").val(record.CAS_ID);$("#client_id").val(record.CLIENT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"administrativetasks"});'
	})};
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"administrativetasks.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"4","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":''
	})};

//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Load Group1*/case "CAS_ID":var list='task_id,client_id,g1_assignedto,g1_category,g1_completed,g1_daterequested,g1_datestarted,g1_duedate,g1_estimatedtime,g1_instructions,g1_priority,g1_requestedby,g1_status,g1_taskdescription';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","result":""	}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

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
'"]]}'
_saveData({"group":"group1","payload":$.parseJSON(json),page:"administrativetasks"});
break;
/*Save Group2*/
case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"administrativetasks"});
}else{_saveDataCB({'group':'plugins'})}
break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;

case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}catch(err){alert(err)}};

// JavaScript Document// JavaScript Document