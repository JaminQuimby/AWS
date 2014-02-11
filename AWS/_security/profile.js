// JavaScript Document
$(document).ready(function(){
_grid1();
_group1=function(){_grid1()}

});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"profile.cfc",
	"title":"Profile Security",
	"fields":{USER_ID:{key:true,list:false,edit:false}
			,NAME:{title:'User'}
			,M_PAYROLLTAXES:{title:'Payroll Taxes'}
			,M_ACCOUNTINGSERVICES:{title:'Accounting Services'}
			,M_TAXATION:{title:'Taxation'}
			,M_PRACTICEMANAGEMENT:{title:'Practice Management'}
			,G_DELETE:{title:'Delete'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#task_id").val(record.USER_ID);_updateh3(record.NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"profile"});'
	})};
	
	
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){

/*Group1*/case "USER_ID":var list='task_id,g1_payrolltaxes,g1_accountingservices,g1_taxation,g1_practicemanagement,g1_delete';_loadit({"query":query,"list":list});break;

default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array

switch(options["group"]){
case'':
if($("#task_id").val()!="")
{
	_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must input all bold fields.",type: "info",autoClose: true})};
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").is(':checked')+',"'+
$("#g1_payrolltaxes").is(':checked')+',"'+
$("#g1_accountingservices").is(':checked')+',"'+
$("#g1_practicemanagement").is(':checked')+',"'+
$("#g1_delete").is(':checked')+',"'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"profile"});
break;


case"plugins":_pluginSaveData();
break;

/*Other Events*/
case'error':jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in profile.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};