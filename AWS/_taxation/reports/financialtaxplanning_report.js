$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialtaxplanning_report.cfc",
	"title":"Financial Tax Planning",
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
			,FTP_MISSINGINFORECEIVED:{title:'Missing information Received',width:'1%'}
			,FTP_REPORTCOMPLETED:{title:'Report Completed',width:'1%'}
			,FTP_FINALCLIENTMEETING:{title:'Final Client Meeting',width:'1%'}
			,FTP_FEES:{title:'Fees'}
			,FTP_PAID:{title:'Payment Status'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
	})};

