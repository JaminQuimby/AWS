/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/19/2013 - Started
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
	"url":"clientcommunications.cfc",
	"title":"Communications",
	"fields":{C_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},C_VOICEMAIL:{title:'Voicemail'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#c_id").val(record.C_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"c_id","group":"group1","page":"clientcommunications"});'
	}); }

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"clientcommunications.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"12","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#c_id").val()+'","loadType":"group2"}',
	"functions":''
	})}
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "C_ID":var list='c_id,client_id,g1_briefmessage,g1_caller,g1_completed,g1_credithold,g1_date,g1_duedate,g1_email,g1_emailaddress,g1_ext,g1_fax,g1_faxnumber,g1_fees,g1_for,g1_mail,g1_paid,g1_personalcontact,g1_responsenotneeded,g1_returnedcall,g1_spouse,g1_starttime,g1_takenby,g1_telephone,g1_textmessage,g1_voicemail';_loadit({"query":query,"list":list});break;

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

/*TO DO ?*/
var e58=document.getElementById("m_fs_subtaskgroup").value
,e59=document.getElementById("m_fs_historicalfs").value;
/*
Build arguments for Related Clients UNDER CONSTRUCTION
*/
switch(options["group"]){
/*Save Client*/
case'':
if($("#g1_client").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}

break;
/*Save Group1*/

case'group1':var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#g1_briefmessage").val()+'","'+
$("#g1_caller").val()+'",'+
$("#g1_completed").is(':checked')+','+
$("#g1_credithold").is(':checked')+',"'+
$("#g1_date").val()+'","'+
$("#g1_duedate").val()+'",'+
$("#g1_email").is(':checked')+',"'+
$("#g1_emailaddress").val()+'","'+
$("#g1_ext").val()+'",'+
$("#g1_fax").is(':checked')+',"'+
$("#g1_faxnumber").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_for").val()+'",'+
$("#g1_mail").is(':checked')+',"'+
$("#g1_paid").val()+'",'+
$("#g1_personalcontact").is(':checked')+','+
$("#g1_responsenotneeded").is(':checked')+','+
$("#g1_returnedcall").is(':checked')+',"'+
$("#g1_spouse").val()+'","'+
$("#g1_starttime").val()+'","'+
$("#g1_takenby").val()+'","'+
$("#g1_telephone").val()+'",'+
$("#g1_textmessage").is(':checked')+','+
$("#g1_voicemail").is(':checked')+',"'+
'"]]}'
if($("#client_id").val()!=""){_saveData({group:"group1","payload":$.parseJSON(json),page:"clientcommunications"});
}else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false})}	
break;

/*Save Group2*/
case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$g1_client.val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+
'"]]}'
if($("comment_isLoaded").val()!=0 && $("#g2_commenttext").val()!=""){
_saveData({group:"group3",payload:$.parseJSON(json),page:"clientcommunications"});
}else{_saveDataCB({'group':'group3'});}
break;
/*Save Group3*/
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