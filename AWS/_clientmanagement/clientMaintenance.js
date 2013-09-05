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
_group2=function(){}
_group3=function(){_grid3()}
_group4=function(){}
_group4_1=function(){_grid4_1()}
_group4_2=function(){_grid4_2()}
_group4_3=function(){_grid4_3()}
_group4_4=function(){_grid4_4()}
_group4_5=function(){_grid4_5()}
_group4_6=function(){_grid4_6()}
_group5=function(){}
_group6=function(){
//Load Grid
_grid6();
_group6_1();
}


_group6_1=function(){
$('#isLoaded_group6_1').val(1);
_loadData({'id':'cl_id','group':'group6_1','page':'clientmaintenance'});
var g6_g1_label1=$("#g6_g1_label1");
var g6_g1_label2=$("#g6_g1_label2");
var g6_g1_label3=$("#g6_g1_label3");
var g6_g1_label4=$("#g6_g1_label4");
var g6_value1=$('label[for="g6_value1"]');
var g6_value2=$('label[for="g6_value2"]');
var g6_value3=$('label[for="g6_value3"]');
var g6_value4=$('label[for="g6_value4"]');
g6_value1.html(g6_g1_label1.val());
g6_value2.html(g6_g1_label2.val());
g6_value3.html(g6_g1_label3.val());
g6_value4.html(g6_g1_label4.val());
g6_g1_label1.change(function(){g6_value1.html($(this).val())});
g6_g1_label2.change(function(){g6_value2.html($(this).val())});
g6_g1_label3.change(function(){g6_value3.html($(this).val())});
g6_g1_label4.change(function(){g6_value4.html($(this).val())});
}
_group7=function(){_grid7()}
});

/*Define Grid Instances*/   
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientMaintenance.cfc",
	"title":"Clients",
	"fields":{CLIENT_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},CLIENT_SALUTATION:{title:'Salutation'},CLIENT_TYPETEXT:{title:'Type'},CLIENT_SINCE:{title:'Since'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"client_id","group":"group1","page":"clientmaintenance"});'
	}); }
	
_grid1_1=function(){_jGrid({
	"grid":"grid1_1",
	"url":"clientMaintenance.cfc",
	"title":"Custom Fields",
	"fields":{field_id:{key:true,list:false,edit:false},field_name:{title:'Name'},field_value:{title:'Value'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1_1","clientid":'+$("#client_id").val()+'}',
	"functions":'$("#cl_fieldid").val(record.field_id);$("#group1").accordion({active:2});$("#isLoaded_group1_2").val(1);_loadData({"id":"cl_fieldid","group":"group1_2","page":"clientmaintenance"});'
	});}
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"clientMaintenance.cfc",
	"title":"Client Contacts",
	"fields":{contact_id:{key:true,list:false,edit:false},contact_name:{title:'Contact Name'},contact_phone1:{title:'Phone 1'},contact_email1:{title:'Email 1'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3","clientid":'+$("#client_id").val()+'}',
	"functions":'$("#co_id").val(record.contact_id);_loadData({"id":"co_id","group":"group3","page":"clientmaintenance"});$("#group3").accordion({active:1});'
	});}
	
_grid4_1=function(){_jGrid({
	"grid":"grid4_1",
	"url":"clientMaintenance.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FDS_MONTHTEXT:{title:'Month'},FDS_YEAR:{title:'Year'},FDS_PERIODEND:{title:'Period End'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_1"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?fds_id="+$("#fds_id").val();'
	});}
	
_grid4_2=function(){_jGrid({
	"grid":"grid4_2",
	"url":"clientMaintenance.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{MC_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},MC_CATEGORYTEXT:{title:'Consulting Categories'},MC_DESCRIPTION:{title:'Task Description'},MC_STATUS:{title:'Status'},MC_DUEDATE:{title:'Due Date'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctConsultingTasks.cfm?mc_id="+$("#mc_id").val();'
	});}

_grid4_3=function(){_jGrid({
	"grid":"grid4_3",
	"url":"clientMaintenance.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_YEAR:{title:'Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group4_3"}',
	"functions":'$("#pc_id").val(record.PC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollPayrollChecks.cfm?pc_id="+$("#pc_id").val();'
	}); }

