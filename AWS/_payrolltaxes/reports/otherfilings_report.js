$(document).ready(function(){
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"otherfilings_report.cfc",
	"title":"Other Filings Status",
	"fields":{OF_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name',width:'20%'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_TAXYEAR:{title:'Year',width:'1%'}
			,OF_PERIOD:{title:'Period',width:'5%'}
			,OF_STATE:{title:'State',width:'9%'}
			,OF_FORM:{title:'Form',width:'1%'}
			,OF_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,OF_MISSINGINFO:{title:'Missing Info',width:'5%'}
			,OF_MIRECEIVED:{title:'Missing Information Received',width:'1%'}
			,OF_PREPARATION_DATECOMPLETED:{title:'Preparation',width:'1%'}
			,OF_REVIEW_DATECOMPLETED:{title:'Review',width:'1%'}
			,OF_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,OF_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,OF_FEES:{title:'Fees',width:'9%'}
			,OF_ESTTIME:{title:'Estimated Time',width:'10%'}
			,OF_PAYMENTSTATUS:{title:'Payment Status',width:'10%'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};


