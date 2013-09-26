$(document).ready(function(){
	
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
_group3=function(){_grid3()}
_group4=function(){_grid4()}
_group5=function(){_grid5()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check Status",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name',width:'20%'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'9%'}
			,PC_PAYDATE:{title:'Pay Date',width:'9%'}
			,PC_MISSINGINFO:{title:'Missing Information',width:'9%'}
			,PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'9%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'9%'}
			,PC_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'9%'}
			,PC_FEES:{title:'Fees',width:'9%'}
			,PC_PAYMENTSTATUS:{title:'Payment Status',width:'9%'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group1"}',
	"functions":''
	})};

_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check - Current Employee",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_DATEDUE:{title:'Due Date'},PC_YEAR:{title:'Year'},PC_PAYENDDATE:{title:'Pay End'},PC_PAYDATE:{title:'Pay Date'},PC_MISSINGINFO:{title:'Missing Information'},PC_OBTAININFO_DATECOMPLETED:{title:'Information Received'},PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled'},PC_DELIVERY_DATECOMPLETED:{title:'Delivered'},PC_FEES:{title:'Fees'},PC_PAYMENTSTATUS:{title:'Payment Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":''
	})};
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check - Unassigned",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_DATEDUE:{title:'Due Date'},PC_YEAR:{title:'Year'},PC_PAYENDDATE:{title:'Pay End'},PC_PAYDATE:{title:'Pay Date'},PC_MISSINGINFO:{title:'Missing Information'},PC_OBTAININFO_DATECOMPLETED:{title:'Information Received'},PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled'},PC_DELIVERY_DATECOMPLETED:{title:'Delivered'},PC_FEES:{title:'Fees'},PC_PAYMENTSTATUS:{title:'Payment Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group3"}',
	"functions":''
	})};

_grid4=function(){_jGrid({
	"grid":"grid4",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check - Missing Information",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_DATEDUE:{title:'Due Date'},PC_YEAR:{title:'Year'},PC_PAYENDDATE:{title:'Pay End'},PC_PAYDATE:{title:'Pay Date'},PC_MISSINGINFO:{title:'Missing Information'},PC_OBTAININFO_DATECOMPLETED:{title:'Information Received'},PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled'},PC_DELIVERY_DATECOMPLETED:{title:'Delivered'},PC_FEES:{title:'Fees'},PC_PAYMENTSTATUS:{title:'Payment Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g4_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group4"}',
	"functions":''
	})};


_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check - Completed Not Billed",
	"fields":{PC_ID:{key:true,list:false,edit:false},CLIENT_NAME:{title:'Client Name'},PC_DATEDUE:{title:'Due Date'},PC_YEAR:{title:'Year'},PC_PAYENDDATE:{title:'Pay End'},PC_PAYDATE:{title:'Pay Date'},PC_MISSINGINFO:{title:'Missing Information'},PC_OBTAININFO_DATECOMPLETED:{title:'Information Received'},PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled'},PC_DELIVERY_DATECOMPLETED:{title:'Delivered'},PC_FEES:{title:'Fees'},PC_PAYMENTSTATUS:{title:'Payment Status'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group5"}',
	"functions":''
	})};








