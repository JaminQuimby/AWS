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
	 ,load_group13:function(){_grid13();}
}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"workinprogress.cfc",	
	"title":"Estimated Time",
	"fields":{
		NAME:{title:'Module'}
		,COUNT_ASSIGNED:{title:'Task Assigned'}
		,COUNT_SUBTASK_ASSIGNED:{title:'Subtasks Assigned'}
		,TOTAL_TIME:{title:'Estimated Time'}
		,TOTAL_SUBTAKS_TIME:{title:'Subtasks Estimated Time'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group1","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'"}',
	"functions":''
})};

_grid2=function(){_jGrid({
	"grid":"grid2",
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
			,MC_DUEDATE:{title:'Due Date',width:'2%'}
			,MC_ESTTIME:{title:'Estimated Time',width:'2%'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}									
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group2","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"2"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"workinprogress.cfc",	
	"title":"Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
 			,CAS_CATEGORYTEXT:{title:'Category'}
			,CAS_TASKDESC:{title:'Description'}
			,CAS_DUEDATE:{title:'Due Date',width:'1%'}
			,CAS_STATUSTEXT:{title:'Status'}
			,CAS_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}						
			,CAS_DATEREQESTED:{title:'Date Requested',width:'1%'}							
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group3","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"4"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
})};

_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"workinprogress.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BFS_TASKNAME:{title:'Subtask Name',width:'2%'}
			,BF_ACTIVITY:{title:'Activity'}
			,BF_OWNERS:{title:'Owners'}
			,BF_BUSINESSTYPETEXT:{title:'Business Type'}
			,BF_DUEDATE:{title:'Due Date',width:'1%'}
 			,BF_STATUSTEXT:{title:'Status'}
			,BF_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
		    ,BF_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,BF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
						
	},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group4","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"3"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};

_grid5=function(){_jGrid({
	"grid":"grid5", 
	"url":"workinprogress.cfc",	
	"title":"Communications",
	"fields":{CO_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_DATE:{title:'Date and Time'}
			,CO_DUEDATE:{title:'Due Date',width:'2%'}
			,CO_STATUSTEXT:{title:'Status',width:'2%'}
			,CO_FORTEXT:{title:'For',width:'2%'}
			,CO_RESPONSENEEDED:{title:'Response Required',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_RETURNCALL:{title:'Returned Call',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}			
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group5","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"12"}',	
	"functions":'$("#co_id").val(record.CO_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
})};



	
_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"workinprogress.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false}
  			 ,CLIENT_NAME:{title:'Client Name'}
			 ,FTP_CATEGORYTEXT:{title:'Category'}
			 ,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			 ,FTP_STATUSTEXT:{title:'Status'}
			 ,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			 ,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			 ,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group6","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"9"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};

_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"workinprogress.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
 			,CLIENT_ID:{list:false,edit:false}
 			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Period'}
			,FDS_PERIODEND:{title:'Period End',width:'1%'}
			,FDS_DUEDATE:{title:'Due Date',width:'1%'}
			,FDS_STATUSTEXT:{title:'Status'}
			,FDS_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'1%'}
			,FDS_SORT:{title:'Sort',width:'1%'}
			,FDS_CHECKS:{title:'Checks',width:'1%'}
			,FDS_SALES:{title:'Sales',width:'1%'}
			,FDS_ENTRY:{title:'Entry',width:'1%'}
			,FDS_RECONCILE:{title:'Reconciliation',width:'1%'}
			,FDS_COMPILE:{title:'Compiliation',width:'1%'}
			,FDS_REVIEW:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY:{title:'Assembly ',width:'1%'}
			,FDS_DELIVERY:{title:'Delivery',width:'1%'}
			,FDS_ACCTRPT:{title:'Report',width:'1%'}

			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group7","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"5"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};



