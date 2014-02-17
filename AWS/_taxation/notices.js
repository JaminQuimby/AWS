$(document).ready(function(){
jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});

_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"notices.cfc",
	"title":"Notice Matter",
	"fields":{NM_ID:{key:true,list:false,edit:false}
,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.NM_ID+"',page:'notices',group:'group1'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,CLIENT_NAME:{title:'Client Name'}
			,NM_NAME:{title:'Matter Name'}
			,NM_STATUSTEXT:{title:'Matter Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"8"}',
	"functions":'$("#task_id").val(record.NM_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"notices"});'
	})};
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"notices.cfc",
	"title":"Notice",
	"fields":{N_ID:{key:true,list:false,edit:false}
,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.N_ID+"',page:'notices',group:'group2'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,NM_NAME:{title:'Matter'}
			,N_NOTICESTATUSTEXT:{title:'Status'}
			,N_1_TAXFORMTEXT:{title:'Tax Form'}
			,N_1_TAXYEAR:{title:'Tax Year',width:'1%'}
			,N_1_RESDUEDATE:{title:'Due Date for Response',width:'1%'}	
			,N_1_NOTICENUMBER:{title:'Notice Number',width:'1%'}
			,N_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"8"}',
	"functions":'$("#subtask1_id").val(record.N_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"notices"});'
	})};

_loadAssets=function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"notices"});_loadData({"id":"task_id","group":"assetCompTask","page":"notices"});}
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "NM_ID":var list='task_id,client_id,g1_mattername,g1_matterstatus,g2_matter';_loadit({"query":query,"list":list});_loadAssets();break;
/*Group2*/case "N_ID":var list='subtask1_id,g2_assignedto,g2_deliverymethod,g2_estimatedtime,g2_fees,g2_missinginformation,g2_missinginforeceived,g2_noticestatus,g2_paid,g2_priority';_loadit({"query":query,"list":list});break;
/*Group2_1*/case "N_1_DATENOTICEREC":var list='g2_1_datenoticereceived,g2_1_methodreceived,g2_1_noticedate,g2_1_noticenumber,g2_1_duedateforresponse,g2_1_taxform,g2_1_taxyear';_loadit({"query":query,"list":list});break;
/*Group2_2*/case "N_2_IRSSTATERESPONSE":var list='g2_2_irsstateresponserecieved,g2_2_responsecompleted,g2_2_responsecompletedby,g2_2_responsesubmitted,g2_2_reviewassignedto,g2_2_reviewcompleted,g2_2_reviewrequired';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
$.extend(true, options, params);
alert(options["group"])
switch(options["group"]){

case'':
if($("#client_id").val()!=0 && $("#g1_mattername").val()!="" && $("#g1_matterstatus").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must input all bold fields.",type: "info",autoClose: true})};
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
$("#g2_deliverymethod").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_fees").val()+'",'+
$("#g2_missinginformation").is(':checked')+',"'+
$("#g2_missinginforeceived").val()+'","'+
$("#g2_noticestatus").val()+'","'+
$("#g2_paid").val()+'","'+
$("#g2_priority").val()+'","'+
'"]]}';
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_1'})};
break;

case'group2_1':var json='{"DATA":[["'+
//group 2 subgroup 1
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_1_noticenumber").val()+'","'+
$("#g2_1_noticedate").val()+'","'+
$("#g2_1_taxyear").val()+'","'+
$("#g2_1_taxform").val()+'","'+
$("#g2_1_methodreceived").val()+'","'+
$("#g2_1_datenoticereceived").val()+'","'+
$("#g2_1_duedateforresponse").val()+'","'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_2'})};
break;

case'group2_2':var json='{"DATA":[["'+
//group 2 subgroup 2
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_2_irsstateresponserecieved").val()+'","'+
$("#g2_2_responsecompleted").val()+'","'+
$("#g2_2_responsecompletedby").val()+'","'+
$("#g2_2_responsesubmitted").val()+'","'+
$("#g2_2_reviewassignedto").val()+'","'+
$("#g2_2_reviewcompleted").val()+'",'+
$("#g2_2_reviewrequired").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2",payload:$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in notices.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}