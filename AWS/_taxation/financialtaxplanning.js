$(document).ready(function(){_grid1();});

var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_loadit({"query":{"COLUMNS":["G1_STATUS"],"DATA":[[4]]},"list":"g1_status","page":"financialtaxplanning"});_toggle("group1,largeMenu");_hide("entrance,smallMenu");_addNewTask();}
	,load_group1:function(){_grid1();}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"financialtaxplanning"});}
}

	_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialtaxplanning.cfc",
	"title":"Financial & Tax Planning",
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.FTP_ID+"',page:'financialtaxplanning',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
  			 ,CLIENT_NAME:{title:'Client Name'}
			 ,FTP_CATEGORYTEXT:{title:'Category'}
			 ,FTP_DESCRIPTION:{title:'Description'}
			 ,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			 ,FTP_STATUSTEXT:{title:'Status'}
			 ,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			 ,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			 ,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"9"}',
	"functions":'$("#task_id").val(record.FTP_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"financialtaxplanning"});'
	})};
	

_loadDataCB=function(query){
try{
if(query==null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else{
switch(query.COLUMNS[0]){
case "FTP_ID":var list='task_id,client_id,g1_assignedto,g1_category,g1_description,g1_duedate,g1_estimatedtime,g1_fees,g1_finalclientmeeting,g1_informationcompiled,g1_informationreceived,g1_informationrequested,g1_missinginformation,g1_missinginforeceived,g1_paid,g1_priority,g1_reportcompleted,g1_requestforservices,g1_status';_loadit({"query":query,"list":list});_run.load_assets();break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);
switch(options["group"]){
case'':
if($("#client_id").val()!=0){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_assignedto").val()+'","'+
$("#g1_category").val()+'","'+
$("#g1_description").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_estimatedtime").val()+'","'+
$("#g1_fees").val().replace(/([$])/g, '')+'","'+
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
_saveData({group:"group1","payload":$.parseJSON(json),page:"financialtaxplanning"});
break;
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in financialtaxplanning.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};