$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialstatements.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FDS_MONTHTEXT:{title:'Month'},FDS_YEAR:{title:'Year'},FDS_PERIODEND:{title:'Period End'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#task_id").val(record.FDS_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"financialstatements"});'
	})};
	
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"financialstatements.cfc",
	"title":"Subtasks",
	"fields":{FDSS_ID:{key:true,list:false,edit:false},fdss_subtaskTEXT:{title:'Subtask'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$("#subtask1_id").val(record.FDSS_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"financialstatements"});'
	})};
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"financialstatements.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"5","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#task_id").val()+'","loadType":"group3"}',
	"functions":''
	})};
	
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "FDS_ID":var list='task_id,client_id,g1_cmireceived,g1_compilemi,g1_deliverymethod,g1_duedate,g1_esttime,g1_fees,g1_mireceived,g1_missinginfo,g1_month,g1_paymentstatus,g1_periodend,g1_priority,g1_status,g1_year';_loadit({"query":query,"list":list});break;
/*Group1_1*/case "FDS_OBTAININFO_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completedby,g1_g1_datecompleted,g1_g1_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "FDS_SORT_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completedby,g1_g2_datecompleted,g1_g2_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "FDS_CHECKS_ASSIGNEDTO":var list='g1_g3assignedto,g1_g3completedby,g1_g3_datecompleted,g1_g3estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "FDS_ENTRY_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completedby,g1_g4_datecompleted,g1_g4_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "FDS_RECONCILE_ASSIGNEDTO":var list='g1_g5_assignedto,g1_g5_completedby,g1_g5_datecompleted,g1_g5_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_6*/case "FDS_COMPILE_ASSIGNEDTO":var list='g1_g6_assignedto,g1_g6_completedby,g1_g6_datecompleted,g1_g6_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_7*/case "FDS_REVIEW_ASSIGNEDTO":var list='g1_g7_assignedto,g1_g7_completedby,g1_g7_datecompleted,g1_g7_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_8*/case "FDS_ASSEMBLY_ASSIGNEDTO":var list='g1_g8_assignedto,g1_g8_completedby,g1_g8_datecompleted,g1_g8_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_9*/case "FDS_DELIVERY_ASSIGNEDTO":var list='g1_g9_assignedto,g1_g9_completedby,g1_g9_datecompleted,g1_g9_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_10*/case "FDS_ACCTRPT_ASSIGNEDTO":var list='g1_g10_assignedto,g1_g10_completedby,g1_g10_datecompleted,g1_g10_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_11*/case "FDS_SALES_ASSIGNEDTO":var list='g1_g11_assignedto,g1_g11_completedby,g1_g11_datecompleted,g1_g11_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group2*/case "FDSS_ID":var list='subtask1_id,g2_assignedto,g2_completed,g2_duedate,g2_notes,g2_sequence,g2_status,g2_subtask';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
try{	
$.extend(true, options, params);//turn options into array

switch(options["group"]){
case'':
if($("#client_id").val()>0 && $("#g1_status").val()>0 && $("#g1_duedate").val()!=""){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose the client, status and due date.",type: "info",autoClose: true})}
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
break;

case'group1_1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completedby").val()+'","'+
$("#g1_g1_datecompleted").val()+'","'+
$("#g1_g1_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_2'})}
break;

case'group1_2':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completedby").val()+'","'+
$("#g1_g2_datecompleted").val()+'","'+
$("#g1_g2_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_3'})}
break;

case'group1_3':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completedby").val()+'","'+
$("#g1_g3_datecompleted").val()+'","'+
$("#g1_g3_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_4'})}
break;

case'group1_4':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_datecompleted").val()+'","'+
$("#g1_g4_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_5'})}
break;

case'group1_5':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g5_assignedto").val()+'","'+
$("#g1_g5_completedby").val()+'","'+
$("#g1_g5_datecompleted").val()+'","'+
$("#g1_g5_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_6'})}
break;

case'group1_6':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g6_assignedto").val()+'","'+
$("#g1_g6_completedby").val()+'","'+
$("#g1_g6_datecompleted").val()+'","'+
$("#g1_g6_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_6").val()!=0){_saveData({group:"group1_6","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_7'})}
break;

case'group1_7':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g7_assignedto").val()+'","'+
$("#g1_g7_completedby").val()+'","'+
$("#g1_g7_datecompleted").val()+'","'+
$("#g1_g7_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_7").val()!=0){_saveData({group:"group1_7","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_8'})}
break;

case'group1_8':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g8_assignedto").val()+'","'+
$("#g1_g8_completedby").val()+'","'+
$("#g1_g8_datecompleted").val()+'","'+
$("#g1_g8_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_8").val()!=0){_saveData({group:"group1_8","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_9'})}
break;

case'group1_9':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g9_assignedto").val()+'","'+
$("#g1_g9_completedby").val()+'","'+
$("#g1_g9_datecompleted").val()+'","'+
$("#g1_g9_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_9").val()!=0){_saveData({group:"group1_9","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_10'})}
break;

case'group1_10':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g10_assignedto").val()+'","'+
$("#g1_g10_completedby").val()+'","'+
$("#g1_g10_datecompleted").val()+'","'+
$("#g1_g10_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_10").val()!=0){_saveData({group:"group1_10","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group1_11'})}
break;

case'group1_11':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g11_assignedto").val()+'","'+
$("#g1_g11_completedby").val()+'","'+
$("#g1_g11_datecompleted").val()+'","'+
$("#g1_g11_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_11").val()!=0){_saveData({group:"group1_11","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group2'})}
break;

case'group2':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_duedate").val()+'","'+
$("#g2_notes").val()+'","'+
$("#g2_sequence").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_subtask").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'group3'})}
break;

case'group3':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g3_commentdate").val()+'","'+
$("#g3_commenttext").val()+'","'+
'"]]}'
if($("#comment_isLoaded").val()!=0){
_saveData({group:"group3",payload:$.parseJSON(json),page:"financialstatements"})}
else{_saveDataCB({'group':'plugins'})}
break;

case"plugins":_pluginSaveData();
break;

/*Other Events*/
case'error':jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};