_grid8=function(){_jGrid({
	"grid":"grid8",
	"url":"workinprogress.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,N_NAME:{title:'Matter Name'}
			,NST_1_NOTICEDATE:{title:'Notice Date',width:"1%"}
			,NST_MISSINGINFO:{title:'Missing Information Compiled',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_PRIORITY:{title:'Priority'}
			,NST_ASSIGNEDTOTEXT:{title:'Assigned To'}
			,NST_1_RESDUEDATE:{title:'Response Due'}
			,NST_ESTTIME:{title:'Estimated Time'}
			,NST_2_REVREQUIRED:{title:'Review Required',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_2_REVASSIGNEDTOTEXT:{title:'Review Assigned To'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group8","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"8"}',
	"functions":'$("#n_id").val(record.N_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID'
})};	
	
_grid9=function(){_jGrid({
	"grid":"grid9",
	"url":"workinprogress.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false}
  				,CLIENT_NAME:{title:'Client Name'}
				,OF_TAXYEAR:{title:'Tax Year'}
				,OF_PERIODTEXT:{title:'Period'}
				,OF_STATETEXT:{title:'State'}
				,OF_TYPETEXT:{title:'Type'}
				,OF_FORMTEXT:{title:'Form',width:'1%'}
				,OF_DUEDATE:{title:'Due Date',width:'1%'}
				,OF_FILINGDEADLINE:{title:'Filing Deadline',width:'1%'}
 				,OF_STATUSTEXT:{title:'Status'}
				,OF_INFORMATIONRECEIVED:{title:'Information',width:'1%'}												
				,OF_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}	
				,OF_MISSINGINFORECEIVED:{title:'Missing Info Received',width:'1%'}									
				,OF_OBTAININFO:{title:'Informtaion',width:'1%'}
				,OF_PREPARATION:{title:'Preparation',width:'1%'}
				,OF_REVIEW:{title:'Review',width:'1%'}
				,OF_ASSEMBLY:{title:'Assembly',width:'1%'}
				,OF_DELIVERY:{title:'Delivery',width:'1%'}						
				},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group9","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"11"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};
	
_grid10=function(){_jGrid({
	"grid":"grid10",
	"url":"workinprogress.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false}
 			,CLIENT_NAME:{title:'Client Name'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_DUEDATE:{title:'Due Date',width:'1%'}
 			,PC_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
 			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_OBTAININFO:{title:'Information',width:'1%'}
			,PC_PREPARATION:{title:'Preparation',width:'1%'}
			,PC_REVIEW:{title:'Review',width:'1%'}
			,PC_ASSEMBLY:{title:'Assembly',width:'1%'}
			,PC_DELIVERY:{title:'Delivery',width:'1%'}

			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group10","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"10"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};
	
_grid11=function(){_jGrid({
	"grid":"grid11",
	"url":"workinprogress.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTHTEXT:{title:'Period'}
			,PT_STATETEXT:{title:'State'}
			,PT_TYPETEXT:{title:'Return Type'}	
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,PT_OBTAININFO:{title:'Information',width:'1%'}
			,PT_ENTRY:{title:'Entry',width:'1%'}
			,PT_REC:{title:'Reconciliation',width:'1%'}
			,PT_REVIEW:{title:'Review',width:'1%'}
			,PT_ASSEMBLY:{title:'Assembly',width:'1%'}
			,PT_DELIVERY:{title:'Delivery',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group11","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"13"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};
	


_grid12=function(){_jGrid({
	"grid":"grid12",
	"url":"workinprogress.cfc",	
	"title":"Personal Property Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_4_EXTENDED:{title:'PPTR Extended',width:'2%'}
			,TR_4_COMPLETED:{title:'Completed',width:'2%'}
			,TR_TAXYEAR:{title:'Year',width:'2%'}
			,TR_TAXFORM:{title:'Form'}
			,TR_PRIORITY:{title:'Information Received',width:'2%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,TR_4_PPTRESTTIME:{title:'Estimated Time',width:'2%'}
			,TR_4_RFR:{title:'Ready For Review',width:'2%'}
			,TR_4_DELIVERED:{title:'Delivery',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group12","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};


_grid13=function(){_jGrid({
	"grid":"grid13",
	"url":"workinprogress.cfc",	
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_TAXYEAR:{title:'Tax Year',width:'1%'}
			,TR_TAXFORMTEXT:{title:'Tax Form',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}		
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}		
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}		
			,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'1%'}		
			,TR_2_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To',width:'1%'}		
			,TR_2_REVIEWED:{title:'Reviewed',width:'1%'}			
			,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}		
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}		
			,TR_3_ASSEMBLERETURN:{title:'Assembly',width:'1%'}
			,TR_3_DELIVERED:{title:'Delivery',width:'1%'}	
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":"0","loadType":"group13","userid":"'+$("#g1_assignedto").val()+'","clientid":"'+$("#client_id").val()+'","group":"'+$("#g1_group").val()+'","duedate":"'+$("#g1_duedate").val()+'","formid":"6"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};


