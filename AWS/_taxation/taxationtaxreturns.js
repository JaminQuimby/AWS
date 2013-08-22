/*
Javascript for Taxation > Tax Returns
Developer:Jamin Quimby
Programmer 1:Raymond Smith
*/
$(document).ready(function(){
//Load Grid
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
_group4=function(){_grid4()}
});
/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxationtaxreturns.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#tr_id").val(record.TR_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"tr_id","group":"group1","page":"taxationtaxreturns"});'
	}); }
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationtaxreturns.cfc",
	"title":"State",
	"fields":{TRST_ID:{key:true,list:false,edit:false},TRST_ASSIGNEDTOTEXT:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'$("#trst_id").val(record.TRST_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"trst_id","group":"group2","page":"taxationtaxreturns"});'
	})}
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"taxationtaxreturns.cfc",
	"title":"Schedule",
	"fields":{TRSC_ID:{key:true,list:false,edit:false},TRSC_ASSIGNEDTOTEXT:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3"}',
	"functions":'$("#trsc_id").val(record.TRSC_ID);$("#group3").accordion({active:1});$("#isLoaded_group3").val(1);_loadData({"id":"trsc_id","group":"group3","page":"taxationtaxreturns"});'
	})}
_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"taxationtaxreturns.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"6","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#tr_id").val()+'","loadType":"group4"}',
	"functions":''
	})}
