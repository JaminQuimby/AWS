$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
}
 
 
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
	"title":"Financial & Tax Planning",
	"fields":{FTP_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FTP_CATEGORYTEXT:{title:'Category'}
			,FTP_DUEDATE:{title:'Due Date',width:'2%'}
			,FTP_STATUSTEXT:{title:'Status'}
			,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,FTP_REQUESTSERVICE:{title:'Request for Service',width:'2%'}
			,FTP_MISSINGINFO:{title:'Missing Information',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FTP_INFOREQUESTED:{title:'Information Requested',width:'2%'}
			,FTP_INFORECEIVED:{title:'Information Received',width:'2%'}
			,FTP_INFOCOMPILED:{title:'Information Compiled',width:'2%'}
			,FTP_REPORTCOMPLETED:{title:'Report Completed',width:'2%'}
			,FTP_FINALCLIENTMEETING:{title:'Final Client Meeting',width:'2%'}
			,FTP_FEES:{title:'Fees'}
			,FTP_PAIDTEXT:{title:'Payment Status'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"9"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID+"&nav=0","_blank")'
	})};

