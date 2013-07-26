/*
Javascript for FinancialStatements
Developers:Jamin Quimby
7/26/2013 - Started
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
_grid1();// Load Initial Client Grid	

$('.gf-checkbox').hide()
//Load Select Boxes


//Bind Label Elements


//Load Custom Labels


//Load Accordians

$("#entrance").accordion({heightStyle:"content"});
$("#group1").accordion({heightStyle:"content"});
$("#group2").accordion({heightStyle:"content"});
$("#group3").accordion({heightStyle:"content"});

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
//$("#cl_type").chosen();

});


/*jtable Helper Object*/
_jGrid=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":""//&method=
	}
	$.extend(true, options, params);
	var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});
$(grid).jtable('destroy');
$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
	selecting:true,
	actions:{
	listAction:options['url']+"?returnFormat=json&method="+options['method']+"&argumentCollection="+options['arguments'],
	},
	fields:options['fields'],
		selectionChanged:function(){
			var $selectedRows=$(grid).jtable('selectedRows');//Get all selected rows
				$('#SelectedRowList').empty();
                if($selectedRows.length > 0){//Show selected rows
                   $selectedRows.each(function(){
					var record=$(this).data('record');
						eval(options['functions']);//Functions for onclick
					});
                }else{
                    //No rows selected
                 $('#SelectedRowList').append('No row selected! Select rows to see here...');
				 }}});
$(grid).jtable('load');
};


//Load Data
_loadData=function(params){
var options={"id":"","group":""}
try{$.extend(true, options, params);
$.ajax({type:'GET',url:'clientMaintenance.cfc?method=f_loadData',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"id":$('#'+options["id"]).val(),"loadType":options["group"]})}
,success:function(json){_loadDataCB($.parseJSON(json))}
,error:function(data){errorHandle($.parseJSON(data))}})}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};
	
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Recoard request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*Client Group*/case "CLIENT_ACTIVE":var list='cl_active,cl_credit_hold,cl_dms_reference,cl_group,cl_name,cl_notes,cl_referred_by,cl_salutation,cl_since,cl_spouse,cl_trade_name,cl_type,s_label1,s_label2,s_label3,s_label4,rc_group';_loadit({"query":query,"list":list});break;
/*Taxes*/case "CLIENT_TAX_SERVICES":var list='t_taxservices,t_formtype,t_businessc,t_rentalpropertye,t_disregardedentity,t_personalproperty';_loadit({"query":query,"list":list});break;
/*Payroll*/case "CLIENT_PAYROLL_PREP":var list='p_payrollpreparation,p_paycheckfrequency,p_payrolltaxservices,p_prtaxdepositschedule,p_1099preparation,p_ein,p_pin,p_password';_loadit({"query":query,"list":list});break;
/*Accounting*/case "CLIENT_ACCOUNTING_SERVICES":var list='a_accountingServices,a_bookkeeping,a_compilation,a_review,a_audit,a_financialstatementfreq,a_fiscalyearend,a_software,a_version,a_username,a_accountingpassword';_loadit({"query":query,"list":list});break;
/*Contact*/case "CONTACT_ID":var list='co_id,co_type,co_name,co_address1,co_address2,co_city,co_state,co_zip,co_phone1,co_phone2,co_phone3,co_phone4,co_phone5,co_email1,co_email2,co_website,co_effectivedate,co_acctsoftwareupdate,co_taxupdate,co_customlabel,co_customvalue';_loadit({"query":query,"list":list});break;
/*CustomFields*/case "FIELD_ID":var list="cl_fieldid,cl_fieldname,cl_fieldvalue";_loadit({"query":query,"list":list});break;
/*Accounting Consulting Tasks*/case "MCT_ID":var list="m_mct_id,m_mct_duedate,m_mct_group,m_mct_category";_loadit({"query":query,"list":list});break;
/*Financial Statements*/case "FS_ID":var list="m_fs_id,m_fs_year,m_fs_periodend,m_fs_month,m_fs_subtaskgroup,m_fs_historicalfs";_loadit({"query":query,"list":list});break;
/*Payroll Checks*/case "PC_ID":var list="m_pc_id,m_pc_year,m_pc_payenddate,m_pc_paydate,m_pc_duedate,m_pc_inforeceived,m_pc_missinginfo";_loadit({"query":query,"list":list});break;
/*Payroll Taxes*/case "PT_ID":var list="m_pt_id,m_pt_year,m_pt_month,m_pt_returntype,m_pt_lastpaydate,m_pt_duedate,m_pt_inforeceived,m_pt_missinginfo";_loadit({"query":query,"list":list});break;
/*Tax Status Listing*/case "TSL_ID":var list="m_tsl_id,m_tsl_year,m_tsl_taxform,m_tsl_inforeceived,m_tsl_missinginfo";_loadit({"query":query,"list":list});break;
/*Other Filings*/case "OF_ID":var list="m_of_id,m_of_year,m_of_duedate,m_of_period,m_of_state,m_of_task,m_of_form";_loadit({"query":query,"list":list});break;
/*State Labels*/case"CLIENT_STATELABEL1":var list="sl_label1,sl_label2,sl_label3,sl_label4";_loadit({"query":query,"list":list});break;
/*State Information*/case "SI_ID":var list="si_id,s_state,s_revenue,s_employees,s_property,s_nexus,s_reason,s_registered,s_value1,s_value2,s_value3,s_value4";_loadit({"query":query,"list":list});break;
/*Related Clients*/case"CLIENT_RELATIONS":var list="rc_group";_loadit({"query":query,"list":list});break;
default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false});}}
}catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
};

