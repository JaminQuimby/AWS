$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"administrativetasks_report.cfc",
	"title":"Administrative Tasks Report",
	"fields":{CAS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CAS_DUEDATE:{title:'Due Date'}
			,CAS_PRIORITY:{title:'Priority'}
			,CAS_ASSIGNTO:{title:'Assigned To',width:'1%'}
			,CAS_STATUS:{title:'Status',width:'1%'}
			,CAS_DATEREQESTED:{title:'Date Requested',width:'1%'}
			,CAS_COMPLETED:{title:'Completed'}
			,CAS_TASKDESC:{title:'Description'}
			,CAS_INSTRUCTIONS:{title:'Instructions'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.CAS_ID'
	})};

