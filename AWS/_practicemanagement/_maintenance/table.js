$(document).ready(function(){
_grid1(jqMessage({message:"Changes to select boxes effects the dropdown select options for your entire company.",type: "warning",autoClose: false}));
_group1=function(){}
_group2=function(){_clearfields({"sel":"opt_Form,g2_optionGroup,g2_optionHide","list":"g2_optionName,g2_optionDescription"});_grid2();}
});

$('#opt_OtherFilings').hide();
$('#opt_TaxReturnsSchedule').hide();

_options=function(id){
	switch(id){
	case'10':$('#opt_OtherFilings').show(); break; 
	case'35':$('#opt_TaxReturnsSchedule').show(); break;
	}};
	
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"table.cfc",
	"title":"Table Maintenance",
	"fields":{SELECTNAME_ID:{key:true,list:false,edit:false},SELECTLABEL:{title:'Select Name'},SELECTDESCRIPTION:{title:'Select Description'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#task_id").val(record.SELECTNAME_ID);_options(record.SELECTNAME_ID);_updateh3(record.SELECTLABEL);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"table"});'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"table.cfc",
	"title":"Select Options",
	"fields":{SELECT_ID:{key:true,list:false,edit:false},OPTIONNAME:{title:'Option Name'},OPTIONGROUPTEXT:{title:'Form Specific'},OPTIONHIDETEXT:{title:'Hide From'},OPTIONDESCRIPTION:{title:'Option Description'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$(".trackers #subtask1_id").val(record.SELECT_ID);_loadData({"id":"subtask1_id","group":"group2","page":"table"});$("#group2").accordion({active:1});'
	})};
	
	
_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group1*/case "SELECTNAME_ID":var list='task_id,g1_selectLabel,g1_selectDescription';_loadit({"query":query,"list":list,"page":"table"});break;
/*Group2*/case "SELECT_ID":var list='subtask1_id,g2_optionName,g2_optionDescription,g2_optionGroup,g2_optionHide';
//Load Options
//Other Filing Types
if($("#task_id").val() == '10'){
var list=list+',opt_State,opt_FilingDeadline,opt_ExtensionDeadline';	
	}
	
if($("#task_id").val() == '35'){
var list=list+',opt_Form';
	}	
	
_loadit({"query":query,"list":list,"page":"table"});break;


default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};
_saveDataCB=function(params){
var options={"id":"","group":"","subgroup":"","result":""}
$.extend(true, options, params);
switch(options["group"]){
case'':_saveDataCB({'group':'group2'});jqMessage({message: "Saving.",type: "save",autoClose: true});break;
case'group1': _saveDataCB({'group':'group2'}); break;

case'group2':var json='{"DATA":[["'+
$("#subtask1_id").val()+'","'+
$("#task_id").val()+'","'+
'ROWCOUNT'+'","'+
$("#g2_optionName").val()+'","'+
$("#g2_optionDescription").val()+'","'+
$("#g2_optionGroup").val()+'","'+
$("#g2_optionHide").val()+'","'+

(($("#task_id").val() == '10' )?
$("#opt_State").val()+'","'+
$("#opt_FilingDeadline").val()+'","'+
$("#opt_ExtensionDeadline").val()+'","'
:one='')+

(($("#task_id").val() == '35' )?
$("#opt_Form").val()+'","'
:one='')+

'","'+
'","'+
'","'+
'"]]}'
_saveData({group:"group1",payload:$.parseJSON(json),page:"table"});
break;
/*Start Saving Plugins*/
case"plugins":_pluginSaveData({"subgroup":options["subgroup"]});break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception in table.js "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: false,duration: 5});break;}}