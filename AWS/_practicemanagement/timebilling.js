$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
_group4=function(){_grid4()}
_group5=function(){_grid5()}
_group6=function(){_grid6()}
_group7=function(){_grid7()}
_group8=function(){_grid8()}
_group9=function(){_grid9()}
_group10=function(){_grid10()}
_group11=function(){_grid11()}
_group12=function(){_grid12()}
_group13=function(){_grid13()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"timebilling.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,PC_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,PC_FEES:{title:'Fees'}
			,PC_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};


 
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"timebilling.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_TYPE:{title:'Type'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTH:{title:'Month'}
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_MISSINGRECEIVED:{title:'Missing Information Received',width:'1%'}
			,PT_ENTRY_DATECOMPLETED:{title:'Entry',width:'1%'}
			,PT_REC_DATECOMPLETED:{title:'Reconcile',width:'1%'}
			,PT_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,PT_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,PT_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,PT_FEES:{title:'Fees'}
			,PT_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"timebilling.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_TAXYEAR:{title:'Year',width:'1%'}
			,OF_PERIOD:{title:'Period'}
			,OF_STATE:{title:'State'}
			,OF_FORM:{title:'Form',width:'1%'}
			,OF_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,OF_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,OF_MIRECEIVED:{title:'Missing Information Received',width:'1%'}
			,OF_PREPARATION_DATECOMPLETED:{title:'Preparation',width:'1%'}
			,OF_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,OF_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,OF_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,OF_FEES:{title:'Fees'}
			,OF_ESTTIME:{title:'Estimated Time'}
			,OF_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group3"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};


	
_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"timebilling.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_STATUS:{title:'Status',width:'1%'}
			,BF_ASSIGNEDTO:{title:'Assignedto',width:'1%'}
 			,BF_DATEINITIATED:{title:'Date Initiated',width:'1%'}
 			,BF_BUSINESSTYPE:{title:'Business Type',width:'1%'}
 			,BF_BUSINESSSUBMITTED:{title:'Form Submitted',width:'1%'}
 			,BF_BUSINESSRECEIVED:{title:'Form Received',width:'1%'}
			,BF_ARTICLESSUBMITTED:{title:'Article Submitted',width:'1%'}
			,BF_ARTICLESAPPROVED:{title:'Article Approved',width:'1%'}
			,BF_TRADENAMESUBMITTED:{title:'Trade Name Submitted',width:'1%'}
			,BF_TRADENAMERECEIVED:{title:'Trade Name Received',width:'1%'}
			,BF_MINUTESBYLAWSDRAFT:{title:'Minutes By Laws Draft',width:'1%'}
			,BF_MINUTESBYLAWSFINAL:{title:'Minutes By Laws Final',width:'1%'}
			,BF_MINUTESCOMPLETED:{title:'Minutes Completed',width:'1%'}
			,BF_DISSOLUTIONREQUESTED:{title:'Dissolution Requested',width:'1%',list:false}
			,BF_DISSOLUTIONSUBMITTED:{title:'Dissolution Submitted',width:'1%',list:false}
			,BF_DISSOLUTIONCOMPLETED:{title:'Dissolution Completed',width:'1%',list:false}
			,BF_OTHERACTIVITY:{title:'Other Activity',width:'1%'}
			,BF_OTHERSTARTED:{title:'Other Started',width:'1%'}
			,BF_OTHERCOMPLETED:{title:'Other Completed',width:'1%'}
			,BF_RECORDBOOKORDERED:{title:'Record Book Ordered',width:'1%'}
  			,BF_FEES:{title:'Fees'}
			,BF_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group4"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};

