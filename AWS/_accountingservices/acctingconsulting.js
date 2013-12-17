$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});
  
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"acctingconsulting.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			,MC_STATUS:{title:'Status'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#task_id").val(record.MC_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"acctingconsulting"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"acctingconsulting.cfc",
	"title":"Subtasks",
	"fields":{MCS_ID:{key:true,list:false,edit:false}
			,MCS_SUBTASK:{title:'Subtask'}
			,MCS_NOTES:{title:'Notes'}
			,MCS_STATUS:{title:'Status'}
			,MCS_DEPENDENCIES:{title:'Dependencies'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$(".trackers #subtask1_id").val(record.MCS_ID);_loadData({"id":"subtask1_id","group":"group2","page":"acctingconsulting"});$("#group2").accordion({active:1});;'
	})};
	

_loadDataCB=function(query){
try{
if(query!=null){
switch(query.COLUMNS[0]){
/*Group1*/case "MC_ID":var list='task_id,client_id,g1_assignedto,g1_consultingcategory,g1_duedate,g1_estimatedtime,g1_fees,g1_missinginfo,g1_missinginforeceived,g1_paid,g1_priority,g1_projectcompleted,g1_requestforservices,g1_status,g1_taskdescription,g1_workinitiated';_loadit({"query":query,"list":list});break;
/*Group2*/case "MCS_ID":var list='subtask1_id,g2_actualtime,g2_assignedto,g2_completed,g2_dependancy,g2_duedate,g2_estimatedtime,g2_note,g2_sequence,g2_status,g2_subtask';_loadit({"query":query,"list":list});break;
/*AssetSpouse*/case "CLIENT_SPOUSE":var list='g1_spouse';_loadit({"query":query,"list":list});break;
/*AssetCategory*/case "OPTIONDESCRIPTION":var list='g1_taskdescription';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""};
$.extend(true, options, params);//turn options into array
alert(options["group"]);
switch(options["group"]){

case'':
if($("#client_id").val()!="" && $("#g1_consultingcategory").val()!=0 && $("#g1_taskdescription").val()!="")
{
	_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must input all bold fields.",type: "info",autoClose: true})};
break;


case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_consultingcategory").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_missinginfo").val()+'",'+
$("#g1_missinginforeceived").is(':checked')+',"'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_projectcompleted").val()+'","'+
$("#g1_requestforservices").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_taskdescription").val()+'","'+
$("#g1_workinitiated").val()+'","'+
'"]]}'
if($("#g1_consultingcategory").val()!="" && $("#g1_taskdescription").val()!=""){
_saveData({group:"group1","payload":$.parseJSON(json),page:"acctingconsulting"})}
else{jqMessage({message: "You must enter all required fields.",type: "info",autoClose: true})}
break;

case'group2':var json='{"DATA":[["'+
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
/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in acctingconsulting.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}};