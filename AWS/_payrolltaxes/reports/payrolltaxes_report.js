$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"payrolltaxes_report.cfc",
	"title":"Payroll Taxes Status",
	"fields":{PT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_TYPE:{title:'Type'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTH:{title:'Month'}
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Info',width:'1%'}
			,PT_MISSINGRECEIVED:{title:'Missing Information Received',width:'1%'}
			,PT_ENTRY_DATECOMPLETED:{title:'Entry',width:'1%'}
			,PT_REC_DATECOMPLETED:{title:'Reconcile',width:'1%'}
			,PT_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,PT_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,PT_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,PT_FEES:{title:'Fees'}
			,PT_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};