_grid4_4=function(){_jGrid({
	"grid":"grid4_4",
	"url":"clientMaintenance.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PT_YEAR:{title:'Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group4_4"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollPayrollTaxes.cfm?pt_id="+$("#pt_id").val();'
	}); }
	
_grid4_5=function(){_jGrid({
	"grid":"grid4_5",
	"url":"clientMaintenance.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group4_5"}',
	"functions":'$("#tr_id").val(record.TR_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxationTaxReturns.cfm?tr_id="+$("#tr_id").val();'
	}); }
	
_grid4_6=function(){_jGrid({
	"grid":"grid4_6",
	"url":"clientMaintenance.cfc",
	"title":"Other Filings",
	"fields":{OF_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},OF_TAXYEAR:{title:'Tax Year'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group4_6"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollOtherFilingsRequirements.cfm?of_id="+$("#of_id").val();'
	}); }
	
_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"clientMaintenance.cfc",
	"title":"State Information",
	"fields":{SI_ID:{key:true,list:false,edit:false},si_state:{title:'State'},si_revenue:{title:'Revenue',type:"checkbox",values:{'0':'No','1':'Yes'}},si_employees:{title:'Employees',type:"checkbox",values:{'0':'No','1':'Yes'}},si_property:{title:'Property',type:"checkbox",values:{'0':'No','1':'Yes'}},si_nexus:{title:'Nexus',type:"checkbox",values:{'0':'No','1':'Yes'}},si_reason:{title:'Reason'},si_registered:{title:'Registered',type:"checkbox",values:{'0':'No','1':'Yes'}},si_misc1:{title:$('#g6_g1_label1').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},si_misc2:{title:$('#g6_g1_label2').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},si_misc3:{title:$('#g6_g1_label3').val(),type:"checkbox",values:{'0':'No','1':'Yes'}},si_misc4:{title:$('#g6_g1_label4').val(),type:"checkbox",values:{'0':'No','1':'Yes'}}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group6","clientid":'+$("#client_id").val()+'}',
	"functions":'$("#si_id").val(record.si_id);_loadData({"id":"si_id","group":"group6","page":"clientmaintenance"});$("#group6").accordion({active:1});'
	});}

_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"clientMaintenance.cfc",
	"title":"Client Relations",
	"fields":{client_id:{key:true,list:false,edit:false},client_name:{title:'Client Name'},client_active:{title:'Active',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }},client_since:{title:'Client Since'},client_typeTEXT:{title:'Client Type'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g7_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#g7_group").val()+'","loadType":"group7","clientid":'+$("#client_id").val()+'}',
	"functions":'_loadData({"id":"client_id","group":"group7","page":"clientmaintenance"});$("#group7").accordion({active:1});'
	});}





