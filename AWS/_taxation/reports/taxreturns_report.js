$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"currentfees","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"extensiondone","t":"date","v":""}
,{"n":"extensionrequested","t":"date","v":""}
,{"n":"notrequired","t":"boolean","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"priorfees","t":"numeric","v":""}
,{"n":"taxform","t":"numeric","v":""}
,{"n":"taxyear","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"filingdeadline","t":"date","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"reason","t":"text","v":""}
,{"n":"1_dropoffappointment","t":"date","v":""}
,{"n":"1_dropoffappointmentlength","t":"numeric","v":""}
,{"n":"1_dropoffappointmentwith","t":"numeric","v":""}
,{"n":"1_whileyouwaitappt","t":"date","v":""}
,{"n":"1_pickupappointment","t":"date","v":""}
,{"n":"1_pickupappointmentlength","t":"numeric","v":""}
,{"n":"1_pickupappointmentwith","t":"numeric","v":""}
,{"n":"2_assignedto","t":"numeric","v":""}
,{"n":"2_completed","t":"date","v":""}
,{"n":"2_informationreceived","t":"date","v":""}
,{"n":"2_preparedby","t":"numeric","v":""}
,{"n":"2_readyforreview","t":"date","v":""}
,{"n":"2_reviewassignedto","t":"numeric","v":""}
,{"n":"2_reviewed","t":"date","v":""}
,{"n":"2_reviewedby","t":"numeric","v":""}
,{"n":"2_reviewedwithnotes","t":"date","v":""}
,{"n":"3_assemblereturn","t":"date","v":""}
,{"n":"3_contacted","t":"date","v":""}
,{"n":"3_delivered","t":"date","v":""}
,{"n":"3_emailed","t":"boolean","v":""}
,{"n":"3_messageleft","t":"boolean","v":""}
,{"n":"3_missingsignatures","t":"boolean","v":""}
,{"n":"3_multistatereturn","t":"boolean","v":""}
,{"n":"4_assignedto","t":"numeric","v":""}
,{"n":"4_completed","t":"date","v":""}
,{"n":"4_currentfees","t":"numeric","v":""}
,{"n":"4_delivered","t":"date","v":""}
,{"n":"4_extended","t":"date","v":""}
,{"n":"4_paid","t":"numeric","v":""}
,{"n":"4_pptresttime","t":"numeric","v":""}
,{"n":"4_priorfees","t":"numeric","v":""}
,{"n":"4_required","t":"boolean","v":""}
,{"n":"4_rfr","t":"date","v":""}
,{"n":"4_extensionrequested","t":"date","v":""}
,{"n":"4_completedby","t":"numeric","v":""}
,{"n":"4_reviewassigned","t":"numeric","v":""}
,{"n":"4_reviewed","t":"date","v":""}
,{"n":"4_reviewedby","t":"numeric","v":""}
]; $.each(grid1_config, function(idx, obj) {$('#group1 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
	_jGrid({
	"grid":"grid1",
	"url":"taxreturns_report.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
		,CLIENT_NAME:{title:'Client Name'}
		,TR_TAXYEAR:{title:'Year',width:'2%'}
		,TR_TAXFORMTEXT:{title:'Form'}
		,TR_DUEDATE:{title:'Due Date',width:'2%'}
		,TR_2_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
		,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'}
		,TR_MISSINGINFO:{title:'Missing Information',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
		,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'2%'}
		,TR_2_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To',width:'2%'}
		,TR_2_REVIEWED:{title:'Reviewed'}			
		,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'2%'}
		,TR_2_COMPLETED:{title:'Completed',width:'2%'}
		,TR_3_ASSEMBLERETURN:{title:'Assembly',width:'2%'}
		,TR_3_DELIVERED:{title:'Delivery',width:'2%'}
		,TR_DELIVERYMETHODTEXT:{title:'Delivery Method'}
		,TR_PRIORFEES:{title:'Prior Fees'}
		,TR_CURRENTFEES:{title:'Current Fees'}
		,TR_PAIDTEXT:{title:'Payment Status'}
		,TR_EXTENSIONREQUESTED:{title:'Extension Requested',width:'2%'}
		,TR_EXTENSIONDONE:{title:'Extension Completed',width:'2%'}
		,TR_3_MULTISTATERETURN:{title:'Multi-State Return',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_4_REQUIRED:{title:'PPTR Required',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_4_COMPLETED:{title:'PPTR Completed',width:'2%'}
		,TR_4_DELIVERED:{title:'PPTR Delivery',width:'2%'}	
		,TR_PRIORITY:{title:'Priority',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_ESTTIME:{title:'Estimated Time',width:'2%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"6"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID+"&nav=0","_blank")'
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"taxreturns_report.cfc",
	"title":"State Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
		,CLIENT_NAME:{title:'Client Name'}
		,CLIENT_TYPETEXT:{title:'Client Type'}
		,TR_TAXYEAR:{title:'Year',width:'2%'}
		,TR_TAXFORMTEXT:{title:'Form'}
		,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'}
		,TR_2_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
		,TR_PRIORFEES:{title:'Prior Fees'}
		,TR_1_DROPOFFAPPOINTMENT:{title:'Drop Off Appointment',width:'2%'}
		,TR_1_PICKUPAPPOINTMENT:{title:'Pick Up Appointment',width:'2%'}
		,TR_MISSINGINFO:{title:'Missing Information',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
		,TR_DUEDATE:{title:'Due Date',width:'2%'}
		,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'2%'}
		,TR_EXTENSIONREQUESTED:{title:'Extension Requested',width:'2%'}
		,TR_EXTENSIONDONE:{title:'Extension Done',width:'2%'}
		,TR_3_MISSINGSIGNATURES:{title:'Missing Signatures',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_3_ASSEMBLERETURN:{title:'Assembly',width:'2%'}
		,TR_3_CONTACTED:{title:'Contacted',width:'2%'}
		,TR_2_PREPAREDBYTEXT:{title:'Prepared By',width:'2%'}
		,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'2%'}
		,TR_2_COMPLETED:{title:'Completed',width:'2%'}
		,TR_3_DELIVERED:{title:'Delivery',width:'2%'}
		,TR_FILINGDEADLINE:{title:'Filing Deadline',width:'2%'}
		,TR_4_REQUIRED:{title:'PPTR Required',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,TR_4_EXTENDED:{title:'PPTR Extended',width:'2%'}
		,TR_4_RFR:{title:'PPTR Ready For Review',width:'2%'}
		,TR_4_COMPLETED:{title:'PPTR Completed',width:'2%'}
		,TR_4_DELIVERED:{title:'PPTR Delivery',width:'2%'}	
		,TRST_STATETEXT:{title:'State'}	
		,TRST_PRIMARY:{title:'Primary State',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}	
		,TRST_COMPLETED:{title:'State Return Completed',width:'2%'}	
		,TR_4_CURRENTFEES:{title:'PPTR Current Fees'}
		,TR_CURRENTFEES:{title:'Current Fees'}
		,TR_PAIDTEXT:{title:'Payment Status'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"6"}',
	"functions":''
	})};