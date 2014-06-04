$(document).ready(function(){
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
	 ,load_group13:function(){_grid13();}
}
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"timebillingreport.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_DUEDATE:{title:'Due Date',width:'2%'}
			,PC_YEAR:{title:'Year',width:'2%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'2%'}
			,PC_PAYDATE:{title:'Pay Date',width:'2%'}
			,PC_MISSINGINFO:{title:'Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'2%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Assembly',width:'2%'}
			,PC_DELIVERY_DATECOMPLETED:{title:'Delivery',width:'2%'}
			,PC_FEES:{title:'Fees'}
			,PC_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group1","formid":"10"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};
 
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"timebillingreport.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_DUEDATE:{title:'Due Date',width:'2%'}
			,PT_TYPETEXT:{title:'Type'}
			,PT_YEAR:{title:'Year',width:'2%'}
			,PT_MONTHTEXT:{title:'Month'}
			,PT_LASTPAY:{title:'Last Pay',width:'2%'}
			,PT_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'2%'}
			,PT_MISSINGINFO:{title:'Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
			,PT_ENTRY_DATECOMPLETED:{title:'Entry',width:'2%'}
			,PT_REC_DATECOMPLETED:{title:'Reconcile',width:'2%'}
			,PT_REVIEW_DATECOMPLETED:{title:'Review',width:'2%'}
			,PT_ASSEMBLY_DATECOMPLETED:{title:'Assembly',width:'2%'}
			,PT_DELIVERY_DATECOMPLETED:{title:'Delivery',width:'2%'}
			,PT_FEES:{title:'Fees'}
			,PT_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"13"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"timebillingreport.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_DUEDATE:{title:'Due Date',width:'2%'}
			,OF_TAXYEAR:{title:'Year',width:'2%'}
			,OF_PERIODTEXT:{title:'Period'}
			,OF_STATETEXT:{title:'State'}
			,OF_FORMTEXT:{title:'Form',width:'2%'}
			,OF_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'2%'}
			,OF_MISSINGINFO:{title:'Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,OF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
			,OF_PREPARATION_DATECOMPLETED:{title:'Preparation',width:'2%'}
			,OF_REVIEW_DATECOMPLETED:{title:'Review',width:'2%'}
			,OF_ASSEMBLY_DATECOMPLETED:{title:'Assembly',width:'2%'}
			,OF_DELIVERY_DATECOMPLETED:{title:'Delivery',width:'2%'}
			,OF_FEES:{title:'Fees'}
			,OF_ESTTIME:{title:'Estimated Time'}
			,OF_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group3","formid":"11"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};


	
_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"timebillingreport.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_STATUSTEXT:{title:'Status',width:'2%'}
			,BF_ASSIGNEDTOTEXT:{title:'Assignedto',width:'2%'}
 			,BF_DATEINITIATED:{title:'Date Initiated',width:'2%'}
 			,BF_BUSINESSTYPE:{title:'Business Type',width:'2%'}
 			,BF_BUSINESSSUBMITTED:{title:'Form Submitted',width:'2%'}
 			,BF_BUSINESSRECEIVED:{title:'Form Received',width:'2%'}
			,BF_ARTICLESSUBMITTED:{title:'Article Submitted',width:'2%'}
			,BF_ARTICLESAPPROVED:{title:'Article Approved',width:'2%'}
			,BF_TRADENAMESUBMITTED:{title:'Trade Name Submitted',width:'2%'}
			,BF_TRADENAMERECEIVED:{title:'Trade Name Received',width:'2%'}
			,BF_MINUTESBYLAWSDRAFT:{title:'Minutes By Laws Draft',width:'2%'}
			,BF_MINUTESBYLAWSFINAL:{title:'Minutes By Laws Final',width:'2%'}
			,BF_MINUTESCOMPLETED:{title:'Minutes Completed',width:'2%'}
			,BF_DISSOLUTIONREQUESTED:{title:'Dissolution Requested',width:'2%',list:false}
			,BF_DISSOLUTIONSUBMITTED:{title:'Dissolution Submitted',width:'2%',list:false}
			,BF_DISSOLUTIONCOMPLETED:{title:'Dissolution Completed',width:'2%',list:false}
			,BF_OTHERACTIVITY:{title:'Other Activity',width:'2%'}
			,BF_OTHERSTARTED:{title:'Other Started',width:'2%'}
			,BF_OTHERCOMPLETED:{title:'Other Completed',width:'2%'}
			,BF_RECORDBOOKORDERED:{title:'Record Book Ordered',width:'2%'}
  			,BF_FEES:{title:'Fees'}
			,BF_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group4","formid":"3"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};

_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"timebillingreport.cfc",
	"title":"Accounting & Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORYTEXT:{title:'Consulting Category'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_DESCRIPTION:{title:'Description'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service',width:'2%'}
			,MC_DUEDATE:{title:'Due Date',width:'2%'}
			,MC_WORKINITIATED:{title:'Work Initiated',width:'2%'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed',width:'2%'}
			,MC_ESTTIME:{title:'Estimated Time'}
			,MC_FEES:{title:'Fees'}
			,MC_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group5","formid":"2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	
	
_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"timebillingreport.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'2%'}
			,FDS_MONTHTEXT:{title:'Month'}
			,FDS_MISSINGINFO:{title:'Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'2%'}
			,FDS_SORT:{title:'Sort',width:'2%'}
			,FDS_CHECKS:{title:'Checks',width:'2%'}
			,FDS_SALES:{title:'Sales',width:'2%'}
			,FDS_ENTRY:{title:'Entry',width:'2%'}
			,FDS_RECONCILE:{title:'Reconcile',width:'2%'}
			,FDS_COMPILE:{title:'Compilie',width:'2%'}
			,FDS_REVIEW:{title:'Review',width:'2%'}
			,FDS_ASSEMBLY:{title:'Assembly',width:'2%'}
			,FDS_DELIVERY:{title:'Delivery',width:'2%'}
			,FDS_ACCTRPT:{title:'Report',width:'2%'}
			,FDS_FEES:{title:'Fees',width:'2%'}
			,FDS_PAIDTEXT:{title:'Payment Status',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group6","formid":"5"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};
	
		
_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"timebillingreport.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FTP_CATEGORYTEXT:{title:'Category'}
			,FTP_STATUSTEXT:{title:'Status'}
			,FTP_DUEDATE:{title:'Due Date',width:'2%'}
			,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,FTP_REQUESTSERVICE:{title:'Request for Service',width:'2%'}
			,FTP_INFOREQUESTED:{title:'Information Requested',width:'2%'}
			,FTP_INFORECEIVED:{title:'Information Received',width:'2%'}
			,FTP_INFOCOMPILED:{title:'Information Compiled',width:'2%'}
			,FTP_MISSINGINFO:{title:'Missing Information',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FTP_MISSINGINFORECEIVED:{title:'Missing information Received',width:'2%'}
			,FTP_REPORTCOMPLETED:{title:'Report Completed',width:'2%'}
			,FTP_FINALCLIENTMEETING:{title:'Final Client Meeting',width:'2%'}
			,FTP_FEES:{title:'Fees'}
			,FTP_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g7_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group7","formid":"9"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};

	
_grid8=function(){_jGrid({
	"grid":"grid8",
	"url":"timebillingreport.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,N_NAME:{title:'Matter Name'}
			,NST_1_TAXYEAR:{title:'Tax Year',width:'2%'}
			,NST_1_TAXFORMTEXT:{title:'Tax Form'}
			,NST_1_NOTICENUMBER:{title:'Notice Number'}
			,NST_STATUSTEXT:{title:'Status',width:'2%'}
			,NST_MISSINGINFO:{title:'Missing Information',width:'2%'}
			,NST_1_DATENOTICEREC:{title:'Date Notice Received',width:'2%'}
			,NST_1_RESDUEDATE:{title:'Response Due Date',width:'2%'}
			,NST_2_RESSUBMITED:{title:'Response Submited',width:'2%'}
			,NST_2_REVREQUIRED:{title:'Review Required',width:'2%'}			
			,NST_FEES:{title:'Fees'}
			,NST_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g8_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group8","formid":"8"}',
	"functions":'$("#n_id").val(record.N_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID'
	})};


_grid9=function(){_jGrid({
	"grid":"grid9",
	"url":"timebillingreport.cfc",	
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Tax Form'},
			TR_2_COMPLETED:{title:'Completed',width:'2%'},
			TR_3_DELIVERED:{title:'Delivery',width:'2%'},
			TR_2_PREPAREDBYTEXT:{title:'Prepared By',width:'2%'},
			TR_CURRENTFEES:{title:'Fees'},
			TR_PAIDTEXT:{title:'Payment Status'},
			TR_4_MULTISTATERETURN:{title:'Multi State Return',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g9_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group9","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	

_grid10=function(){_jGrid({
	"grid":"grid10",
	"url":"timebillingreport.cfc",	
	"title":"PPTRs",
	"fields":{TR_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Tax Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Tax Form'},
			TR_4_COMPLETED:{title:'Completed',width:'2%'},
			TR_4_CURRENTFEES:{title:'Current Fees'},		
			TR_4_PAIDTEXT:{title:'Payment Status'},
			TR_4_DELIVERED:{title:'Delivery',width:'2%'},
			TR_4_MULTISTATERETURN:{title:'Multi State Return',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g10_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group10","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	

_grid11=function(){_jGrid({
	"grid":"grid11",
	"url":"timebillingreport.cfc",	
	"title":"State Tax Returns",
	"fields":{TRST_ID:{key:true,list:false,edit:false},
			TR_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'2%'},
			TRST_STATETEXT:{title:'State'},
			TRST_1_COMPLETED:{title:'Completed',width:'2%'},
			TRST_2_DELIVERED:{title:'Delivery',width:'2%'},
			TRST_1_PREPAREDBY:{title:'Prepared By',width:'2%'},
			TRST_2_CURRENTFEES:{title:'Fees'},
			TRST_2_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g11_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group11","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID+"&subtask1_id="+record.TRST_ID'
})};


_grid12=function(){_jGrid({
	"grid":"grid12",
	"url":"timebillingreport.cfc",	
	"title":"State Tax Returns",
	"fields":{TRST_ID:{key:true,list:false,edit:false},
			TR_ID:{list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			TR_TAXYEAR:{title:'Year',width:'2%'},
			TR_TAXFORMTEXT:{title:'Tax Form'},
			TRST_STATETEXT:{title:'State'},
			TRST_3_PPTRCOMPLETED:{title:'Completed',width:'2%'},
			TRST_3_PPTRCURRENTFEES:{title:'Current Fees'},
			TRST_2_PAIDTEXT:{title:'Payment Status'},
			TRST_3_PPTRDELIVERED:{title:'Delivery',width:'2%'}			
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g12_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group12","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID+"&subtask1_id="+record.TRST_ID'
})};


_grid13=function(){_jGrid({
	"grid":"grid13",
	"url":"timebillingreport.cfc",	
	"title":"Communications",
	"fields":{CO_ID:{key:true,list:false,edit:false},
			CLIENT_NAME:{title:'Client Name'},
			CO_CALLER:{title:'Caller'},
			CO_FORTEXT:{title:'For'},	
 			CO_FEES:{title:'Fees'},
			CO_PAIDTEXT:{title:'Payment Status'},
			CO_DATE:{title:'Date &amp; Time',width:'2%'},
			CO_TELEPHONE:{title:'Phone'},
			CO_EXT:{title:'Ext'},
			CO_EMAILADDRESS:{title:'Email'},
			CO_RESPONSENEEDED:{title:'Response Needed',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},
			CO_RETURNCALL:{title:'Returned Call',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }},		
			CO_BRIEFMESSAGE:{title:'Brief Message'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g13_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group13","formid":"12"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
})};


