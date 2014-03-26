$(document).ready(function(){_grid1();});

var _run={
	  new_group1:function(){document.getElementById("content").className="contentbig";_loadit({"query":{"COLUMNS":["G1_STATUS"],"DATA":[[4]]},"list":"g1_status","page":"businessformation"});_toggle("group1,largeMenu");_hide("entrance");_addNewTask();}
	 ,new_group2:function(){$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);$("#subtask1_id").val(0);}
	 ,load_group1:function(){_grid1();}
	 ,load_group1_1:function(){_loadData({"id":"task_id","group":"group1_1","page":"businessformation"});$("#isLoaded_group1_1").val(1);}
	 ,load_group1_2:function(){_loadData({"id":"task_id","group":"group1_2","page":"businessformation"});$("#isLoaded_group1_2").val(1);}
	 ,load_group1_3:function(){_loadData({"id":"task_id","group":"group1_3","page":"businessformation"});$("#isLoaded_group1_3").val(1);}
	 ,load_group1_4:function(){_loadData({"id":"task_id","group":"group1_4","page":"businessformation"});$("#isLoaded_group1_4").val(1);}
	 ,load_group1_5:function(){_loadData({"id":"task_id","group":"group1_5","page":"businessformation"});$("#isLoaded_group1_5").val(1);}
	 ,load_group2:function(){_grid2();}
	 ,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"businessformation"});}
	 }
	 

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"businessformation.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.BF_ID+"',page:'businessformation',group:'group1'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_ID:{list:false,edit:false}
		,CLIENT_NAME:{title:'Client Name'}
		,BF_ACTIVITY:{title:'Activity'}
		,BF_OWNERS:{title:'Owners'}
		,BF_BUSINESSTYPETEXT:{title:'Business Type'}
		,BF_DUEDATE:{title:'Due Date',width:'1%'}
		,BF_STATUSTEXT:{title:'Status'}
		,BF_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1","formid":"3"}',
	"functions":'$("#task_id").val(record.BF_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"businessformation"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"businessformation.cfc",
	"title":"Business Formation Subtask",
	"fields":{BFS_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.BFS_ID+"',page:'businessformation',group:'group2'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,BFS_TASKNAME:{title:'Task'}
		,BFS_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
        ,BFS_DATEINITIATED:{title:'Date Initiated',width:'1%'}
		,BFS_DATECOMPLETED:{title:'Date Completed',width:'1%'}
		,BFS_ESTIMATEDTIME:{title:'Estimated Time'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$("#subtask1_id").val(record.BFS_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"businessformation"});'
	})};


_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "BF_ID":var list='task_id,client_id,g1_activity,g1_assignedto,g1_g5_businesscreceived,g1_g5_businesssubmitted,g1_g5_businesstype,g1_dateinitiated,g1_duedate,g1_estimatedtime,g1_fees,g1_owners,g1_paid,g1_priority,g1_status';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_1*/case "BF_ARTICLESAPPROVED":var list='g1_g1_articlesapproved,g1_g1_articlessubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_2*/case "BF_TRADENAMERECEIVED":var list='g1_g2_tradenamereceived,g1_g2_tradenamesubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_3*/case "BF_MINUTESBYLAWSDRAFT":var list='g1_g3_minutesbylawsdraft,g1_g3_minutesbylawsfinal,g1_g3_minutescompleted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_4*/case "BF_DISSOLUTIONCOMPLETED":var list='g1_g4_disolutioncompleted,g1_g4_dissolutionrequested,g1_g4_dissolutionsubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_5*/case "BF_OTHERACTIVITY":var list='g1_g5_otheractivity,g1_g5_othercompleted,g1_g5_otherstarted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group2*/case "BFS_ID":var list='subtask1_id,g2_assignedto,g2_completed,g2_dateinitiated,g2_esttime,g2_task';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);
switch(options["group"]){
	
case'':_saveDataCB({'group':'group1'});break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_activity").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_g5_businesstype").val()+'","'+
$("#g1_g5_businesscreceived").val()+'","'+
$("#g1_g5_businesssubmitted").val()+'","'+
$("#g1_dateinitiated").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_owners").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_status").val()+'","'+
'"]]}';

if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_owners").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Owners",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Owners');}
	}
else if ($("#g1_activity").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Activity",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Activity');}
	}
else if(_duplicateCheck({"check":[{"item":"client_id"},{"item":"g1_owners"},{"item":"g1_activity"}],"loadType":"group1","page":"businessformation"})=='true'&&$('#task_id').val()=='0'){
	jqMessage({"type":"destroy"});jqMessage({message: "This task already exsists.",type: "error",autoClose: false});
	if(debug){window.console.log('This task already exsists.');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1",payload:$.parseJSON(json),page:"businessformation"});
	if(debug){window.console.log('Start Saving Business Formation');}	
	}	
break;

case'group1_1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g1_articlesapproved").val()+'","'+
$("#g1_g1_articlessubmitted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'group1_2'})};
break;

case'group1_2':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g2_tradenamereceived").val()+'","'+
$("#g1_g2_tradenamesubmitted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'group1_3'})};
break;

case'group1_3':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g3_minutesbylawsdraft").val()+'","'+
$("#g1_g3_minutesbylawsfinal").val()+'","'+
$("#g1_g3_minutescompleted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'group1_4'})};
break;

case'group1_4':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g4_disolutioncompleted").val()+'","'+
$("#g1_g4_dissolutionrequested").val()+'","'+
$("#g1_g4_dissolutionsubmitted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'group1_5'})};
break;

case'group1_5':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g5_otheractivity").val()+'","'+
$("#g1_g5_othercompleted").val()+'","'+
$("#g1_g5_otherstarted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'group2'})};
break;

case'group2':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_dateinitiated").val()+'","'+
$("#g2_esttime").val()+'","'+
$("#g2_task").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in businessformation.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};