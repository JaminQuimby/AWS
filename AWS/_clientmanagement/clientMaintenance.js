/*
Javascript for Client Maintenance Module
Developers:Jamin Quimby
7/26/2013 Finished ~ Jamin Quimby
9/03/2013 Raymond Smith
*/

$(document).ready(function(){
//Load Grid
_grid1();
_group1=function(){}
_group1_1=function(){_grid1_1()}
_group3=function(){_grid3()}
_group5=function(){_grid5()}
_group6=function(){_grid6()}

});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientMaintenance.cfc",
	"title":"Clients",
	"fields":{CLIENT_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},CLIENT_SALUTATION:{title:'Salutation'},CLIENT_TYPETEXT:{title:'Type'},CLIENT_SINCE:{title:'Since'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#cl_id").val(record.CLIENT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"cl_id","group":"group1","page":"clientmaintenance"});'
	}); }
	
_grid1_1=function(){_jGrid({
	"grid":"grid1_1",
	"url":"clientMaintenance.cfc",
	"title":"Custom Fields",
	"fields":{field_id:{key:true,list:false,edit:false},field_name:{title:'Name'},field_value:{title:'Value'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1_1","clientid":'+$("#cl_id").val()+'}',
	"functions":'$("#cl_fieldid").val(record.field_id);_loadData({"id":"cl_fieldid","group":"group3","page":"clientmaintenance"});$("#client").accordion({active:2});'
	});}

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"clientMaintenance.cfc",
	"title":"Client Contacts",
	"fields":{contact_id:{key:true,list:false,edit:false},contact_name:{title:'Contact Name'},contact_phone1:{title:'Phone 1'},contact_email1:{title:'Email 1'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3","clientid":'+$("#cl_id").val()+'}',
	"functions":'$("#co_id").val(record.contact_id);_loadData({"id":"co_id","group":"group1_1","page":"clientmaintenance"});$("#contacts").accordion({active:1});'
	});}
	
_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"clientMaintenance.cfc",
	"title":"State Information",
	"fields":{si_id:{key:true,list:false,edit:false},g5_state:{title:'State'},g5_revenue:{title:'Revenue',type:"checkbox",values:{'0':'No','1':'Yes'}},g5_employees:{title:'Employees',type:"checkbox",values:{'0':'No','1':'Yes'}},g5_property:{title:'Property',type:"checkbox",values:{'0':'No','1':'Yes'}},g5_nexus:{title:'Nexus',type:"checkbox",values:{'0':'No','1':'Yes'}},g5_reason:{title:'Reason'},g5_registered:{title:'Registered',type:"checkbox",values:{'0':'No','1':'Yes'}},g5_misc1:{title:$('#sl_label1').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},g5_misc2:{title:$('#sl_label2').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},g5_misc3:{title:$('#sl_label3').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},g5_misc4:{title:$('#sl_label4').val(),type:"checkbox",values:{'0':'No','1':'Yes'}}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group5","clientid":'+$("#cl_id").val()+'}',
	"functions":'$("#si_id").val(record.si_id);_loadData({"id":"si_id","group":"group5","page":"clientmaintenance"});$("#state").accordion({active:1});'
	});}

_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"clientMaintenance.cfc",
	"title":"Client Relations",
	"fields":{client_id:{key:true,list:false,edit:false},client_name:{title:'Client Name'},client_active:{title:'Active',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }},client_since:{title:'Client Since'},client_typeTEXT:{title:'Client Type'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#g6_group").val()+'","loadType":"group6","clientid":'+$("#cl_id").val()+'}',
	"functions":'_loadData({"id":"client_id","group":"group6","page":"clientmaintenance"});$("#rclients").accordion({active:1});'
	});}
	
	

//Bind Label Elements
$("#g5_g1_label1").change(function(){$("label[for='g5_value1']").html($(this).val());})
$("#g5_g1_label2").change(function(){$("label[for='g5_value2']").html($(this).val());})
$("#g5_g1_label3").change(function(){$("label[for='g5_value3']").html($(this).val());})
$("#g5_g1_label4").change(function(){$("label[for='g5_value4']").html($(this).val());})

