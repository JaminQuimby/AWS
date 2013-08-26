/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/19/2013 - Started
*/



$(document).ready(function(){
/*Define Grid Instances*/   
_grid1();
_group1=function(){}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
_group4=function(){_grid4()}
_group5=function(){_grid5()}
});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"practicemaintenance.cfc",
	"title":"Maintenance",
	"fields":{M_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},M_:{title:''}},//Unsure about this case where group one has nothing.
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#m_id").val(record.M_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"m_id","group":"group1","page":"paypracticemaintenance"});'
	}); }


_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"practicemaintenance.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false},C_DATE:{title:'Date'},U_NAME:{title:'Name'},C_NOTES:{title:'Comment'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"13","ClientID":"'+$("#client_id").val()+'","OTHERID":"'+$("#m_id").val()+'","loadType":"group2"}',
	"functions":''
	})}





	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group1*/case "M_ID":var list='m_id';_loadit({"query":query,"list":list});break;
/*Group1_1*/case "M_1_SOFTWARENAME":var list='g1_g1_softwarename';_loadit({"query":query,"list":list});break;
/*Group1_2*/case "M_2_CATEGORY":var list='g1_g2_category,g1_g2_description';_loadit({"query":query,"list":list});break;
/*Group1_3*/case "M_3_GROUPNAME":var list='g1_g3_groupname';_loadit({"query":query,"list":list});break;
/*Group1_4*/case "M_4_DESCRIPTION":var list='g1_g4_description, g1_g4_pfpcategory';_loadit({"query":query,"list":list});break;
/*Group1_5*/case "M_5_SUBTASKGROUP":var list='g1_g5_subtaskgroup';_loadit({"query":query,"list":list});break;
/*Group1_6*/case "M_6_DEPENDENCY":var list='g1_g6_dependency, g1_g6_sequence, g1_g6_subtaskgroup, g1_g6_task';_loadit({"query":query,"list":list});break;
/*Group1_7*/case "M_7_CONSULTINGCATEGORY":var list='g1_g7_consultingcategory, g1_g7_description, g1_g7_estimatedtime, g1_g7_priority';_loadit({"query":query,"list":list});break;
/*Group1_8*/case "M_8_CONSULTINGGROUP":var list='g1_g8_consultinggroup';_loadit({"query":query,"list":list});break;
/*Group1_9*/case "M_9_DEPENDENCY":var list='g1_g9_dependency, g1_g9_group, g1_g9_sequence, g1_g9_task';_loadit({"query":query,"list":list});break;
/*Group1_10*/case "M_10_DESCRIPTION":var list='g1_g10_description, g1_g10_instructions, g1_g10_noticenumbers';_loadit({"query":query,"list":list});break;
/*Group1_11*/case "M_11_DESCRIPTION":var list='g1_g11_description, g1_g11_extensiondeadline, g1_g11_filingdeadline, g1_g11_form, g1_g11_state';_loadit({"query":query,"list":list});break;
/*Group1_12*/case "M_12_DESCRIPTION":var list='g1_g12_description, g1_g12_type';_loadit({"query":query,"list":list});break;
/*Group1_13*/case "M_13_PAYROLLFREQUENCIES":var list='g1_g13_paryrollfrequencies';_loadit({"query":query,"list":list});break;
/*Group1_14*/case "M_14_ID":var list='g1_g14_id, g1_g14_returntype';_loadit({"query":query,"list":list});break;
/*Group1_15*/case "M_15_TAXMATTERS":var list='g1_g15_taxmatters';_loadit({"query":query,"list":list});break;
/*Group1_16*/case "M_16_ABBREVIATIONS":var list='g1_g16_abbreviations, g1_g16_state';_loadit({"query":query,"list":list});break;
/*Group1_17*/case "M_17_DESCRIPTION":var list='g1_g17_description, g1_g17_extensiondeadline, g1_g17_filingdeadline, g1_g17_form, g1_g17_state';_loadit({"query":query,"list":list});break;
/*Group1_18*/case "M_18_DESCRIPTION":var list='g1_g18_description, g1_g18_schedule, g1_g18_taxform';_loadit({"query":query,"list":list});break;
/*Group1_19*/case "M_19_FILINGDEADLINE":var list='g1_g19_filingdeadline, g1_g19_formdescription, g1_g19_formnumber';_loadit({"query":query,"list":list});break;
/*Group1_20*/case "M_20_TAXERVICEFIELD1":var list='g1_g20_taxservicefield1, g1_g20_taxservicefield2, g1_g20_taxservicefield3, g1_g20_taxservicefield4';_loadit({"query":query,"list":list});break;
/*Group2*/case "MHD_ID":var list='mhd_id';_loadit({"query":query,"list":list});break;


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

