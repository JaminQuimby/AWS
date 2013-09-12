/*
Javascript for FinancialStatements
Developers:Jamin Quimby
7/26/2013 - Started
Raymond Smith
8/29/2013
*/
$(document).ready(function(){
/*Define Grid Instances*/   
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"payrollpayrolltaxes.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PT_YEAR:{title:'Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#pt_id").val(record.PT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"pt_id","group":"group1","page":"payrollpayrolltaxes"});'
	}); }

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"payrollpayrolltaxes.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"13","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#pt_id").val()+'","loadType":"group2"}',
	"functions":''
	})}

	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "PT_ID":var list='pt_id,client_id,g1_deliverymethod,g1_duedate,g1_estimatedtime,g1_fees,g1_lastpay,g1_missinginformation,g1_missinginforeceived,g1_month,g1_paymentstatus,g1_priority,g1_type,g1_year';_loadit({"query":query,"list":list});break;
/*Group1_1*/case "PT_OBTAININFO_ASSIGNEDTO":var list='g1_g1_assignedto,g1_g1_completedby,g1_g1_completed,g1_g1_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "PT_ENTRY_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completedby,g1_g2_completed,g1_g2_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "PT_REC_ASSIGNEDTO":var list='g1_g3_assignedto,g1_g3_completedby,g1_g3_completed,g1_g3_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "PT_REVIEW_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completedby,g1_g4_completed,g1_g4_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "PT_ASSEMBLY_ASSIGNEDTO":var list='g1_g5_assignedto,g1_g5_completedby,g1_g5_completed,g1_g5_estimatedtime';_loadit({"query":query,"list":list});break;
/*Group1_6*/case "PT_DELIVERY_ASSIGNEDTO":var list='g1_g6_assignedto,g1_g6_completedby,g1_g6_completed,g1_g6_estimatedtime';_loadit({"query":query,"list":list});break;

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
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

case'group1':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_deliverymethod").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_lastpay").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_missinginforeceived").val()+'","'+
$("#g1_month").val()+'","'+
$("#g1_paymentstatus").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_type").val()+'","'+
$("#g1_year").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"payrollpayrolltaxes"});
break;
/*----------Save Group 1 Subgroup 1-------------*/
case'group1_1':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g1_assignedto").val()+'","'+
$("#g1_g1_completedby").val()+'","'+
$("#g1_g1_completed").val()+'","'+
$("#g1_g1_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group1_2'})}
break;

/*Subgroup 2*/
case'group1_2':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completedby").val()+'","'+
$("#g1_g2_completed").val()+'","'+
$("#g1_g2_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group1_3'})}
break;

/*Subgroup 3*/
case'group1_3':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g3_assignedto").val()+'","'+
$("#g1_g3_completedby").val()+'","'+
$("#g1_g3_completed").val()+'","'+
$("#g1_g3_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group1_4'})}
break;

/*Subgroup 4*/
case'group1_4':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_completed").val()+'","'+
$("#g1_g4_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group1_5'})}
break;

/*Subgroup 5*/
case'group1_5':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g5_assignedto").val()+'","'+
$("#g1_g5_completedby").val()+'","'+
$("#g1_g5_completed").val()+'","'+
$("#g1_g5_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group2'})}
break;

/*Subgroup 6*/
case'group1_6':var json='{"DATA":[["'+
$("#pt_id").val()+'","'+
$("#g1_g6_assignedto").val()+'","'+
$("#g1_g6_completedby").val()+'","'+
$("#g1_g6_completed").val()+'","'+
$("#g1_g6_estimatedtime").val()+'","'+
'"]]}'
if($("#isLoaded_group1_6").val()!=0){_saveData({group:"group1_6","payload":$.parseJSON(json),page:"payrollpayrolltaxes"})}
else{_saveDataCB({'group':'group2'})}
break;

/*----------SAVE GROUP 2----------*/
case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#pt_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if($("#comment_isLoaded").val()!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"payrollpayrolltaxes"});
}else{_saveDataCB({'group':'group3'})}
break;
/*This group does not exist in the cfm, this trigger instance is to update the posted message for the client.*/
case'group3':
jqMessage({message: "Your data has been saved.",type: "success",autoClose: true});
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
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};// JavaScript Document// JavaScript Document