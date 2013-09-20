$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"notices.cfc",
	"title":"Notice Matter",
	"fields":{NM_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},NM_NAME:{title:'Matter Name'},NM_STATUS:{title:'Matter Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.NM_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"notices"});'
	})};
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"notices.cfc",
	"title":"Notice",
	"fields":{N_ID:{key:true,list:false,edit:false},N_ASSIGNEDTOTEXT:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$("#subtask1_id").val(record.N_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"notices"});'
	})};


_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "NM_ID":var list='task_id,client_id,g1_mattername,g1_matterstatus';_loadit({"query":query,"list":list});break;
/*Group2*/case "N_ID":var list='subtask1_id,g2_matter,g2_assignedto,g2_estimatedtime,g2_noticestatus,g2_priority';_loadit({"query":query,"list":list});break;
/*Group2_1*/case "N_1_FEES":var list='g2_1_fees,g2_1_methodreceived,g2_1_noticedate,g2_1_noticenumber,g2_1_paid,g2_1_taxform,g2_1_taxyear';_loadit({"query":query,"list":list});break;
/*Group2_2*/case "N_2_DATENOTICEREC":var list='g2_2_datenoticereceived,g2_2_duedateforresponse,g2_2_irsstateresponserecieved,g2_2_responsecompleted,g2_2_responsecompletedby,g2_2_responsesubmitted,g2_2_reviewassignedto,g2_2_reviewcompleted,g2_2_reviewrequired';_loadit({"query":query,"list":list});break;
/*Group2_3*/case "N_3_MISSINGINFO":var list='g2_3_missinginformation,g2_3_missinginforeceived';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
$.extend(true, options, params);

alert(options["group"])
switch(options["group"]){

case'':
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})};
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_mattername").val()+'","'+
$("#g1_matterstatus").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"notices"});
break;

case'group2':
$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_noticestatus").val()+'","'+
$("#g2_priority").val()+'","'+
'"]]}';
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_1'})};
break;

case'group2_1':var json='{"DATA":[["'+
//group 2 subgroup 1
$("#task_id").val()+'","'+
$("#g2_1_fees").val()+'","'+
$("#g2_1_methodreceived").val()+'","'+
$("#g2_1_noticedate").val()+'","'+
$("#g2_1_noticenumber").val()+'","'+
$("#g2_1_paid").val()+'","'+
$("#g2_1_taxform").val()+'","'+
$("#g2_1_taxyear").val()+'","'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_2'})};
break;

case'group2_2':var json='{"DATA":[["'+
//group 2 subgroup 2
$("#task_id").val()+'","'+
$("#g2_2_datenoticereceived").val()+'","'+
$("#g2_2_duedateforresponse").val()+'","'+
$("#g2_2_irsstateresponserecieved").val()+'","'+
$("#g2_2_responsecompleted").val()+'","'+
$("#g2_2_responsecompletedby").val()+'","'+
$("#g2_2_responsesubmitted").val()+'","'+
$("#g2_2_reviewassignedto").val()+'","'+
$("#g2_2_reviewcompleted").val()+'",'+
$("#g2_2_reviewrequired").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2",payload:$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_3'})};
break;

case'group2_3':var json='{"DATA":[["'+
//group 2 subgroup 3
$("#task_id").val()+'",'+
$("#g2_3_missinginformation").val()+',"'+
$("#g2_3_missinginforeceived").val()+'","'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3",payload:$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}