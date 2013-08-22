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
});


/*Define Grid Instances*/   
	_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxationnotices.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},N_TAXYEARS:{title:'Tax Years'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#n_id").val(record.N_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"n_id","group":"group1","page":"taxationnotices"});'
	}); }
	
	_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationnotices.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"8","ClientID":"'+$("#client_id").val()+'","loadType":"group2"}',
	"functions":''
	})}
	
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "N_ID":var list='n_id,client_id,g1_assignedto,g1_datenoticereceived,g1_duedateforresponse,g1_estimatedtime,g1_fees,g1_irsstateresponserecieved,g1_matter,g1_methodreceived,g1_missinginforeceived,g1_missinginformation,g1_noticedate,g1_noticenumber,g1_noticestatus,g1_paid,g1_priority,g1_responsecompleted,g1_responsecompletedby,g1_reviewassignedto,g1_reviewcompleted,g1_reviewrequired,g1_responsecompletedby,g1_responsesubmitted,g1_taxform,g1_taxyear';_loadit({"query":query,"list":list});break;

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
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#n_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_datenoticereceived").val()+'","'+
$("#g1_duedateforresponse").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_irsstateresponserecieved").val()+'","'+
$("#g1_matter").val()+'","'+
$("#g1_methodreceived").val()+'","'+
$("#g1_missinginforeceived").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_noticedate").val()+'","'+
$("#g1_noticenumber").val()+'","'+
$("#g1_noticestatus").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_responsecompleted").val()+'","'+
$("#g1_responsecompletedby").val()+'","'+
$("#g1_reviewassignedto").val()+'","'+
$("#g1_reviewcompleted").val()+'",'+
$("#g1_reviewrequired").is(':checked')+',"'+
$("#g1_responsesubmitted").val()+'","'+
$("#g1_taxform").val()+'","'+
$("#g1_taxyear").val()+'","'+
'"]]}'
if($client_id.val()!=0 ){
_saveData({group:"group1",payload:$.parseJSON(json),page:"taxationnotices"});
}else{
_saveDataCB({'group':'group2'});
	}
break;

/*----------SAVE GROUP 2----------*/
case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#pa_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationnotices"});
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
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};// JavaScript Document