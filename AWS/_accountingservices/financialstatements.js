$(document).ready(function(){_grid1();});

var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_loadit({"query":{"COLUMNS":["G1_STATUS"],"DATA":[[4]]},"list":"g1_status","page":"financialstatements"});_toggle("group1,largeMenu");_hide("entrance,smallMenu,group2");_addNewTask();}
	,new_group2:function(){$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);$("#subtask1_id").val("0");_loadit({"query":{"COLUMNS":["G2_STATUS"],"DATA":[[4]]},"list":"g2_status","page":"financialstatements"});_clearfields({"list":"g2_assignedto,g2_completed,g2_duedate,g2_notes,g2_sequence,g2_status,g2_subtask,g2_dependencies"});	 }
	,new_clone1:function(){jqMessage({message: "Warning: Would you like to import the selected group?.", "type":"warning", autoClose: false,buttons:[{"name":"Save","on_click":"_saveDataCB({\"group\":\"group2_clone1\"});_grid2();","class":"optional"},{"name":"Exit","on_click":"","class":"optional"}]})}
	,new_clone2:function(){jqMessage({message: "Warning: Would you like to import the selected history?.", "type":"warning", autoClose: false,buttons:[{"name":"Save","on_click":"_saveDataCB({\"group\":\"group2_clone2\"});_grid2();","class":"optional"},{"name":"Exit","on_click":"","class":"optional"}]})}
	,load_group1:function(){_grid1();_run.load_select_clone2();}
	,load_group1_1:function(){if($("#isLoaded_group1_1").val()=="0"){_loadData({"id":"task_id","group":"group1_1","page":"financialstatements"});$("#isLoaded_group1_1").val(1);}}
	,load_group1_2:function(){if($("#isLoaded_group1_2").val()=="0"){_loadData({"id":"task_id","group":"group1_2","page":"financialstatements"});$("#isLoaded_group1_2").val(1);}}
	,load_group1_3:function(){if($("#isLoaded_group1_3").val()=="0"){_loadData({"id":"task_id","group":"group1_3","page":"financialstatements"});$("#isLoaded_group1_3").val(1);}}
	,load_group1_4:function(){if($("#isLoaded_group1_4").val()=="0"){_loadData({"id":"task_id","group":"group1_4","page":"financialstatements"});$("#isLoaded_group1_4").val(1);}}
	,load_group1_5:function(){if($("#isLoaded_group1_5").val()=="0"){_loadData({"id":"task_id","group":"group1_5","page":"financialstatements"});$("#isLoaded_group1_5").val(1);}}
	,load_group1_6:function(){if($("#isLoaded_group1_6").val()=="0"){_loadData({"id":"task_id","group":"group1_6","page":"financialstatements"});$("#isLoaded_group1_6").val(1);}}
	,load_group1_7:function(){if($("#isLoaded_group1_7").val()=="0"){_loadData({"id":"task_id","group":"group1_7","page":"financialstatements"});$("#isLoaded_group1_7").val(1);}}
	,load_group1_8:function(){if($("#isLoaded_group1_8").val()=="0"){_loadData({"id":"task_id","group":"group1_8","page":"financialstatements"});$("#isLoaded_group1_8").val(1);}}
	,load_group1_9:function(){if($("#isLoaded_group1_9").val()=="0"){_loadData({"id":"task_id","group":"group1_9","page":"financialstatements"});$("#isLoaded_group1_9").val(1);}}
	,load_group1_10:function(){if($("#isLoaded_group1_10").val()=="0"){_loadData({"id":"task_id","group":"group1_10","page":"financialstatements"});$("#isLoaded_group1_10").val(1);}}
	,load_group1_11:function(){if($("#isLoaded_group1_11").val()=="0"){_loadData({"id":"task_id","group":"group1_11","page":"financialstatements"});$("#isLoaded_group1_11").val(1);}}
	,load_group2:function(){_grid2();_clearfields({"list":"g2_completed,g2_duedate,g2_notes,g2_sequence,g2_assignedto,g2_status,g2_subtask,g2_dependencies"});$('#subtask1_id').val('0');_run.load_select_clone2()}
	,load_select_clone2:function(){_loadSelect({'selectName':'g2_history','selectObject':'g2_history',"option1":""+$("#client_id").val()+"",'page':'financialstatements'});}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"financialstatements"});_loadData({"id":"task_id","group":"assetCompTask","page":"financialstatements"});}
}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialstatements.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.FDS_ID+"',page:'financialstatements',group:'group1'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_ID:{list:false,edit:false}
		,CLIENT_NAME:{title:'Client Name'}
		,FDS_YEAR:{title:'Year',width:'1%'}
		,FDS_MONTHTEXT:{title:'Period'}
		,FDS_PERIODEND:{title:'Period End',width:'1%'}
		,FDS_DUEDATE:{title:'Due Date',width:'1%'}
		,FDS_STATUSTEXT:{title:'Status'}
		,FDS_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		,FDS_COMPILEMI:{title:'Compile Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		,FDS_OBTAININFO:{title:'Info',width:'1%'}
		,FDS_SORT:{title:'Sort',width:'1%'}
		,FDS_CHECKS:{title:'Checks',width:'1%'}
		,FDS_SALES:{title:'Sales',width:'1%'}
		,FDS_ENTRY:{title:'Entry',width:'1%'}
		,FDS_RECONCILE:{title:'Reconciliation',width:'1%'}
		,FDS_COMPILE:{title:'Compiliation',width:'1%'}
		,FDS_REVIEW:{title:'Review',width:'1%'}
		,FDS_ASSEMBLY:{title:'Assembly ',width:'1%'}
		,FDS_DELIVERY:{title:'Delivery',width:'1%'}
		,FDS_ACCTRPT:{title:'Report',width:'1%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"5"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#task_id").val(record.FDS_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"financialstatements"});'
	})};
	
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"financialstatements.cfc",
	"title":"Subtasks",
	"fields":{FDSS_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.FDSS_ID+"',page:'financialstatements',group:'group2'});_grid2();","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img;}}
		,FDSS_SEQUENCE:{title:'Sequence'}
		,FDSS_SUBTASKTEXT:{title:'Subtask'}
		,FDSS_DUEDATE:{title:'Due Date'}
		,FDSS_STATUSTEXT:{title:'Status'}
		,FDSS_ASSIGNEDTOTEXT:{title:'Assigned To'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"5"}',
	"functions":'$("#subtask1_id").val(record.FDSS_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"financialstatements"});'
	})};

