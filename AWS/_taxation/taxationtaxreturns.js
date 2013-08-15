/*
Javascript for Client Accounting and Consulting Tasks
Developers:Jamin Quimby

Grid1 = Entrance
*/

$(document).ready(function(){
// Load Initial Client Grid	
_grid1();
// Show Entrace Window
$('#entrance').show();

_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}

});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxationtaxreturns.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#tr_id").val=(record.TR_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"tr_id","group":"client"});'
	});}

	
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

/*
Build arguments for Related Clients UNDER CONSTRUCTION
*/
switch(options["group"]){
/*Save Client*/
case'client':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#cl_active").is(':checked')+'","'+
$("#cl_credit_hold").is(':checked')+'","'+
$("#cl_dms_reference").val()+'","'+
$("#cl_group").val()+'","'+
$("#cl_name").val()+'","'+
$("#cl_notes").val()+'","'+
$("#cl_referred_by").val()+'","'+
$("#cl_salutation").val()+'","'+
$("#cl_since").val()+'","'+
$("#cl_spouse").val()+'","'+
$("#cl_trade_name").val()+'","'+
$("#cl_type").val()+
'"]]}'
if($("#cl_name").val()!=""&&$("#cl_salutation").val()!=""&&$("#cl_type").val()!=""&&$("#cl_since").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});

jqMessage({message: "Document is saving. ",type: "save",autoClose: false});
}
else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false});}	
	break;


/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'none':break;
case'next':_saveData();break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}catch(err){alert(err)}};


/*Error Handelers*/
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};