$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});


/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"documenttracking.cfc",
	"title":"Document Tracking",
	"fields":{DT_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},DT_SENDER:{title:'Sender'},DT_DESCRIPTION:{title:'Description'},DT_ASSIGNEDTO:{title:'Assigned To'},DT_ROUTING:{title:'Routing'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#file_id").val(record.FILE_ID);$("#task_id").val(record.DT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"documenttracking"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"documenttracking.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"14","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":''
	})};
	
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "DT_ID":var list='task_id,client_id,form_id,file_id,g1_assignedto,g1_date,g1_delivery,g1_description,g1_email,g1_fax,g1_mail,g1_routing,g1_sender,g1_staff';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
alert(options["group"]);
switch(options["group"]){
case'':
if($("#client_id").val()>0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

/*Save Client*/
case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#form_id").val()+'","'+
$("#file_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_date").val()+'",'+
$("#g1_delivery").is(':checked')+',"'+
$("#g1_description").val()+'",'+
$("#g1_email").is(':checked')+','+
$("#g1_fax").is(':checked')+','+
$("#g1_mail").is(':checked')+',"'+
$("#g1_routing").val()+'","'+
$("#g1_sender").val()+'","'+
$("#g1_staff").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"documenttracking"});
break;

case'group2':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_commentdate").val()+'","'+
$("#g2_commenttext").val()+'","'+
'"]]}'
if($("#comment_isLoaded").val()!=0){
_saveData({group:"group2",payload:$.parseJSON(json),page:"documenttracking"})}
else{_saveDataCB({'group':'plugins'})};
break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};