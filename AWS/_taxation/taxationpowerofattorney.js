/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/16/2013 - Started
*/



/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialstatements.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FDS_MONTHTEXT:{title:'Month'},FDS_YEAR:{title:'Year'},FDS_PERIODEND:{title:'Period End'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#fss_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"financialdatastatus"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#fds_id").val=(record.FDS_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"cl_id","group":"client"});'
	});}
	
$(document).ready(function(){
$.ajaxSetup({cache:false});//Stop ajax cacheing
// Load Initial Client Grid	
_grid1();
$('.gf-checkbox').hide()
//Load Select Boxes

//Bind Label Elements


//Load Custom Labels


//Load Accordians
$('.gf-checkbox').accordion({heightStyle:"content", active:false});
$('#entrance').accordion({heightStyle:"content", active:false});

//Set Date Picker Defaults	
$.datepicker.setDefaults({
showOn:"both",
buttonImageOnly:true,
buttonImage:"../assets/img/datepicker.gif",
constrainInput:true
});
//Load Date Pickers
//$("#cl_since").datepicker();

//Load Select Boxes
$('select').chosen();

});



_group1=function(){}
_group2=function(){}
_group3=function(){}
	
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
jqMessage({message: "Saveing.",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}

break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#g1_client").val()+'","'+
$("#g1_taxyears").val()+'","'+
$("#g1_taxforms").val()+'","'+
$("#g1_taxmatters").val()+'","'+
$("#g1_preparers").val()+'","'+
$("#g1_datesignedbyclient").val()+'","'+
$("#g1_datesenttoirs").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_dateofrevocation").val()+'","'+
'"]]}'
if($g1_client.val()!=0 ){
_saveData({group:"group1",payload:$.parseJSON(json),page:"taxationpowerofattorney"});
}else{
_saveDataCB({'group':'group2'});
	}
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
_saveData({group:"group2",payload:$.parseJSON(json),page:"acctconsultingtasks"});
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
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};