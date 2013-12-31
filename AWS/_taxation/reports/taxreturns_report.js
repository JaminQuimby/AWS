$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"taxreturns_report.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_TYPE:{title:'Client Type'}
			,TR_TAXYEAR:{title:'Year',width:'1%'}
			,TR_TAXFORM:{title:'Form'}
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}
			,TR_2_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,TR_PRIORFEES:{title:'Prior Fees'}
			,TR_1_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'1%'}
			,TR_1_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'1%'}
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'1%'}
			,TR_EXTENSIONREQUESTED:{title:'Extension Requested',width:'1%'}
			,TR_EXTENSIONDONE:{title:'Extension Done',width:'1%'}
			,TR_3_MISSINGSIGNATURES:{title:'Missing Signatures',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_3_ASSEMBLERETURN:{title:'Assembled',width:'1%'}
			,TR_3_CONTACTED:{title:'Contacted',width:'1%'}
			,TR_2_PREPAREDBY:{title:'Prepared By',width:'1%'}
			,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}
			,TR_3_DELIVERED:{title:'Delivered',width:'1%'}
			,TR_FILINGDEADLINE:{title:'Filing Deadline',width:'1%'}
			,TR_4_REQUIRED:{title:'PPTR Required',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_4_EXTENDED:{title:'PPTR Extended',width:'1%'}
			,TR_4_RFR:{title:'PPTR Ready For Review',width:'1%'}
			,TR_4_COMPLETED:{title:'PPTR Completed',width:'1%'}
			,TR_4_DELIVERED:{title:'PPTR Delivered',width:'1%'}	
			,TR_4_CURRENTFEES:{title:'PPTR Current Fees'}
			,TR_CURRENTFEES:{title:'Current Fees'}
			,TR_PAID:{title:'Payment Status'}
},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID+"&nav=0","_blank")'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxreturns_report.cfc",
	"title":"State Tax Returns",
	"fields":{TR_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_TYPE:{title:'Client Type'}
			,TR_TAXYEAR:{title:'Year',width:'1%'}
			,TR_TAXFORM:{title:'Form'}
			,TR_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}
			,TR_2_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,TR_PRIORFEES:{title:'Prior Fees'}
			,TR_1_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'1%'}
			,TR_1_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'1%'}
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'1%'}
			,TR_EXTENSIONREQUESTED:{title:'Extension Requested',width:'1%'}
			,TR_EXTENSIONDONE:{title:'Extension Done',width:'1%'}
			,TR_3_MISSINGSIGNATURES:{title:'Missing Signatures',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_3_ASSEMBLERETURN:{title:'Assembled',width:'1%'}
			,TR_3_CONTACTED:{title:'Contacted',width:'1%'}
			,TR_2_PREPAREDBY:{title:'Prepared By',width:'1%'}
			,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}
			,TR_3_DELIVERED:{title:'Delivered',width:'1%'}
			,TR_FILINGDEADLINE:{title:'Filing Deadline',width:'1%'}
			,TR_4_REQUIRED:{title:'PPTR Required',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_4_EXTENDED:{title:'PPTR Extended',width:'1%'}
			,TR_4_RFR:{title:'PPTR Ready For Review',width:'1%'}
			,TR_4_COMPLETED:{title:'PPTR Completed',width:'1%'}
			,TR_4_DELIVERED:{title:'PPTR Delivered',width:'1%'}	
			,TRST_STATE:{title:'State'}	
			,TRST_PRIMARY:{title:'Primary State',width:'1%'}	
			,TRST_COMPLETED:{title:'State Return Completed',width:'1%'}	
			,TR_3_CURRENTFEES:{title:'PPTR Current Fees'}
			,TR_CURRENTFEES:{title:'Current Fees'}
			,TR_PAID:{title:'Payment Status'}
},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":''
	})};




