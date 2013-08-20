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
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#g1_client").val(record.CLIENT_ID);$("#tr_id").val=(record.TR_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"tr_id","group":"client"});'
	})}
	
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationtaxreturns.cfc",
	"title":"State",
	"fields":{TRST_ID:{key:true,list:false,edit:false},TRST_ASSIGNEDTO:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'$("#trst_id").val=(record.TRST_ID);_loadData({"id":"trst_id","group":"group2"});'
	})}
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"taxationtaxreturns.cfc",
	"title":"Schedule",
	"fields":{TRSC_ID:{key:true,list:false,edit:false},TRSC_ASSIGNEDTO:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3"}',
	"functions":'$("#trsc_id").val=(record.TRSC_ID);_loadData({"id":"trsc_id","group":"group3"});'
	})}
		
_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"taxationtaxreturns.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"2","ClientID":"'+$("#g1_client").val()+'","loadType":"group4"}',
	"functions":''
	})}

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
//turn options into array
$.extend(true, options, params);
//start switch
switch(options["group"]){
//Starting with Save Message
case'':
if($("#g1_client").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saveing.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#tr_id").val()+'","'+
$("#g1_client").val()+'","'+
$("#g1_credithold").is(':checked')+'","'+
$("#g1_currentfees").val()+'","'+
$("#g1_esttime").val()+'","'+
$("#g1_extensiondone").val()+'","'+
$("#g1_extensionrequested").val()+'","'+
$("#g1_notrequired").is(':checked')+'","'+
$("#g1_pptresttime").val()+
$("#g1_priorfees").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_reason").val()+'","'+
//This field does not get saved for rendering only. $("#g1_spouse").val()+'","'+
$("#g1_taxform").val()+'","'+
$("#g1_taxyear").val()+'","'+
'"]]}'
if($("#g1_client").val()!=""){_saveData({"group":"group1","payload":$.parseJSON(json),"page":"taxationtaxreturns"})}
else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false})}	
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
$("#g1_g1_missinginforeceived").val()+'","'+
$("#g1_g1_missinginformation").is(':checked')+'","'+
$("#g1_g1_preparedby").val()+'","'+
$("#g1_g1_readyforreview").val()+'","'+
$("#g1_g1_reviewassignedto").val()+'","'+
$("#g1_g1_reviewed").val()+'","'+
$("#g1_g1_reviewedby").val()+'","'+
$("#g1_g1_reviewedwithnotes").val()+'","'+
'"]]}'
if(isLoaded_group1_1!=0){_saveData({"group":"group1_1","payload":$.parseJSON(json),"page":"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_2'})}
break;
/*----------Save Group 1 Subgroup 2-------------*/
case'group1_1':var json='{"DATA":[["'+
//group 1 subgroup 2
$("#tr_id").val()+'","'+
$("#g1_g2_assemblereturn").val()+'","'+
$("#g1_g2_contacted").val()+'","'+
$("#g1_g2_delivered").val()+'","'+
$("#g1_g2_deliverymethod").val()+'","'+
$("#g1_g2_emailed").is(':checked')+'","'+
$("#g1_g2_messageleft").is(':checked')+'","'+
$("#g1_g2_missingsignatures").is(':checked')+'","'+
$("#g1_g2_multistatereturn").is(':checked')+'","'+
$("#g1_g2_paymentstatus").val()+'","'+
'"]]}'
if(isLoaded_group1_2!=0){_saveData({"group":"group1_2","payload":$.parseJSON(json),"page":"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_3'})}
break;
/*----------Save Group 1 Subgroup 3-------------*/
case'group1_1':var json='{"DATA":[["'+
//group 1 subgroup 3
$("#tr_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_currentfees").val()+'","'+
$("#g1_g3_delivered").val()+'","'+
$("#g1_g3_extended").val()+'","'+
$("#g1_g3_paymentstatus").val()+'","'+
$("#g1_g3_priorfees").val()+'","'+
$("#g1_g3_required").is(':checked')+'","'+
$("#g1_g3_rfr").val()+'","'+
'"]]}'
if(isLoaded_group1_3!=0){_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group1_4'})}
break;
/*----------Save Group 1 Subgroup 4-------------*/
case'group1_1':var json='{"DATA":[["'+
//group 1 subgroup 4
$("#tr_id").val()+'","'+
$("#g1_g4_dropoffappointment").val()+'","'+
$("#g1_g4_dropoffappointmentlength").val()+'","'+
$("#g1_g4_dropoffappointmenttime").val()+'","'+
$("#g1_g4_dropoffappointmentwith").val()+'","'+
$("#g1_g4_pickupappointment").val()+'","'+
$("#g1_g4_pickupappointmentlength").val()+'","'+
$("#g1_g4_pickupappointmenttime").val()+'","'+
$("#g1_g4_pickupappointmentwith").val()+'","'+
$("#g1_g4_whileyouwaitappt").is(':checked')+'","'+
'"]]}'
if(isLoaded_group1_4!=0){_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationtaxreturns"})}
else{_saveDataCB({'group':'group2'})}
break;
/*----------SAVE GROUP 2----------*/
case'group2':var json='{"DATA":[["'+
$("#tr_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_primary").is(':checked')+'","'+
$("#g2_reviewassignedto").val()+'","'+
$("#g2_state").val()+'","'+
$("#g2_status").val()+'","'+
'"]]}'
if(isLoaded_group2!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationtaxreturns"});
	}
else{_saveDataCB({'group':'group3'})}
break;
/*----------SAVE GROUP 3----------*/
case'group3':var json='{"DATA":[["'+
$("#tr_id").val()+'","'+
$("#g3_assignedto").val()+'","'+
$("#g3_reviewassignedto").val()+'","'+
$("#g3_schedule").val()+'","'+
$("#g3_status").val()+'","'+
'"]]}'
if(isLoaded_group3!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationtaxreturns"});
	}
else{_saveDataCB({'group':'group4'})}
break;
/*----------SAVE GROUP 4----------*/
case'group4':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if(isLoaded_group4!=0){
_saveData({group:"group4",payload:$.parseJSON(json),page:"taxationtaxreturns"});
}else{}
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
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}
}


/*Error Handelers*/
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false})};