//Save Data
_saveData=function(params){
var options={
	"group":"",
	"payload":""
	}
try{	
$.extend(true, options, params);//turn options into array
if(options["payload"]!=""||options["payload"]=="undefined"){
$.ajax({
  type: 'GET',
  url: 'clientMaintenance.cfc?method=f_saveData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"payload":JSON.stringify(options["payload"])})
  },
  success:function(json){_saveDataCB($.parseJSON(json));},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});}else{_saveDataCB({"id":$("#cl_id").val(),"group":"client"});}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
}
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
case'client':var json='{"DATA":[["'+
$("#cl_id").val()+'","'+
$("#cl_active").is(':checked')+'","'+
$("#cl_credit_hold").is(':checked')+'","'+
$("#cl_dms_reference").val()+'","'+
$("#cl_group").val()+'","'+
$("#cl_name").val()+'","'+
$("#cl_notes").val()+'","'+
$("#cl_referred_by").val()+'","'+
$("#cl_salutation").val()+'","'+
$("#cl_since").val()+'","'+
$("#cl_spouse").val()+'","'+
$("#cl_trade_name").val()+'","'+
$("#cl_type").val()+
'"]]}'
if($("#cl_name").val()!=""&&$("#cl_salutation").val()!=""&&$("#cl_type").val()!=""&&$("#cl_since").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});

jqMessage({message: "Document is saving. ",type: "save",autoClose: false});
}
else{jqMessage({message: "Error in _saveDataCB, Missing Client Information",type: "error",autoClose: false});}	
	break;

/*Save Custom Fields*/
case'customfields':var json='{"DATA":[["'+options["id"]+'","'+
$("#cl_fieldid").val()+'","'+
$("#cl_fieldname").val()+'","'+
$("#cl_fieldvalue").val()+
'"]]}';
if(options["group"]!=""&&$('#cf_isLoaded').val()==1&&$("#cl_fieldname").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
}
else{
	_saveDataCB({"id":$("#cl_id").val(),"group":"taxes"});}
break;

/*Save Taxes*/
case'taxes':var json='{"DATA":[["'+options["id"]+'","'+
$("#t_taxservices").is(':checked')+'","'+
$("#t_formtype").val()+'","'+
$("#t_businessc").is(':checked')+'","'+
$("#t_rentalpropertye").is(':checked')+'","'+
$("#t_disregardedentity").is(':checked')+'","'+
$("#t_personalproperty").is(':checked')+
'"]]}';
if(options["group"]!=""&&$("#t_isLoaded").val()==1){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"payroll"});}
break;

/*Save payroll*/
case'payroll':var json='{"DATA":[["'+options["id"]+'","'+
$("#p_payrollpreparation").is(':checked')+'","'+
$("#p_paycheckfrequency").val()+'","'+
$("#p_payrolltaxservices").is(':checked')+'","'+
$("#p_prtaxdepositschedule").val()+'","'+
$("#p_1099preparation").is(':checked')+'","'+
$("#p_ein").val()+'","'+
$("#p_pin").val()+'","'+
$("#p_password").val()+
'"]]}';
if(options["group"]!=""&&$("#p_isLoaded").val()==1){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"accounting"});}
break;

