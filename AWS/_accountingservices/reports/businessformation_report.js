$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
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
];
 
	_jGrid({
	"grid":"grid1",
	"url":"businessformation_report.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_STATUS:{title:'Status',width:'1%'}
			,BF_ASSIGNEDTO:{title:'Assignedto',width:'1%'}
 			,BF_DATEINITIATED:{title:'Date Initiated',width:'1%'}
 			,BF_BUSINESSTYPE:{title:'Business Type',width:'1%'}
 			,BF_BUSINESSSUBMITTED:{title:'Form Submitted',width:'1%'}
 			,BF_BUSINESSRECEIVED:{title:'Form Received',width:'1%'}
			,BF_ARTICLESSUBMITTED:{title:'Article Submitted',width:'1%'}
			,BF_ARTICLESAPPROVED:{title:'Article Approved',width:'1%'}
			,BF_TRADENAMESUBMITTED:{title:'Trade Name Submitted',width:'1%'}
			,BF_TRADENAMERECEIVED:{title:'Trade Name Received',width:'1%'}
			,BF_MINUTESBYLAWSDRAFT:{title:'Minutes By Laws Draft',width:'1%'}
			,BF_MINUTESBYLAWSFINAL:{title:'Minutes By Laws Final',width:'1%'}
			,BF_MINUTESCOMPLETED:{title:'Minutes Completed',width:'1%'}
			,BF_DISSOLUTIONREQUESTED:{title:'Dissolution Requested',width:'1%',list:false}
			,BF_DISSOLUTIONSUBMITTED:{title:'Dissolution Submitted',width:'1%',list:false}
			,BF_DISSOLUTIONCOMPLETED:{title:'Dissolution Completed',width:'1%',list:false}
			,BF_OTHERACTIVITY:{title:'Other Activity',width:'1%'}
			,BF_OTHERSTARTED:{title:'Other Started',width:'1%'}
			,BF_OTHERCOMPLETED:{title:'Other Completed',width:'1%'}
			,BF_RECORDBOOKORDERED:{title:'Record Book Ordered',width:'1%'}
  			,BF_FEES:{title:'Fees'}
			,BF_PAID:{title:'Payment Status'}
},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"3"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID+"&nav=0","_blank")'
	})};