/*TO DO ?*/
var e58=document.getElementById("m_fs_subtaskgroup").value
,e59=document.getElementById("m_fs_historicalfs").value;
/*
Build arguments for Related Clients UNDER CONSTRUCTION
*/
switch(options["group"]){
/*Save Client*/


/*Save Group1*/
case'group1':var json='{"DATA":[["'+
'"]]}'
break;



/* Group 1 Subgroup 1 */
case'group1_1':var json='{"DATA":[["'+
$("#g1_g1_softwarename").val()+'","'+
'"]]}'
if($("#isLoaded_group1_1").val()!=0){_saveData({group:"group1_1","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_2'})}
break;
/* Group 1 Subgroup 2 */
case'group1_2':var json='{"DATA":[["'+
$("#g1_g2_category").val()+'","'+
$("#g1_g2_description").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_3'})}
break;
/* Group 1 Subgroup 3 */
case'group1_3':var json='{"DATA":[["'+
$("#g1_g3_groupname").val()+'","'+
'"]]}'
if($("#isLoaded_group1_3").val()!=0){_saveData({group:"group1_3","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_4'})}
break;
/* Group 1 Subgroup 4 */
case'group1_4':var json='{"DATA":[["'+
$("#g1_g4_description").val()+'","'+
$("#g1_g4_pfpcategory").val()+'","'+
'"]]}'
if($("#isLoaded_group1_4").val()!=0){_saveData({group:"group1_4","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_5'})}
break;
/* Group 1 Subgroup 5 */
case'group1_5':var json='{"DATA":[["'+
$("#g1_g5_subtaskgroup").val()+'","'+
'"]]}'
if($("#isLoaded_group1_5").val()!=0){_saveData({group:"group1_5","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_6'})}
break;
/* Group 1 Subgroup 6 */
case'group1_6':var json='{"DATA":[["'+
$("#g1_g6_dependency").val()+'","'+
$("#g1_g6_sequence").val()+'","'+
$("#g1_g6_subtaskgroup").val()+'","'+
$("#g1_g6_task").val()+'","'+
'"]]}'
if($("#isLoaded_group1_6").val()!=0){_saveData({group:"group1_6","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_7'})}
break;
/* Group 1 Subgroup 7 */
case'group1_7':var json='{"DATA":[["'+
$("#g1_g7_consultingcategory").val()+'","'+
$("#g1_g7_description").val()+'","'+
$("#g1_g7_estimatedtime").val()+'","'+
$("#g1_g7_priority").val()+'","'+
'"]]}'
if($("#isLoaded_group1_7").val()!=0){_saveData({group:"group1_7","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_8'})}
break;
/* Group 1 Subgroup 8 */
case'group1_8':var json='{"DATA":[["'+
$("#g1_g8_consultinggroup").val()+'","'+
'"]]}'
if($("#isLoaded_group1_8").val()!=0){_saveData({group:"group1_8","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_9'})}
break;
/* Group 1 Subgroup 9 */
case'group1_9':var json='{"DATA":[["'+
$("#g1_g9_dependency").val()+'","'+
$("#g1_g9_group").val()+'","'+
$("#g1_g9_sequence").val()+'","'+
$("#g1_g9_task").val()+'","'+
'"]]}'
if($("#isLoaded_group1_9").val()!=0){_saveData({group:"group1_9","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_10'})}
break;
/* Group 1 Subgroup 10 */
case'group1_10':var json='{"DATA":[["'+
$("#g1_g10_description").val()+'","'+
$("#g1_g10_instructions").val()+'","'+
$("#g1_g10_noticenumbers").val()+'","'+
'"]]}'
if($("#isLoaded_group1_10").val()!=0){_saveData({group:"group1_10","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_11'})}
break;
/* Group 1 Subgroup 11 */
case'group1_11':var json='{"DATA":[["'+
$("#g1_g11_description").val()+'","'+
$("#g1_g11_extensiondeadline").val()+'","'+
$("#g1_g11_filingdeadline").val()+'","'+
$("#g1_g11_form").val()+'","'+
$("#g1_g11_state").val()+'","'+
'"]]}'
if($("#isLoaded_group1_11").val()!=0){_saveData({group:"group1_11","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_12'})}
break;
/* Group 1 Subgroup 12 */
case'group1_12':var json='{"DATA":[["'+
$("#g1_g12_description").val()+'","'+
$("#g1_g12_type").val()+'","'+
'"]]}'
if($("#isLoaded_group1_12").val()!=0){_saveData({group:"group1_12","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_13'})}
break;
/* Group 1 Subgroup 13 */
case'group1_13':var json='{"DATA":[["'+
$("#g1_g13_paryrollfrequencies").val()+'","'+
'"]]}'
if($("#isLoaded_group1_13").val()!=0){_saveData({group:"group1_13","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_14'})}
break;
/* Group 1 Subgroup 14 */
case'group1_14':var json='{"DATA":[["'+
$("#g1_g14_id").val()+'","'+
$("#g1_g14_returntype").val()+'","'+
'"]]}'
if($("#isLoaded_group1_14").val()!=0){_saveData({group:"group1_14","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_15'})}
break;
/* Group 1 Subgroup 15 */
case'group1_15':var json='{"DATA":[["'+
$("#g1_g15_taxmatters").val()+'","'+
'"]]}'
if($("#isLoaded_group1_15").val()!=0){_saveData({group:"group1_15","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_16'})}
break;
/* Group 1 Subgroup 16 */
case'group1_16':var json='{"DATA":[["'+
$("#g1_g16_abbreviations").val()+'","'+
$("#g1_g16_state").val()+'","'+
'"]]}'
if($("#isLoaded_group1_16").val()!=0){_saveData({group:"group1_16","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_17'})}
break;
/* Group 1 Subgroup 17 */
case'group1_17':var json='{"DATA":[["'+
$("#g1_g17_description").val()+'","'+
$("#g1_g17_extensiondeadline").val()+'","'+
$("#g1_g17_filingdeadline").val()+'","'+
$("#g1_g17_form").val()+'","'+
$("#g1_g17_state").val()+'","'+
'"]]}'
if($("#isLoaded_group1_17").val()!=0){_saveData({group:"group1_17","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_18'})}
break;
/* Group 1 Subgroup 18 */
case'group1_18':var json='{"DATA":[["'+
$("#g1_g18_description").val()+'","'+
$("#g1_g18_schedule").val()+'","'+
$("#g1_g18_taxform").val()+'","'+
'"]]}'
if($("#isLoaded_group1_18").val()!=0){_saveData({group:"group1_18","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_19'})}
break;
/* Group 1 Subgroup 19 */
case'group1_19':var json='{"DATA":[["'+
$("#g1_g19_filingdeadline").val()+'","'+
$("#g1_g19_formdescription").val()+'","'+
$("#g1_g19_formnumber").val()+'","'+
'"]]}'
if($("#isLoaded_group1_19").val()!=0){_saveData({group:"group1_19","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group1_20'})}
break;
/* Group 1 Subgroup 20 */
case'group1_20':var json='{"DATA":[["'+
$("#g1_g20_taxservicefield1").val()+'","'+
$("#g1_g20_taxservicefield2").val()+'","'+
$("#g1_g20_taxservicefield3").val()+'","'+
$("#g1_g20_taxservicefield4").val()+'","'+
'"]]}'
if($("#isLoaded_group1_20").val()!=0){_saveData({group:"group1_20","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2'})}
break;


/* Group 2 Subgroup 1 */
case'group2_1':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_2'})}
break;
/* Group 2 Subgroup 2 */
case'group2_2':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_3'})}
break;
/* Group 2 Subgroup 3 */
case'group2_3':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_4'})}
break;
/* Group 2 Subgroup 4 */
case'group2_4':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_4").val()!=0){_saveData({group:"group2_4","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_5'})}
break;
/* Group 2 Subgroup 5 */
case'group2_5':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_5").val()!=0){_saveData({group:"group2_5","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_6'})}
break;
/* Group 2 Subgroup 6 */
case'group2_6':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_6").val()!=0){_saveData({group:"group2_6","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_7'})}
break;
/* Group 2 Subgroup 7 */
case'group2_7':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_7").val()!=0){_saveData({group:"group2_7","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_8'})}
break;
/* Group 2 Subgroup 8 */
case'group2_8':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_8").val()!=0){_saveData({group:"group2_8","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_9'})}
break;
/* Group 2 Subgroup 9 */
case'group2_9':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_9").val()!=0){_saveData({group:"group2_9","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_10'})}
break;
/* Group 2 Subgroup 10 */
case'group2_10':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_10").val()!=0){_saveData({group:"group2_10","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group2_111'})}
break;
/* Group 2 Subgroup 11 */
case'group2_11':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group2_11").val()!=0){_saveData({group:"group2_11","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group3_1'})}
break;


/*Save Group3*/
case'group3_1':var json='{"DATA":[["'+
$("#g3_active").is(':checked')+'","'+
$("#g3_address").val()+'","'+
$("#g3_birthday").val()+'","'+
$("#g3_cafnumber").val()+'","'+
$("#g3_childsname1").val()+'","'+
$("#g3_childsname2").val()+'","'+
$("#g3_childsname3").val()+'","'+
$("#g3_city").val()+'","'+
$("#g3_email1").val()+'","'+
$("#g3_email2").val()+'","'+
$("#g3_emgphone").val()+'","'+
$("#g3_emgcontact").val()+'","'+
$("#g3_ext").val()+'","'+
$("#g3_homephone").val()+'","'+
$("#g3_initials").val()+'","'+
$("#g3_mobilephone").val()+'","'+
$("#g3_name").val()+'","'+
$("#g3_ptin").val()+'","'+
$("#g3_relationship").val()+'","'+
$("#g3_spouse").val()+'","'+
$("#g3_state").val()+'","'+
$("#g3_website").val()+'","'+
$("#g3_workphone").val()+'","'+
'"]]}'
if($("#isLoaded_group3_1").val()!=0){_saveData({group:"group3_1","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group3_2'})}
break;
/* Group 3 Subgroup 2 */
case'group3_2':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group3_2").val()!=0){_saveData({group:"group3_2","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group3_3'})}
break;
/* Group 3 Subgroup 3 */
case'group3_3':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group3_3").val()!=0){_saveData({group:"group3_3","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group3_4'})}
break;
/* Group 3 Subgroup 4 */
case'group2_4':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group3_4").val()!=0){_saveData({group:"group3_4","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group4'})}
break;

/*Save Group4*/
case'group4':var json='{"DATA":[["'+

'"]]}'
if($("#isLoaded_group4").val()!=0){_saveData({group:"group4","payload":$.parseJSON(json),page:"practicemaintenance"})}
else{_saveDataCB({'group':'group5'})}
break;

/*----------SAVE GROUP 5----------*/
case'group5':var json='{"DATA":[["'+
$("#comment_id").val()+'","'+
$("#form_id").val()+'","'+
$("#user_id").val()+'","'+
$("#client_id").val()+'","'+
$("#of_id").val()+'","'+
$("#g5_commentdate").val()+'","'+
$("#g5_commenttext").val()+'","'+
'"]]}'
if($("#isLoaded_group5").val()!=0){
_saveData({group:"group5",payload:$.parseJSON(json),page:"practicemaintenance"});
}else{_saveDataCB({'group':'group6'})}
break;

case'group6':
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