$(document).ready(function(){
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}

$( document ).ajaxComplete(function( event, xhr, settings ) {
if(typeof $.parseJSON(xhr.responseText ).COLUMNS != "undefined"){
if($.parseJSON(xhr.responseText ).COLUMNS.toString()=='TRST_STATE'){
	_loadSelect({'selectName':'global_taxreturnsstateforms','selectObject':'g2_requiredforms','option1':$('#g2_state').val(),'page':'taxreturns'});
	_loadData({"id":"subtask1_id","group":"group2","page":"taxreturns"});
}

}
});
});
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxreturns.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.TR_ID+"',page:'taxreturns',group:'group1'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_TAXYEAR:{title:'Tax Year',width:'1%'}
			,TR_TAXFORMTEXT:{title:'Tax Form',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}		
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}		
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}		
			,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'1%'}		
			,TR_2_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To',width:'1%'}		
			,TR_2_REVIEWED:{title:'Reviewed',width:'1%'}			
			,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}		
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}		
			,TR_3_ASSEMBLERETURN:{title:'Assembled',width:'1%'}		
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"6"}',
	"functions":'$("#task_id").val(record.TR_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"taxreturns"});'
	})};
	
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxreturns.cfc",
	"title":"State",
	"fields":{TRST_ID:{key:true,list:false,edit:false}
,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.TRST_ID+"',page:'taxreturns',group:'group2'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,TRST_STATETEXT:{title:'State'}
			,TRST_PRIMARY:{title:'Primary'}
			,TRST_STATUSTEXT:{title:'Status'}
			,TRST_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,TRST_1_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"6"}',
	"functions":'$("#subtask1_id").val(record.TRST_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2_state","page":"taxreturns"});'
	})};
	
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"taxreturns.cfc",
	"title":"Schedule",
	"fields":{TRSC_ID:{key:true,list:false,edit:false}
,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.TRSC_ID+"',page:'taxreturns',group:'group3'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,TRSC_SCHEDULETEXT:{title:'Schedule'}
			,TRSC_STATUSTEXT:{title:'Status'}
			,TRSC_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,TRSC_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To'}},
			
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group3","formid":"6"}',
	"functions":'$("#subtask2_id").val(record.TRSC_ID);$("#group3").accordion({active:1});$("#isLoaded_group3").val(1);_loadSelect({"selectName":"global_taxreturnschedule","selectObject":"g3_schedule","option1":$("#g1_taxform").val(),"page":"taxreturns"});_loadData({"id":"subtask2_id","group":"group3","page":"taxreturns"});'
	})};

