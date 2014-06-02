$(document).ready(function(){_grid1();});

var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_loadit({"query":{"COLUMNS":["G1_STATUS"],"DATA":[[4]]},"list":"g1_status","page":"acctingconsulting"});_toggle("group1,largeMenu");_hide("entrance,smallMenu,group2");_addNewTask();}
	,new_group2:function(){_run.load_group2({open:true});$("#subtask1_id").val(0);_clearfields({"list":"g2_sequence,g2_duedate,g2_completed,g2_estimatedtime,g2_actualtime,g2_note,g2_subtask,g2_assignedto,g2_status,g2_dependancy"});}
	,load_group1:function(params){var options={'open':false};$.extend(true,options,params);_grid1();if(options['open']==true){_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass().addClass("contentbig");$("#group1").accordion({active:0});}if(options['open']==false){_toggle("entrance,smallMenu");_hide("group1,largeMenu");$("#content").removeClass().addClass("contentsmall");$("#group1").accordion({active:0});}}
	,load_group2:function(params){_loadData({"id":"task_id","group":"group2","page":"acctingconsulting"});_grid2();$("#subtask_isLoaded").val(1);var options={'open':false};$.extend(true,options,params);if(options['open']==true){$("#group2").accordion({active:1});$("#subtask_isLoaded").val(1);}if(options['open']==false){$("#group2").accordion({active:0})}}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"acctingconsulting"});}
}
  
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"acctingconsulting.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{MC_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.MC_ID+"',page:'acctingconsulting',group:'group1'});_run.load_group1();","class":"button"},{"name":"no","on_click":"_run.load_group1()","class":"button"}], autoClose: false})});return $img}}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_PRIORITY:{title:'Priority'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To'}			
			,MC_DUEDATE:{title:'Due Date',width:'2%'}
			,MC_ESTTIME:{title:'Estimated Time',width:'2%'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}	
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1","formid":"2"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#task_id").val(record.MC_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"acctingconsulting"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"acctingconsulting.cfc",
	"title":"Subtasks",
	"fields":{MCS_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.MCS_ID+"',page:'acctingconsulting',group:'group2'});_run.load_group2()","class":"button"},{"name":"no","on_click":"_run.load_group2()","class":"button"}], autoClose: false})});return $img}}
		,MCS_SEQUENCE:{title:'Sequence',width:'2%'}
		,MCS_SUBTASKTEXT:{title:'Subtask'}
		,MCS_STATUSTEXT:{title:'Status'}	
		,MCS_DUEDATE:{title:'Due Date',width:'2%'}
		,MCS_ASSIGNEDTOTEXT:{title:'Assigned To'}
 		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"2"}',
	"functions":'$(".trackers #subtask1_id").val(record.MCS_ID);_loadData({"id":"subtask1_id","group":"group2","page":"acctingconsulting"});$("#group2").accordion({active:1});;'
	})};

_loadDataCB=function(query){
try{
if(query!=null){
switch(query.COLUMNS[0]){
/*Group1*/case "MC_ID":var list='task_id,client_id,g1_assignedto,g1_consultingcategory,g1_taskdescription,g1_duedate,g1_estimatedtime,g1_fees,g1_informationreceived,g1_missinginfo,g1_missinginforeceived,g1_paid,g1_priority,g1_projectcompleted,g1_requestforservices,g1_status,g1_workinitiated';_loadit({"query":query,"list":list});_run.load_assets();break;
/*Group2*/case "MCS_ID":var list='subtask1_id,g2_actualtime,g2_assignedto,g2_completed,g2_dependancy,g2_duedate,g2_estimatedtime,g2_note,g2_sequence,g2_status,g2_subtask';_loadit({"query":query,"list":list});break;
/*AssetCategory*/  case "OPTIONDESCRIPTION":var list='g1_taskdescription';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""};
$.extend(true, options, params);//turn options into array
alert(options["group"]);
switch(options["group"]){

case'':_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});break;


case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_consultingcategory").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_informationreceived").val()+'","'+
$("#g1_missinginfo").is(':checked')+'","'+
$("#g1_missinginforeceived").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_projectcompleted").val()+'","'+
$("#g1_requestforservices").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_taskdescription").val()+'","'+
$("#g1_workinitiated").val()+'","'+
'"]]}'

if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_consultingcategory").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Consulting Category",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Consulting Category');}
	}
else if ($("#g1_taskdescription").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Task Description",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Task Description');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1","payload":$.parseJSON(json),page:"acctingconsulting"})
	if(debug){window.console.log('Start Saving Accounting and Consulting tasks');}	
	}
break;

case'group2':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_actualtime").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_dependancy").val()+'","'+
$("#g2_duedate").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_note").val()+'","'+
$("#g2_sequence").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_subtask").val()+'","'+
'"]]}'
if($("#subtask_isLoaded").val()!=0){
if( $("#g2_subtask").val()!=0){
	_saveData({group:"group2",payload:$.parseJSON(json),page:"acctingconsulting"})}
else{jqMessage({message: "You must select a subtask.",type: "info",autoClose: true})}}
else{_saveDataCB({'group':'plugins'})}
break;

case'group2_duplicate':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_acctgroup").val()+'","'+
'"]]}'
if($("#task_isLoaded").val()!=0){
	_saveData({group:"group2_duplicate",payload:$.parseJSON(json),page:"acctingconsulting"})}
	else{jqMessage({message: "You must select a task.",type: "info",autoClose: true})}
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in acctingconsulting.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}};