$(document).ready(function(){

	
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){

var grid1_config = [
{"n":"search","t":"text","v":""}
,{"n":"altfreq","t":"boolean","v":""}
,{"n":"assembly_assignedto","t":"date","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_completedby","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"clientname","t":"date","v":""}
,{"n":"datedue","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"date","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_completedby","t":"date","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
,{"n":"esttime","t":"date","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"obtaininfo_assignedto","t":"date","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"date","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"text","v":""}
,{"n":"payenddate","t":"date","v":""}
,{"n":"paydate","t":"date","v":""}
,{"n":"preparation_assignedto","t":"date","v":""}
,{"n":"preparation_datecompleted","t":"date","v":""}
,{"n":"preparation_completedby","t":"date","v":""}
,{"n":"preparation_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"date","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"date","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"year","t":"numeric","v":""}
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});


	_jGrid({
	"grid":"grid1",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check Status",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PC_OBTAININFO:{title:'Information Received',width:'1%'}
			,PC_ASSEMBLY:{title:'Assembled',width:'1%'}
			,PC_DELIVERY:{title:'Delivered',width:'1%'}
			,PC_FEES:{title:'Fees'}
			,PC_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"10"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID+"&nav=0","_blank")'
	})};