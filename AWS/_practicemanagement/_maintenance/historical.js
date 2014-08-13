
$(document).ready(function(){

	_grid1();
});
_run={	
 	load_group1:function(){_grid1();}
	,load_group2:function(){_grid2();}
	,load_group3:function(){_grid3();}
	,load_group4:function(){_grid4();}
	,load_group5:function(){_grid5();}
	,load_group6:function(){_grid6();}
	,load_group7:function(){_grid7();}
	,load_group8:function(){_grid8();}
	,load_group9:function(){_grid9();}
	,load_group10:function(){_grid10();}
	,load_group11:function(){_grid11();}
	,load_group12:function(){_grid12();}
}


_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""} 
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"description","t":"text","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"projectcompleted","t":"date","v":""}
,{"n":"requestforservice","t":"date","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"workinitiated","t":"date","v":""}
];$.each(grid1_config, function(idx, obj) {$('#group1 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});

	_jGrid({
	"grid":"grid1",
	"url":"historical.cfc",
	"title":"Accounting &amp; Consulting",
	"fields":{MC_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_REQUESTFORSERVICE:{title:'Request For Service'}
			,MC_PROJECTCOMPLETED:{title:'Project Completed'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_PRIORITY:{title:'Priority'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To'}			
			,MC_DUEDATE:{title:'Due Date',width:'2%'}
			,MC_ESTTIME:{title:'Estimated Time',width:'2%'}
			,MC_CATEGORYTEXT:{title:'Consulting Categories'}
			,MC_DESCRIPTION:{title:'Task Description'}	
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g1_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group1","formid":"2"}',
	"functions":'$("#task_id").val(record.MC_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID,\'WIPPOP\');'
})};	


_grid2=function(){
var grid2_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"completed","t":"date","v":""}
,{"n":"datereqested","t":"date","v":""}
,{"n":"datestarted","t":"date","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"instructions","t":"text","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reqestby","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"taskdesc","t":"text","v":""}
];$.each(grid2_config, function(idx, obj) {$('#group2 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid2",
	"url":"historical.cfc",	
	"title":"Administrative Tasks",
	"fields":{AS_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
 			,AS_CATEGORYTEXT:{title:'Category'}
			,AS_TASKDESC:{title:'Description'}
			,AS_DUEDATE:{title:'Due Date',width:'1%'}
			,AS_STATUSTEXT:{title:'Status'}
			,AS_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}						
			,AS_DATEREQESTED:{title:'Date Requested',width:'1%'}	
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g2_filter").val(),grid2_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group2","formid":"4"}',
	"functions":'$("#task_id").val(record.AS_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.AS_ID,\'WIPPOP\');'
})};


_grid3=function(){
var grid3_config = [
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
];$.each(grid3_config, function(idx, obj) {$('#group3 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid3",
	"url":"historical.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,BF_ACTIVITY:{title:'Activity'}
			,BF_OWNERS:{title:'Owners'}
			,BF_BUSINESSTYPETEXT:{title:'Business Type'}
			,BF_DUEDATE:{title:'Due Date',width:'1%'}
 			,BF_STATUSTEXT:{title:'Status'}
			,BF_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
		    ,BF_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,BF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}	
	},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g3_filter").val(),grid3_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group3","formid":"3"}',
	"functions":'$("#task_id").val(record.BF_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessformation.cfm?task_id="+record.BF_ID,\'WIPPOP\');'
})};

_grid4=function(){
var grid4_config = [
{"n":"search","type":"text","v":""}    
,{"n":"active","t":"boolean","v":""}
,{"n":"credit_hold","t":"boolean","v":""}
,{"n":"disregard","t":"boolean","v":""}
,{"n":"group","t":"text","v":""}
,{"n":"name","t":"text","v":""}
,{"n":"notes","t":"text","v":""}
,{"n":"personal_property","t":"boolean","v":""}
,{"n":"referred_by","t":"text","v":""}
,{"n":"relations","t":"text","v":""}
,{"n":"salutation","t":"text","v":""}
,{"n":"schedule_c","t":"boolean","v":""}
,{"n":"schedule_e","t":"boolean","v":""}
,{"n":"since","t":"date","v":""}
,{"n":"spouse","t":"text","v":""}
,{"n":"statelabel1","t":"text","v":""}
,{"n":"statelabel2","t":"text","v":""}
,{"n":"statelabel3","t":"text","v":""}
,{"n":"statelabel4","t":"text","v":""}
,{"n":"trade_name","t":"text","v":""}
,{"n":"type","t":"numeric","v":""}

];$.each(grid4_config, function(idx, obj) {$('#group4 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid4",
	"url":"historical.cfc",
	"title":"Client Maintenance",	
	"fields":{CLIENT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_SALUTATION:{title:'Salutation'}
			,CLIENT_TYPETEXT:{title:'Type'}
			,CLIENT_SINCE:{title:'Client Since',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g4_filter").val(),grid4_config)+',"orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group4","formid":"1"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/clientMaintenance.cfm?task_id="+record.CLIENT_ID,\'WIPPOP\');'
	})};  

_grid5=function(){
var grid5_config = [
{"n":"search","type":"text","v":""}    
,{"n":"briefmessage","t":"text","v":""}
,{"n":"caller","t":"text","v":""}
,{"n":"completed","t":"boolean","v":""}
,{"n":"contactmethod","t":"text","v":""}
,{"n":"date","t":"date","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"emailaddress","t":"text","v":""}
,{"n":"ext","t":"numeric","v":""}
,{"n":"faxnumber","t":"text","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"for","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"responseneeded","t":"boolean","v":""}
,{"n":"returncall","t":"boolean","v":""}
,{"n":"takenby","t":"numeric","v":""}
,{"n":"telephone","t":"numeric","v":""}
];$.each(grid5_config, function(idx, obj) {$('#group5 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid5",
	"url":"historical.cfc",	
	"title":"Communications",
	"fields":{CO_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_DATE:{title:'Date and Time'}
			,CO_DUEDATE:{title:'Due Date',width:'2%'}
			,CO_STATUSTEXT:{title:'Status',width:'2%'}
			,CO_FORTEXT:{title:'For',width:'2%'}
			,CO_RESPONSENEEDED:{title:'Response Required',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_RETURNCALL:{title:'Returned Call',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}			
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
	},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g5_filter").val(),grid5_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group5","formid":"12"}',
	"functions":'$("#task_id").val(record.CO_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID,\'WIPPOP\');'
})};



	
	

_grid6=function(){
var grid6_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"category","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"finalclientmeeting","t":"date","v":""}
,{"n":"infocompiled","t":"date","v":""}
,{"n":"inforeceived","t":"date","v":""}
,{"n":"inforequested","t":"date","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reportcompleted","t":"date","v":""}
,{"n":"requestservice","t":"date","v":""}
,{"n":"status","t":"numeric","v":""}

];$.each(grid6_config, function(idx, obj) {$('#group6 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid6",
	"url":"historical.cfc",	
	"title":"Financial &amp; Tax Planning", 
	"fields":{FTP_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
  			 ,CLIENT_NAME:{title:'Client Name'}
			 ,FTP_CATEGORYTEXT:{title:'Category'}
			 ,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			 ,FTP_STATUSTEXT:{title:'Status'}
			 ,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			 ,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			 ,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g6_filter").val(),grid6_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group6","formid":"9"}',
	"functions":'$("#task_id").val(record.FTP_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID,\'WIPPOP\');'
})};




_grid7=function(){
var grid7_config = [
{"n":"search","type":"text","v":""}    
,{"n":"acctrpt_assignedto","t":"numeric","v":""}
,{"n":"acctrpt_completedby","t":"numeric","v":""}
,{"n":"acctrpt_datecompleted","t":"date","v":""}
,{"n":"acctrpt_esttime","t":"numeric","v":""}
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_completedby","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"checks_assignedto","t":"numeric","v":""}
,{"n":"checks_completedby","t":"numeric","v":""}
,{"n":"checks_datecompleted","t":"date","v":""}
,{"n":"checks_esttime","t":"numeric","v":""}	  
,{"n":"compilemi","t":"boolean","v":""}
,{"n":"compile_assignedto","t":"numeric","v":""}
,{"n":"compile_completedby","t":"numeric","v":""}
,{"n":"compile_datecompleted","t":"date","v":""}
,{"n":"compile_esttime","t":"numeric","v":""}
,{"n":"cmireceived","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"entry_assignedto","t":"numeric","v":""}
,{"n":"entry_completedby","t":"numeric","v":""}
,{"n":"entry_datecompleted","t":"date","v":""}
,{"n":"entry_esttime","t":"numeric","v":""} 
,{"n":"esttime","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"month","t":"numeric","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"periodend","t":"date","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"reconcile_assignedto","t":"numeric","v":""}
,{"n":"reconcile_completedby","t":"numeric","v":""}
,{"n":"reconcile_datecompleted","t":"date","v":""}
,{"n":"reconcile_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_esttime","t":"numeric","v":""}  
,{"n":"sales_assignedto","t":"numeric","v":""}
,{"n":"sales_completedby","t":"numeric","v":""}
,{"n":"sales_datecompleted","t":"date","v":""}
,{"n":"sales_esttime","t":"numeric","v":""}	  
,{"n":"sort_assignedto","t":"numeric","v":""}
,{"n":"sort_completedby","t":"numeric","v":""}
,{"n":"sort_datecompleted","t":"date","v":""}
,{"n":"sort_esttime","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"year","t":"numeric","v":""}
];$.each(grid7_config, function(idx, obj) {$('#group7 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid7",
	"url":"historical.cfc",
	"title":"Financial Statements",
	"fields":{FDS_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
 			,CLIENT_ID:{list:false,edit:false}
 			,CLIENT_NAME:{title:'Client Name'}
			,FDS_YEAR:{title:'Year',width:'1%'}
			,FDS_MONTHTEXT:{title:'Period'}
			,FDS_PERIODEND:{title:'Period End',width:'1%'}
			,FDS_DUEDATE:{title:'Due Date',width:'1%'}
			,FDS_STATUSTEXT:{title:'Status'}
			,FDS_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_COMPILEMI:{title:'Compile Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,FDS_OBTAININFO:{title:'Info',width:'1%'}
			,FDS_SORT:{title:'Sort',width:'1%'}
			,FDS_CHECKS:{title:'Checks',width:'1%'}
			,FDS_SALES:{title:'Sales',width:'1%'}
			,FDS_ENTRY:{title:'Entry',width:'1%'}
			,FDS_RECONCILE:{title:'Reconciliation',width:'1%'}
			,FDS_COMPILE:{title:'Compiliation',width:'1%'}
			,FDS_REVIEW:{title:'Review',width:'1%'}
			,FDS_ASSEMBLY:{title:'Assembly ',width:'1%'}
			,FDS_DELIVERY:{title:'Delivery',width:'1%'}
			,FDS_ACCTRPT:{title:'Report',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g7_filter").val(),grid7_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group7","formid":"5"}',
	"functions":'$("#task_id").val(record.FDS_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialstatements.cfm?task_id="+record.FDS_ID,\'WIPPOP\');'
})};



	

_grid8=function(){
var grid8_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"noticestatus","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"1_datenoticerec","t":"date","v":""}
,{"n":"1_methodreceived","t":"numeric","v":""}
,{"n":"1_noticenumber","t":"numeric","v":""}
,{"n":"1_noticedate","t":"date","v":""}
,{"n":"1_taxform","t":"numeric","v":""}
,{"n":"1_taxyear","t":"numeric","v":""}
,{"n":"2_irsstateresponse","t":"date","v":""}
,{"n":"2_rescompleted","t":"date","v":""}
,{"n":"2_rescompletedby","t":"numeric","v":""}
,{"n":"2_resduedate","t":"date","v":""}
,{"n":"2_revassignedto","t":"numeric","v":""}
,{"n":"2_revcompleted","t":"date","v":""}
,{"n":"2_revrequired","t":"boolean","v":""}
,{"n":"2_ressubmited","t":"date","v":""}

];$.each(grid8_config, function(idx, obj) {$('#group8 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid8",
	"url":"historical.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,N_NAME:{title:'Matter Name'}
			,N_STATUSTEXT:{title:'Matter Status'}
			,NST_1_TAXYEAR:{title:'Tax Year',width:'2%'}
			,NST_1_TAXFORMTEXT:{title:'Tax Form'}
			,NST_1_NOTICENUMBERTEXT:{title:'Notice Number'}
			,NST_STATUSTEXT:{title:'Notice Status'}
			,NST_MISSINGINFO:{title:'Missing Information',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_1_DATENOTICEREC:{title:'Date Notice Received',width:'2%'}
			,NST_1_RESDUEDATE:{title:'Response Due Date',width:'2%'}
			,NST_2_RESSUBMITED:{title:'Response Submitted',width:'2%'}
			,NST_2_REVREQUIRED:{title:'Review Required',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,NST_FEES:{title:'Fees'}
			,NST_PAIDTEXT:{title:'Payment Status'}
			,NST_PRIORITY:{title:'Priority'}
			,NST_ESTTIME:{title:'Estimated Time'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g8_filter").val(),grid8_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group8","formid":"8"}',
	"functions":'$("#task_id").val(record.N_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID,\'WIPPOP\');'
})};
	
	

_grid9=function(){
var grid9_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_compeltedby","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"numeric","v":""}
,{"n":"delivery_completedby","t":"numeric","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"extensioncompleted","t":"date","v":""}
,{"n":"extensiondeadline","t":"date","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"filingdeadline","t":"date","v":""}
,{"n":"form","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"period","t":"numeric","v":""}
,{"n":"preparation_assignedto","t":"numeric","v":""}
,{"n":"preparation_datecompleted","t":"date","v":""}
,{"n":"preparation_completedby","t":"numeric","v":""}
,{"n":"preparation_esttime","t":"numeric","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"state","t":"numeric","v":""}
,{"n":"status","t":"numeric","v":""}
,{"n":"task","t":"numeric","v":""}
,{"n":"taxyear","t":"numeric","v":""}
];$.each(grid9_config, function(idx, obj) {$('#group9 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid9",
	"url":"historical.cfc",
	"title":"Other Fililngs",
	"fields":{OF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,OF_TAXYEAR:{title:'Tax Year'}
			,OF_PERIODTEXT:{title:'Period'}
			,OF_STATETEXT:{title:'State'}
			,OF_TYPETEXT:{title:'Type'}
			,OF_FORMTEXT:{title:'Form',width:'1%'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_FILINGDEADLINE:{title:'Filing Deadline',width:'1%'}
			,OF_STATUSTEXT:{title:'Status'}
			,OF_INFORMATIONRECEIVED:{title:'Information',width:'1%'}												
			,OF_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}	
			,OF_MISSINGINFORECEIVED:{title:'Missing Info Received',width:'1%'}									
			,OF_OBTAININFO:{title:'Informtaion',width:'1%'}
			,OF_PREPARATION:{title:'Preparation',width:'1%'}
			,OF_REVIEW:{title:'Review',width:'1%'}
			,OF_ASSEMBLY:{title:'Assembly',width:'1%'}
			,OF_DELIVERY:{title:'Delivery',width:'1%'}						
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g9_filter").val(),grid9_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group9","formid":"11"}',
	"functions":'$("#task_id").val(record.OF_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID,\'WIPPOP\');'
})};

	
_grid10=function(){
var grid10_config = [
{"n":"search","t":"text","v":""}
,{"n":"altfreq","t":"boolean","v":""}
,{"n":"assembly_assignedto","t":"date","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_completedby","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"clientname","t":"date","v":""}
,{"n":"datedue","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"date","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_completedby","t":"date","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
,{"n":"esttime","t":"date","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"obtaininfo_assignedto","t":"date","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"date","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"text","v":""}
,{"n":"payenddate","t":"date","v":""}
,{"n":"paydate","t":"date","v":""}
,{"n":"preparation_assignedto","t":"date","v":""}
,{"n":"preparation_datecompleted","t":"date","v":""}
,{"n":"preparation_completedby","t":"date","v":""}
,{"n":"preparation_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"date","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"date","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"year","t":"numeric","v":""}
];$.each(grid10_config, function(idx, obj) {$('#group10 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});


	_jGrid({
	"grid":"grid10",
	"url":"historical.cfc",
	"title":"Payroll Checks",
	"fields":{PC_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
 			,CLIENT_NAME:{title:'Client Name'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_DUEDATE:{title:'Due Date',width:'1%'}
 			,PC_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
 			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_OBTAININFO:{title:'Information',width:'1%'}
			,PC_PREPARATION:{title:'Preparation',width:'1%'}
			,PC_REVIEW:{title:'Review',width:'1%'}
			,PC_ASSEMBLY:{title:'Assembly',width:'1%'}
			,PC_DELIVERY:{title:'Delivery',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g10_filter").val(),grid10_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group10","formid":"10"}',
	"functions":'$("#task_id").val(record.PC_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID,\'WIPPOP\');'
})};
	
	

_grid11=function(){
var grid11_config = [
{"n":"search","type":"text","v":""}
,{"n":"year","t":"numeric","v":""}
,{"n":"month","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"type","t":"numeric","v":""}
,{"n":"lastpay","t":"date","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"numeric","v":""}
,{"n":"fees","t":"date","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"obtaininfo_assignedto","t":"numeric","v":""}
,{"n":"obtaininfo_datecomplted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"numeric","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"entry_assignedto","t":"numeric","v":""}
,{"n":"entry_datecompleted","t":"date","v":""}
,{"n":"entry_completedby","t":"numeric","v":""}
,{"n":"entry_esttime","t":"numeric","v":""}
,{"n":"rec_assignedto","t":"numeric","v":""}
,{"n":"rec_datecompleted","t":"date","v":""}
,{"n":"rec_completedby","t":"numeric","v":""}
,{"n":"rec_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"numeric","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"numeric","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"assembly_assignedto","t":"numeric","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_completedby","t":"numeric","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"numeric","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_completedby","t":"numeric","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
];$.each(grid11_config, function(idx, obj) {$('#group11 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});

	_jGrid({
	"grid":"grid11",
	"url":"historical.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,PT_YEAR:{title:'Year',width:'1%'}
			,PT_MONTHTEXT:{title:'Period'}
			,PT_STATETEXT:{title:'State'}
			,PT_TYPETEXT:{title:'Return Type'}	
			,PT_LASTPAY:{title:'Last Pay',width:'1%'}
			,PT_DUEDATE:{title:'Due Date',width:'1%'}
			,PT_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,PT_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}
			,PT_OBTAININFO:{title:'Information',width:'1%'}
			,PT_ENTRY:{title:'Entry',width:'1%'}
			,PT_REC:{title:'Reconciliation',width:'1%'}
			,PT_REVIEW:{title:'Review',width:'1%'}
			,PT_ASSEMBLY:{title:'Assembly',width:'1%'}
			,PT_DELIVERY:{title:'Delivery',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g11_filter").val(),grid11_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group11","formid":"13"}',
	"functions":'$("#task_id").val(record.PT_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID,\'WIPPOP\');'
})};
	

 
_grid12=function(){
var grid12_config = [
{"n":"search","type":"text","v":""}    
,{"n":"currentfees","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"extensiondone","t":"date","v":""}
,{"n":"extensionrequested","t":"date","v":""}
,{"n":"notrequired","t":"boolean","v":""}
,{"n":"priority","t":"numeric","v":""}
,{"n":"priorfees","t":"numeric","v":""}
,{"n":"taxform","t":"numeric","v":""}
,{"n":"taxyear","t":"numeric","v":""}
,{"n":"duedate","t":"date","v":""}
,{"n":"filingdeadline","t":"date","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"paid","t":"numeric","v":""}
,{"n":"reason","t":"text","v":""}
,{"n":"1_dropoffappointment","t":"date","v":""}
,{"n":"1_dropoffappointmentlength","t":"numeric","v":""}
,{"n":"1_dropoffappointmentwith","t":"numeric","v":""}
,{"n":"1_whileyouwaitappt","t":"date","v":""}
,{"n":"1_pickupappointment","t":"date","v":""}
,{"n":"1_pickupappointmentlength","t":"numeric","v":""}
,{"n":"1_pickupappointmentwith","t":"numeric","v":""}
,{"n":"2_assignedto","t":"numeric","v":""}
,{"n":"2_completed","t":"date","v":""}
,{"n":"2_informationreceived","t":"date","v":""}
,{"n":"2_preparedby","t":"numeric","v":""}
,{"n":"2_readyforreview","t":"date","v":""}
,{"n":"2_reviewassignedto","t":"numeric","v":""}
,{"n":"2_reviewed","t":"date","v":""}
,{"n":"2_reviewedby","t":"numeric","v":""}
,{"n":"2_reviewedwithnotes","t":"date","v":""}
,{"n":"3_assemblereturn","t":"date","v":""}
,{"n":"3_contacted","t":"date","v":""}
,{"n":"3_delivered","t":"date","v":""}
,{"n":"3_emailed","t":"boolean","v":""}
,{"n":"3_messageleft","t":"boolean","v":""}
,{"n":"3_missingsignatures","t":"boolean","v":""}
,{"n":"3_multistatereturn","t":"boolean","v":""}
,{"n":"4_assignedto","t":"numeric","v":""}
,{"n":"4_completed","t":"date","v":""}
,{"n":"4_currentfees","t":"numeric","v":""}
,{"n":"4_delivered","t":"date","v":""}
,{"n":"4_extended","t":"date","v":""}
,{"n":"4_paid","t":"numeric","v":""}
,{"n":"4_pptresttime","t":"numeric","v":""}
,{"n":"4_priorfees","t":"numeric","v":""}
,{"n":"4_required","t":"boolean","v":""}
,{"n":"4_rfr","t":"date","v":""}
,{"n":"4_extensionrequested","t":"date","v":""}
,{"n":"4_completedby","t":"numeric","v":""}
,{"n":"4_reviewassigned","t":"numeric","v":""}
,{"n":"4_reviewed","t":"date","v":""}
,{"n":"4_reviewedby","t":"numeric","v":""}
]; $.each(grid12_config, function(idx, obj) {$('#group12 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
	_jGrid({
	"grid":"grid12",
	"url":"historical.cfc",	
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_TAXYEAR:{title:'Tax Year',width:'1%'}
			,TR_TAXFORMTEXT:{title:'Tax Form',width:'1%'}
			,TR_DUEDATE:{title:'Due Date',width:'1%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}		
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'1%'}		
			,TR_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,TR_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'1%'}		
			,TR_2_READYFORREVIEW:{title:'Ready For Review',width:'1%'}		
			,TR_2_REVIEWASSIGNEDTOTEXT:{title:'Review Assigned To',width:'1%'}		
			,TR_2_REVIEWED:{title:'Reviewed',width:'1%'}			
			,TR_2_REVIEWEDWITHNOTES:{title:'Reviewed With Notes',width:'1%'}		
			,TR_2_COMPLETED:{title:'Completed',width:'1%'}		
			,TR_3_ASSEMBLERETURN:{title:'Assembly',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g12_filter").val(),grid12_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group12","formid":"6"}',
	"functions":'$("#task_id").val(record.TR_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID,\'WIPPOP\');'
})};	