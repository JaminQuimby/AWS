$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
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
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessFormation.cfm?task_id="+record.BF_ID+"&nav=0","_blank")'
	})};