_loadAssets=function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"taxreturns"});}
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "TR_ID":var list='task_id,client_id,g1_currentfees,g1_deliverymethod,g1_duedate,g1_esttime,g1_extensiondone,g1_extensionrequested,g1_filingdeadline,g1_missinginformation,g1_missinginforeceived,g1_notrequired,g1_paymentstatus,g1_priorfees,g1_priority,g1_reason,g1_taxform,g1_taxyear';_loadit({"query":query,"list":list});_loadAssets();break; 
/*Group1_1*/case "TR_1_DROPOFFAPPOINTMENT":var list='g1_g1_dropoffappointment,g1_g1_dropoffappointmentlength,g1_g1_dropoffappointmentwith,g1_g1_pickupappointment,g1_g1_pickupappointmentlength,g1_g1_pickupappointmentwith,g1_g1_whileyouwaitappt';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "TR_2_ASSIGNEDTO":var list='g1_g2_assignedto,g1_g2_completed,g1_g2_informationreceived,g1_g2_preparedby,g1_g2_readyforreview,g1_g2_reviewassignedto,g1_g2_reviewed,g1_g2_reviewedby,g1_g2_reviewedwithnotes';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "TR_3_ASSEMBLERETURN":var list='g1_g3_assemblereturn,g1_g3_contacted,g1_g3_delivered,g1_g3_emailed,g1_g3_messageleft,g1_g3_missingsignatures,g1_g3_multistatereturn';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "TR_4_ASSIGNEDTO":var list='g1_g4_assignedto,g1_g4_completed,g1_g4_completedby,g1_g4_currentfees,g1_g4_delivered,g1_g4_extended,g1_g4_extensionrequested,g1_g4_paymentstatus,g1_g4_pptresttime,g1_g4_priorfees,g1_g4_required,g1_g4_reviewassigned,g1_g4_reviewed,g1_g4_reviewedby,g1_g4_rfr';_loadit({"query":query,"list":list});break;
/*Group2*/case "TRST_ID":var list='subtask1_id,g2_assignedto,g2_completed,g2_primary,g2_reviewassignedto,g2_state,g2_status,g2_requiredforms';_loadit({"query":query,"list":list});break;
/*Group2 State*/case"TRST_STATE":var list='g2_state'; _loadit({"query":query,"list":list});break;
/*Group2_1*/case "TRST_1_ASSIGNEDTO":var list='g2_g1_assignedto,g2_g1_completed,g2_g1_duedate,g2_g1_informationreceived,g2_g1_missinginforeceived,g2_g1_missinginformation,g2_g1_preparedby,g2_g1_readyforreview,g2_g1_reviewassignedto,g2_g1_reviewed,g2_g1_reviewedby,g2_g1_reviewedwithnotes';_loadit({"query":query,"list":list});break;
/*Group2_2*/case "TRST_2_ASSEMBLERETURN":var list='g2_g2_assemblereturn,g2_g2_contacted,g2_g2_currentfees,g2_g2_delivered,g2_g2_deliverymethod,g2_g2_emailed,g2_g2_messageleft,g2_g2_missingsignatures,g2_g2_paymentstatus,g2_g2_priorfees';_loadit({"query":query,"list":list});break;
/*Group2_3*/case "TRST_3_PPTRASSIGNEDTO":var list='g2_g3_assignedto,g2_g3_completed,g2_g3_currentfees,g2_g3_delivered,g2_g3_extended,g2_g3_paymentstatus,g2_g3_priorfees,g2_g3_required,g2_g3_rfr';_loadit({"query":query,"list":list});break;
/*Group3*/case "TRSC_ID":var list='subtask2_id,g3_assignedto,g3_reviewassignedto,g3_schedule,g3_status';_loadit({"query":query,"list":list});break;
/*Group3_1*/case "TRSC_1_ASSIGNEDTO":var list='g3_g1_assignedto,g3_g1_completed,g3_g1_duedate,g3_g1_informationreceived,g3_g1_missinginforeceived,g3_g1_missinginformation,g3_g1_preparedby,g3_g1_readyforreview,g3_g1_reviewassignedto,g3_g1_reviewed,g3_g1_reviewedby,g3_g1_reviewedwithnotes';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){var options={"id":"","group":"","subgroup":"","result":""};$.extend(true, options, params);var $client_id=$("#client_id");
switch(options["group"]){

case'':
if($("#client_id").val()!=0){_saveDataCB({'group':'group1'});jqMessage({message: "Saving",type: "save",autoClose: true})}
else{jqMessage({message: "You must choose a client.",type: "info",autoClose: true})}
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_currentfees").val()+'","'+
$("#g1_deliverymethod").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_esttime").val()+'","'+
$("#g1_extensiondone").val()+'","'+
$("#g1_extensionrequested").val()+'","'+
$("#g1_filingdeadline").val()+'",'+
$("#g1_missinginformation").is(':checked')+',"'+
$("#g1_missinginforeceived").val()+'",'+
$("#g1_notrequired").is(':checked')+',"'+
$("#g1_paymentstatus").val()+'","'+
$("#g1_priorfees").val()+'","'+
$("#g1_priority").val()+'","'+
$("#g1_reason").val()+'","'+
$("#g1_taxform").val()+'","'+
$("#g1_taxyear").val()+'","'+
'"]]}' 


if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_taxyear").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Tax Year",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Year');}
	}
else if ($("#g1_taxform").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message:"Missing Tax Form",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Form');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1","payload":$.parseJSON(json),page:"taxreturns"})
	if(debug){window.console.log('Start Saving Tax Returns');}	
	}
break;


case'group1_1':var json='{"DATA":[["'+
//group 1 subgroup 1
$("#task_id").val()+'","'+
$("#g1_g1_dropoffappointment").val()+'","'+
$("#g1_g1_dropoffappointmentlength").val()+'","'+
$("#g1_g1_dropoffappointmentwith").val()+'","'+
$("#g1_g1_pickupappointment").val()+'","'+
$("#g1_g1_pickupappointmentlength").val()+'","'+
$("#g1_g1_pickupappointmentwith").val()+'",'+
$("#g1_g1_whileyouwaitappt").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group1_2'})};
break;

case'group1_2':var json='{"DATA":[["'+
//group 1 subgroup 2
$("#task_id").val()+'","'+
$("#g1_g2_assignedto").val()+'","'+
$("#g1_g2_completed").val()+'","'+
$("#g1_g2_informationreceived").val()+'","'+
$("#g1_g2_preparedby").val()+'","'+
$("#g1_g2_readyforreview").val()+'","'+
$("#g1_g2_reviewassignedto").val()+'","'+
$("#g1_g2_reviewed").val()+'","'+
$("#g1_g2_reviewedby").val()+'","'+
$("#g1_g2_reviewedwithnotes").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group1_3'})};
break;

case'group1_3':var json='{"DATA":[["'+
//group 1 subgroup 3
$("#task_id").val()+'","'+
$("#g1_g3_assemblereturn").val()+'","'+
$("#g1_g3_contacted").val()+'","'+
$("#g1_g3_delivered").val()+'",'+
$("#g1_g3_emailed").is(':checked')+','+
$("#g1_g3_messageleft").is(':checked')+','+
$("#g1_g3_missingsignatures").is(':checked')+','+
$("#g1_g3_multistatereturn").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3",payload:$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group1_4'})};
break;

case'group1_4':var json='{"DATA":[["'+
//group 1 subgroup 4
$("#task_id").val()+'","'+
$("#g1_g4_assignedto").val()+'","'+
$("#g1_g4_completed").val()+'","'+
$("#g1_g4_completedby").val()+'","'+
$("#g1_g4_currentfees").val()+'","'+
$("#g1_g4_delivered").val()+'","'+
$("#g1_g4_extended").val()+'","'+
$("#g1_g4_extensionrequested").val()+'","'+
$("#g1_g4_paymentstatus").val()+'","'+
$("#g1_g4_pptresttime").val()+'","'+
$("#g1_g4_priorfees").val()+'",'+
$("#g1_g4_required").is(':checked')+',"'+
$("#g1_g4_reviewassigned").val()+'",'+
$("#g1_g4_reviewed").is(':checked')+',"'+
$("#g1_g4_reviewedby").val()+'","'+
$("#g1_g4_rfr").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4",payload:$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group2'})};
break;

case'group2':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_completed").val()+'",'+
$("#g2_primary").is(':checked')+',"'+
$("#g2_reviewassignedto").val()+'","'+
$("#g2_state").val()+'","'+
$("#g2_status").val()+'","'+
$("#g2_requiredforms").val()+'","'+
'"]]}'
if($("#isLoaded_group2").val()!=0){
if($("#g2_state").val()==0){jqMessage({message: "You must choose a state.",type: "info",autoClose: true})}
else{_saveData({group:"group2","payload":$.parseJSON(json),page:"taxreturns"})}}
else{_saveDataCB({'group':'group2_1'})};
break;

case'group2_1':var json='{"DATA":[["'+
//group 2 subgroup 1
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_g1_assignedto").val()+'","'+
$("#g2_g1_completed").val()+'","'+
$("#g2_g1_duedate").val()+'","'+
$("#g2_g1_informationreceived").val()+'","'+
$("#g2_g1_missinginforeceived").val()+'",'+
$("#g2_g1_missinginformation").is(':checked')+',"'+
$("#g2_g1_preparedby").val()+'","'+
$("#g2_g1_readyforreview").val()+'","'+
$("#g2_g1_reviewassignedto").val()+'","'+
$("#g2_g1_reviewed").val()+'","'+
$("#g2_g1_reviewedby").val()+'","'+
$("#g2_g1_reviewedwithnotes").val()+'","'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group2_2'})};
break;

case'group2_2':var json='{"DATA":[["'+
//group 2 subgroup 2
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_g2_assemblereturn").val()+'","'+
$("#g2_g2_contacted").val()+'","'+
$("#g2_g2_currentfees").val()+'","'+
$("#g2_g2_delivered").val()+'","'+
$("#g2_g2_deliverymethod").val()+'",'+
$("#g2_g2_emailed").is(':checked')+','+
$("#g2_g2_messageleft").is(':checked')+','+
$("#g2_g2_missingsignatures").is(':checked')+',"'+
$("#g2_g2_paymentstatus").val()+'","'+
$("#g2_g2_priorfees").val()+'","'+

'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2","payload":$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group2_3'})};
break;