/*Save accounting*/
case'accounting':var json='{"DATA":[["'+options["id"]+'","'+
$("#a_accountingServices").is(':checked')+'","'+
$("#a_bookkeeping").is(':checked')+'","'+
$("#a_compilation").is(':checked')+'","'+
$("#a_review").is(':checked')+'","'+
$("#a_audit").is(':checked')+'","'+
$("#a_financialstatementfreq").val()+'","'+
$("#a_fiscalyearend").val()+'","'+
$("#a_software").val()+'","'+
$("#a_version").val()+'","'+
$("#a_username").val()+'","'+
$("#a_accountingpassword").val()+
'"]]}';
if(options["group"]!=""&&$("#a_isLoaded").val()==1){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"contact"});}
break;

/*Save Contacts*/
case'contact':var json='{"DATA":[["'+options["id"]+'","'+
$("#co_id").val()+'","'+
$("#co_type").val()+'","'+
$("#co_name").val()+'","'+
$("#co_address1").val()+'","'+
$("#co_address2").val()+'","'+
$("#co_city").val()+'","'+
$("#co_state").val()+'","'+
$("#co_zip").val()+'","'+
$("#co_phone1").val()+'","'+
$("#co_phone2").val()+'","'+
$("#co_phone3").val()+'","'+
$("#co_phone4").val()+'","'+
$("#co_phone5").val()+'","'+
$("#co_email1").val()+'","'+
$("#co_email2").val()+'","'+
$("#co_website").val()+'","'+
$("#co_effectivedate").val()+'","'+
$("#co_acctsoftwareupdate").is(':checked')+'","'+
$("#co_taxupdate").is(':checked')+'","'+
$("#co_customlabel").val()+'","'+
$("#co_customvalue").is(':checked')+
'"]]}';
if(options["group"]!=""&&$("#co_isLoaded").val()==1&&$("#co_name").val()!=""){

_saveData({"group":options["group"],"payload":$.parseJSON(json)}); 
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"financialstatements"});}
break;


/*Save Financial Statements*/
case'financialstatements':var json='{"DATA":[["'+options["id"]+'","'+
$("#m_fs_id").val()+'","'+
$("#m_fs_month").val()+'","'+
$("#m_fs_periodend").val()+'","'+
$("#m_fs_year").val()+
'"]]}';
if(options["group"]!=""&&$("#m_fs_isLoaded").val()==1&&$("#m_fs_month").val()!="0"&&$("#m_fs_periodend").val()!==""&&$("#m_fs_year").val()!==""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"managementconsulting"});}
break;

/*Save Management Consulting Tasks*/
case'managementconsulting':
var json='{"DATA":[["'+options["id"]+'","'+
$("#m_mct_id").val()+'","'+
$("#m_mct_category").val()+'","'+
$("#m_mct_duedate").val()+
'"]]}';
if(options["group"]!=""&&$("#m_mct_isLoaded").val()==1&&$("#m_mct_category").val()!="0"&&$("#m_mct_duedate").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"payrollchecks"});}
break;

/*Save Payroll Checks*/
case'payrollchecks':var json='{"DATA":[["'+options["id"]+'","'+
$("#m_pc_id").val()+'","'+
$("#m_pc_duedate").val()+'","'+
$("#m_pc_inforeceived").val()+'","'+
$("#m_pc_missinginfo").is(':checked')+'","'+
$("#m_pc_paydate").val()+'","'+
$("#m_pc_payenddate").val()+'","'+
$("#m_pc_year").val()+
'"]]}';

if(options["group"]!=""&&$("#m_pc_isLoaded").val()==1&&$("#m_pc_duedate").val()!=""&&$("#m_pc_inforeceived").val()!=""&&$("#m_pc_paydate").val()!=""&&$("#m_pc_payenddate").val()!=""&&$("#m_pc_year").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"payrolltaxes"});}
break;

