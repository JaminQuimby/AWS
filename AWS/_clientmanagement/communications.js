$(document).ready(function(){_grid1();});

var _run={
	 new_group1:function(){document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu');_addNewTask();$('#g1_date').datetimepicker('setDate', (new Date()) );}
	,load_group0:function(){_grid1();}
	,load_group1:function(){}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"communications"});}
	}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"communications.cfc",
	"title":"Communications",
	"fields":{CO_ID:{key:true,list:false,edit:false}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.CO_ID+"',page:'communications',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,CO_CALLER:{title:'Caller'}
		,CO_DATE:{title:'Date and Time'}
		,CO_DUEDATE:{title:'Due Date',width:'2%'}
		,CO_STATUSTEXT:{title:'Status',width:'2%'}
		,CO_FORTEXT:{title:'For',width:'2%'}
		,CO_RESPONSENEEDED:{title:'Response Required',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		,CO_RETURNCALL:{title:'Returned Call',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}			
		,CO_BRIEFMESSAGE:{title:'Brief Message'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.CO_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"communications"});'
	})};
	
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "CO_ID":var list='task_id,client_id,g1_briefmessage,g1_caller,g1_contactmethod,g1_date,g1_duedate,g1_emailaddress,g1_ext,g1_faxnumber,g1_fees,g1_for,g1_paid,g1_status,g1_responseneeded,g1_returnedcall,g1_takenby,g1_telephone';_loadit({"query":query,"list":list});_run.load_assets();break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{
$.extend(true, options, params);//turn options into array
var $client_id=$("#client_id");
alert(options["group"]);
switch(options["group"]){	
case'':_saveDataCB({'group':'group1'});break;
case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
$("#client_id").val()+'","'+
$("#g1_briefmessage").val()+'","'+
$("#g1_caller").val()+'","'+
$("#g1_contactmethod").val()+'","'+
$("#g1_date").val()+'","'+
$("#g1_duedate").val()+'","'+
$("#g1_emailaddress").val()+'","'+
$("#g1_ext").val()+'","'+
$("#g1_faxnumber").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g1_fees").val()+'","'+
$("#g1_for").val()+'","'+
$("#g1_paid").val()+'","'+
$("#g1_status").val()+'",'+
$("#g1_responseneeded").is(':checked')+','+
$("#g1_returnedcall").is(':checked')+',"'+
$("#g1_takenby").val()+'","'+
$("#g1_telephone").val().replace(/[^0-9\.]/g, '')+'","'+
'"]]}'


if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_date").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Date and Time",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Date and Time');}
	}
else if ($("#g1_caller").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Caller",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Caller');}
	}
else if ($("#g1_takenby").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Taken By",type: "error",autoClose: false});
	if(debug){window.console.log('Missing  Taken By');}
	}
else if ($("#g1_contactmethod").val()==null){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Contact method",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Contact method');}
	}
else if ($("#g1_briefmessage").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Breif Message",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Breif Message');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1","payload":$.parseJSON(json),page:"communications"});
	if(debug){window.console.log('Start Saving Communications');}	
	}
break;
/*Start Saving Plugins*/
case"plugins":$('#task_id').val(options['id']);_pluginSaveData({"subgroup":options["subgroup"]});break;
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in communications.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};