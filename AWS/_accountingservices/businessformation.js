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
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#bf_id").val=(record.BF_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"bf_id","group":"group1"});'
	});}
	

$(document).ready(function(){
$.ajaxSetup({cache:false});//Stop ajax cacheing
// Load Initial Client Grid	
_grid1();
$('#entrance').show()

});



_group1=function(){}
_group2=function(){}

	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Client Group*/case "CLIENT_ACTIVE":var list='cl_active,cl_credit_hold,cl_dms_reference,cl_group,cl_name,cl_notes,cl_referred_by,cl_salutation,cl_since,cl_spouse,cl_trade_name,cl_type,s_label1,s_label2,s_label3,s_label4,rc_group';_loadit({"query":query,"list":list});break;

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
alert(options["group"]);
switch(options["group"]){
/*First Group to Save*/
case'':_saveDataCB({'group':'group1'});break;
/*Save Client*/
case'group1':var json='{"DATA":[["'+
$("#bf_id").val()+'","'+
$("#client_id").val()+'","'+
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
'"]]}'


_saveData({group:"group1",payload:$.parseJSON(json),page:"businessformation"});
jqMessage({message: "Document is saving. ",type: "save",autoClose: false});

	break;

case'group2':alert('group2');break;

/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'none':break;

case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}catch(err){alert(err)}};


/*Error Handelers*/
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};// JavaScript Document// JavaScript Document