_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "FDS_ID":var list='task_id,client_id,g1_cmireceived,g1_compilemi,g1_deliverymethod,g1_duedate,g1_esttime,g1_fees,g1_inforeceived,g1_mireceived,g1_missinginfo,g1_month,g1_paymentstatus,g1_periodend,g1_priority,g1_status,g1_year,g1_credithold';_loadit({"query":query,"list":list});_run.load_assets();break;
/*Group1_1*/case "FDS_OBTAININFO_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completedby,g1_g1_datecompleted,g1_g1_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "FDS_SORT_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completedby,g1_g2_datecompleted,g1_g2_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "FDS_CHECKS_ASSIGNEDTO":var list='g1_g3_assignedto,g1_g3_completedby,g1_g3_datecompleted,g1_g3_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "FDS_SALES_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completedby,g1_g4_datecompleted,g1_g4_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "FDS_ENTRY_ASSIGNEDTO":var list='g1_g5_assignedto,g1_g5_completedby,g1_g5_datecompleted,g1_g5_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_6*/case "FDS_RECONCILE_ASSIGNEDTO":var list='g1_g6_assignedto,g1_g6_completedby,g1_g6_datecompleted,g1_g6_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_7*/case "FDS_COMPILE_ASSIGNEDTO":var list='g1_g7_assignedto,g1_g7_completedby,g1_g7_datecompleted,g1_g7_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_8*/case "FDS_REVIEW_ASSIGNEDTO":var list='g1_g8_assignedto,g1_g8_completedby,g1_g8_datecompleted,g1_g8_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_9*/case "FDS_ASSEMBLY_ASSIGNEDTO":var list='g1_g9_assignedto,g1_g9_completedby,g1_g9_datecompleted,g1_g9_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_10*/case "FDS_DELIVERY_ASSIGNEDTO":var list='g1_g10_assignedto,g1_g10_completedby,g1_g10_datecompleted,g1_g10_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_11*/case "FDS_ACCTRPT_ASSIGNEDTO":var list='g1_g11_assignedto,g1_g11_completedby,g1_g11_datecompleted,g1_g11_estimatedtime';_loadit({"query":query,"list":list});break;


