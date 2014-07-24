$(document).ready(function(){_grid1()});

var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_toggle("group1,largeMenu");_hide("entrance,smallMenu,group2");_addNewTask();}
	,new_group2:function(){$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);$("#subtask1_id").val(0);_addNewTask({"new":"subtask1_id"});_clearfields({"list":"g2_priority,g2_estimatedtime,g2_missinginformation,g2_missinginforeceived,g2_fees,g2_1_noticenumber,g2_1_noticedate,g2_1_datenoticereceived,g2_1_duedateforresponse,g2_2_responsecompleted,g2_2_reviewrequired,g2_2_reviewcompleted,g2_2_responsesubmitted,g2_2_irsstateresponserecieved,g2_noticestatus,g2_deliverymethod,g2_1_noticenumber,g2_2_reviewassignedto,g2_assignedto,g2_paid,g2_1_taxyear,g2_1_taxform,g2_1_methodreceived,g2_2_responsecompletedby"});}
	,load_group1:function(){_grid1();}
	,load_group2:function(){_grid2();$("#isLoaded_group2").val(1);if($('#task_id').val()!=0||$('#task_id').val()!=''){_loadit({"query":{"COLUMNS":["g2_noticestatus"],"DATA":[[4]]},"list":"g2_noticestatus","page":"notices"});}}
	,load_group2_1:function(){_loadData({"id":"subtask1_id","group":"group2_1","page":"notices"});$("#isLoaded_group2_1").val(1);}
	,load_group2_2:function(){_loadData({"id":"subtask1_id","group":"group2_2","page":"notices"});$("#isLoaded_group2_2").val(1);}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"notices"});}
	}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"notices.cfc",
	"title":"Notice Matters",
	"fields":{N_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.N_ID+"',page:'notices',group:'group1'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,N_NAME:{title:'Matter Name'}
		,N_STATUSTEXT:{title:'Matter Status'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"8"}',
	"functions":'$("#task_id").val(record.N_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"notices"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"notices.cfc",
	"title":"Notices",
	"fields":{NST_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.NST_ID+"',page:'notices',group:'group2'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,N_NAME:{title:'Matter Name'}
		,N_STATUSTEXT:{title:'Matter Status'}	
		,NST_1_TAXYEAR:{title:'Tax Year',width:'2%'}
		,NST_1_TAXFORMTEXT:{title:'Tax Form'}
		,NST_1_NOTICENUMBERTEXT:{title:'Notice Number',width:'2%'}
		,NST_1_RESDUEDATE:{title:'Due Date for Response',width:'2%'}	
		,NST_STATUSTEXT:{title:'Notice Status'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"8"}',
	"functions":'$("#subtask1_id").val(record.NST_ID);$("#group2").accordion({active:1});$("#isLoaded_group2").val(1);_loadData({"id":"subtask1_id","group":"group2","page":"notices"});'
	})};


_loadDataCB=function(query){if(debug){window.console.log('_loadDataCB Start - '+query.COLUMNS[0]);}

switch(query.COLUMNS[0]){
/*Group1*/case "N_ID":var list='task_id,client_id,g1_mattername,g1_matterstatus,g2_matter';_loadit({"query":query,"list":list});_run.load_assets();break;
/*Group2*/case "NST_ID":var list='subtask1_id,g2_assignedto,g2_deliverymethod,g2_estimatedtime,g2_fees,g2_missinginformation,g2_missinginforeceived,g2_noticestatus,g2_paid,g2_priority';_loadit({"query":query,"list":list});break;
/*Group2_1*/case "NST_1_DATENOTICEREC":var list='g2_1_datenoticereceived,g2_1_methodreceived,g2_1_noticedate,g2_1_noticenumber,g2_1_duedateforresponse,g2_1_taxform,g2_1_taxyear'; _loadit({"query":query,"list":list}); break;
/*Group2_2*/case "NST_2_IRSSTATERESPONSE":var list='g2_2_irsstateresponserecieved,g2_2_responsecompleted,g2_2_responsecompletedby,g2_2_responsesubmitted,g2_2_reviewassignedto,g2_2_reviewcompleted,g2_2_reviewrequired';_loadit({"query":query,"list":list});break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){ if(debug){window.console.log('_loadDataCB switch default:'+query.COLUMNS[0]);} var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
}
};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
$.extend(true, options, params);
switch(options["group"]){
case'':_saveDataCB({'group':'group1'});break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_mattername").val()+'","'+
$("#g1_matterstatus").val()+'","'+
'"]]}'
if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_mattername").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Matter Name",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Matter Name');}
	}
