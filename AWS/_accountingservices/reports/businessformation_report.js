$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"activity","t":"text","v":""}
,{"n":"articlesapproved","t":"date","v":""}
,{"n":"articlessubmitted","t":"date","v":""}
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"businessreceived","t":"date","v":""}
,{"n":"businesssubmitted","t":"date","v":""}
,{"n":"businesstype","t":"text","v":""}
,{"n":"dateinitiated","t":"date","v":""}
,{"n":"dissolutioncompleted","t":"date","v":""}
,{"n":"dissolutionrequested","t":"date","v":""}
,{"n":"dissolutionsubmitted","t":"date","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"minutesbylawsdraft","t":"date","v":""}
,{"n":"minutesbylawsfinal","t":"date","v":""}
,{"n":"minutescompleted","t":"date","v":""}
,{"n":"otheractivity","t":"date","v":""}
,{"n":"othercomplete","t":"date","v":""}
,{"n":"otherstarted","t":"date","v":""}
,{"n":"owners","t":"text","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"tradenamereceived","t":"date","v":""}
,{"n":"tradenamesubmitted","t":"date","v":""}
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"businessformation_report.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_ACTIVITY:{title:'Activity'}
			,BF_OWNERS:{title:'Owners',width:'2%'}
 			,BF_BUSINESSTYPETEXT:{title:'Business Type',width:'2%'}
			,BF_DUEDATE:{title:'Due Date',width:'2%'}
			,BF_STATUSTEXT:{title:'Status',width:'2%'}
			,BF_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
		    ,BF_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,BF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}				
			,BF_ARTICLESAPPROVED:{title:'Article Approved',width:'2%'}
			,BF_TRADENAMERECEIVED:{title:'Trade Name Received',width:'2%'}
			,BF_MINUTESCOMPLETED:{title:'Minutes Completed',width:'2%'}
			,BF_DISSOLUTIONCOMPLETED:{title:'Dissolution Completed',width:'2%',list:false}
  			,BF_PRIORITY:{title:'Priority'}
			,BF_ESTTIME:{title:'Estimated Time'}
},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"3"}',
	"functions":' window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessformation.cfm?task_id="+record.BF_ID,\'WIPPOP\');'
	})};