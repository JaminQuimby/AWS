$(document).ready(function(){
$('#g1_assignedto').val($('#user_id').val()).trigger('chosen:updated');
_grid1();
});

var _run={
 	 load_group1:function(){_grid1();}
	 ,load_group2:function(){_grid2();}
	 ,load_group3:function(){_grid3();}
	 ,load_group4:function(){_grid4();}
	 ,load_group5:function(){_grid5();}
	 ,load_group6:function(){_grid6();}
	 ,load_group7:function(){_grid7();}
	 ,load_group8:function(){_grid8();}
	 ,load_group9:function(){_grid9();}
	 ,load_group10:function(){_grid10();}
	 ,load_group11:function(){_grid11();}
	 ,load_group12:function(){_grid12();}
}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"workinprogress.cfc",	
	"title":"Estimated Time",
	"fields":{
		NAME:{title:'Module'}
		,COUNT_ASSIGNED:{title:'Task Assigned'}
		,TOTAL_TIME:{title:'Estimated Time'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'"}',
	"functions":''
})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"workinprogress.cfc",	
	"title":"Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CAS_COMPLETED:{title:'Completed',width:'1%'}
			,CAS_STATUSTEXT:{title:'Status',width:'1%'}
			,CAS_PRIORITY:{title:'Priority',width:"1%"}
			,CAS_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,CAS_DUEDATE:{title:'Due Date',width:"1%"}
			,CAS_ESTTIME:{title:'Estimated Time'}
			,CAS_CATEGORYTEXT:{title:'Category'}
			,CAS_TASKDESC:{title:'Task Description'}		
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"4"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
})};

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"workinprogress.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_DATEINITIATED:{title:'Date Initiated'}
			,BF_STATUSTEXT:{title:'Status'}
			,BF_PRIORITY:{title:'Priority',width:'1%'}
			,BF_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,BF_DUEDATE:{title:'Due Date'}
			,BF_ESTTIME:{title:'Estimated Time'}
			,BF_ACTIVITY:{title:'Activity'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"3"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};
	
_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"workinprogress.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			,FTP_REPORTCOMPLETED:{title:'Due Date',width:'1%'}
			,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FTP_STATUSTEXT:{title:'Status'}
			,FTP_PRIORITY:{title:'Status'}
			,FTP_ASSIGNEDTOTEXT:{title:'Status'}
			,FTP_DUEDATE:{title:'Status'}
			,FTP_ESTIMATEDTIME:{title:'Status'}
			,FTP_CATEGORYTEXT:{title:'Category'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group4","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"9"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};

_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"workinprogress.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_PERIODEND:{title:'Period End',width:'1%'}
			,FDS_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Missing Information Compiled',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_STATUSTEXT:{title:'Status'}
			,FDS_PRIORITY:{title:'Priority',width:'1%'}
			,FDS_DUEDATE:{title:'Due Date',width:'1%'}
			,FDS_ESTTIME:{title:'Estimated Time'}		
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Month'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group5","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"5"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};

_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"workinprogress.cfc",
	"title":"Accounting &amp; Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_PRIORITY:{title:'Priority'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To'}			
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			,MC_ESTTIME:{title:'Estimated Time',width:'1%'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}									
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group6","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	

_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"workinprogress.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,N_NAME:{title:'Matter Name'}
			,NST_1_NOTICEDATE:{title:'Notice Date',width:"1%"}
			,NST_MISSINGINFO:{title:'Missing Information Compiled',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_PRIORITY:{title:'Priority'}
			,NST_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,NST_1_RESDUEDATE:{title:'Response Due'}
			,NST_ESTTIME:{title:'Estimated Time'}
			,NST_2_REVREQUIRED:{title:'Review Required',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_2_REVASSIGNEDTOTEXT:{title:'Review Assigned To'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g7_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group7","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"8"}',
	"functions":'$("#n_id").val(record.N_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID'
})};	
	
_grid8=function(){_jGrid({
	"grid":"grid8",
	"url":"workinprogress.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
 			,OF_TYPETEXT:{title:'Type'}
			,OF_FORMTEXT:{title:'Form'}
			,OF_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,OF_STATUSTEXT:{title:'Status'}
			,OF_PRIORITY:{title:'Priority'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_ESTTIME:{title:'Estimated Time',width:'1%'}
			,OF_TAXYEAR:{title:'Tax Year',width:'1%'}
			,OF_PERIODTEXT:{title:'Period',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g8_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group8","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"11"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};
	
_grid9=function(){_jGrid({
	"grid":"grid9",
	"url":"workinprogress.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
 			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Completed',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,PC_DUEDATE:{title:'Date Due',width:'1%'}
			,PC_ESTTIME:{title:'Estimated Time',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g9_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group9","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"10"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};
	
_grid10=function(){_jGrid({
	"grid":"grid10",
	"url":"workinprogress.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_PRIORITY:{title:'Priority',width:'1%'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_ESTTIME:{title:'Estimated Time',width:'1%'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTH:{title:'Month',width:'1%'}
			,PT_TYPE:{title:'Return Type',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g10_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group10","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"13"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};
	


_grid11=function(){_jGrid({
	"grid":"grid11",
	"url":"workinprogress.cfc",	
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_TAXYEAR:{title:'Tax Year',width:'1%'}
			,TR_TAXFORM:{title:'Tax Form',width:'1%'}
			,TR_PRIORITY:{title:'Priority',width:'1%'}
			,TR_2_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_ESTTIME:{title:'Estimated Time',width:'1%'}
			,TR_4_REQUIRED:{title:'PPTR Required',width:'1%'}
			,TR_4_RFR:{title:'Ready For Review',width:'1%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'PPTR Assigned To',width:'1%'}		
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g11_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group11","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};



_grid12=function(){_jGrid({
	"grid":"grid12",
	"url":"workinprogress.cfc",	
	"title":"Personal Property Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_4_EXTENDED:{title:'PPTR Extended',width:'1%'}
			,TR_4_COMPLETED:{title:'Completed',width:'1%'}
			,TR_TAXYEAR:{title:'Year',width:'1%'}
			,TR_TAXFORM:{title:'Form'}
			,TR_PRIORITY:{title:'Information Received',width:'1%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			,TR_4_PPTRESTTIME:{title:'Estimated Time',width:'1%'}
			,TR_4_RFR:{title:'Ready For Review',width:'1%'}
			,TR_4_DELIVERED:{title:'Delivered',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g12_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group12","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};