/*Group2*/case "FDSS_ID":var list='subtask1_id,g2_assignedto,g2_completed,g2_duedate,g2_notes,g2_sequence,g2_status,g2_subtask,g2_dependencies';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
/*assetCompTask*/case "FDS_OBTAININFO_DATECOMPLETED":var list='g1_g1_head1,g1_g1_head2,g1_g2_head1,g1_g2_head2,g1_g3_head1,g1_g3_head2,g1_g4_head1,g1_g4_head2,g1_g5_head1,g1_g5_head2,g1_g6_head1,g1_g6_head2,g1_g7_head1,g1_g7_head2,g1_g8_head1,g1_g8_head2,g1_g9_head1,g1_g9_head2,g1_g10_head1,g1_g10_head2,g1_g11_head1,g1_g11_head2';_loadit({"query":query,"list":list});break;

default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array


switch(options["group"]){
case'':

if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if($("#g1_year").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Year",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Year');}
	}
else if($("#g1_month").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Period",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Month');}
	}
else if($("#g1_periodend").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Period End",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Month');}
	}
else if(_duplicateCheck({"check":[{"item":"client_id"},{"item":"g1_year"},{"item":"g1_month"},{"item":"g1_periodend"}],"loadType":"group1","page":"financialstatements"})=='true'&&$('#task_id').val()=='0'){
	jqMessage({"type":"destroy"});jqMessage({message: "This task already exsists.",type: "error",autoClose: false});
	if(debug){window.console.log('This task already exsists.');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});
	if(debug){window.console.log('Start Saving Financial Statements');}	
	}	
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_cmireceived").val()+'",'+
$("#g1_compilemi").is(':checked')+',"'+
$("#g1_deliverymethod").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_esttime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_inforeceived").val()+'","'+
$("#g1_mireceived").val()+'",'+
$("#g1_missinginfo").is(':checked')+',"'+
$("#g1_month").val()+'","'+
$("#g1_paymentstatus").val()+'","'+
$("#g1_periodend").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_year").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"financialstatements"});
if(debug){window.console.log('Group 1 - Saving Data');}
break;

