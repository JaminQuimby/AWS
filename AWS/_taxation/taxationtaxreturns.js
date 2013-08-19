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

$.extend(true, options, params);//turn options into array
try{
switch(options["group"]){
//Starting with Save Message
case'':
if($("#g1_client").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saveing.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}

break;
/*Save Group1*/

case'group1':var json='{"DATA":[["'+
$("#g1_client").val()+'","'+
$("#g1_spouse").val()+'","'+
$("#g1_credithold").val()+'","'+
$("#g1_taxyear").val()+'","'+
$("#g1_currentfees").val()+'","'+
$("#g1_extensionrequested").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_taxform").val()+'","'+
$("#g1_priorfees").val()+'","'+
$("#g1_extensiondone").val()+'","'+
$("#g1_esttime").val()+'","'+
$("#g1_notrequired").val()+'","'+
$("#g1_reason").val()+'","'+
$("#g1_pptresttime").val()+

//group 1 subgroup 1
$("#g1_g1_informationreceived").val()+'","'+
$("#g1_g1_filingdeadline").val()+'","'+
$("#g1_g1_duedate").val()+'","'+
$("#g1_g1_missinginformation").is(':checked')+'","'+
$("#g1_g1_missinginforeceived").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_preparedby").val()+'","'+
$("#g1_g1_readyforreview").val()+'","'+
$("#g1_g1_reviewassignedto").val()+'","'+
$("#g1_g1_reviewed").val()+'","'+
$("#g1_g1_reviewedby").val()+'","'+
$("#g1_g1_reviewedwithnotes").val()+'","'+
$("#g1_g1_completed").val()+'","'+


//group 1 subgroup 2
$("#g1_g2_assemblereturn").val()+'","'+
$("#g1_g2_contacted").val()+'","'+
$("#g1_g2_messageleft").is(':checked')+'","'+
$("#g1_g2_emailed").is(':checked')+'","'+
$("#g1_g2_missingSignatures").is(':checked')+'","'+
$("#g1_g2_delivered").val()+'","'+
$("#g1_g2_deliverymethod").val()+'","'+
$("#g1_g2_paymentstatus").val()+'","'+
$("#g1_g2_multistatereturn").is(':checked')+'","'+



//group 1 subgroup 3
$("#g1_g3_pptrrequired").is(':checked')+'","'+
$("#g1_g3_pptrassignedto").val()+'","'+
$("#g1_g3_pptrextended").val()+'","'+
$("#g1_g3_pptrrfr").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_delivered").val()+'","'+
$("#g1_g3_paymentstatus").val()+'","'+
$("#g1_g3_currentfees").val()+'","'+
$("#g1_g3_priorfees").val()+'","'+

//group 1 subgroup 3
$("#g1_g4_dropoffappointment").val()+'","'+
$("#g1_g4_dropoffappointmenttime").val()+'","'+
$("#g1_g4_dropoffappointmentlength").val()+'","'+
$("#g1_g4_dropoffappointmentwith").val()+'","'+
$("#g1_g4_whileyouwaitappt").is(':checked')+'","'+
$("#g1_g4_pickupappointment").val()+'","'+
$("#g1_g4_pickupappointmenttime").val()+'","'+
$("#g1_g4_pickupappointmentlength").val()+'","'+
$("#g1_g4_pickupappointmentwith").val()+'","'+
'"]]}'
if($("#g1_client").val()!=""){
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