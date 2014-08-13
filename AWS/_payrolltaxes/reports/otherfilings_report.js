$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_compeltedby","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"numeric","v":""}
,{"n":"delivery_completedby","t":"numeric","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"extensioncompleted","t":"date","v":""}
,{"n":"extensiondeadline","t":"date","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"filingdeadline","t":"date","v":""}
,{"n":"form","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"period","t":"numeric","v":""}
,{"n":"preparation_assignedto","t":"numeric","v":""}
,{"n":"preparation_datecompleted","t":"date","v":""}
,{"n":"preparation_completedby","t":"numeric","v":""}
,{"n":"preparation_esttime","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"state","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"task","t":"numeric","v":""}
,{"n":"taxyear","t":"numeric","v":""}
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"otherfilings_report.cfc",
	"title":"Other Filings Status",
	"fields":{OF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_TAXYEAR:{title:'Year',width:'2%'}
			,OF_PERIODTEXT:{title:'Period'}
			,OF_STATETEXT:{title:'State'}
			,OF_TYPETEXT:{title:'Type'}
			,OF_FORMTEXT:{title:'Form',width:'2%'}			
			,OF_DUEDATE:{title:'Due Date',width:'2%'}
			,OF_FILINGDEADLINE:{title:'Filing Deadline',width:'2%'}
			,OF_STATUSTEXT:{title:'Status'}
			,OF_MISSINGINFO:{title:'Missing Info',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,OF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
			,OF_OBTAININFO:{title:'Information',width:'2%'}
			,OF_PREPARATION:{title:'Preparation',width:'2%'}
			,OF_REVIEW:{title:'Review',width:'2%'}
			,OF_ASSEMBLY:{title:'Assembly',width:'2%'}
			,OF_DELIVERY:{title:'Delivery',width:'2%'}
			,OF_FEES:{title:'Fees'}
			,OF_PAIDTEXT:{title:'Payment Status'}
			,OF_PRIORITY:{title:'Priority'}
			,OF_ESTTIME:{title:'Estimated Time'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"11"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID+"&nav=0","_blank")'
	})};