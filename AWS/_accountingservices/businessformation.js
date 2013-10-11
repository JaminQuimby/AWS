$(document).ready(function(){
_grid1();
_group1=function(){}
});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"businessformation.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_ACTIVITY:{title:'Activity'}
			,BF_OWNERS:{title:'Owners'}
			,BF_STATUS:{title:'Status'}
			,BF_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#task_id").val(record.BF_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"businessformation"});'
	})};

_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "BF_ID":var list='task_id,client_id,g1_activity,g1_assignedto,g1_dateinitiated,g1_duedate,g1_estimatedtime,g1_fees,g1_owners,g1_paid,g1_priority,g1_status';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_1*/case "BF_ARTICLESAPPROVED":var list='g1_g1_articlesapproved,g1_g1_articlessubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_2*/case "BF_TRADENAMERECEIVED":var list='g1_g2_tradenamereceived,g1_g2_tradenamesubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_3*/case "BF_MINUTESBYLAWSDRAFT":var list='g1_g3_minutesbylawsdraft,g1_g3_minutesbylawsfinal,g1_g3_minutescompleted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_4*/case "BF_DISSOLUTIONCOMPLETED":var list='g1_g4_disolutioncompleted,g1_g4_dissolutionrequested,g1_g4_dissolutionsubmitted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
/*Group1_5*/case "BF_BUSINESSTYPE":var list='g1_g5_businesstype,g1_g5_businesscreceived,g1_g5_businesssubmitted,g1_g5_otheractivity,g1_g5_othercompleted,g1_g5_otherstarted';_loadit({"query":query,"list":list,"page":"businessformation"});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
try{	
$.extend(true, options, params);
switch(options["group"]){
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_activity").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_dateinitiated").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_owners").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_status").val()+'","'+
'"]]}'
_saveData({group:"group1",payload:$.parseJSON(json),page:"businessformation"});
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
$("#g1_g5_businesstype").val()+'","'+
$("#g1_g5_businesscreceived").val()+'","'+
$("#g1_g5_businesssubmitted").val()+'","'+
$("#g1_g5_otheractivity").val()+'","'+
$("#g1_g5_othercompleted").val()+'","'+
$("#g1_g5_otherstarted").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"businessformation"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};