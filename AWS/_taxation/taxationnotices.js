/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/16/2013
*/

$(document).ready(function(){
//Load Grid
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
});
/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxationnotices.cfc",
	"title":"Notice Matter",
	"fields":{NM_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},NM_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#nm_id").val(record.NM_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"nm_id","group":"group1","page":"taxationnotices"});'
	}); }
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationnotices.cfc",
	"title":"Notice",
	"fields":{N_ID:{key:true,list:false,edit:false},N_ASSIGNEDTOTEXT:{title:'Assigned To'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'$("#n_id").val(record.N_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"n_id","group":"group2","page":"taxationnotices"});'
	})}
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"taxationnotices.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"8","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#nm_id").val()+'","loadType":"group3"}',
	"functions":''
	})}

//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "NM_ID":var list='nm_id,client_id,g1_mattername,g1_matterstatus';_loadit({"query":query,"list":list});break;
/*Group2*/case "N_ID":var list='n_id,g2_assignedto,g2_estimatedtime,g2_noticestatus,g2_priority';_loadit({"query":query,"list":list});break;
/*Group2_1*/case "N_1_FEES":var list='g2_1_fees,g2_1_methodreceived,g2_1_noticedate,g2_1_noticenumber,g2_1_paid,g2_1_taxform,g2_1_taxyear';_loadit({"query":query,"list":list});break;
/*Group2_2*/case "N_2_DATENOTICERECEIVED":var list='g2_2_datenoticereceived,g2_2_duedateforresponse,g2_2_irsstateresponserecieved,g2_2_responsecompleted,g2_2_responsecompletedby,g2_2_responsesubmitted,g2_2_reviewassignedto,g2_2_reviewcompleted,g2_2_reviewrequired';_loadit({"query":query,"list":list});break;
/*Group2_3*/case "N_3_MISSINGINFORECEIVED":var list='g2_3_missinginforeceived,g2_3_missinginformation';_loadit({"query":query,"list":list});break;

default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false});}}
}catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
};

/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
$.extend(true, options, params);
alert(options["group"])
var $client_id=$("#client_id");
switch(options["group"]){
//Start with Save Message
case'':
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;
/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#nm_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_mattername").val()+'","'+
$("#g1_matterstatus").val()+'","'+
'"]]}'
if($client_id.val()!="" ){_saveData({group:"group1","payload":$.parseJSON(json),page:"taxationnotices"});
}else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false})}	
break;
/*----------Save Group 2-------------*/
case'group2':var json='{"DATA":[["'+
$("#n_id").val()+'","'+
$("#nm_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_noticestatus").val()+'","'+
$("#g2_priority").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"taxationnotices"})}
else{_saveDataCB({'group':'group2_1'})}
break;
/*----------Save Group 2 Subgroup 1-------------*/
case'group2_1':var json='{"DATA":[["'+
//group 1 subgroup 1
$("#nm_id").val()+'","'+
$("#g2_1_fees").val()+'","'+
$("#g2_1_methodreceived").val()+'","'+
$("#g2_1_noticedate").val()+'","'+
$("#g2_1_noticenumber").val()+'","'+
$("#g2_1_paid").val()+'","'+
$("#g2_1_taxform").val()+'","'+
$("#g2_1_taxyear").val()+'","'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"taxationnotices"})}
else{_saveDataCB({'group':'group2_2'})}
break;
/*----------Save Group 2 Subgroup 2-------------*/
case'group2_2':var json='{"DATA":[["'+
//group 1 subgroup 2
$("#nm_id").val()+'","'+
$("#g2_2_datenoticereceived").val()+'","'+
$("#g2_2_duedateforresponse").val()+'","'+
$("#g2_2_irsstateresponserecieved").val()+'","'+
$("#g2_2_responsecompleted").val()+'","'+
$("#g2_2_responsecompletedby").val()+'","'+
$("#g2_2_responsesubmitted").val()+'","'+
$("#g2_2_reviewassignedto").val()+'","'+
$("#g2_2_reviewcompleted").val()+'",'+
$("#g2_2_reviewrequired").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2",payload:$.parseJSON(json),page:"taxationnotices"})}
else{_saveDataCB({'group':'group2_3'})}
break;
/*----------Save Group 2 Subgroup 3-------------*/
case'group2_3':var json='{"DATA":[["'+
//group 1 subgroup 3
$("#nm_id").val()+'","'+
$("#g2_3_missinginforeceived").val()+'",'+
$("#g2_3_missinginformation").val()+'","'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3",payload:$.parseJSON(json),page:"taxationnotices"})}
else{_saveDataCB({'group':'group3'})}
break;

/*----------SAVE GROUP 3----------*/
case'group3':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#tr_id").val()+'","'+
$("#g3_commentdate").val()+'","'+
$("#g3_commenttext").val()+'","'+
'"]]}'
if($("#isLoaded_group3").val()!=0){
_saveData({group:"group3",payload:$.parseJSON(json),page:"taxationnotices"});
}else{_saveDataCB({'group':'group4'})}
break;
/*This group does not exist in the cfm, this trigger instance is to update the posted message for the client.*/
case'group4':
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