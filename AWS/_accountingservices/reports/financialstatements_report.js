$(document).ready(function(){
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"financialstatements_report.cfc",
	"title":"Financial Reporting",
	"fields":{FDS_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name',width:'20%'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTH:{title:'Month',width:'10%'}
			,FDS_MISSINGINFO:{title:'Missing Info',width:'5%'}
			,FDS_COMPILEMI:{title:'Compile Missing Info',width:'5%'}
			,FDS_OBTAININFO_DATECOMPLETED:{title:'Info',width:'1%'}
			,FDS_SORT_DATECOMPLETED:{title:'Sort',width:'1%'}
			,FDS_CHECKS_DATECOMPLETED:{title:'Checks',width:'1%'}
			,FDS_SALES_DATECOMPLETED:{title:'Sales',width:'1%'}
			,FDS_ENTRY_DATECOMPLETED:{title:'Entry',width:'1%'}
			,FDS_RECONCILE_DATECOMPLETED:{title:'Reconcile',width:'1%'}
			,FDS_COMPILE_DATECOMPLETED:{title:'Compilie',width:'1%'}
			,FDS_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,FDS_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,FDS_ACCTRPT_DATECOMPLETED:{title:'Report',width:'1%'}
			,FDS_FEES:{title:'Fees',width:'9%'}
			,FDS_PAYMENTSTATUS:{title:'Payment Status',width:'10%'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};