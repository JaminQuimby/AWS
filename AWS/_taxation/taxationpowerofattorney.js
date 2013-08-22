/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/16/2013 - Started
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
	"url":"taxationpowerofattorney.cfc",
	"title":"Power of Attorney",
	"fields":{PA_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PA_TAXYEARS:{title:'Tax Years'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#pa_id").val(record.PA_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"pa_id","group":"group1","page":"taxationpowerofattorney"});'
	}); }
	_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxationpowerofattorney.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"7","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#pa_id").val()+'","loadType":"group2"}',
	"functions":''
	})}
	
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "PA_ID":var list='pa_id,client_id,g1_dateofrevocation,g1_datesenttoirs,g1_datesignedbyclient,g1_preparers,g1_status,g1_taxforms,g1_taxmatters,g1_taxyears';_loadit({"query":query,"list":list});break;
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
var $client_id=$("#client_id");
alert(options["group"])
/*TO DO ?*/
//var e58=document.getElementById("m_fs_subtaskgroup").value
//,e59=document.getElementById("m_fs_historicalfs").value;
/*
Build arguments for Related Clients UNDER CONSTRUCTION
*/
switch(options["group"]){
	/*Save Client*/
case'':
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true});
}else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#pa_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_dateofrevocation").val()+'","'+
$("#g1_datesenttoirs").val()+'","'+
$("#g1_datesignedbyclient").val()+'","'+
$("#g1_preparers").val()+'","'+
$("#g1_status").val()+'","'+
$("#g1_taxforms").val()+'","'+
$("#g1_taxmatters").val()+'","'+
$("#g1_taxyears").val()+'","'+
'"]]}'
if($client_id.val()!="" ){_saveData({group:"group1",payload:$.parseJSON(json),page:"taxationpowerofattorney"});
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
_saveData({group:"group2",payload:$.parseJSON(json),page:"taxationpowerofattorney"});
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
errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};