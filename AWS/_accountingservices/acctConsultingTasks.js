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
	"url":"acctconsultingtasks.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{MC_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},MC_CATEGORYTEXT:{title:'Consulting Categories'},MC_DESCRIPTION:{title:'Task Description'},MC_STATUS:{title:'Status'},MC_DUEDATE:{title:'Due Date'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#grid1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$(".trackers #mc_id").val(record.MC_ID);'
	+'_updateh3(record.CLIENT_NAME);'
	+'_toggle("group1,largeMenu");'
	+'$(".gf-checkbox").hide();'
	+'$("div#group1").show();'
	+'$("div#content").removeClass();'
	+'$("div#content").addClass("contentbig");'
	+'_loadData({"id":"mc_id","group":"group1","page":"acctconsultingtasks"});'
	})}

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"acctconsultingtasks.cfc",
	"title":"Subtasks",
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'_loadData({"id":"comment_id","group":"group2","page":"acctconsultingtasks"});'
	});}

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"acctconsultingtasks.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'_loadData({"id":"comment_id","group":"group3","page":"acctconsultingtasks"});'
	});}

	
	
//Load Data call Back
_loadDataCB=function(query){if(query!=null){switch(query.COLUMNS[0]){
/*START LOAD DATA */
/*Group1*/case "MC_ID":var list='mc_id,g1_client,g1_spouse,g1_credithold,g1_consultingcategory,g1_taskdescription,g1_priority,g1_assignedto,g1_status,g1_requestforservices,g1_workinitiated,g1_duedate,g1_projectcompleted,g1_estimatedtime,g1_fees,g1_paid';_loadit({"query":query,"list":list});break;
/*AssetSpouse*/case "CLIENT_SPOUSE":var list='g1_spouse';_loadit({"query":query,"list":list});break;
/*AssetCategory*/case "OPTIONDESCRIPTION":var list='g1_taskdescription';_loadit({"query":query,"list":list});break;

/*END LOAD DATA */
default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}};


/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={
	"id":"",//ID
	"group":"",//Switch Group
	"result":""//Call Back Response
	}

$.extend(true, options, params);//turn options into array

switch(options["group"]){
//Starting with Save Message
case'':
if($("#g1_client").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saveing.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}

break;
/*Save Group1*/

case'group1':
var $g1_estimatedtime=$("#g1_estimatedtime");
var $g1_fees=$("#g1_fees");
var $g1_duedate=$("#g1_duedate");
var $g1_requestforservices=$("#g1_requestforservices");
var $g1_projectcompleted=$("#g1_projectcompleted");
/*Convert to numbers*/
if( $.type($g1_estimatedtime.val())==="number"){$g1_estimatedtime.val()}else{$g1_estimatedtime.val(0)}
if( $.type($g1_fees.val())==="number"){$g1_fees.val()}else{$g1_fees.val(0)}
var json='{"DATA":[["'+
$("#mc_id").val()+'","'+
$("#g1_client").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_consultingcategory").val()+'","'+
$("#g1_taskdescription").val()+'","'+
$g1_duedate.val()+'","'+
$g1_estimatedtime.val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$g1_projectcompleted.val()+'","'+
$g1_requestforservices.val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_workinitiated").val()+'","'+
$("#g1_credithold").is(":checked")+'","'+
'"]]}'
if($("#g1_client").val()!=0){

_saveData({group:"group1",payload:$.parseJSON(json),page:"acctconsultingtasks"});
}else{
_saveDataCB({'group':'group2'});
	}
break;
/*Save Group2*/
case'group2':
var json='{"DATA":[["'+
$("#mcs_id").val()+'","'+
$("#mc_id").val()+'","'+
$("#g2_actualtime").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'","'+
$("#g2_dependancy").val()+'","'+
$("#g2_duedate").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_note").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_subtask").val()+'","'+
'"]]}'

if($("subtask_isLoaded").val()!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"acctconsultingtasks"});
}else{_saveDataCB({'group':'group3'});}


break;
/*Save Group3*/
case'group3':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#g3_commentdate").val()+'","'+
$("#g3_commenttext").val()+'","'+
'"]]}'
if($("comment_isLoaded").val()!=0){
_saveData({group:"group3",payload:$.parseJSON(json),page:"acctconsultingtasks"});
}else{_saveDataCB({'group':'group4'});}
break;
/*Save Group4*/
case'group4':
jqMessage({message: "Your data has been saved.",type: "success",autoClose: true});
break;

/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'none':break;
case'next':_saveData();break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
}};