/*
Javascript for Employee Dashboard
Developers:Jamin Quimby
7/26/2013 - Started
*/


$(document).ready(function(){
	

_grid0();
_group1=function(){_grid1_1()};
_group1_1=function(){_grid1_1()};
_group1_2=function(){_grid1_2()};
_group1_3=function(){_grid1_3()};

_group2=function(){_grid2_1()}
_group2_1=function(){_grid2_1()};
_group2_2=function(){_grid2_2()};
_group2_3=function(){_grid2_3()};

_group3=function(){_grid3_1()}
_group3_1=function(){_grid3_1()};
_group3_2=function(){_grid3_2()};

_group4=function(){_grid4_1()}
_group4_1=function(){_grid4_1()};
_group4_2=function(){_grid4_2()};
_group4_3=function(){_grid4_3()};
_group4_4=function(){_grid4_4()};
_group4_5=function(){_grid4_5()};
_group4_6=function(){_grid4_6()};

_group5=function(){_grid5_1()}
_group5_1=function(){_grid5_1()};
_group5_2=function(){_grid5_2()};
_group5_3=function(){_grid5_3()};
});
 
_grid0=function(){_jGrid({
	"grid":"grid0",
	"url":"employeedashboard.cfc",
	"title":"Employee Dashboard",
	"fields":{SI_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			NAME:{title:'Employee Name'},
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0"}',
	"functions":'$("#task_id").val(record.USER_ID);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_grid1_1();'
})};
	
_grid1_1=function(){_jGrid({
	"grid":"grid1_1",
	"url":"employeedashboard.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			PC_YEAR:{title:'Year',width:'2%'},
			PC_PAYENDDATE:{title:'Pay End',width:'2%'},
			PC_PAYDATE:{title:'Pay Date',width:'2%'},
			PC_DUEDATE:{title:'Due Date',width:'2%'},
			PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'2%'},
			PC_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group1_1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};

_grid1_2=function(){_jGrid({
	"grid":"grid1_2",
	"url":"employeedashboard.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			PT_YEAR:{title:'Year',width:'2%'},
			PT_MONTHTEXT:{title:'Month'},
			PT_TYPETEXT:{title:'Type'},
			PT_LASTPAY:{title:'Last Pay',width:'2%'},
			PT_DUEDATE:{title:'Due Date',width:'2%'},
			PT_DELIVERY_DATECOMPLETED:{title:'Completed',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group1_2","formid":"12"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};

_grid1_3=function(){_jGrid({
	"grid":"grid1_3",
	"url":"employeedashboard.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			OF_TAXYEAR:{title:'Tax Year',width:'2%'},
			OF_STATETEXT:{title:'State'},
			OF_TASKTEXT:{title:'Task'},
			OF_FORMTEXT:{title:'Form'},
			OF_STATUSTEXT:{title:'Status'},
			OF_DUEDATE:{title:'Due Date',width:'2%'},
			OF_MISSINGINFO:{title:'Missing Info',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group1_3","formid":"11"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};
	
_grid2_1=function(){_jGrid({
	"grid":"grid2_1",
	"url":"employeedashboard.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			BF_ACTIVITY:{title:'Activity'},
			BF_STATUSTEXT:{title:'Status'},
			BF_DUEDATE:{title:'Due Date',width:'2%'},
			BF_FEES:{title:'Fees'},
			BF_PAIDTEXT:{title:'Paid'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group2_1","formid":"3"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};
	
_grid2_2=function(){_jGrid({
	"grid":"grid2_2",
	"url":"employeedashboard.cfc",
	"title":"Accounting & Consulting",
	"fields":{MC_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			MC_CATEGORYTEXT:{title:'Consulting Categories'},
			MC_DESCRIPTION:{title:'Task Description'},
			MC_STATUSTEXT:{title:'Status'},
			MC_DUEDATE:{title:'Due Date',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group2_2","formid":"2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	
	
_grid2_3=function(){_jGrid({
	"grid":"grid2_3",
	"url":"employeedashboard.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			FDS_YEAR:{title:'Year',width:'2%'},
			FDS_MONTHTEXT:{title:'Month'},
			FDS_DUEDATE:{title:'Due Date',width:'2%'},
			FDS_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'},
			FDS_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			FDS_CMIRECEIVED:{title:'Compiled Missing Information Received',width:'2%'},
			FDS_COMPILEMI:{title:'Missing Information Compiled',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group2_3","formid":"5"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};
	
_grid3_1=function(){_jGrid({
	"grid":"grid3_1",
	"url":"employeedashboard.cfc",
	"title":"Notices",
	"fields":{NM_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			NM_NAME:{title:'Matter Name'},
			N_1_TAXYEAR:{title:'Tax Year',width:'2%'},
			N_1_TAXFORM:{title:'Tax Form'},
			N_1_NOTICENUMBER:{title:'Notice Number',width:'2%'},
			N_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			NM_STATUS:{title:'Notice Status'},
			N_1_DATENOTICEREC:{title:'Notice Received',width:'2%'},
			N_1_RESDUEDATE:{title:'Response Due',width:'2%'},
			N_1_RESCOMPLETED:{title:'Response Submitted',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group3_1"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	})};

_grid3_2=function(){_jGrid({
	"grid":"grid3_2",
	"url":"employeedashboard.cfc",
	"title":"Notices For Review",
	"fields":{NM_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			NM_NAME:{title:'Matter Name'},
			N_1_TAXYEAR:{title:'Tax Year',width:'2%'},
			N_1_TAXFORM:{title:'Tax Form'},
			N_1_NOTICENUMBER:{title:'Notice Number',width:'2%'},
			N_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			NM_STATUS:{title:'Notice Status'},
			N_1_DATENOTICEREC:{title:'Notice Received',width:'2%'},
			N_1_RESDUEDATE:{title:'Response Due',width:'2%'},
			N_1_RESCOMPLETED:{title:'Response Submitted',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group3_2"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	})};
	

_grid4_1=function(){_jGrid({
	"grid":"grid4_1",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready For Data Entry",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Form'},
			TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'},
			TR_PRIORFEES:{title:'Prior Fees'},
			TR_1_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'2%'},
			TR_1_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'2%'},
			TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'},
			TR_DUEDATE:{title:'Due Date',width:'2%'},
			TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_1","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	
	
_grid4_2=function(){_jGrid({
	"grid":"grid4_2",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns With Missing Information",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Tax Form'},
			TR_1_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'},
			TR_1_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_2","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	
	
_grid4_3=function(){_jGrid({
	"grid":"grid4_3",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready for Review",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'2%'},
			TR_FORM:{title:'Tax Form'},
			TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'},
			TR_1_DUEDATE:{title:'Due Date',width:'2%'},
			TR_1_READYFORREVIEW:{title:'Ready for Review',width:'2%'},
			TR_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'2%'},
			TR_4_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'2%'},
			TR_1_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			TR_1_REVIEWEDWITHNOTES:{title:'Review With Notes',width:'2%'},
			TR_1_COMPLETED:{title:'Completed',width:'2%'},
			TR_2_DELIVERED:{title:'Delivery',width:'2%'},
			TR_2_PAYMENTSTATUS:{title:'Paid'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_3","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	
	
_grid4_4=function(){_jGrid({
	"grid":"grid4_4",
	"url":"employeedashboard.cfc",	
	"title":"Tax Returns Ready for Assembly & Delivery",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Tax Form'},
			TR_1_COMPLETED:{title:'Completed',width:'2%'},
			TR_CURRENTFEES:{title:'Fees'},
			TR_2_ASSEMBLERETURN:{title:'Assembly',width:'2%'},
			TR_2_CONTACTED:{title:'Contacted',width:'2%'},
			TR_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'2%'},
			TR_4_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'2%'},
			TR_2_PAYMENTSTATUS:{title:'Paid'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_4","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	

_grid4_5=function(){_jGrid({
	"grid":"grid4_5",
	"url":"employeedashboard.cfc",	
	"title":"Incomplete State Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'2%'},
			TR_FORM:{title:'Tax Form'},
			TRST_STATE:{title:'State'},
			TRST_1_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'},
			TRST_1_DUEDATE:{title:'Due Date',width:'2%'},
			TRST_1_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'},
			TRST_1_READYFORREVIEW:{title:'Ready for Review',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_5","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};
	
_grid4_6=function(){_jGrid({
	"grid":"grid4_6",
	"url":"employeedashboard.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			FTP_CATEGORY:{title:'Category'},
			FTP_REQUESTSERVICE:{title:'Request for Services',width:'2%'},
			FTP_DUEDATE:{title:'Due Date',width:'2%'},
			FTP_INFORECEIVED:{title:'Information Received',width:'2%'},
			FTP_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			FTP_STATUS:{title:'Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group4_6","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};
	
	
_grid5_1=function(){_jGrid({
	"grid":"grid5_1",
	"url":"employeedashboard.cfc",	
	"title":"Administrative Tasks",
	"fields":{CAS_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			CAS_DUEDATE:{title:'Due Date',width:'2%'},
			CAS_PRIORITY:{title:'Priority'},
			CAS_STATUSTEXT:{title:'Status'},
			CAS_TASKDESC:{title:'Description'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group5_1","formid":"4"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
})};

_grid5_2=function(){_jGrid({
	"grid":"grid5_2",
	"url":"employeedashboard.cfc",	
	"title":"Communications Dashboard",
	"fields":{CO_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_NAME:{title:'Client Name'},
			CO_CALLER:{title:'Caller'},
			CO_CREDITHOLD:{title:'Credit Hold',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			CO_FEES:{title:'Fees'},
			CO_PAID:{title:'Paid'},
			CO_DATE:{title:'Date &amp; Time',width:'2%'},
			CO_TELEPHONE:{title:'Phone'},
			CO_EXT:{title:'Ext'},
			CO_EMAILADDRESS:{title:'Email'},
			CO_RESPONSENEEDED:{title:'Response Needed',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			CO_RETURNCALL:{title:'Returned Call',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},		
			CO_BRIEFMESSAGE:{title:'Brief Message'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group5_2"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
})};
	
_grid5_3=function(){_jGrid({
	"grid":"grid5_3",
	"url":"employeedashboard.cfc",	
	"title":"Document Tracking Log",
	"fields":{DT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'},
			CLIENT_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			DT_DATE:{title:'Date',width:'2%'},
			DT_STAFFTEXT:{title:'Staff'},
			DT_SENDER:{title:'Sender'},
			DT_DESCRIPTION:{title:'Description'},
			DT_DELIVERY:{title:'Delivery'},
			DT_ROUTING:{title:'Routing'},
			DT_ASSIGNEDTOTEXT:{title:'Assigned To'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","userid":"'+$("#task_id").val()+'","ID":"0","loadType":"group5_3"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/documenttracking.cfm?task_id="+record.DT_ID'
})};


// JavaScript Document// JavaScript Document