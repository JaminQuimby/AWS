$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""} 
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"description","t":"text","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"projectcompleted","t":"date","v":""}
,{"n":"requestforservice","t":"date","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"workinitiated","t":"date","v":""}
];$.each(grid1_config, function(idx, obj) {$('#group0 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});

	_jGrid({
	"grid":"grid1",
	"url":"acctingconsulting_report.cfc",
	"title":"Accounting &amp; Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORYTEXT:{title:'Consulting Category'}
			,MC_DESCRIPTION:{title:'Description'}
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service',width:'1%'}
			,MC_WORKINITIATED:{title:'Work Initiated',width:'1%'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed',width:'1%'}
			,MC_FEES:{title:'Fees'}
			,MC_PAIDTEXT:{title:'Payment Status'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"2"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID+"&nav=0","_blank")'
	})};