else if ($("#g2_1_noticenumber").val()=="0" && $("#isLoaded_group2_1").val()=="1" ){
	$('.gf-checkbox').hide();$('#group2').show();$('#group2').accordion({ active: 2 });$("#isLoaded_group2_1").val(1);
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Notice Number",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Notice Number');}
	}
else if ($("#g2_1_noticedate").val()==""&& $("#isLoaded_group2_1").val()=="1" ){
	$('.gf-checkbox').hide();$('#group2').show().accordion({ active: 2 });$("#isLoaded_group2_1").val(1);
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Notice Date",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Notice Date');}
	}
else if ($("#g2_1_taxyear").val()=="0"&& $("#isLoaded_group2_1").val()=="1" ){
	$('.gf-checkbox').hide();$('#group2').show().accordion({ active: 2 });$("#isLoaded_group2_1").val(1);
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Tax Year",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Year');}
	}
else if ($("#g2_1_taxform").val()=="0"&& $("#isLoaded_group2_1").val()=="1" ){
	$('.gf-checkbox').hide();$('#group2').show().accordion({ active: 2 });$("#isLoaded_group2_1").val(1);
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Tax Form",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Form');}
	}
else if ($("#g2_1_methodreceived").val()=="0"&& $("#isLoaded_group2_1").val()=="1" ){
	$('.gf-checkbox').hide();$('#group2').show().accordion({ active: 2 });$("#isLoaded_group2_1").val(1);
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Method Received",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Method Received');}
	}
else if(_duplicateCheck({"check":[{"item":"client_id"},{"item":"g2_1_noticenumber"},{"item":"g2_1_noticedate"},{"item":"g2_1_taxyear"},{"item":"g2_1_taxform"},{"item":"g2_1_duedateforresponse"}],"loadType":"group1","page":"notices"})=='true'&&$('#subtask1_id').val()=='0'){
	jqMessage({"type":"destroy"});jqMessage({message: "This task is already in the system.",type: "error",autoClose: false});
	if(debug){window.console.log('This task is already in the system..');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1","payload":$.parseJSON(json),page:"notices"});
	if(debug){window.console.log('Start Saving Notices');}	
	}
	
break;

case'group2':$("#task_id").val(options["id"]);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_assignedto").val()+'","'+
$("#g2_deliverymethod").val()+'","'+
$("#g2_estimatedtime").val()+'","'+
$("#g2_fees").val()+'",'+
$("#g2_missinginformation").is(':checked')+',"'+
$("#g2_missinginforeceived").val()+'","'+
$("#g2_noticestatus").val()+'","'+
$("#g2_paid").val().replace(/([$,])/g, '')+'","'+
$("#g2_priority").val()+'","'+
'"]]}';
if($("#isLoaded_group2").val()!=0){_saveData({group:"group2","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_1'})};
break;

case'group2_1':$("#subtask1_id").val(options["id"]);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_1_noticenumber").val()+'","'+
$("#g2_1_noticedate").val()+'","'+
$("#g2_1_taxyear").val()+'","'+
$("#g2_1_taxform").val()+'","'+
$("#g2_1_methodreceived").val()+'","'+
$("#g2_1_datenoticereceived").val()+'","'+
$("#g2_1_duedateforresponse").val()+'","'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'group2_2'})};
break;

case'group2_2':$("#subtask1_id").val(options["id"]);
var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
$("#g2_2_irsstateresponserecieved").val()+'","'+
$("#g2_2_responsecompleted").val()+'","'+
$("#g2_2_responsecompletedby").val()+'","'+
$("#g2_2_responsesubmitted").val()+'","'+
$("#g2_2_reviewassignedto").val()+'","'+
$("#g2_2_reviewcompleted").val()+'",'+
$("#g2_2_reviewrequired").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2",payload:$.parseJSON(json),page:"notices"})}
else{_saveDataCB({'group':'plugins'})};
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in notices.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}