/*
Javascript for FinancialStatements
Developers:Jamin Quimby
7/26/2013 - Started
*/


$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});

/*Define Grid Instances*/   
	_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxationfinancialtaxplanning.cfc",
	"title":"Financial Tax Planning",
	"fields":{FTP_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FTP_STATUS:{title:'Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#ftp_id").val(record.FTP_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"ftp_id","group":"group1","page":"taxationfinancialtaxplanning"});'
	}); }
	_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationfinancialtaxplanning.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"9","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#ftp_id").val()+'","loadType":"group2"}',
	"functions":''
	})}
	

	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "FTP_ID":var list='ftp_id,client_id,g1_assignedto,g1_category,g1_duedate,g1_estimatedtime,g1_fees,g1_finalclientmeeting,g1_informationcompiled,g1_informationreceived,g1_informationrequested,g1_missinginformation,g1_missinginforeceived,g1_paid,g1_priority,g1_reportcompleted,g1_requestforservices,g1_status';_loadit({"query":query,"list":list});break;

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
/*Save Client*/
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#ftp_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_category").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_finalclientmeeting").val()+'","'+
$("#g1_informationcompiled").val()+'","'+
$("#g1_informationreceived").val()+'","'+
$("#g1_informationrequested").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_missinginforeceived").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_reportcompleted").val()+'","'+
$("#g1_requestforservices").val()+'","'+
$("#g1_status").val()+'","'+
'"]]}'
if($("#client_id").val()!=""){_saveData({group:"group1","payload":$.parseJSON(json),page:"taxationfinancialtaxplanning"});
}else{_saveDataCB({'group':'group2'});}	
break;

/*Save Group2*/
case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#ftp_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if($("comment_isLoaded").val()!=0 && $("#g2_commenttext").val()!=""){
_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationfinancialtaxplanning"});
}else{_saveDataCB({'group':'group3'});}
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
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};// JavaScript Document