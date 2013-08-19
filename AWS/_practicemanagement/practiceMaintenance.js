/*
Javascript for FinancialStatements
Developers:Jamin Quimby, Raymond Smith
7/26/2013 - Started
8/19/2013 - Started
*/



/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialstatements.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FDS_MONTHTEXT:{title:'Month'},FDS_YEAR:{title:'Year'},FDS_PERIODEND:{title:'Period End'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#fss_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"financialdatastatus"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);$("#fds_id").val=(record.FDS_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"cl_id","group":"client"});'
	});}
	
$(document).ready(function(){
$.ajaxSetup({cache:false});//Stop ajax cacheing
// Load Initial Client Grid	
_grid1();
$('.gf-checkbox').hide()
//Load Select Boxes

//Bind Label Elements


//Load Custom Labels


//Load Accordians
$('.gf-checkbox').accordion({heightStyle:"content", active:false});
$('#entrance').accordion({heightStyle:"content", active:false});

//Set Date Picker Defaults	
$.datepicker.setDefaults({
showOn:"both",
buttonImageOnly:true,
buttonImage:"../assets/img/datepicker.gif",
constrainInput:true
});
//Load Date Pickers
//$("#cl_since").datepicker();

//Load Select Boxes
$('select').chosen();

});



_group1=function(){}
_group2=function(){}
_group3=function(){}
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Client Group*/case "CLIENT_ACTIVE":var list='cl_active,cl_credit_hold,cl_dms_reference,cl_group,cl_name,cl_notes,cl_referred_by,cl_salutation,cl_since,cl_spouse,cl_trade_name,cl_type,s_label1,s_label2,s_label3,s_label4,rc_group';_loadit({"query":query,"list":list});break;

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
/* Group 1 Subgroup 1 */
$("#g1_g1_softwarename").val()+'","'+
/* Group 1 Subgroup 2 */
$("#g1_g2_category").val()+'","'+
$("#g1_g2_description").val()+'","'+
/* Group 1 Subgroup 3 */
$("#g1_g3_groupname").val()+'","'+
/* Group 1 Subgroup 4 */
$("#g1_g4_pfpcategory").val()+'","'+
$("#g1_g4_description").val()+'","'+
/* Group 1 Subgroup 5 */
$("#g1_g5_subtaskgroup").val()+'","'+
/* Group 1 Subgroup 6 */
$("#g1_g6_task").val()+'","'+
$("#g1_g6_sequence").val()+'","'+
$("#g1_g6_subtaskgroup").val()+'","'+
$("#g1_g6_dependency").val()+'","'+
/* Group 1 Subgroup 7 */
$("#g1_g7_consultingcategory").val()+'","'+
$("#g1_g7_description").val()+'","'+
$("#g1_g7_priority").val()+'","'+
$("#g1_g7_estimatedtime").val()+'","'+
/* Group 1 Subgroup 8 */
$("#g1_g8_consultinggroup").val()+'","'+
/* Group 1 Subgroup 9 */
$("#g1_g9_task").val()+'","'+
$("#g1_g9_sequence").val()+'","'+
$("#g1_g9_group").val()+'","'+
$("#g1_g9_dependency").val()+'","'+
/* Group 1 Subgroup 10 */
$("#g1_g10_noticenumbers").val()+'","'+
$("#g1_g10_description").val()+'","'+
$("#g1_g10_instructions").val()+'","'+
/* Group 1 Subgroup 11 */
$("#g1_g11_state").val()+'","'+
$("#g1_g11_form").val()+'","'+
$("#g1_g11_filingdeadline").val()+'","'+
$("#g1_g11_extensiondeadline").val()+'","'+
$("#g1_g11_description").val()+'","'+
/* Group 1 Subgroup 12 */
$("#g1_g12_type").val()+'","'+
$("#g1_g12_description").val()+'","'+
/* Group 1 Subgroup 13 */
$("#g1_g13_paryrollfrequencies").val()+'","'+
/* Group 1 Subgroup 14 */
$("#g1_g14_returntype").val()+'","'+
$("#g1_g14_id").val()+'","'+
/* Group 1 Subgroup 15 */
$("#g1_g15_taxmatters").val()+'","'+
/* Group 1 Subgroup 16 */
$("#g1_g16_state").val()+'","'+
$("#g1_g16_abbreviations").val()+'","'+
/* Group 1 Subgroup 17 */
$("#g1_g17_state").val()+'","'+
$("#g1_g17_form").val()+'","'+
$("#g1_g17_filingdeadline").val()+'","'+
$("#g1_g17_extensiondeadline").val()+'","'+
$("#g1_g17_description").val()+'","'+
/* Group 1 Subgroup 18 */
$("#g1_g18_taxform").val()+'","'+
$("#g1_g18_schedule").val()+'","'+
$("#g1_g18_description").val()+'","'+
/* Group 1 Subgroup 19 */
$("#g1_g19_formnumber").val()+'","'+
$("#g1_g19_formdescription").val()+'","'+
$("#g1_g19_filingdeadline").val()+'","'+
/* Group 1 Subgroup 20 */
$("#g1_g20_taxservicefield1").val()+'","'+
$("#g1_g20_taxservicefield2").val()+'","'+
$("#g1_g20_taxservicefield3").val()+'","'+
$("#g1_g20_taxservicefield4").val()+'","'+

'"]]}'
break;


/*Save Group2*/
case'group2':var json='{"DATA":[["'+

'"]]}'
break;


/*Save Group3*/
case'group3':var json='{"DATA":[["'+
$("#g3_name").val()+'","'+
$("#g3_spouse").val()+'","'+
$("#g3_active").is(':checked')+'","'+
$("#g3_initials").val()+'","'+
$("#g3_birthday").val()+'","'+
$("#g3_address").val()+'","'+
$("#g3_city").val()+'","'+
$("#g3_state").val()+'","'+
$("#g3_homephone").val()+'","'+
$("#g3_mobilephone").val()+'","'+
$("#g3_workphone").val()+'","'+
$("#g3_ext").val()+'","'+
$("#g3_email1").val()+'","'+
$("#g3_email2").val()+'","'+
$("#g3_website").val()+'","'+
$("#g3_childsname1").val()+'","'+
$("#g3_childsname2").val()+'","'+
$("#g3_childsname3").val()+'","'+
$("#g3_cafnumber").val()+'","'+
$("#g3_ptin").val()+'","'+
$("#g3_emgcontact").val()+'","'+
$("#g3_relationship").val()+'","'+
$("#g3_emgphone").val()+'","'+

'"]]}'
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