case'group1_1':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completedby").val()+'","'+
$("#g1_g1_datecompleted").val()+'","'+
$("#g1_g1_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){
	_saveData({group:"group1_1","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_1 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_2',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_1 - Skipped saving data');}
	}
break;

case'group1_2':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completedby").val()+'","'+
$("#g1_g2_datecompleted").val()+'","'+
$("#g1_g2_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){
	_saveData({group:"group1_2","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_2 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_3',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_2 - Skipped saving data');}
	}
break;

case'group1_3':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completedby").val()+'","'+
$("#g1_g3_datecompleted").val()+'","'+
$("#g1_g3_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){
	_saveData({group:"group1_3","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_3 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_4',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_3 - Skipped saving data');}
	}
break;

case'group1_4':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_datecompleted").val()+'","'+
$("#g1_g4_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){
	_saveData({group:"group1_4","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_4 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_5',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_4 - Skipped saving data');}
	}
break;

case'group1_5':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g5_assignedto").val()+'","'+
$("#g1_g5_completedby").val()+'","'+
$("#g1_g5_datecompleted").val()+'","'+
$("#g1_g5_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){
	_saveData({group:"group1_5","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_5 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_6',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_5 - Skipped saving data');}
	}
break;

case'group1_6':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g6_assignedto").val()+'","'+
$("#g1_g6_completedby").val()+'","'+
$("#g1_g6_datecompleted").val()+'","'+
$("#g1_g6_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_6").val()!=0){
	_saveData({group:"group1_6","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_6 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_7',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_6 - Skipped saving data');}
	}
break;

case'group1_7':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g7_assignedto").val()+'","'+
$("#g1_g7_completedby").val()+'","'+
$("#g1_g7_datecompleted").val()+'","'+
$("#g1_g7_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_7").val()!=0){
	_saveData({group:"group1_7","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_7 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_8',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_7 - Skipped saving data');}
	}
break;

case'group1_8':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g8_assignedto").val()+'","'+
$("#g1_g8_completedby").val()+'","'+
$("#g1_g8_datecompleted").val()+'","'+
$("#g1_g8_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_8").val()!=0){
	_saveData({group:"group1_8","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_8 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_9',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_8 - Skipped saving data');}
	}
break;

case'group1_9':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g9_assignedto").val()+'","'+
$("#g1_g9_completedby").val()+'","'+
$("#g1_g9_datecompleted").val()+'","'+
$("#g1_g9_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_9").val()!=0){
	_saveData({group:"group1_9","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_9 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_10',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_9 - Skipped saving data');}
	}
break;

case'group1_10':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g10_assignedto").val()+'","'+
$("#g1_g10_completedby").val()+'","'+
$("#g1_g10_datecompleted").val()+'","'+
$("#g1_g10_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_10").val()!=0){
	_saveData({group:"group1_10","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_10 - Saving Data');}
	}else{
	_saveDataCB({'group':'group1_11',"id":""+$("#task_id").val()+""});
	if(debug){window.console.log('Group 1_10 - Skipped saving data');}
	}
break;

case'group1_11':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g11_assignedto").val()+'","'+
$("#g1_g11_completedby").val()+'","'+
$("#g1_g11_datecompleted").val()+'","'+
$("#g1_g11_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_11").val()!=0){
	_saveData({group:"group1_11","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group 1_11 - Saving Data');}
	}else{
	_saveDataCB({'group':'group2',"id":""+$("#subtask1_id").val()+""});
	if(debug){window.console.log('Group 1_11 - Skipped saving data');}
	}
break;

case'group2':
$("#subtask1_id").val(options['id']);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_duedate").val()+'","'+
$("#g2_notes").val()+'","'+
$("#g2_sequence").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_subtask").val()+'","'+
$("#g2_dependencies").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){
	_saveData({group:"group2","payload":$.parseJSON(json),page:"financialstatements"});
	if(debug){window.console.log('Group2 - Saving Data');}
	}else{
	_saveDataCB({'group':'plugins'});
	if(debug){window.console.log('Group2 - Skipped saving data');}
	}
break;

/*group2_clone1*/
case'group2_clone1':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_group").val()+'","'+
'"]]}'
if($("#task_isLoaded").val()!=0){
	_saveData({group:"group2_clone1",payload:$.parseJSON(json),page:"financialstatements"})}
else{jqMessage({message: "You must select a task.",type: "info",autoClose: true})}
break;

case'group2_clone2':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g2_history").val()+'","'+
'"]]}'
if($("#task_isLoaded").val()!=0){
	_saveData({group:"group2_clone2",payload:$.parseJSON(json),page:"financialstatements"})}
else{jqMessage({message: "You must select a task.",type: "info",autoClose: true})}
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]})
	if(debug){window.console.log('Saving Plugins');}
	
break;
/*Other Events*/
case'error':jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({"message":"A exception in financialstatements.js","description":""+options["group"]+' json: '+json+'  id: '+options["id"]+"" ,"type": "sucess","autoClose": false});
alert('"message":"A exception in financialstatements.js","description":"'+options["group"]+' json: '+json+'  id: '+options["id"]+'" ,"type": "sucess","autoClose": false')
break;
}}
catch(err){alert(err)}};