/*LOAD DATA BASED ON QUERY RETURN*/
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "TR_ID":var list='tr_id,client_id,g1_credithold,g1_currentfees,g1_esttime,g1_extensiondone,g1_extensionrequested,g1_notrequired,g1_priorfees,g1_priority,g1_reason,g1_taxform,g1_taxyear,g1_spouse';_loadit({"query":query,"list":list});break;
/*Group1_1*/case "TR_G1_1_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completed,g1_g1_duedate,g1_g1_filingdeadline,g1_g1_informationreceived,g1_g1_missinginforeceived,g1_g1_missinginformation,g1_g1_preparedby,g1_g1_readyforreview,g1_g1_reviewassignedto,g1_g1_reviewed,g1_g1_reviewedby,g1_g1_reviewedwithnotes';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "TR_G1_3_ASSIGNEDTO":var list='g1_g3_assignedto,g1_g3_completed,g1_g3_currentfees,g1_g3_delivered,g1_g3_extended,g1_g3_paymentstatus,g1_g3_pptresttime,g1_g3_priorfees,g1_g3_required,g1_g3_rfr';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "TR_G1_4_DROPOFFAPPOINTMENT":var list='g1_g4_dropoffappointment,g1_g4_dropoffappointmentlength,g1_g4_dropoffappointmentwith,g1_g4_pickupappointment,g1_g4_pickupappointmentlength,g1_g4_pickupappointmentwith,g1_g4_whileyouwaitappt';_loadit({"query":query,"list":list});break;
/*Group2*/case "TRST_ID":var list='trst_id,g2_assignedto,g2_completed,g2_primary,g2_reviewassignedto,g2_state,g2_status';_loadit({"query":query,"list":list});break;
/*Group3*/case "TRSC_ID":var list='trsc_id,g3_assignedto,g3_reviewassignedto,g3_schedule,g3_status';_loadit({"query":query,"list":list});break;
/*AssetSpouse*/case "CLIENT_SPOUSE":var list='g1_spouse';_loadit({"query":query,"list":list});break;
default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false});}}
}catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
};
/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
$.extend(true, options, params);
var $client_id=$("#client_id");
switch(options["group"]){
//Start with Save Message
case'':
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;
/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#tr_id").val()+'","'+
$("#client_id").val()+'",'+
$("#g1_credithold").is(':checked')+',"'+
$("#g1_currentfees").val()+'","'+
$("#g1_esttime").val()+'","'+
$("#g1_extensiondone").val()+'","'+
$("#g1_extensionrequested").val()+'",'+
$("#g1_notrequired").is(':checked')+',"'+
$("#g1_priorfees").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_reason").val()+'","'+
$("#g1_taxform").val()+'","'+
$("#g1_taxyear").val()+'","'+
'"]]}'
if($("#client_id").val()!=""){_saveData({group:"group1","payload":$.parseJSON(json),page:"taxationtaxreturns"});
}else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false})}	
break;
/*----------Save Group 1 Subgroup 1-------------*/
case'group1_1':var json='{"DATA":[["'+
//group 1 subgroup 1
$("#tr_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completed").val()+'","'+
$("#g1_g1_duedate").val()+'","'+
$("#g1_g1_filingdeadline").val()+'","'+
$("#g1_g1_informationreceived").val()+'","'+
$("#g1_g1_missinginforeceived").val()+'",'+
$("#g1_g1_missinginformation").is(':checked')+',"'+
$("#g1_g1_preparedby").val()+'","'+
$("#g1_g1_readyforreview").val()+'","'+
$("#g1_g1_reviewassignedto").val()+'","'+
$("#g1_g1_reviewed").val()+'","'+
$("#g1_g1_reviewedby").val()+'","'+
$("#g1_g1_reviewedwithnotes").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_2'})}
break;
/*----------Save Group 1 Subgroup 2-------------*/
case'group1_2':var json='{"DATA":[["'+
//group 1 subgroup 2
$("#tr_id").val()+'","'+
$("#g1_g2_assemblereturn").val()+'","'+
$("#g1_g2_contacted").val()+'","'+
$("#g1_g2_delivered").val()+'","'+
$("#g1_g2_deliverymethod").val()+'",'+
$("#g1_g2_emailed").is(':checked')+','+
$("#g1_g2_messageleft").is(':checked')+','+
$("#g1_g2_missingsignatures").is(':checked')+','+
$("#g1_g2_multistatereturn").is(':checked')+',"'+
$("#g1_g2_paymentstatus").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_3'})}
break;
/*----------Save Group 1 Subgroup 3-------------*/
case'group1_3':var json='{"DATA":[["'+
//group 1 subgroup 3
$("#tr_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_currentfees").val()+'","'+
$("#g1_g3_delivered").val()+'","'+
$("#g1_g3_extended").val()+'","'+
$("#g1_g3_paymentstatus").val()+'","'+
$("#g1_g3_pptresttime").val()+'","'+
$("#g1_g3_priorfees").val()+'",'+
$("#g1_g3_required").is(':checked')+',"'+
$("#g1_g3_rfr").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3",payload:$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_4'})}
break;
/*----------Save Group 1 Subgroup 4-------------*/
case'group1_4':var json='{"DATA":[["'+
//group 1 subgroup 4
$("#tr_id").val()+'","'+
$("#g1_g4_dropoffappointment").val()+'","'+
$("#g1_g4_dropoffappointmentlength").val()+'","'+
$("#g1_g4_dropoffappointmentwith").val()+'","'+
$("#g1_g4_pickupappointment").val()+'","'+
$("#g1_g4_pickupappointmentlength").val()+'","'+
$("#g1_g4_pickupappointmentwith").val()+'",'+
$("#g1_g4_whileyouwaitappt").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4",payload:$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group2'})}
break;
/*----------SAVE GROUP 2----------*/
case'group2':var json='{"DATA":[["'+
$("#trst_id").val()+'","'+
$("#tr_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'",'+
$("#g2_primary").is(':checked')+',"'+
$("#g2_reviewassignedto").val()+'","'+
$("#g2_state").val()+'","'+
$("#g2_status").val()+'","'+
'"]]}'

if($("#isLoaded_group2").val()!=0){
if($("#g2_state").val()==0){jqMessage({message: "You must choose a state.",type: "info",autoClose: true})}
else{_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationtaxreturns"})}}
else{_saveDataCB({'group':'group3'})}
break;
/*----------SAVE GROUP 3----------*/
case'group3':var json='{"DATA":[["'+
$("#trsc_id").val()+'","'+
$("#tr_id").val()+'","'+
$("#g3_assignedto").val()+'","'+
$("#g3_reviewassignedto").val()+'","'+
$("#g3_schedule").val()+'","'+
$("#g3_status").val()+'","'+
'"]]}'
if($("#isLoaded_group3").val()!=0){
if($("#g3_schedule").val()==0){jqMessage({message: "You must choose a schedule.",type: "info",autoClose: true})}
else{_saveData({group:"group3",payload:$.parseJSON(json),page:"taxationtaxreturns"})}
}
else{_saveDataCB({'group':'group4'})}
break;
/*----------SAVE GROUP 4----------*/
case'group4':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#tr_id").val()+'","'+
$("#g4_commentdate").val()+'","'+
$("#g4_commenttext").val()+'","'+
'"]]}'
if($("#isLoaded_group4").val()!=0){
_saveData({group:"group4",payload:$.parseJSON(json),page:"taxationtaxreturns"});
}else{_saveDataCB({'group':'group5'})}
break;
/*This group does not exist in the cfm, this trigger instance is to update the posted message for the client.*/
case'group5':
jqMessage({message: "Your data has been saved.",type: "success",autoClose: true});
break;

/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'none':break;
case'next':_saveData();break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
/*Error Handelers*/
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};