//Load Custom Labels
_loadData({"id":"cl_id","group":"statelabels","page":"clientmaintenance"});


//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group 1*/case "CLIENT_ACTIVE":var list='g1_active,g1_credit_hold,g1_dms_reference,g1_group,g1_name,g1_notes,g1_referred_by,g1_salutation,g1_since,g1_spouse,g1_trade_name,g1_type,g5_g1_label1,g5_g1_label2,g5_g1_label3,g5_g1_label4,g6_group';_loadit({"query":query,"list":list});break;
/*Group 1_1*/case "FIELD_ID":var list="cl_fieldid,g1_g1_fieldname,g1_g1_fieldvalue";_loadit({"query":query,"list":list});break;
/*Group 2_1*/case "CLIENT_TAX_SERVICES":var list='g2_g1_taxservices,g2_g1_formtype,g2_g1_businessc,g2_g1_rentalpropertye,g2_g1_disregardedentity,g2_g1_personalproperty';_loadit({"query":query,"list":list});break;
/*Group 2_2*/case "CLIENT_PAYROLL_PREP":var list='g2_g2_payrollpreparation,g2_g2_paycheckfrequency,g2_g2_payrolltaxservices,g2_g2_prtaxdepositschedule,g2_g2_1099preparation,g2_g2_ein,g2_g2_pin,g2_g2_password';_loadit({"query":query,"list":list});break;
/*Group 2_3*/case "CLIENT_ACCOUNTING_SERVICES":var list='g2_g3_accountingServices,g2_g3_bookkeeping,g2_g3_compilation,g2_g3_review,g2_g3_audit,g2_g3_financialstatementfreq,g2_g3_fiscalyearend,g2_g3_software,g2_g3_version,g2_g3_username,g2_g3_accountingpassword';_loadit({"query":query,"list":list});break;
/*Group 3*/case "CONTACT_ID":var list='co_id,g3_type,g3_name,g3_address1,g3_address2,g3_city,g3_state,g3_zip,g3_phone1,g3_phone2,g3_phone3,g3_phone4,g3_phone5,g3_email1,g3_email2,g3_website,g3_effectivedate,g3_acctsoftwareupdate,g3_taxupdate,g3_customlabel,g3_customvalue';_loadit({"query":query,"list":list});break;

/*Group 4_1*/case "MCT_ID":var list="m_mct_id,g4_g1_duedate,g4_g1_group,g4_g1_category";_loadit({"query":query,"list":list});break;
/*Group 4_2*/case "FS_ID":var list="m_fs_id,g4_g2_year,g4_g2_periodend,g4_g2_month,g4_g2_subtaskgroup,g4_g2_historicalfs";_loadit({"query":query,"list":list});break;
/*Group 4_3*/case "PC_ID":var list="m_pc_id,g4_g3_year,g4_g3_payenddate,g4_g3_paydate,g4_g3_duedate,g4_g3_inforeceived,g4_g3_missinginfo";_loadit({"query":query,"list":list});break;
/*Group 4_4*/case "PT_ID":var list="m_pt_id,g4_g4_year,g4_g4_month,g4_g4_returntype,g4_g4_lastpaydate,g4_g4_duedate,g4_g4_inforeceived,g4_g4_missinginfo";_loadit({"query":query,"list":list});break;
/*Group 4_5*/case "TSL_ID":var list="m_tsl_id,g4_g5_year,g4_g5_taxform,g4_g5_inforeceived,g4_g5_missinginfo";_loadit({"query":query,"list":list});break;
/*Group 4_6*/case "OF_ID":var list="m_of_id,g4_g6_year,g4_g6_duedate,g4_g6_period,g4_g6_state,g4_g6_task,g4_g6_form";_loadit({"query":query,"list":list});break;

/*Group 5*/case "SI_ID":var list="si_id,g5_state,g5_revenue,g5_employees,g5_property,g5_nexus,g5_reason,g5_registered,g5_value1,g5_value2,g5_value3,g5_value4";_loadit({"query":query,"list":list});break;
/*Group 5_1*/case"CLIENT_STATELABEL1":var list="g5_g1_label1,g5_g1_label2,g5_g1_label3,g5_g1_label4";_loadit({"query":query,"list":list});break;

