$(document).ready(function(){  
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"communications.cfc",
	"title":"Communications",
	"fields":{CO_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
			,CO_FORTEXT:{title:'For',width:'1%'}
			,CO_DUEDATE:{title:'Due Date',width:'1%'}
			,CO_RESPONSENEEDED:{title:'Response Needed',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.CO_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"communications"});_loadData({"id":"client_id","group":"assetSpouse","page":"communications"});'
	})};

_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "CO_ID":var list='task_id,client_id,g1_briefmessage,g1_caller,g1_completed,g1_contactmethod,g1_credithold,g1_date,g1_duedate,g1_emailaddress,g1_ext,g1_faxnumber,g1_fees,g1_for,g1_paid,g1_responseneeded,g1_returnedcall,g1_takenby,g1_telephone,g1_spouse';_loadit({"query":query,"list":list});break;
/*AssetSpouse*/case "CLIENT_SPOUSE":var list='g1_spouse';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","result":""}
try{
$.extend(true, options, params);//turn options into array
var $client_id=$("#client_id");
switch(options["group"]){
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})};
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_briefmessage").val()+'","'+
$("#g1_caller").val()+'",'+
$("#g1_completed").is(':checked')+','+
$("#g1_contactmethod").is(':checked')+','+
$("#g1_credithold").is(':checked')+',"'+
$("#g1_date").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_emailaddress").val()+'","'+
$("#g1_ext").val()+'","'+
$("#g1_faxnumber").val()+'","'+
$("#g1_fees").val()+'","'+
$("#g1_for").val()+'","'+
$("#g1_paid").val()+'",'+
$("#g1_responseneeded").is(':checked')+','+
$("#g1_returnedcall").is(':checked')+',"'+
$("#g1_takenby").val()+'","'+
$("#g1_telephone").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"communications"});
break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in communications.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};