$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check Status",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Info',width:'1%'}
			,PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,PC_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,PC_FEES:{title:'Fees'}
			,PC_PAYMENTSTATUS:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};