_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"timebilling.cfc",
	"title":"Accounting & Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORY:{title:'Consulting Category'}
			,MC_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,MC_STATUS:{title:'Status'}
			,MC_DESCRIPTION:{title:'Description'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service',width:'1%'}
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			,MC_WORKINITIATED:{title:'Work Initiated',width:'1%'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed',width:'1%'}
			,MC_ESTIMATEDTIME:{title:'Estimated Time'}
			,MC_FEES:{title:'Fees'}
			,MC_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group5"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	
	
_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"timebilling.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTH:{title:'Month'}
			,FDS_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'1%'}
			,FDS_SORT:{title:'Sort',width:'1%'}
			,FDS_CHECKS:{title:'Checks',width:'1%'}
			,FDS_SALES:{title:'Sales',width:'1%'}
			,FDS_ENTRY:{title:'Entry',width:'1%'}
			,FDS_RECONCILE:{title:'Reconcile',width:'1%'}
			,FDS_COMPILE:{title:'Compilie',width:'1%'}
			,FDS_REVIEW:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY:{title:'Assembled',width:'1%'}
			,FDS_DELIVERY:{title:'Delivered',width:'1%'}
			,FDS_ACCTRPT:{title:'Report',width:'1%'}
			,FDSS_SUBTASK:{title:'Subtask',width:'1%'}
			,FDSS_STATUS:{title:'Status',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group6"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};
	
		
_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"timebilling.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FTP_CATEGORY:{title:'Category'}
			,FTP_STATUS:{title:'Status'}
			,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			,FTP_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,FTP_REQUESTSERVICE:{title:'Request for Service',width:'1%'}
			,FTP_INFOREQUESTED:{title:'Information Requested',width:'1%'}
			,FTP_INFORECEIVED:{title:'Information Received',width:'1%'}
			,FTP_INFOCOMPILED:{title:'Information Compiled',width:'1%'}
			,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FTP_MISSINGINFOREC:{title:'Missing information Received',width:'1%'}
			,FTP_REPORTCOMPLETED:{title:'Report Completed',width:'1%'}
			,FTP_FINALCLIENTMEETING:{title:'Final Client Meeting',width:'1%'}
			,FTP_FEES:{title:'Fees'}
			,FTP_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g7_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group7"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};

	
_grid8=function(){_jGrid({
	"grid":"grid8",
	"url":"timebilling.cfc",
	"title":"Notices",
	"fields":{NM_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,NM_NAME:{title:'Matter Name'}
			,N_1_TAXYEAR:{title:'Tax Year',width:'1%'}
			,N_1_TAXFORM:{title:'Tax Form'}
			,N_1_NOTICENUMBER:{title:'Notice Number'}
			,N_1_FEES:{title:'Fees'}
			,N_1_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g8_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group8"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	})};


_grid9=function(){_jGrid({
	"grid":"grid9",
	"url":"timebilling.cfc",	
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'1%'},
			TR_TAXFORM:{title:'Tax Form'},
			TR_1_COMPLETED:{title:'Completed',width:'1%'},
			TR_2_DELIVERED:{title:'Delivered',width:'1%'},
			TR_1_PREPAREDBY:{title:'Prepared By',width:'1%'},
			TR_CURRENTFEES:{title:'Fees'},
			TR_2_PAYMENTSTATUS:{title:'Payment Status'},
			TR_3_MULTISTATERETURN:{title:'Multi State Return',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g9_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group9"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	

_grid10=function(){_jGrid({
	"grid":"grid10",
	"url":"timebilling.cfc",	
	"title":"PPTRs",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'1%'},
			TR_TAXFORM:{title:'Tax Form'},
			TR_3_COMPLETED:{title:'Completed',width:'1%'},
			TR_3_CURRENTFEES:{title:'Current Fees'},		
			TR_3_PAYMENTSTATUS:{title:'Payment Status'},
			TR_3_DELIVERED:{title:'Delivered',width:'1%'},
			TR_3_MULTISTATERETURN:{title:'Multi State Return',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g10_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group10"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	

_grid11=function(){_jGrid({
	"grid":"grid11",
	"url":"timebilling.cfc",	
	"title":"State Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'1%'},
			TRST_STATE:{title:'State'},
			TRST_1_COMPLETED:{title:'Completed',width:'1%'},
			TRST_2_DELIVERED:{title:'Delivered',width:'1%'},
			TRST_1_PREPAREDBY:{title:'Prepared By',width:'1%'},
			TRST_2_CURRENTFEES:{title:'Fees'},
			TRST_3_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g11_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group11"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};


_grid12=function(){_jGrid({
	"grid":"grid12",
	"url":"timebilling.cfc",	
	"title":"State Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'1%'},
			TR_TAXFORM:{title:'Tax Form'},
			TRST_STATE:{title:'State'},
			TRST_3_PPTRCOMPLETED:{title:'Completed',width:'1%'},
			TRST_3_PPTRCURRENTFEES:{title:'Current Fees'},
			TRST_3_PAYMENTSTATUS:{title:'Payment Status'},
			TRST_3_PPTRDELIVERED:{title:'Delivered',width:'1%'}			
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g12_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group12"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};


_grid13=function(){_jGrid({
	"grid":"grid13",
	"url":"timebilling.cfc",	
	"title":"Communications",
	"fields":{CO_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			CO_CALLER:{title:'Caller'},
			CO_FOR:{title:'For'},	
 			CO_FEES:{title:'Fees'},
			CO_PAID:{title:'Payment Status'},
			CO_DATE:{title:'Date &amp; Time',width:'1%'},
			CO_TELEPHONE:{title:'Phone'},
			CO_EXT:{title:'Ext'},
			CO_EMAILADDRESS:{title:'Email'},
			CO_RESPONSENEEDED:{title:'Response Needed',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			CO_RETURNCALL:{title:'Returned Call',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},		
			CO_BRIEFMESSAGE:{title:'Brief Message'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g13_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group13"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
})};


