$(document).ready(function(){_grid1();});

var _run={
	new_task:function(){document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2');}
	,load_group1:function(){}
	}

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"documenttracking.cfc",
	"title":"Document Tracking",
	"fields":{DT_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.DT_ID+"',page:'documenttracking',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_ID:{list:false,edit:false}
		,DT_DATE:{title:'Date',width:'1%'}
		,CLIENT_NAME:{title:'Client Name'}
		,DT_SENDER:{title:'Sender'}
		,DT_STAFF:{title:'Received By'}
		,DT_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
		,DT_DESCRIPTION:{title:'Description'}
		,DT_ROUTING:{title:'Routing'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#file_id").val(record.FILE_ID);$("#task_id").val(record.DT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"documenttracking"});'
	})};
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "DT_ID":var list='task_id,client_id,g1_assignedto,g1_date,g1_description,g1_routing,g1_sender,g1_staff';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
case'':
if($("#client_id").val()>0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Client*/
case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_date").val()+'","'+
$("#g1_description").val()+'","'+
$("#g1_routing").val()+'","'+
$("#g1_sender").val()+'","'+
$("#g1_staff").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"documenttracking"});
break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in documenttracking.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};