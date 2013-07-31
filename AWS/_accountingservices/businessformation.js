/*
Javascript for FinancialStatements
Developers:Jamin Quimby
7/26/2013 - Started
*/



/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"businessformation.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},BF_OWNERS:{title:'Owners'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#bf_id").val(record.BF_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"bf_id","group":"group1","page":"businessformation"});'
	});}
	

$(document).ready(function(){
$.ajaxSetup({cache:false});//Stop ajax cacheing
// Load Initial Client Grid	
_grid1();
$('#entrance').show()

});



_group1=function(){}
_group2=function(){}
_group3=function(){}
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Business Financial Group*/case "BF_ID":var list='bf_id,g1_clientname,g1_status,g1_assignedto,g1_owners,g1_priority,g1_dateinitiated,g1_articlessubmitted,g1_articlesapproved,g1_tradenamesubmitted,g1_tradenamereceived,g1_minutesbylawsdraft,g1_minutesbylawsfinal,g1_tinss4submitted,g1_tinreceived,g1_poa2848signed,g1_statecrasubmitted,g1_statecrareceived,g1_scorp2553submitted,g1_scorp2553received,g1_corp8832submitted,g1_corp8832received,g1_501c3submitted,g1_501creceived,g1_minutescompleted,g1_dissolutionrequested,g1_dissolutionsubmitted,g1_disolutioncompleted,g1_otheractivity,g1_otherstarted,g1_othercompleted,g1_recoardbookordered,g1_estimatedtime,g1_duedate,g1_fees,g1_paid,g1_activity';_loadit({"query":query,"list":list,"page":"businessformation"});break;

default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false});}}
}catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
};


/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={
	"id":"",//ID
	"group":"",//Switch Group
	"result":""//Call Back Response
	}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
/*First Group to Save*/
case'':_saveDataCB({'group':'group1'});
jqMessage({message: "Save sucessfull. ",type: "save",autoClose: true});
break;
/*Save Client*/
case'group1':var json='{"DATA":[["'+
$("#bf_id").val()+'","'+
$("#g1_clientname").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_owners").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_dateinitiated").val()+'","'+
$("#g1_articlessubmitted").val()+'","'+
$("#g1_articlesapproved").val()+'","'+
$("#g1_tradenamesubmitted").val()+'","'+
$("#g1_tradenamereceived").val()+'","'+
$("#g1_minutesbylawsdraft").val()+'","'+
$("#g1_minutesbylawsfinal").val()+'","'+
$("#g1_tinss4submitted").val()+'","'+
$("#g1_tinreceived").val()+'","'+
$("#g1_poa2848signed").val()+'","'+
$("#g1_statecrasubmitted").val()+'","'+
$("#g1_statecrareceived").val()+'","'+
$("#g1_scorp2553submitted").val()+'","'+
$("#g1_scorp2553received").val()+'","'+
$("#g1_corp8832submitted").val()+'","'+
$("#g1_corp8832received").val()+'","'+
$("#g1_501c3submitted").val()+'","'+
$("#g1_501creceived").val()+'","'+
$("#g1_minutescompleted").val()+'","'+
$("#g1_dissolutionrequested").val()+'","'+
$("#g1_dissolutionsubmitted").val()+'","'+
$("#g1_disolutioncompleted").val()+'","'+
$("#g1_otheractivity").val()+'","'+
$("#g1_otherstarted").val()+'","'+
$("#g1_othercompleted").val()+'","'+
$("#g1_recoardbookordered").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_activity").val()+'","'+
'"]]}'
_saveData({group:"group1",payload:$.parseJSON(json),page:"businessformation"});break;

case'group2':var json='{"DATA":[["'+
$("#g2_commentdate").val()+'","'+
$("#g2_commentemployee").val()+'","'+
$("#g2_commentnotes").val()+'","'+
'"]]}'
_saveData({group:"group2",payload:$.parseJSON(json),page:"businessformation"});
break;

case'group3':
jqMessage({message: "Document is saving. ",type: "success",autoClose: true});
break;

/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'none':break;

case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}catch(err){alert(err)}};


/*Error Handelers*/
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};// JavaScript Document// JavaScript Document