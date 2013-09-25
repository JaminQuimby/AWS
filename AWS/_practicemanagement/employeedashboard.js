/*
Javascript for Employee Dashboard
Developers:Jamin Quimby
7/26/2013 - Started
*/

$(document).ready(function(){
	
	jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});

_grid1();
_group1=function(){}

_group2=function(){}
_group2_1=function(){_grid2_1()};
_group2_2=function(){_grid2_2()};
_group2_3=function(){_grid2_3()};

_group3=function(){}
_group3_1=function(){_grid3_1()};
_group3_2=function(){_grid3_2()};
_group3_3=function(){_grid3_3()};

_group4=function(){}
_group4_1=function(){_grid4_1()};
_group4_2=function(){_grid4_2()};

_group5=function(){}
_group5_1=function(){_grid5_1()};
_group5_2=function(){_grid5_2()};
_group5_3=function(){_grid5_3()};
_group5_4=function(){_grid5_4()};
_group5_5=function(){_grid5_5()};
_group5_6=function(){_grid5_6()};

_group6=function(){}
_group6_1=function(){_grid6_1()};
_group6_2=function(){_grid6_2()};
_group6_3=function(){_grid6_3()};

_group7=function(){_grid7()}


});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"employeedashboard.cfc",
	"title":"Employee Dashboard",
	"fields":{SI_ID:{key:true,list:false,edit:false},NAME:{title:'Employee Name'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.USER_ID);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");'
	})};
	
_grid2_1=function(){_jGrid({
	"grid":"grid2_1",
	"url":"employeedashboard.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_YEAR:{title:'Year'},PC_PAYENDDATE:{title:'Pay End'},PC_PAYDATE:{title:'Pay Date'},PC_DATEDUE:{title:'Due Date'},PC_MISSINGRECEIVED:{title:'Information Received'},PC_MISSINGINFO:{title:'Missing Information'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group2_1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
	})};
_grid2_2=function(){_jGrid({
	"grid":"grid2_2",
	"url":"employeedashboard.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PT_YEAR:{title:'Year'},PT_MONTH:{title:'Month'},PT_TYPE:{title:'Type'},PT_PAYMENTSTATUS:{title:'Status'},PT_LASTPAY:{title:'Last Pay'},PT_DUEDATE:{title:'Due Date'},PT_DELIVERY_DATECOMPLETED:{title:'Completed'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group2_2"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
	})};
_grid2_3=function(){_jGrid({
	"grid":"grid2_3",
	"url":"employeedashboard.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},OF_TAXYEAR:{title:'Tax Year'},OF_STATE:{title:'State'},OF_TASK:{title:'Task'},OF_FORM:{title:'Form'},OF_STATUS:{title:'Status'},OF_DUEDATE:{title:'Due Date'},OF_MISSINGINFO:{title:'Missing Info'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group2_3"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
	})};
	
_grid3_1=function(){_jGrid({
	"grid":"grid3_1",
	"url":"employeedashboard.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},BF_ACTIVITY:{title:'Activity'},BF_STATUS:{title:'Status'},BF_DUEDATE:{title:'Due Date'},BF_FEES:{title:'Fees'},BF_PAID:{title:'Paid'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group3_1"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
	})};
	
_grid3_2=function(){_jGrid({
	"grid":"grid3_2",
	"url":"employeedashboard.cfc",
	"title":"Accounting & Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},MC_CATEGORYTEXT:{title:'Consulting Categories'},MC_DESCRIPTION:{title:'Task Description'},MC_STATUS:{title:'Status'},MC_DUEDATE:{title:'Due Date'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group3_2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctConsultingTasks.cfm?task_id="+record.MC_ID'
	})};	
	
