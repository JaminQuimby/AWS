/*
Javascript for Client Maintenance Module
Developers:Jamin Quimby

Grid1 = Entrance
*/

$(document).ready(function(){
// Load Initial Client Grid	
_grid1();
// Show Entrace Window
$('#entrance').show();

_group1=function(){}
_group2=function(){}
_group3=function(){_grid3()}

});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"acctconsultingtasks.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{CLIENT_ID:{key:true,list:false,edit:false},MC_ID:{key:false,list:false,edit:false},SI_ID:{key:false,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},mc_categoryTEXT:{title:'Consulting Categories'},mc_description:{title:'Task Description'},mc_status:{title:'Status'},mc_duedate:{title:'Due Date'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#grid1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$(".trackers #client_id").val(record.CLIENT_ID);'+'$(".trackers #mc_id").val(record.MC_ID);'+'$(".trackers #si_id").val(record.SI_ID);'+'_updateh3(record.CLIENT_NAME);'+'_toggle("group1,largeMenu");'+'$(".gf-checkbox").hide();$("div#group1").show();'+'$("div#content").removeClass();'+'$("div#content").addClass("contentbig");'+'_loadData({"id":"mc_id","group":"group1","page":"acctconsultingtasks"});'
	})}

_grid3=function(){_jGrid({
	"grid":"grid2",
	"url":"businessformation.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'_loadData({"id":"comment_id","group":"group3","page":"acctconsultingtasks"});'
	});}

	
	
//Load Data call Back
_loadDataCB=function(query){if(query!=null){switch(query.COLUMNS[0]){
/*START LOAD DATA */
/*Group1*/case "MC_ID":var list='mc_id,client_id,si_id,mc_category,mc_comments,mc_description,mc_duedate,mc_estimatedtime,mc_fees,mc_paid,mc_priority,mc_projectcompleted,mc_requestforservice,mc_status,mc_source,mc_workinitiated';_loadit({"query":query,"list":list});break;

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
case'':_saveDataCB({'group':'group1'});
jqMessage({message: "Saveing.",type: "save",autoClose: true});
break;
/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#mc_id").val()+'","'+
$("#g1_client").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_consultingcategory").val()+'","'+
$("#g1_taskdescription").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_projectcompleted").val()+'","'+
$("#g1_requestforservices").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_workinitiated").val()+'","'+
$("#g1_spouse").val()+'","'+
$("#g1_credithold").is(":checked")+'","'+
'"]]}'
_saveData({group:"group1",page:"acctconsultingtasks",payload:$.parseJSON(json)});
jqMessage({message: "Saved!. ",type: "save",autoClose: false})
break;
/*Save Group2*/
case'group2':
jqMessage({message: "Your data has been saved.",type: "success",autoClose: true});
break;
/*Save Group3*/
case'group3':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
_saveData({group:"group2",payload:$.parseJSON(json),page:"acctconsultingtasks"});
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

