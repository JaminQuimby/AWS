$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"acctingconsulting_report.cfc",
	"title":"Accounting &amp; Consulting",
	"fields":{MC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORY:{title:'Consulting Category'}
			,MC_ASSIGNEDTO:{title:'Assigned To',width:'1%'}
			,MC_STATUS:{title:'Status'}
			,MC_DESCRIPTION:{title:'Description'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service',width:'1%'}
			,MC_DUEDATE:{title:'Due Date',width:'1%'}
			,MC_WORKINITIATED:{title:'Work Initiated',width:'1%'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed',width:'1%'}
			,MC_ESTIMATEDTIME:{title:'Estimated Time'}
			,MC_FEES:{title:'Fees'}
			,MC_PAID:{title:'Payment Status'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};