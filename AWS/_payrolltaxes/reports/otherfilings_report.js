$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"otherfilings_report.cfc",
	"title":"Other Filings Status",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_TAXYEAR:{title:'Year',width:'1%'}
			,OF_PERIOD:{title:'Period'}
			,OF_STATE:{title:'State'}
			,OF_FORM:{title:'Form',width:'1%'}
			,OF_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,OF_MISSINGINFO:{title:'Missing Info',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,OF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,OF_PREPARATION_DATECOMPLETED:{title:'Preparation',width:'1%'}
			,OF_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,OF_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,OF_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,OF_FEES:{title:'Fees'}
			,OF_ESTTIME:{title:'Estimated Time'}
			,OF_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID+"&nav=0","_blank")'
	})};