/*Save Payroll Taxes*/
case'payrolltaxes':var json='{"DATA":[["'+options["id"]+'","'+
$("#m_pt_id").val()+'","'+
$("#m_pt_duedate").val()+'","'+
$("#m_pt_inforeceived").val()+'","'+
$("#m_pt_lastpaydate").val()+'","'+
$("#m_pt_missinginfo").is(':checked')+'","'+
$("#m_pt_month").val()+'","'+
$("#m_pt_returntype").val()+'","'+
$("#m_pt_year").val()+
'"]]}';
if(options["group"]!=""
&&$("#m_pt_isLoaded").val()==1
&&$("#m_pt_duedate").val()!=""
&&$("#m_pt_inforeceived").val()!=""
&&$("#m_pt_lastpaydate").val()!=""
&&$("#m_pt_month").val()!="0"
&&$("#m_pt_returntype").val()!="0"
&&$("#m_pt_year").val()!=""){
	_saveData({"group":options["group"],"payload":$.parseJSON(json)});
	}

else{_saveDataCB({"id":$("#cl_id").val(),"group":"taxstatuslisting"});}
break;

/*Save Tax Status Listing*/
case'taxstatuslisting':var json='{"DATA":[["'+options["id"]+'","'+
$("#m_tsl_id").val()+'","'+
$("#m_tsl_inforeceived").val()+'","'+
$("#m_tsl_missinginfo").is(':checked')+'","'+
$("#m_tsl_taxform").val()+'","'+
$("#m_tsl_taxyear").val()+
'"]]}';
if(options["group"]!=""&&$("#m_tsl_isLoaded").val()==1&&$("#m_tsl_id").val()!=""&&$("#m_tsl_inforeceived").val()!=""&&$("#m_tsl_taxform").val()!=""&&$("#m_tsl_taxyear").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)}); 
	}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"otherfilings"});}
break;


/*Save Other Filings*/
case'otherfilings':

var json='{"DATA":[["'+options["id"]+'","'+
$("#m_of_id").val()+'","'+
$("#m_of_duedate").val()+'","'+
$("#m_of_form").val()+'","'+
$("#m_of_period").val()+'","'+
$("#m_of_state").val()+'","'+
$("#m_of_task").val()+'","'+
$("#m_of_taxyear").val()+
'"]]}';
if(options["group"]!=""&&$("#m_of_isLoaded").val()==1&&$("#m_of_duedate").val()!=""&&$("#m_of_form").val()!=""&&$("#m_of_period").val()!=""&&$("#m_of_state").val()!=""&&$("#m_of_task").val()!=""&&$("#m_of_taxyear").val()!=""){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"statelabels"});}
break;
/*Save State Labels*/
case'statelabels':var json='{"DATA":[["'+options["id"]+'","'+
$("#sl_label1").val()+'","'+
$("#sl_label2").val()+'","'+
$("#sl_label3").val()+'","'+
$("#sl_label4").val()+
'"]]}';
if(options["group"]!=""&&$("#sl_label1").val()!=""&&$("#sl_label2").val()!=""&&$("#sl_label3").val()!=""&&$("#sl_label4").val()!=""){	
_saveData({"group":options["group"],"payload":$.parseJSON(json)})}
else{_saveDataCB({"id":$("#cl_id").val(),"group":"stateinformation"})}
break;

/*Save State Information*/
case'stateinformation':
var json='{"DATA":[["'+options["id"]+'","'+
$("#si_id").val()+'","'+
$("#s_employees").is(':checked')+'","'+
$("#s_nexus").is(':checked')+'","'+
$("#s_property").is(':checked')+'","'+
$("#s_reason").val()+'","'+
$("#s_registered").is(':checked')+'","'+
$("#s_revenue").is(':checked')+'","'+
$("#s_state").val()+'","'+
$("#s_value1").is(':checked')+'","'+
$("#s_value2").is(':checked')+'","'+
$("#s_value3").is(':checked')+'","'+
$("#s_value4").is(':checked')+
'"]]}';
if(options["group"]!=""&&$("#s_isLoaded").val()==1){
_saveData({"group":options["group"],"payload":$.parseJSON(json)});
}else{_saveDataCB({"id":$("#cl_id").val(),"group":"clientrelations"});}
break;
/*Save Client Relations*/
case'clientrelations':
var json='{"DATA":[["'+options["id"]+'","'+
$("#rc_group").val()+
'"]]}';

alert($("#rc_group").val() +" ? "+options["id"])
if(options["group"]!=""&&$("#rc_isLoaded").val()==1){	
_saveData({"group":options["group"],"payload":$.parseJSON(json)})
}else{
_saveDataCB({"id":$("#cl_id").val(),"group":"saved"})
}
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