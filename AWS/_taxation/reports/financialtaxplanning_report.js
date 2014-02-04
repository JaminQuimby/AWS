$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"finalclientmeeting","t":"date","v":""}
,{"n":"infocompiled","t":"date","v":""}
,{"n":"inforeceived","t":"date","v":""}
,{"n":"inforequested","t":"date","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reportcompleted","t":"date","v":""}
,{"n":"requestservice","t":"date","v":""}
,{"n":"status","t":"numeric","v":""}

];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
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
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"9"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID+"&nav=0","_blank")'
	})};