/*Related Clients*/case"CLIENT_RELATIONS":var list="g6_group";_loadit({"query":query,"list":list});break;
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
	
/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#g1_active").is(':checked')+','+
$("#g1_credit_hold").is(':checked')+',"'+
$("#g1_dms_reference").val()+'","'+
$("#g1_group").val()+'","'+
$("#g1_name").val()+'","'+
$("#g1_notes").val()+'","'+
$("#g1_referred_by").val()+'","'+
$("#g1_salutation").val()+'","'+
$("#g1_since").val()+'","'+
$("#g1_spouse").val()+'","'+
$("#g1_trade_name").val()+'","'+
$("#g1_type").val()+'","'+
'"]]}'
if($("#g1_name").val()!=""&&$("#g1_salutation").val()!=""&&$("#g1_type").val()!=""&&$("#g1_since").val()!=""){
_saveData({group:"group1","payload":$.parseJSON(json),page:"clientmaintenance"});
jqMessage({message: "Document is saving. ",type: "save",autoClose: false});
}
else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false});}	
break;

/*group 1_2*/
case'group1_2':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#cl_fieldid").val()+'","'+
$("#g1_g2_fieldname").val()+'","'+
$("#g1_g2_fieldvalue").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_1'})}
break;

/*Group 2_1*/
case'group2_1':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#g2_g1_taxservices").is(':checked')+',"'+
$("#g2_g1_formtype").val()+'",'+
$("#g2_g1_businessc").is(':checked')+','+
$("#g2_g1_rentalpropertye").is(':checked')+','+
$("#g2_g1_disregardedentity").is(':checked')+','+
$("#g2_g1_personalproperty").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_2'})}
break;

/*Group 2_2*/
case'group2_2':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#g2_g2_payrollpreparation").is(':checked')+',"'+
$("#g2_g2_paycheckfrequency").val()+'",'+
$("#g2_g2_payrolltaxservices").is(':checked')+',"'+
$("#g2_g2_prtaxdepositschedule").val()+'",'+
$("#g2_g2_1099preparation").is(':checked')+',"'+
$("#g2_g2_ein").val()+'","'+
$("#g2_g2_pin").val()+'","'+
$("#g2_g2_password").val()+'","'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_2'})}
break;

/*Group 2_3*/
case'group2_3':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#g2_g3accountingServices").is(':checked')+','+
$("#g2_g3bookkeeping").is(':checked')+','+
$("#g2_g3compilation").is(':checked')+','+
$("#g2_g3review").is(':checked')+','+
$("#g2_g3audit").is(':checked')+',"'+
$("#g2_g3financialstatementfreq").val()+'","'+
$("#g2_g3fiscalyearend").val()+'","'+
$("#g2_g3software").val()+'","'+
$("#g2_g3version").val()+'","'+
$("#g2_g3username").val()+'","'+
$("#g2_g3accountingpassword").val()+'","'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group3'})}
break;

/*Save group 3*/
case'group3':var json='{"DATA":[["'+
$("#co_id").val()+'","'+
$("#cl_id").val()+'","'+
$("#g3_type").val()+'","'+
$("#g3_name").val()+'","'+
$("#g3_address1").val()+'","'+
$("#g3_address2").val()+'","'+
$("#g3_city").val()+'","'+
$("#g3_state").val()+'","'+
$("#g3_zip").val()+'","'+
$("#g3_phone1").val()+'","'+
$("#g3_phone2").val()+'","'+
$("#g3_phone3").val()+'","'+
$("#g3_phone4").val()+'","'+
$("#g3_phone5").val()+'","'+
$("#g3_email1").val()+'","'+
$("#g3_email2").val()+'","'+
$("#g3_website").val()+'","'+
$("#g3_effectivedate").val()+'",'+
$("#g3_acctsoftwareupdate").is(':checked')+','+
$("#g3_taxupdate").is(':checked')+',"'+
$("#g3_customlabel").val()+'",'+
$("#g3_customvalue").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group3'})}
break;

