/*
Javascript for Client Maintenance Module
Developers:Jamin Quimby

Grid1 = Entrance
*/

$(document).ready(function(){
//Load Grids
_grid1();


});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"acctconsultingtasks.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":
	{
	 CLIENT_ID:{key:true,list:false,edit:false}
	,MC_ID:{key:false,list:false,edit:false}
	,SI_ID:{key:false,list:false,edit:false}
	,CLIENT_NAME:{title:'Client Name'}
	,mc_categoryTEXT:{title:'Consulting Categories'}
	,mc_description:{title:'Task Description'}
	,mc_status:{title:'Status'}
	,mc_duedate:{title:'Due Date'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#grid1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":
		'$(".trackers #client_id").val(record.CLIENT_ID);'
	+	'$(".trackers #mc_id").val(record.MC_ID);'
	+	'$(".trackers #si_id").val(record.SI_ID);'
	+	'_updateh3(record.CLIENT_NAME);'
	+	'_toggle("group1,largeMenu");'
	+	'$(".gf-checkbox").hide();$("div#group1").show();'
	+	'$("div#content").removeClass();'
	+	'$("div#content").addClass("contentbig");'
	+	'_loadData({"id":"mc_id","group":"group1","page":"acctconsultingtasks"});'
	});}


	
	
//Load Data call Back
_loadDataCB=function(query){if(query!=null){switch(query.COLUMNS[0]){
/*START LOAD DATA */
/*Group1*/case "MC_ID":var list='mc_id,client_id,si_id,mc_category,mc_comments,mc_description,mc_duedate,mc_estimatedtime,mc_fees,mc_hot,mc_paid,mc_priority,mc_projectcompleted,mc_requestforservice,mc_status,mc_source,mc_workinitiated';_loadit({"query":query,"list":list});break;

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
/*Save Client*/
case'client':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#cl_active").is(':checked')+'","'+
$("#cl_credit_hold").is(':checked')+'","'+
$("#cl_dms_reference").val()+'","'+
$("#cl_group").val()+'","'+
$("#cl_name").val()+'","'+
$("#cl_notes").val()+'","'+
$("#cl_referred_by").val()+'","'+
$("#cl_salutation").val()+'","'+
$("#cl_since").val()+'","'+
$("#cl_spouse").val()+'","'+
$("#cl_trade_name").val()+'","'+
$("#cl_type").val()+
'"]]}'
if($("#cl_name").val()!=""&&$("#cl_salutation").val()!=""&&$("#cl_type").val()!=""&&$("#cl_since").val()!=""){
_saveData({"group":options["group"],"page":"clientmaintenance","payload":$.parseJSON(json)});

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
}};

