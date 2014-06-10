$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
}
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}
,{"n":"year","t":"numeric","v":""}
,{"n":"month","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"type","t":"numeric","v":""}
,{"n":"lastpay","t":"date","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"numeric","v":""}
,{"n":"fees","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"entry_assignedto","t":"numeric","v":""}
,{"n":"entry_datecompleted","t":"date","v":""}
,{"n":"entry_completedby","t":"numeric","v":""}
,{"n":"entry_esttime","t":"numeric","v":""}
,{"n":"rec_assignedto","t":"numeric","v":""}
,{"n":"rec_datecompleted","t":"date","v":""}
,{"n":"rec_completedby","t":"numeric","v":""}
,{"n":"rec_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_completedby","t":"numeric","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"numeric","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_completedby","t":"numeric","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
];$.each(grid1_config, function(idx, obj) {$('#group1 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});

	_jGrid({
	"grid":"grid1",
	"url":"payrolltaxes_report.cfc",
	"title":"Payroll Taxes Status",
	"fields":{PT_ID:{key:true,list:false,edit:false}
		,CLIENT_NAME:{title:'Client Name'}
		,PT_YEAR:{title:'Year',width:'2%'}
		,PT_MONTHTEXT:{title:'Period'}
		,PT_STATETEXT:{title:'State'}
		,PT_TYPETEXT:{title:'Type'}
		,PT_LASTPAY:{title:'Last Pay',width:'2%'}
		,PT_DUEDATE:{title:'Due Date',width:'2%'}
 		,PT_MISSINGINFO:{title:'Missing Info',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		,PT_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
		,PT_OBTAININFO:{title:'Information',width:'2%'}
		,PT_ENTRY:{title:'Entry',width:'2%'}
		,PT_REC:{title:'Reconciliation',width:'2%'}
		,PT_REVIEW:{title:'Review',width:'2%'}
		,PT_ASSEMBLY:{title:'Assembly',width:'2%'}
		,PT_DELIVERY:{title:'Delivery',width:'2%'}
		,PT_FEES:{title:'Fees'}
		,PT_PAIDTEXT:{title:'Payment Status'}
		,PT_PRIORITY:{title:'Priority'}
		,PT_ESTTIME:{title:'Estimated Time'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"13"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID+"&nav=0","_blank")'
	})};