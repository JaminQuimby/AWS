$(document).ready(function(){_grid1()});


var _run={
	 new_group1:function(){document.getElementById("content").className="contentbig";_toggle("group1,largeMenu");_hide("entrance,smallMenu");_addNewTask();}
	,load_group1:function(){_grid1();}
	,load_assets:function(){_loadData({"id":"client_id","group":"assetCreditHold","page":"powerofattorney"});}
}


	_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"powerofattorney.cfc",
	"title":"Power of Attorney",
	"fields":{PA_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.PA_ID+"',page:'powerofattorney',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,PA_TAXYEARS:{title:'Tax Years'}
		,PA_TAXFORMSTEXT:{title:'Tax Forms'}
		,PA_TAXMATTERSTEXT:{title:'Tax Matters'}
		,PA_PREPARERSTEXT:{title:'Preparers',width:'2%'}
		,PA_STATUSTEXT:{title:'Status'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"7"}',
	"functions":'$("#task_id").val(record.PA_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"powerofattorney"});'
	})};


_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "PA_ID":var list='task_id,client_id,g1_dateofrevocation,g1_datesenttoirs,g1_datesignedbyclient,g1_preparers,g1_status,g1_taxforms,g1_taxmatters,g1_taxyears';_loadit({"query":query,"list":list});_run.load_assets();break;
/*AssetCreditHold*/case "CLIENT_CREDIT_HOLD":var list='g1_credithold';_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
var $client_id=$("#client_id");
switch(options["group"]){

case'':_saveDataCB({'group':'group1'});break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'","'+
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

 console.log($("#g1_taxyears").val())
if($("#client_id").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Client",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Client');}
	}
else if ($("#g1_taxyears").val()==null){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Tax Year",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Year');}
	}
else if ($("#g1_taxforms").val()==null){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Tax Forms",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Tax Forms');}
	}
else if ($("#g1_taxmatters").val()==null){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Tax Matters",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Missing Tax Matters');}
	}
else if ($("#g1_preparers").val()==null){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Preparers",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Preparers');}
	}
else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1",payload:$.parseJSON(json),page:"powerofattorney"});
	if(debug){window.console.log('Start Saving Other Filings');}	
	}	

break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in powerofattorney.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}
catch(err){alert(err)}};