case'group2_3':var json='{"DATA":[["'+
//group 2 subgroup 3
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_g3_assignedto").val()+'","'+
$("#g2_g3_completed").val()+'","'+
$("#g2_g3_currentfees").val()+'","'+
$("#g2_g3_delivered").val()+'","'+
$("#g2_g3_extended").val()+'","'+
$("#g2_g3_paymentstatus").val()+'","'+
$("#g2_g3_priorfees").val()+'",'+
$("#g2_g3_required").is(':checked')+',"'+
$("#g2_g3_rfr").val()+'","'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3",payload:$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group3'})};
break;

case'group3':var json='{"DATA":[["'+
$("#subtask2_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g3_assignedto").val()+'","'+
$("#g3_reviewassignedto").val()+'","'+
$("#g3_schedule").val()+'","'+
$("#g3_status").val()+'","'+
'"]]}'
if($("#isLoaded_group3").val()!=0){_saveData({group:"group3",payload:$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'group3_1'})};
break;

case'group3_1':var json='{"DATA":[["'+
//group 3 subgroup 1
$("#subtask2_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g3_g1_assignedto").val()+'","'+
$("#g3_g1_completed").val()+'","'+
$("#g3_g1_duedate").val()+'","'+
$("#g3_g1_informationreceived").val()+'","'+
$("#g3_g1_missinginforeceived").val()+'",'+
$("#g3_g1_missinginformation").is(':checked')+',"'+
$("#g3_g1_preparedby").val()+'","'+
$("#g3_g1_readyforreview").val()+'","'+
$("#g3_g1_reviewassignedto").val()+'","'+
$("#g3_g1_reviewed").val()+'","'+
$("#g3_g1_reviewedby").val()+'","'+
$("#g3_g1_reviewedwithnotes").val()+'","'+
'"]]}'
if($("#isLoaded_group3_1").val()!=0){_saveData({group:"group3_1","payload":$.parseJSON(json),page:"taxreturns"})}
else{_saveDataCB({'group':'plugins'})};
break;


/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;

/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in taxreturns.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