//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Group 1*/case "CLIENT_ID":var list='client_id,g1_active,g1_credit_hold,g1_dms_reference,g1_g3_group,g1_name,g1_notes,g1_referred_by,g1_salutation,g1_since,g1_spouse,g1_trade_name,g1_type,g6_g1_label1,g6_g1_label2,g6_g1_label3,g6_g1_label4,g7_group';_loadit({"query":query,"list":list});break;
/*Group 1_2*/case "FIELD_ID":var list="cl_fieldid,g1_g2_fieldname,g1_g2_fieldvalue";_loadit({"query":query,"list":list});break;
/*Group 2_1*/case "CLIENT_TAX_SERVICES":var list='g2_g1_taxservices,g2_g1_formtype,g2_g1_businessc,g2_g1_rentalpropertye,g2_g1_disregardedentity,g2_g1_personalproperty';_loadit({"query":query,"list":list});break;
/*Group 2_2*/case "CLIENT_PAYROLL_PREP":var list='g2_g2_payrollpreparation,g2_g2_paycheckfrequency,g2_g2_payrolltaxservices,g2_g2_prtaxdepositschedule,g2_g2_1099preparation,g2_g2_ein,g2_g2_pin,g2_g2_password';_loadit({"query":query,"list":list});break;
/*Group 2_3*/case "CLIENT_ACCOUNTING_SERVICES":var list='g2_g3_accountingServices,g2_g3_bookkeeping,g2_g3_compilation,g2_g3_review,g2_g3_audit,g2_g3_financialstatementfreq,g2_g3_fiscalyearend,g2_g3_software,g2_g3_version,g2_g3_username,g2_g3_accountingpassword';_loadit({"query":query,"list":list});break;
/*Group 3*/case "CONTACT_ID":var list='co_id,g3_type,g3_name,g3_address1,g3_address2,g3_city,g3_state,g3_zip,g3_phone1,g3_phone2,g3_phone3,g3_phone4,g3_phone5,g3_email1,g3_email2,g3_website,g3_effectivedate,g3_acctsoftwareupdate,g3_taxupdate,g3_customlabel,g3_customvalue';_loadit({"query":query,"list":list});break;
/*Group 6*/case "SI_ID":var list="si_id,g6_state,g6_revenue,g6_employees,g6_property,g6_nexus,g6_reason,g6_registered,g6_value1,g6_value2,g6_value3,g6_value4";_loadit({"query":query,"list":list});break;
/*Group 6_1*/case"CLIENT_STATELABEL1":var list="g6_g1_label1,g6_g1_label2,g6_g1_label3,g6_g1_label4";_loadit({"query":query,"list":list});break;
/*Group 7*/case"CLIENT_RELATIONS":var list="g7_group";_loadit({"query":query,"list":list});break;
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

alert(options["group"]);
switch(options["group"]){
//Starting with Save Message
case'':
if($("#g1_name").val()!=""){
_saveDataCB({'group':'group1'});
jqMessage({message: "Saving.",type: "save",autoClose: true});
}else{jqMessage({message: "You must enter a client name.",type: "info",autoClose: true})}

break;
	
/*Save Group1*/
case'group1':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
$("#g1_active").is(':checked')+','+
$("#g1_credit_hold").is(':checked')+',"'+
$("#g1_dms_reference").val()+'","'+
$("#g1_g3_group").val()+'","'+
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
_saveData({group:"group1",payload:$.parseJSON(json),page:"clientmaintenance"});
}
else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false});}	
break;

/*group 1_2*/
case'group1_2':var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#cl_fieldid").val()+'","'+
$("#g1_g2_fieldname").val()+'","'+
$("#g1_g2_fieldvalue").val()+'","'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){_saveData({group:"group1_2","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_1'})}
break;

/*Group 2_1*/
case'group2_1':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
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
$("#client_id").val()+'",'+
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
else{_saveDataCB({'group':'group2_3'})}
break;

/*Group 2_3*/
case'group2_3':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
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
$("#client_id").val()+'","'+
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
if($("#isLoaded_group3").val()!=0){_saveData({group:"group3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group6'})}
break;

/*Save State Information*/
case'group6':
var json='{"DATA":[["'+
$("#si_id").val()+'","'+
$("#client_id").val()+'",'+
$("#g6_employees").is(':checked')+','+
$("#g6_nexus").is(':checked')+','+
$("#g6_property").is(':checked')+',"'+
$("#g6_reason").val()+'",'+
$("#g6_registered").is(':checked')+','+
$("#g6_revenue").is(':checked')+',"'+
$("#g6_state").val()+'",'+
$("#g6_value1").is(':checked')+','+
$("#g6_value2").is(':checked')+','+
$("#g6_value3").is(':checked')+','+
$("#g6_value4").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group6").val()!=0){_saveData({group:"group6","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group6_1'})}
break;

/*Save State Labels*/
case'group6_1':var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#g6_g1_label1").val()+'","'+
$("#g6_g1_label2").val()+'","'+
$("#g6_g1_label3").val()+'","'+
$("#g6_g1_label4").val()+'","'+
'"]]}'
if($("#isLoaded_group6_1").val()!=0){_saveData({group:"group6_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group7'})}
break;


/*Save Client Relations*/
case'group7':
var json='{"DATA":[["'+
$("#g7_group").val()+'","'+
'"]]}'
if($("#isLoaded_group7").val()!=0){_saveData({group:"group7","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group8'})}
break;

case'group8':
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