/*Save Financial Statements*/
case'group4_1':var json='{"DATA":[["'+
$("#m_fs_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g2_month").val()+'","'+
$("#g4_g2_periodend").val()+'","'+
$("#g4_g2_year").val()+'","'+
'"]]}'
if($("#isLoaded_group4_2").val()!=0){_saveData({group:"group4_2","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group4_3'})}
break;

/*Save Management Consulting Tasks*/
case'group4_2':var json='{"DATA":[["'+
$("#m_mct_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g1_category").val()+'","'+
$("#g4_g1_duedate").val()+'","'+
'"]]}'
if($("#isLoaded_group4_1").val()!=0){_saveData({group:"group4_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group4_2'})}
break;

/*Save Payroll Checks*/
case'group4_3':var json='{"DATA":[["'+
$("#m_pc_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g3_duedate").val()+'","'+
$("#g4_g3_inforeceived").val()+'",'+
$("#g4_g3_missinginfo").is(':checked')+',"'+
$("#g4_g3_paydate").val()+'","'+
$("#g4_g3_payenddate").val()+'","'+
$("#g4_g3_year").val()+'","'+
'"]]}'
if($("#isLoaded_group4_3").val()!=0){_saveData({group:"group4_3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group4_4'})}
break;

/*Save Payroll Taxes*/
case'group4_4':var json='{"DATA":[["'+
$("#m_pt_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g4_duedate").val()+'","'+
$("#g4_g4_inforeceived").val()+'","'+
$("#g4_g4_lastpaydate").val()+'",'+
$("#g4_g4_missinginfo").is(':checked')+',"'+
$("#g4_g4_month").val()+'","'+
$("#g4_g4_returntype").val()+'","'+
$("#g4_g4_year").val()+'","'+
'"]]}'
if($("#isLoaded_group4_4").val()!=0){_saveData({group:"group4_4","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group4_5'})}
break;

/*Save Tax Status Listing*/
case'group4_5':var json='{"DATA":[["'+
$("#m_tsl_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g5_inforeceived").val()+'",'+
$("#g4_g5_missinginfo").is(':checked')+',"'+
$("#g4_g5_taxform").val()+'","'+
$("#g4_g5_taxyear").val()+'","'+
'"]]}'
if($("#isLoaded_group4_5").val()!=0){_saveData({group:"group4_5","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group4_6'})}
break;

/*Save Other Filings*/
case'group4_6':var json='{"DATA":[["'+
$("#m_of_id").val()+'","'+
$("#cl_id").val()+'","'+

$("#g4_g6_duedate").val()+'","'+
$("#g4_g6_form").val()+'","'+
$("#g4_g6_period").val()+'","'+
$("#g4_g6_state").val()+'","'+
$("#g4_g6_task").val()+'","'+
$("#g4_g6_taxyear").val()+'","'+
'"]]}'
if($("#isLoaded_group4_6").val()!=0){_saveData({group:"group4_6","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group5'})}
break;

/*Save State Information*/
case'group5':
var json='{"DATA":[["'+
$("#si_id").val()+'",'+
$("#g5_employees").is(':checked')+','+
$("#g5_nexus").is(':checked')+',"'+
$("#g5_property").is(':checked')+',"'+
$("#g5_reason").val()+'",'+
$("#g5_registered").is(':checked')+','+
$("#g5_revenue").is(':checked')+',"'+
$("#g5_state").val()+'",'+
$("#g5_value1").is(':checked')+','+
$("#g5_value2").is(':checked')+','+
$("#g5_value3").is(':checked')+','+
$("#g5_value4").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group5").val()!=0){_saveData({group:"group5","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group5_1'})}
break;

/*Save State Labels*/
case'group5_1':var json='{"DATA":[["'+
$("#g5_g1_label1").val()+'","'+
$("#g5_g1_label2").val()+'","'+
$("#g5_g1_label3").val()+'","'+
$("#g5_g1_label4").val()+'","'+
'"]]}'
if($("#isLoaded_group5_1").val()!=0){_saveData({group:"group5_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group6'})}
break;


/*Save Client Relations*/
case'group6':
var json='{"DATA":[["'+
$("#rc_group").val()+'","'+
'"]]}'
if($("#isLoaded_group6").val()!=0){_saveData({group:"group6","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group7'})}
break;

case'group7':
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