$(document).ready(function(){_grid1();});

var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_toggle("group1,largeMenu");_hide("entrance,smallMenu");_addNewTask();}
	,load_group1:function(){_grid1();}
	,load_group1_1:function(){if($("#isLoaded_group1_1").val()=="0"){_loadData({"id":"task_id","group":"group1_1","page":"payrollchecks"});$("#isLoaded_group1_1").val(1);}}
	,load_group1_2:function(){if($("#isLoaded_group1_2").val()=="0"){_loadData({"id":"task_id","group":"group1_2","page":"payrollchecks"});$("#isLoaded_group1_2").val(1);}}
	,load_group1_3:function(){if($("#isLoaded_group1_3").val()=="0"){_loadData({"id":"task_id","group":"group1_3","page":"payrollchecks"});$("#isLoaded_group1_3").val(1);}}
	,load_group1_4:function(){if($("#isLoaded_group1_4").val()=="0"){_loadData({"id":"task_id","group":"group1_4","page":"payrollchecks"});$("#isLoaded_group1_4").val(1);}}
	,load_group1_5:function(){if($("#isLoaded_group1_5").val()=="0"){_loadData({"id":"task_id","group":"group1_5","page":"payrollchecks"});$("#isLoaded_group1_5").val(1);}}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"payrollchecks"});}
	}

_grid1=function(){
	_jGrid({
	"grid":"grid1",
	"url":"payrollchecks.cfc",
	"title":"Payroll Checks",
	"fields":{
		PC_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.PC_ID+"',page:'payrollchecks',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,PC_YEAR:{title:'Year',width:'1%'}
		,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
		,PC_PAYDATE:{title:'Pay Date',width:'1%'}
		,PC_DUEDATE:{title:'Due Date',width:'1%'}
		,PC_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		,PC_PAYDATE:{title:'Pay Date',width:'1%'}
		,PC_OBTAININFO:{title:'Information',width:'1%'}
		,PC_PREPARATION:{title:'Preparation',width:'1%'}
		,PC_REVIEW:{title:'Review',width:'1%'}
		,PC_ASSEMBLY:{title:'Assembled',width:'1%'}
		,PC_DELIVERY:{title:'Delivery',width:'1%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.PC_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"payrollchecks"});'
	})};

_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "PC_ID":var list='task_id,client_id,g1_altfrequency,g1_duedate,g1_deliverymethod,g1_estimatedtime,g1_fees,g1_missinginformation,g1_missinginforeceived,g1_paydate,g1_payenddate,g1_paymentstatus,g1_year';_loadit({"query":query,"list":list});_run.load_assets();break;
/*Group1_1*/case "PC_OBTAININFO_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completedby,g1_g1_completed,g1_g1_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "PC_PREPARATION_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completedby,g1_g2_completed,g1_g2_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "PC_REVIEW_ASSIGNEDTO":var list='g1_g3_assignedto,g1_g3_completedby,g1_g3_completed,g1_g3_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "PC_ASSEMBLY_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completedby,g1_g4_completed,g1_g4_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "PC_DELIVERY_ASSIGNEDTO":var list='g1_g5_assignedto,g1_g5_completedby,g1_g5_completed,g1_g5_estimatedtime';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
/*assetCompTask*/case "PC_OBTAININFO_DATECOMPLETED":var list='g1_g1_head1,g1_g1_head2,g1_g2_head1,g1_g2_head2,g1_g3_head1,g1_g3_head2,g1_g4_head1,g1_g4_head2,g1_g5_head1,g1_g5_head2';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{$.extend(true, options, params);
switch(options["group"]){
case'':_saveDataCB({'group':'group1'});break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'",'+
$("#g1_altfrequency").is(':checked')+',"'+
$("#g1_duedate").val()+'","'+
$("#g1_deliverymethod").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_missinginforeceived").val()+'","'+
$("#g1_paydate").val()+'","'+
$("#g1_payenddate").val()+'","'+
$("#g1_paymentstatus").val()+'","'+
$("#g1_year").val()+'","'+
'"]]}'


if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_year").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Year",type: "error",autoClose: false});if(debug){window.console.log('Missing Year');}
	}
else if ($("#g1_payenddate").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Pay End Date",type: "error",autoClose: false});if(debug){window.console.log('Missing  Pay End Date');}
	}
else if ($("#g1_paydate").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Pay Date",type: "error",autoClose: false});if(debug){window.console.log('Pay Date');}
	}
else if(_duplicateCheck({"check":[{"item":"client_id"},{"item":"g1_year"},{"item":"g1_payenddate"},{"item":"g1_paydate"},{"item":"g1_altfrequency"}],"loadType":"group1","page":"payrollchecks"})=='true'&&$('#task_id').val()=='0'){
	jqMessage({"type":"destroy"});jqMessage({message: "This task already exsist.",type: "error",autoClose: false});
	if(debug){window.console.log('This task already exsist.');}
	}

else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1","payload":$.parseJSON(json),page:"payrollchecks"});
	if(debug){window.console.log('Start Saving Other Filings');}	
	}	

break;

case'group1_1':
 $("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completedby").val()+'","'+
$("#g1_g1_completed").val()+'","'+
$("#g1_g1_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"payrollchecks"})}
else{_saveDataCB({'group':'group1_2'})}
break;

case'group1_2':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completedby").val()+'","'+
$("#g1_g2_completed").val()+'","'+
$("#g1_g2_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"payrollchecks"})}
else{_saveDataCB({'group':'group1_3'})}
break;

case'group1_3':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completedby").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"payrollchecks"})}
else{_saveDataCB({'group':'group1_4'})}
break;

case'group1_4':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_completed").val()+'","'+
$("#g1_g4_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"payrollchecks"})}
else{_saveDataCB({'group':'group1_5'})}
break;

case'group1_5':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g5_assignedto").val()+'","'+
$("#g1_g5_completedby").val()+'","'+
$("#g1_g5_completed").val()+'","'+
$("#g1_g5_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"payrollchecks"})}
else{_saveDataCB({'group':'plugins'})}
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in payrollchecks.js in group "+options["group"]+" json: "+json+"  id: "+options["id"],type: "error",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};