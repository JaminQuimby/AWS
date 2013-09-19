$(document).ready(function(){
	
_grid1();
_group1=function(){}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"employeecontactinfo.cfc",
	"title":"Employee Contact Information",
	"fields":{SI_ID:{key:true,list:false,edit:false},NAME:{title:'Employee Name'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.USER_ID);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"employeecontactinfo"});'
	})};
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "USER_ID":var list='task_id,g1_active,g1_address,g1_birthday,g1_cafnum,g1_childname1,g1_childname2,g1_childname3,g1_city,g1_contactphone,g1_email1,g1_email2,g1_emergencycontact,g1_ext,g1_initials,g1_phone1,g1_phone2,g1_phone3,g1_ptin,g1_relationship,g1_spousename,g1_state,g1_website1,g1_zip,g1_name';_loadit({"query":query,"list":list});break;

default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};


/*SAVE DATA CALL BACK*/
_saveDataCB=function(params){
var options={"id":"","group":"","result":""	}
try{	
$.extend(true, options, params);//turn options into array

switch(options["group"]){
case'':
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
break;

case'group1':var json='{"DATA":[["'+
$("#task_id").val()+'",'+
$("#g1_active").is(':checked')+',"'+
$("#g1_address").val()+'","'+
$("#g1_birthday").val()+'","'+
$("#g1_cafnum").val()+'","'+
$("#g1_city").val()+'","'+
$("#g1_childname1").val()+'","'+
$("#g1_childname2").val()+'","'+
$("#g1_childname3").val()+'","'+
$("#g1_contactphone").val()+'","'+
$("#g1_email1").val()+'","'+
$("#g1_email2").val()+'","'+
$("#g1_emergencycontact").val()+'","'+
$("#g1_ext").val()+'","'+
$("#g1_initials").val()+'","'+
$("#g1_phone1").val()+'","'+
$("#g1_phone2").val()+'","'+
$("#g1_phone3").val()+'","'+
$("#g1_ptin").val()+'","'+
$("#g1_relationship").val()+'","'+
$("#g1_spousename").val()+'","'+
$("#g1_state").val()+'","'+
$("#g1_website1").val()+'","'+
$("#g1_zip").val()+'","'+
'"]]}'
_saveData({group:"group1","payload":$.parseJSON(json),page:"employeecontactinfo"});
break;

/*Start Saving Plugins*/
case"plugins":_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};





