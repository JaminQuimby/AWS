
$(document).ready(function(){
_grid1();
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
	
});

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"historical.cfc",	
	"title":"Administrative Tasks",
	"fields":{CAS_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client'}
			,CAS_DUEDATE:{title:'Due Date',width:'1%'}
			,CAS_PRIORITY:{title:'Priority',width:'1%'}
			,CAS_STATUS:{title:'Status'}
			,CAS_TASKDESC:{title:'Description'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"historical.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
	,CLIENT_ID:{list:false,edit:false}
	,CLIENT_NAME:{title:'Client Name'}
	,BF_ACTIVITY:{title:'Activity'}
	,BF_STATUS:{title:'Status'}
	,BF_DUEDATE:{title:'Due Date',width:'1%'}
	,BF_FEES:{title:'Fees'}
	,BF_PAID:{title:'Paid'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group2"}',
	"functions":'$("#bf_id").val(record.BF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID'
})};

_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"historical.cfc",	
	"title":"Communications Dashboard",
	"fields":{CO_ID:{key:true,list:false,edit:false}
	,CLIENT_NAME:{title:'Client Name'}
	,CO_CALLER:{title:'Caller'}
	,CO_CREDITHOLD:{title:'Credit Hold',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
	,CO_FEES:{title:'Fees'}
	,CO_PAID:{title:'Paid'}
	,CO_DATE:{title:'Date &amp; Time'}
	,CO_TELEPHONE:{title:'Phone'}
	,CO_EXT:{title:'Ext'}
	,CO_EMAILADDRESS:{title:'Email'}
	,CO_RESPONSENEEDED:{title:'Response Needed',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
	,CO_RETURNCALL:{title:'Returned Call',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
	,CO_BRIEFMESSAGE:{title:'Brief Message'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
})};


_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"historical.cfc",
	"title":"Client Maintenance",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_TYPE:{title:'Client Type',width:"1%"}
			,CLIENT_TRADE_NAME:{title:'Trade Name'}
			,CLIENT_ACTIVE:{title:'Active',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SALUTATION:{title:'Salutation'}
			,CLIENT_SPOUSE:{title:'Spouse'}
			,CLIENT_CREDIT_HOLD:{title:'Credit Hold',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_C:{title:'Business (C)',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_E:{title:'Rental Property (E)',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_DISREGARD:{title:'Disregarded',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_PERSONAL_PROPERTY:{title:'Personal Property',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group4"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?client_id="+record.CLIENT_ID'
	})};  
	
	
_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"historical.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FTP_CATEGORY:{title:'Category'}
			,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			,FTP_INFORECEIVED:{title:'Information Received',width:'1%'}
			,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FTP_STATUS:{title:'Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group5"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
})};


_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"historical.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Month'}
			,FDS_DUEDATE:{title:'Due Date',width:'1%'}
			,FDS_MIRECEIVED:{title:'Missing Information Received',width:'1%'}
			,FDS_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_CMIRECEIVED:{title:'Compiled Missing Information Received',width:'1%'}
			,FDS_COMPILEMI:{title:'Missing Information Compiled',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group6"}',
	"functions":'$("#fds_id").val(record.FDS_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
})};

_grid7=function(){_jGrid({
	"grid":"grid7",
	"url":"historical.cfc",
	"title":"Accounting &amp; Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}
			,MC_STATUS:{title:'Status'}
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g7_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group7"}',
	"functions":'$("#mc_id").val(record.MC_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID'
})};	
	
_grid8=function(){_jGrid({
	"grid":"grid8",
	"url":"historical.cfc",
	"title":"Notices",
	"fields":{NM_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,NM_NAME:{title:'Matter Name'}
			,NM_STATUS:{title:'Notice Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g8_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group8"}',
	"functions":'$("#nm_id").val(record.NM_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
})};
	
	
_grid9=function(){_jGrid({
	"grid":"grid9",
	"url":"historical.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_TAXYEAR:{title:'Tax Year',width:'1%'}
			,OF_STATE:{title:'State'}
			,OF_TASK:{title:'Task'}
			,OF_FORM:{title:'Form'}
			,OF_STATUS:{title:'Status'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g9_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group9"}',
	"functions":'$("#of_id").val(record.OF_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
})};

	
_grid10=function(){_jGrid({
	"grid":"grid10",
	"url":"historical.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_MISSINGRECEIVED:{title:'Information Received',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g10_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group10"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID'
})};
	
	
_grid11=function(){_jGrid({
	"grid":"grid11",
	"url":"historical.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTH:{title:'Month'}
			,PT_TYPE:{title:'Type'}
			,PT_PAYMENTSTATUS:{title:'Status'}
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_DELIVERY_DATECOMPLETED:{title:'Completed',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g11_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group11"}',
	"functions":'$("#pt_id").val(record.PT_ID); window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID'
})};
	

_grid12=function(){_jGrid({
	"grid":"grid12",
	"url":"historical.cfc",	
	"title":"Tax Returns Ready For Data Entry",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_TAXYEAR:{title:'Year',width:'1%'}
			,TR_TAXFORM:{title:'Form'}
			,TR_1_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}
			,TR_PRIORFEES:{title:'Prior Fees',width:'1%'}
			,TR_4_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'1%'}
			,TR_4_PICKUPAPPOINTMENT:{title:'Pick UP Appointment',width:'1%'}
			,TR_1_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,TR_1_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_1_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g12_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group12"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID'
})};	
	























