$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"acctrpt_assignedto","t":"numeric","v":""}
,{"n":"acctrpt_completedby","t":"numeric","v":""}
,{"n":"acctrpt_datecompleted","t":"date","v":""}
,{"n":"acctrpt_esttime","t":"numeric","v":""}
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_completedby","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"checks_assignedto","t":"numeric","v":""}
,{"n":"checks_completedby","t":"numeric","v":""}
,{"n":"checks_datecompleted","t":"date","v":""}
,{"n":"checks_esttime","t":"numeric","v":""}	  
,{"n":"compilemi","t":"boolean","v":""}
,{"n":"compile_assignedto","t":"numeric","v":""}
,{"n":"compile_completedby","t":"numeric","v":""}
,{"n":"compile_datecompleted","t":"date","v":""}
,{"n":"compile_esttime","t":"numeric","v":""}
,{"n":"cmireceived","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"entry_assignedto","t":"numeric","v":""}
,{"n":"entry_completedby","t":"numeric","v":""}
,{"n":"entry_datecompleted","t":"date","v":""}
,{"n":"entry_esttime","t":"numeric","v":""} 
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"month","t":"numeric","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"periodend","t":"date","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reconcile_assignedto","t":"numeric","v":""}
,{"n":"reconcile_completedby","t":"numeric","v":""}
,{"n":"reconcile_datecompleted","t":"date","v":""}
,{"n":"reconcile_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_esttime","t":"numeric","v":""}  
,{"n":"sales_assignedto","t":"numeric","v":""}
,{"n":"sales_completedby","t":"numeric","v":""}
,{"n":"sales_datecompleted","t":"date","v":""}
,{"n":"sales_esttime","t":"numeric","v":""}	  
,{"n":"sort_assignedto","t":"numeric","v":""}
,{"n":"sort_completedby","t":"numeric","v":""}
,{"n":"sort_datecompleted","t":"date","v":""}
,{"n":"sort_esttime","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"year","t":"numeric","v":""}
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 

 
	_jGrid({
	"grid":"grid1",
	"url":"financialstatements_report.cfc",
	"title":"Financial Statement Status",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Period'}
			,FDS_PERIODEND:{title:'Period End',width:'1%'}
			,FDS_DUEDATE:{title:'Due Date',width:'1%'}
			,FDS_STATUSTEXT:{title:'Status'}
			,FDS_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'1%'}
			,FDS_SORT:{title:'Sort',width:'1%'}
			,FDS_CHECKS:{title:'Checks',width:'1%'}
			,FDS_SALES:{title:'Sales',width:'1%'}
			,FDS_ENTRY:{title:'Entry',width:'1%'}
			,FDS_RECONCILE:{title:'Reconcile',width:'1%'}
			,FDS_COMPILE:{title:'Compilie',width:'1%'}
			,FDS_REVIEW:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY:{title:'Assembly',width:'1%'}
			,FDS_DELIVERY:{title:'Delivery',width:'1%'}
			,FDS_ACCTRPT:{title:'Report',width:'1%'}
			,FDS_FEES:{title:'Fees'}
			,FDS_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"5"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialStatements.cfm?task_id="+record.FDS_ID+"&nav=0","_blank")'
	})
	

	};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"financialstatements_report.cfc",
	"title":"Financial Data Status ",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Month'}
			,FDS_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'1%'}
			,FDS_SORT:{title:'Sort',width:'1%'}
			,FDS_CHECKS:{title:'Checks',width:'1%'}
			,FDS_SALES:{title:'Sales',width:'1%'}
			,FDS_ENTRY:{title:'Entry',width:'1%'}
			,FDS_RECONCILE:{title:'Reconcile',width:'1%'}
			,FDS_COMPILE:{title:'Compilie',width:'1%'}
			,FDS_REVIEW:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY:{title:'Assembled',width:'1%'}
			,FDS_DELIVERY:{title:'Delivered',width:'1%'}
			,FDS_ACCTRPT:{title:'Report',width:'1%'}
			,FDSS_SUBTASKTEXT:{title:'Subtask',width:'1%'}
			,FDSS_STATUSTEXT:{title:'Status',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"5"}',
	"functions":''
	})};