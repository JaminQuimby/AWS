$(document).ready(function(){
_grid1();
_group1=function(){}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"payrolltaxes.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTH:{title:'Period'}
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_TYPE:{title:'Return Type'}
			,PT_DUEDATE:{title:'Date Due',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_OBTAININFO_ASSIGNEDTO:{title:'Obtain Information Assigned To',width:'1%'}
			,PT_ENTRY_ASSIGNEDTO:{title:'Entry Assigned To',width:'1%'}
			,PT_REC_ASSIGNEDTO:{title:'Reconciliation Assigned To',width:'1%'}
			,PT_REVIEW_ASSIGNEDTO:{title:'Review Assigned To',width:'1%'}
			,PT_ASSEMBLY_ASSIGNEDTO:{title:'Assembly Assigned To',width:'1%'}
			,PT_DELIVERY_ASSIGNEDTO:{title:'Delivery Assigned To',width:'1%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.PT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"payrolltaxes"});'
	})};


_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "PT_ID":var list='task_id,client_id,g1_deliverymethod,g1_duedate,g1_estimatedtime,g1_fees,g1_lastpay,g1_missinginformation,g1_missinginforeceived,g1_month,g1_paymentstatus,g1_priority,g1_type,g1_year';_loadit({"query":query,"list":list});break;
/*Group1_1*/case "PT_OBTAININFO_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completedby,g1_g1_completed,g1_g1_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "PT_ENTRY_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completedby,g1_g2_completed,g1_g2_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "PT_REC_ASSIGNEDTO":var list='g1_g3_assignedto,g1_g3_completedby,g1_g3_completed,g1_g3_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "PT_REVIEW_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completedby,g1_g4_completed,g1_g4_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "PT_ASSEMBLY_ASSIGNEDTO":var list='g1_g5_assignedto,g1_g5_completedby,g1_g5_completed,g1_g5_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_6*/case "PT_DELIVERY_ASSIGNEDTO":var list='g1_g6_assignedto,g1_g6_completedby,g1_g6_completed,g1_g6_estimatedtime';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
case'':
if($("#client_id").val()!="" && $("#g1_year").val()!="" && $("#g1_month").val()!=0 && $("#g1_lastpay").val()!=0 && $("#g1_type").val()!=0)
{
	_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must input all bold fields.",type: "info",autoClose: true})};
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_deliverymethod").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_lastpay").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_missinginforeceived").val()+'","'+
$("#g1_month").val()+'","'+
$("#g1_paymentstatus").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_type").val()+'","'+
$("#g1_year").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"payrolltaxes"});
break;

case'group1_1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completedby").val()+'","'+
$("#g1_g1_completed").val()+'","'+
$("#g1_g1_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'group1_2'})};
break;

case'group1_2':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completedby").val()+'","'+
$("#g1_g2_completed").val()+'","'+
$("#g1_g2_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'group1_3'})};
break;

case'group1_3':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completedby").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'group1_4'})};
break;

case'group1_4':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_completed").val()+'","'+
$("#g1_g4_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'group1_5'})};
break;

case'group1_5':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g5_assignedto").val()+'","'+
$("#g1_g5_completedby").val()+'","'+
$("#g1_g5_completed").val()+'","'+
$("#g1_g5_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'group1_6'})};
break;

case'group1_6':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#g1_g6_assignedto").val()+'","'+
$("#g1_g6_completedby").val()+'","'+
$("#g1_g6_completed").val()+'","'+
$("#g1_g6_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_6").val()!=0){_saveData({group:"group1_6","payload":$.parseJSON(json),page:"payrolltaxes"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in payrolltaxes.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};