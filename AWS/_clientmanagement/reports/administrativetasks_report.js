$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"completed","t":"date","v":""}
,{"n":"datereqested","t":"date","v":""}
,{"n":"datestarted","t":"date","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"instructions","t":"text","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reqestby","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"taskdesc","t":"text","v":""}
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"administrativetasks_report.cfc",
	"title":"Administrative Tasks Report",
	"fields":{AS_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,AS_CATEGORYTEXT:{title:'Category'}
			,AS_TASKDESC:{title:'Description'}
			,AS_DUEDATE:{title:'Due Date',width:'2%'}
			,AS_STATUSTEXT:{title:'Status',width:'2%'}
			,AS_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,AS_DATEREQESTED:{title:'Date Requested',width:'2%'}
			,AS_DATESTARTED:{title:'Date Started',width:'2%'}
 			,AS_COMPLETED:{title:'Completed',width:'2%'}
			,AS_INSTRUCTIONS:{title:'Instructions'}
			,AS_PRIORITY:{title:'Priority'}
			,AS_ESTTIME:{title:'Estimated Time'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"4"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.AS_ID,\'WIPPOP\');'
	})};