_grid3_3=function(){_jGrid({
	"grid":"grid3_3",
	"url":"employeedashboard.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FDS_YEAR:{title:'Year'},FDS_MONTHTEXT:{title:'Month'},FDS_DUEDATE:{title:'Due Date'},FDS_MIRECEIVED:{title:'Missing Information Received'},FDS_MISSINGINFO:{title:'Missing Information'},FDS_CMIRECEIVED:{title:'Compiled Missing Information Received'},FDS_COMPILEMI:{title:'Missing Information Compiled'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group3_3"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
	})};
	
	
_grid4_1=function(){_jGrid({
	"grid":"grid4_1",
	"url":"employeedashboard.cfc",
	"title":"Notices",
	"fields":{NM_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},NM_NAME:{title:'Matter Name'},N_1_TAXYEAR:{title:'Tax Year'},N_1_TAXFORM:{title:'Tax Form'},N_1_NOTICENUMBER:{title:'Notice Number'},N_3_MISSINGINFO:{title:'Missing Information'},NM_STATUS:{title:'Notice Status'},N_2_DATENOTICEREC:{title:'Notice Received'},N_2_RESDUEDATE:{title:'Response Due'},N_2_RESCOMPLETED:{title:'Response Submitted'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group4_1"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	})};

_grid4_2=function(){_jGrid({
	"grid":"grid4_2",
	"url":"employeedashboard.cfc",
	"title":"Notices For Review",
	"fields":{NM_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},NM_NAME:{title:'Matter Name'},N_1_TAXYEAR:{title:'Tax Year'},N_1_TAXFORM:{title:'Tax Form'},N_1_NOTICENUMBER:{title:'Notice Number'},N_3_MISSINGINFO:{title:'Missing Information'},NM_STATUS:{title:'Notice Status'},N_2_DATENOTICEREC:{title:'Notice Received'},N_2_RESDUEDATE:{title:'Response Due'},N_2_RESCOMPLETED:{title:'Response Submitted'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group4_2"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	})};
	

_grid5_1=function(){_jGrid({
	"grid":"grid5_1",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready For Data Entry",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Year'},TR_TAXFORM:{title:'Form'},TR_G1_1_INFORMATIONRECEIVED:{title:'Information Received'},sTR_G1_3_PRIORFEES:{title:'Prior Fees'},TR_G1_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment'},TR_G1_4_PICKUPAPPOINTMENT:{title:'Pick UP Appointment'},TR_G1_1_MISSINGINFORECEIVED:{title:'Missing Information Received'},TR_G1_1_DUEDATE:{title:'Due Date'},TR_G1_1_REVIEWEDWITHNOTES:{title:'Reviewed With Notes'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};	
	
_grid5_2=function(){_jGrid({
	"grid":"grid5_2",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns With Missing Information",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'},TR_TAXFORM:{title:'Tax Form'},TR_G1_1_INFORMATIONRECEIVED:{title:'Information Received'},TR_G1_1_MISSINGINFORECEIVED:{title:'Missing Information Received'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_2"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};	
	
_grid5_3=function(){_jGrid({
	"grid":"grid5_3",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready for Review",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Year'},TR_FORM:{title:'Tax Form'},TR_G1_1_INFORMATIONRECEIVED:{title:'Information Received'},TR_G1_1_DUEDATE:{title:'Due Date'},TR_G1_3_RFR:{title:'RFR'},TR_G1_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment'},TR_G1_4_PICKUPAPPOINTMENT:{title:'Pick Up Appointment'},TR_G1_1_MISSINGINFO:{title:'Missing Information'},TR_G1_1_REVIEWEDWITHNOTES:{title:'Review With Notes'},TR_G1_1_COMPLETED:{title:'Completed'},TR_G1_2_DELIVERED:{title:'Delivered'},TR_G1_2_PAYMENTSTATUS:{title:'Paid'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_3"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};	
_grid5_4=function(){_jGrid({
	"grid":"grid5_4",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready for Assembly & Delivery",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Tax Year'},TR_TAXFORM:{title:'Tax Form'},TR_G1_1_COMPLETED:{title:'Completed'},TR_CURRENTFEES:{title:'Fees'},TR_G1_2_ASSEMBLERETURN:{title:'Assembled'},TR_G1_2_CONTACTED:{title:'Contacted'},TR_G1_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment'},TR_G1_4_PICKUPAPPOINTMENT:{title:'Pick Up Appointment'},TR_G1_2_DELIVERED:{title:'Delivered'},TR_G1_2_PAYMENTSTATUS:{title:'Paid'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_4"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};	
_grid5_5=function(){_jGrid({
	"grid":"grid5_5",
	"url":"employeedashboard.cfc",	
	"title":"Incomplete State Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},TR_TAXYEAR:{title:'Year'},TR_FORM:{title:'Tax Form'},TRST_STATE:{title:'State'},TR_G1_1_INFORMATIONRECEIVED:{title:'Information Received'},TR_G1_1_DUEDATE:{title:'Due Date'},TR_G1_1_MISSINGINFORECEIVED:{title:'Missing Information Received'},TR_G1_3_RFR:{title:'RFR'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_5"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};
	
_grid5_6=function(){_jGrid({
	"grid":"grid5_6",
	"url":"employeedashboard.cfc",	
	"title":"Financial & Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},FTP_CATEGORY:{title:'Category'},FTP_REQUESTFORSERVICE:{title:'Request for Services'},FTP_DUEDATE:{title:'Due Date'},FTP_INFORECEIVED:{title:'Information Received'},FTP_MISSINGINFO:{title:'Missing Information'},FTP_STATUS:{title:'Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group5_6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
	})};
	
	
_grid6_1=function(){_jGrid({
	"grid":"grid6_1",
	"url":"employeedashboard.cfc",	
	"title":"Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client'},CAS_DUEDATE:{title:'Due Date'},CAS_PRIORITY:{title:'Priority'},CAS_STATUS:{title:'Status'},CAS_TASKDESC:{title:'Description'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group6_1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
	})};
	
_grid6_2=function(){_jGrid({
	"grid":"grid6_2",
	"url":"employeedashboard.cfc",	
	"title":"Communications Dashboard",
	"fields":{CO_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},CO_CALLER:{title:'Caller'},CO_CREDITHOLD:{title:'Credit Hold'},CO_FEES:{title:'Fees'},CO_PAID:{title:'Paid'},CO_DATE:{title:'Date &amp; Time'},CO_TELEPHONE:{title:'Phone'},CO_EXT:{title:'Ext'},CO_EMAILADDRESS:{title:'Email'},CO_RESPONSENEEDED:{title:'Response Needed'},CO_RETURNCALL:{title:'Returned Call'},CO_BRIEFMESSAGE:{title:'Brief Message'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group6_2"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
	})};
	
_grid6_3=function(){_jGrid({
	"grid":"grid6_3",
	"url":"employeedashboard.cfc",	
	"title":"Document Tracking Log",
	"fields":{DT_ID:{key:true,list:false,edit:false},CLIENT_ID:{list:false,edit:false},CLIENT_NAME:{title:'Client Name'},DT_DATE:{title:'Date'},DT_STAFF:{title:'Staff'},DT_SENDER:{title:'Sender'},DT_DESCRIPTION:{title:'Description'},DT_DELIVERY:{title:'Delivery'},DT_ROUTING:{title:'Routing'}},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":'+$("#task_id").val()+',"ID":"0","loadType":"group6_3"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/documenttracking.cfm?task_id="+record.DT_ID'
	})};
	
	
	
	
	
	
//Load Data call Back
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){



default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};/*SAVE DATA CALL BACK*/



_saveDataCB=function(params){
var options={"id":"","group":"","result":""	}
try{	
$.extend(true, options, params);//turn options into array


switch(options["group"]){
/*Save Client*/
case'group1':var json='{"DATA":[["'+






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


// JavaScript Document// JavaScript Document