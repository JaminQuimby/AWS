$(document).ready(function(){_grid1()});

var _run={
	 new_group1:function(){
		 
		 $("#g1_active").prop('checked',true);
		 document.getElementById('content').className='contentbig';
		 _addNewTask();_toggle('group1,largeMenu');
		 _hide('entrance,smallMenu,group2,group3,group4,group5,group6');
		 
		 }
	,new_group1_1:function(){$("#group1").accordion({active:2});$("#isLoaded_group1_2").val(1);$("#cl_fieldid").val(0);_clearfields({"list":"g1_g2_fieldname,g1_g2_fieldvalue,g1_g2_fieldglobal,g1_g3_group"});}
	,new_group3:function(){
		
		$("#group3").accordion({active:1});
		$("#isLoaded_group3").val(1);
		$("#co_id").val(0);
		_clearfields({"list":"g3_type,g3_name,g3_address1,g3_address2,g3_city,g3_state,g3_zip,g3_phone1,g3_ext1,g3_phone2,g3_ext2,g3_phone3,g3_phone4,g3_phone5,g3_email1,g3_email2,g3_website,g3_effectivedate,g3_acctsoftwareupdate,g3_taxupdate,g3_title,g3_customvalue"});
		}

		
	,new_group4_1:function(){ window.open('https://'+window.location.hostname+'/AWS/_accountingservices/acctingconsulting.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_2:function(){ window.open('https://'+window.location.hostname+'/AWS/_clientmanagement/administrativetasks.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_3:function(){ window.open('https://'+window.location.hostname+'/AWS/_accountingservices/businessFormation.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_4:function(){ window.open('https://'+window.location.hostname+'/AWS/_clientmanagement/communications.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_5:function(){ window.open('https://'+window.location.hostname+'/AWS/_taxation/financialtaxplanning.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_6:function(){ window.open('https://'+window.location.hostname+'/AWS/_accountingservices/financialstatements.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_7:function(){ window.open('https://'+window.location.hostname+'/AWS/_taxation/notices.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_8:function(){ window.open('https://'+window.location.hostname+'/AWS/_payrolltaxes/otherfilings.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_9:function(){ window.open('https://'+window.location.hostname+'/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_10:function(){ window.open('https://'+window.location.hostname+'/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_11:function(){ window.open('https://'+window.location.hostname+'/AWS/_taxation/taxreturns.cfm?task_id="+$("#task_id").val()','WIPPOP');}	
	,new_group4_12:function(){ window.open('https://'+window.location.hostname+'/AWS/_taxation/powerofattorney.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group4_13:function(){ window.open('https://'+window.location.hostname+'/AWS/_taxation/taxreturns.cfm?task_id="+$("#task_id").val()','WIPPOP');}
	,new_group5:function(){$("#si_id").val("0");$("#group5").accordion({active:1});$("#isLoaded_group5").val(1);_clearfields({"list":"g5_state,g5_revenue,g5_employees,g5_property,g5_nexus,g5_reason,g5_registered,g5_value1,g5_value2,g5_value3,g5_value4,g5_g1_label1,g5_g1_label2,g5_g1_label3,g5_g1_label4"})}
	,new_group6:function(){$("#group6").accordion({active:1});$("#isLoaded_group6").val(1);_clearfields({"list":"g6_group"});}
	,load_group1:function(){}	
	,load_group1_1:function(){_grid1_1();}
	,load_group1_2:function(){$('#isLoaded_group1_2').val(1)}
	,load_group1_3:function(){$('#isLoaded_group1_3').val(1)}
	,load_group2:function(){}
	,load_group2_1:function(){if($("#isLoaded_group2_1").val()=="0"){_loadData({"id":"client_id","group":"group2_1","page":"clientmaintenance"});$("#isLoaded_group2_1").val(1);}}
	,load_group2_2:function(){if($("#isLoaded_group2_2").val()=="0"){_loadData({"id":"client_id","group":"group2_2","page":"clientmaintenance"});$("#isLoaded_group2_2").val(1);}}
	,load_group2_3:function(){if($("#isLoaded_group2_3").val()=="0"){_loadData({"id":"client_id","group":"group2_3","page":"clientmaintenance"});$("#isLoaded_group2_3").val(1);}}
	,load_group3:function(){_grid3()}
	,load_group4:function(){}
	,load_group4_1:function(){_grid4_1()}
	,load_group4_2:function(){_grid4_2()}
	,load_group4_3:function(){_grid4_3()}
	,load_group4_4:function(){_grid4_4()}	
	,load_group4_5:function(){_grid4_5()}	
	,load_group4_6:function(){_grid4_6()}
	,load_group4_7:function(){_grid4_7()}
	,load_group4_8:function(){_grid4_8()}
	,load_group4_9:function(){_grid4_9()}
	,load_group4_10:function(){_grid4_10()}
	,load_group4_11:function(){_grid4_11()}
	,load_group4_12:function(){_grid4_12()}
	,load_group4_13:function(){_grid4_13()}
	,load_group5:function(){_grid5()}
	,load_group5_1:function(){$('#isLoaded_group5_1').val(1);_loadData({'id':'client_id','group':'group5_1','page':'clientmaintenance'});
								var g5_g1_label1=$("#g5_g1_label1"),g5_g1_label2=$("#g5_g1_label2"),g5_g1_label3=$("#g5_g1_label3"),g5_g1_label4=$("#g5_g1_label4"),g5_value1=$('label[for="g5_value1"]'),g5_value2=$('label[for="g5_value2"]'),g5_value3=$('label[for="g5_value3"]'),g5_value4=$('label[for="g5_value4"]');g5_value1.html(g5_g1_label1.val());g5_value2.html(g5_g1_label2.val());g5_value3.html(g5_g1_label3.val());g5_value4.html(g5_g1_label4.val());g5_g1_label1.change(function(){g5_value1.html($(this).val())});g5_g1_label2.change(function(){g5_value2.html($(this).val())});g5_g1_label3.change(function(){g5_value3.html($(this).val())});g5_g1_label4.change(function(){g5_value4.html($(this).val())});g5_value1.change(function(){g5_g1_label1.html($(this).val())});g5_value2.change(function(){g5_g1_label2.html($(this).val())});g5_value3.change(function(){g5_g1_label3.html($(this).val())});g5_value4.change(function(){g5_g1_label4.html($(this).val())});}
	,load_group6:function(){_grid6()}	
	,load_group6_1:function(){$('#isLoaded_group6').val(1);_loadData({'id':'client_id','group':'group6','page':'clientmaintenance'})}	
	}

_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientMaintenance.cfc",
	"title":"Clients",
	"fields":{CLIENT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
		,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.CLIENT_ID+"',page:'clientmaintenance',group:'group0'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
		,CLIENT_NAME:{title:'Client Name'}
		,CLIENT_SALUTATION:{title:'Salutation'}
		,CLIENT_TYPETEXT:{title:'Type'}
		,CLIENT_SINCE:{title:'Client Since',width:'2%'}
		,CLIENT_ACTIVE:{title:'Active',visibility:'hidden',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"1"}',
	"functions":'$("#client_id").val(record.CLIENT_ID);_updateh3(record.CLIENT_NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"client_id","group":"group1","page":"clientmaintenance"});'
	})};
	
_grid1_1=function(){_jGrid({
	"grid":"grid1_1",
	"url":"clientMaintenance.cfc",
	"title":"Custom Fields",
	"fields":{FIELD_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.FIELD_ID+"',page:'clientmaintenance',group:'group1_2'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,FIELD_NAME:{title:'Name'}
			,FIELD_VALUE:{title:'Value'}
			,FIELD_GLOBAL:{title:'Global',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g1_g1_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1_1","clientid":'+$("#client_id").val()+'}',
	"functions":'$("#cl_fieldid").val(record.FIELD_ID);$("#group1").accordion({active:2});$("#isLoaded_group1_2").val(1);_loadData({"id":"cl_fieldid","group":"group1_2","page":"clientmaintenance"});'
	})};
	
_grid3=function(){_jGrid({
	"grid":"grid3",
	"url":"clientMaintenance.cfc",
	"title":"Client Contacts",
	"fields":{CONTACT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.CONTACT_ID+"',page:'clientmaintenance',group:'group3'});_grid3();","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,CONTACT_NAME:{title:'Contact'}
			,CONTACT_TYPETEXT:{title:'Type'}
			,CONTACT_TITLE:{title:'Title'}
			,CONTACT_PHONE1:{title:'Primary Phone'}
			,CONTACT_EMAIL1:{title:'Primary Email'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g3_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group3","clientid":'+$("#client_id").val()+',"formid":"1"}',
	"functions":'$("#co_id").val(record.CONTACT_ID);$("#isLoaded_group3").val(1);_loadData({"id":"co_id","group":"group3","page":"clientmaintenance"});$("#group3").accordion({active:1});'
	})};

_grid4_1=function(){_jGrid({
	"grid":"grid4_1",
	"url":"clientMaintenance.cfc",
	"title":"Accounting &amp; Consulting Tasks",
	"fields":{MC_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,MC_CATEGORYTEXT:{title:'Consulting Category'}
			,MC_DESCRIPTION:{title:'Task Description'}	
			,MC_DUEDATE:{title:'Due Date',width:'4%'}
			,MC_STATUSTEXT:{title:'Status'}
			,MC_ASSIGNEDTOTEXT:{title:'Assigned To'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_1","formid":"2"}',
	"functions":'$("#task_id").val(record.MC_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/acctingconsulting.cfm?task_id="+record.MC_ID,\'WIPPOP\');'
	})};

_grid4_2=function(){_jGrid({
	"grid":"grid4_2",
	"url":"clientMaintenance.cfc",
	"title":"Client Administrative Tasks",
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
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_2","formid":"4"}',
	"functions":'$("#task_id").val(record.AS_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/administrativetasks.cfm?task_id="+record.AS_ID,\'WIPPOP\');'
})};

_grid4_3=function(){_jGrid({
	"grid":"grid4_3",
	"url":"clientMaintenance.cfc",
	"title":"Business Formation",
	"fields":{BF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
		,CLIENT_ID:{list:false,edit:false}
		,CLIENT_NAME:{title:'Client Name'}
		,BF_ACTIVITY:{title:'Activity'}
		,BF_OWNERS:{title:'Owners'}	
		,BF_BUSINESSTYPETEXT:{title:'Business Type'}
		,BF_DUEDATE:{title:'Due Date',width:'2%'}
		,BF_STATUSTEXT:{title:'Status'}
		,BF_ASSIGNEDTOTEXT:{title:'Assigned To'}
	    ,BF_MISSINGINFO:{title:'Missing Information',width:'2%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
		,BF_MISSINGINFORECEIVED:{title:'Missing Information Received',width:'2%'}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_3","formid":"3"}',
	"functions":'$("#task_id").val(record.BF_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/businessformation.cfm?task_id="+record.BF_ID,\'WIPPOP\');'
})};

_grid4_4=function(){_jGrid({
	"grid":"grid4_4",
	"url":"clientMaintenance.cfc",
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
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_4","formid":"12"}',
	"functions":'$("#task_id").val(record.CO_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID,\'WIPPOP\');'
})};
	
_grid4_5=function(){_jGrid({
	"grid":"grid4_5",
	"url":"clientMaintenance.cfc",
	"title":"Financial & Tax Planning",
	"fields":{FTP_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
  			 ,CLIENT_NAME:{title:'Client Name'}
			 ,FTP_CATEGORYTEXT:{title:'Category'}
			 ,FTP_DESCRIPTION:{title:'Description'}
			 ,FTP_DUEDATE:{title:'Due Date',width:'1%'}
			 ,FTP_STATUSTEXT:{title:'Status'}
			 ,FTP_ASSIGNEDTOTEXT:{title:'Assigned To',width:'1%'}
			 ,FTP_REQUESTSERVICE:{title:'Request for Services',width:'1%'}
			 ,FTP_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
		},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_5","formid":"9"}',
	"functions":'$("#task_id").val(record.FTP_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/financialtaxplanning.cfm?task_id="+record.FTP_ID,\'WIPPOP\');'
	})};
	
_grid4_6=function(){_jGrid({
	"grid":"grid4_6",
	"url":"clientMaintenance.cfc",
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
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_6","formid":"5"}',
	"functions":'$("#task_id").val(record.FDS_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_accountingservices/financialstatements.cfm?task_id="+record.FDS_ID,\'WIPPOP\');'
 	})};
	
_grid4_7=function(){_jGrid({
	"grid":"grid4_7",
	"url":"clientMaintenance.cfc",
	"title":"Notice Matters",
	"fields":{N_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,N_NAME:{title:'Matter Name'}
			,N_STATUSTEXT:{title:'Matter Status'}	
			,NST_1_TAXYEAR:{title:'Tax Year',width:'2%'}
			,NST_1_TAXFORMTEXT:{title:'Tax Form'}
			,NST_1_NOTICENUMBERTEXT:{title:'Notice Number',width:'2%'}
			,NST_1_RESDUEDATE:{title:'Due Date for Response',width:'2%'}	
			,NST_STATUSTEXT:{title:'Notice Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_7","formid":"8"}',
	"functions":'$("#task_id").val(record.N_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID,\'WIPPOP\');'
	})};
	
_grid4_8=function(){_jGrid({
	"grid":"grid4_8",
	"url":"clientMaintenance.cfc",
	"title":"Other Filings",
	"fields":{OF_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
  			,CLIENT_NAME:{title:'Client Name'}
			,OF_TAXYEAR:{title:'Tax Year'}
			,OF_PERIODTEXT:{title:'Period'}
			,OF_STATETEXT:{title:'State'}
			,OF_TYPETEXT:{title:'Type'}
			,OF_FORMTEXT:{title:'Form',width:'1%'}
			,OF_DUEDATE:{title:'Due Date',width:'1%'}
			,OF_FILINGDEADLINE:{title:'Filing Deadline',width:'1%'}
 			,OF_STATUSTEXT:{title:'Status'}
			,OF_MISSINGINFO:{title:'Missing Information',width:'1%',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}	
			,OF_MISSINGINFORECEIVED:{title:'Missing Info Received',width:'1%'}									
			,OF_OBTAININFO:{title:'Information',width:'1%'}
			,OF_PREPARATION:{title:'Preparation',width:'1%'}
			,OF_REVIEW:{title:'Review',width:'1%'}
			,OF_ASSEMBLY:{title:'Assembly',width:'1%'}
			,OF_DELIVERY:{title:'Delivery',width:'1%'}	
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_8","formid":"11"}',
	"functions":'$("#task_id").val(record.OF_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/otherfilings.cfm?task_id="+record.OF_ID,\'WIPPOP\');'
	})};

_grid4_9=function(){_jGrid({
	"grid":"grid4_9",
	"url":"clientMaintenance.cfc",
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
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_9","formid":"10"}',
	"functions":'$("#task_id").val(record.PC_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID,\'WIPPOP\');'
	})};

_grid4_10=function(){_jGrid({
	"grid":"grid4_10",
	"url":"clientMaintenance.cfc",
	"title":"Payroll Taxes",
	"fields":{PT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
 			,CLIENT_NAME:{title:'Client Name'}
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
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_10","formid":"13"}',
	"functions":'$("#task_id").val(record.PT_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrolltaxes.cfm?task_id="+record.PT_ID,\'WIPPOP\');'
	})};

_grid4_11=function(){_jGrid({
	"grid":"grid4_11",
	"url":"clientMaintenance.cfc",	
	"title":"Personal Property Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,TR_4_EXTENDED:{title:'PPTR Extended',width:'2%'}
			,TR_4_COMPLETED:{title:'Completed',width:'2%'}
			,TR_TAXYEAR:{title:'Year',width:'2%'}
			,TR_TAXFORMTEXT:{title:'Form'}
			,TR_2_INFORMATIONRECEIVED:{title:'Information Received',width:'2%'}
			,TR_4_ASSIGNEDTOTEXT:{title:'Assigned To',width:'2%'}
			,TR_4_PPTRESTTIME:{title:'Estimated Time',width:'2%'}
			,TR_4_RFR:{title:'Ready For Review',width:'2%'}
			,TR_4_DELIVERED:{title:'Delivery',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_11","formid":"6"}',
	"functions":'$("#task_id").val(record.TR_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID,\'WIPPOP\');'
	})};	
	
	
_grid4_12=function(){_jGrid({
	"grid":"grid4_12",
	"url":"clientMaintenance.cfc",
	"title":"Power of Attorney",
	"fields":{PA_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,PA_TAXYEARS:{title:'Tax Years'}
			,PA_TAXFORMSTEXT:{title:'Tax Forms'}
			,PA_TAXMATTERSTEXT:{title:'Tax Matters'}
			,PA_PREPARERSTEXT:{title:'Preparers',width:'2%'}
			,PA_STATUSTEXT:{title:'Status'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_12","formid":"7"}',
	"functions":'$("#task_id").val(record.PA_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/powerofattorney.cfm?task_id="+record.PA_ID,\'WIPPOP\');'										  
	})};	
	
_grid4_13=function(){_jGrid({
	"grid":"grid4_13",
	"url":"clientMaintenance.cfc",
	"title":"Tax Returns",
	"fields":{TR_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_ID:{list:false,edit:false}
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
			,TR_3_DELIVERED:{title:'Delivery',width:'1%'}					
			},
	"method":"f_lookupData",
	"arguments":'{"search":"","orderBy":"0","row":"0","ID":'+$("#client_id").val()+',"loadType":"group4_13","formid":"6"}',
	"functions":'$("#task_id").val(record.TR_ID); window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/taxreturns.cfm?task_id="+record.TR_ID,\'WIPPOP\');'
	})};	
	
_grid5=function(){_jGrid({
	"grid":"grid5",
	"url":"clientMaintenance.cfc",
	"title":"State Information",
	"fields":{SI_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.SI_ID+"',page:'clientmaintenance',group:'group5'});_grid5();","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}
			,SI_STATETEXT:{title:'State'}
			,SI_REVENUE:{title:'Revenue',width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_EMPLOYEES:{title:'Employees',width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_PROPERTY:{title:'Property',width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_NEXUS:{title:'Nexus',width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_REASON:{title:'Reason'}
			,SI_REGISTERED:{title:'Registered',width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_MISC1:{title:$('#g5_g1_label1').val(),width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_MISC2:{title:$('#g5_g1_label2').val(),width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_MISC3:{title:$('#g5_g1_label3').val(),width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			,SI_MISC4:{title:$('#g5_g1_label4').val(),width:'2%',type:'checkbox',values:{'0':'No','1':'Yes'}}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g5_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group5","clientid":'+$("#client_id").val()+'}',
	"functions":'$("#si_id").val(record.SI_ID);_loadData({"id":"si_id","group":"group5","page":"clientmaintenance"});$("#group5").accordion({active:1});'
	})};

_grid6=function(){_jGrid({
	"grid":"grid6",
	"url":"clientMaintenance.cfc",
	"title":"Client Relations",
	"fields":{CLIENT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_ACTIVE:{title:'Active',type:'checkbox',values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SINCE:{title:'Client Since'}
			,CLIENT_TYPETEXT:{title:'Client Type'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g6_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#g6_group").val()+'","loadType":"group6","clientid":'+$("#client_id").val()+'}',
	"functions":'_loadData({"id":"client_id","group":"group6","page":"clientmaintenance"});$("#group6").accordion({active:1});'
	})};

_loadDataCB=function(query){
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}
else{
switch(query.COLUMNS[0]){
/*Group 1*/case "CLIENT_ID":var list='client_id,g1_active,g1_credit_hold,g1_g3_group,g1_name,g1_notes,g1_referred_by,g1_salutation,g1_since,g1_spouse,g1_trade_name,g1_type,g5_g1_label1,g5_g1_label2,g5_g1_label3,g5_g1_label4,g6_group';_loadit({"query":query,"list":list});break;
/*Group 1_2*/case "FIELD_ID":var list="cl_fieldid,g1_g2_fieldname,g1_g2_fieldvalue,g1_g2_fieldglobal";_loadit({"query":query,"list":list});break;
/*Group 2_1*/case "CLIENT_TAX_SERVICES":var list='g2_g1_taxservices,g2_g1_formtype,g2_g1_businessc,g2_g1_rentalpropertye,g2_g1_disregardedentity,g2_g1_personalproperty';_loadit({"query":query,"list":list});break;
/*Group 2_2*/case "CLIENT_PAYROLL_PREP":var list='g2_g2_payrollpreparation,g2_g2_paycheckfrequency,g2_g2_payrolltaxservices,g2_g2_prtaxdepositschedule,g2_g2_1099preparation,g2_g2_ein,g2_g2_pin,g2_g2_password';_loadit({"query":query,"list":list});break;
/*Group 2_3*/case "CLIENT_ACCOUNTING_SERVICES":var list='g2_g3_accountingServices,g2_g3_bookkeeping,g2_g3_compilation,g2_g3_review,g2_g3_audit,g2_g3_financialstatementfreq,g2_g3_fiscalyearend,g2_g3_software,g2_g3_version,g2_g3_username,g2_g3_accountingpassword';_loadit({"query":query,"list":list});break;
/*Group 3*/case "CONTACT_ID":var list='co_id,g3_acctsoftwareupdate,g3_address1,g3_address2,g3_city,g3_customlabel,g3_customvalue,g3_effectivedate,g3_email1,g3_email2,g3_ext1,g3_ext2,g3_name,g3_phone1,g3_phone2,g3_phone3,g3_phone4,g3_phone5,g3_state,g3_taxupdate,g3_title,g3_type,g3_website,g3_zip';_loadit({"query":query,"list":list});break;
/*Group 5*/case "SI_ID":var list="si_id,g5_state,g5_revenue,g5_employees,g5_property,g5_nexus,g5_reason,g5_registered,g5_value1,g5_value2,g5_value3,g5_value4";_loadit({"query":query,"list":list});break;
/*Group 5_1*/case"CLIENT_STATELABEL1":var list="g5_g1_label1,g5_g1_label2,g5_g1_label3,g5_g1_label4";_loadit({"query":query,"list":list});break;
/*Group 6*/case"CLIENT_RELATIONS":var list="g6_group";_loadit({"query":query,"list":list});break;
default:if(query!=""){var list=_pluginLoadData(query.COLUMNS[0]);_loadit({"query":query,"list":list})}
else{jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};

_saveDataCB=function(params){
var options={"id":"","contact_id":"","group":"","subgroup":"","result":""}
try{	
$.extend(true, options, params);//turn options into array
switch(options["group"]){
case'':
if($("#g1_name").val()!=""){
_saveDataCB({'group':'group1'});

}
else{jqMessage({message: "You must enter a client name.",type: "info",autoClose: true})};
break;
	
case'group1':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
$("#g1_active").is(':checked')+','+
$("#g1_credit_hold").is(':checked')+',"'+
$("#g1_g3_group").val()+'","'+
$("#g1_name").val()+'","'+
$("#g1_notes").val()+'","'+
$("#g1_referred_by").val()+'","'+
$("#g1_salutation").val()+'","'+
$("#g1_since").val()+'","'+
$("#g1_spouse").val()+'","'+
$("#g1_trade_name").val()+'","'+
$("#g1_type").val()+'","'+
'"]]}'

if($("#g1_name").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Name",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Name');}
	}
else if(_duplicateCheck({"check":[{"item":"g1_name"}],"loadType":"group1","page":"clientmaintenance"})==true && $('#client_id').val()==0){
	jqMessage({"type":"destroy"});jqMessage({message: "Duplicate Client Name Found",type: "error",autoClose: false});
	if(debug){window.console.log('This Client Name already exsists.');}
	}
else if ($("#g1_salutation").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Salutation",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Salutation');}
	}
else if ($("#g1_type").val()=="0"){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Type",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Type');}
	}
else if ($("#g1_since").val()==""){
	jqMessage({"type":"destroy"});jqMessage({message: "Missing Since",type: "error",autoClose: false});
	if(debug){window.console.log('Missing Since');}
	}

else{
	jqMessage({message: "Saving.",type: "save",autoClose: true});
	_saveData({group:"group1",payload:$.parseJSON(json),page:"clientmaintenance"});
	if(debug){window.console.log('Start Saving Client Maintenance');}	
	}	
break;

case'group1_2':
$("#client_id").val(options['id'])
var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#cl_fieldid").val()+'","'+
$("#g1_g2_fieldname").val()+'","'+
$("#g1_g2_fieldvalue").val()+'",'+
$("#g1_g2_fieldglobal").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group1_2").val()!=0){
	if($("#g1_g2_fieldname").val()!=''||$("#g1_g2_fieldvalue").val()!=''){
	_saveData({group:"group1_2","payload":$.parseJSON(json),page:"clientmaintenance"});
	}else{_saveDataCB({'group':'group2_1'})}
}else{_saveDataCB({'group':'group2_1'})}
break;

case'group2_1':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
$("#g2_g1_taxservices").is(':checked')+',"'+
$("#g2_g1_formtype").val()+'",'+
$("#g2_g1_businessc").is(':checked')+','+
$("#g2_g1_rentalpropertye").is(':checked')+','+
$("#g2_g1_disregardedentity").is(':checked')+','+
$("#g2_g1_personalproperty").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group2_1").val()!=0){_saveData({group:"group2_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_2'})}
break;

case'group2_2':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
$("#g2_g2_payrollpreparation").is(':checked')+',"'+
$("#g2_g2_paycheckfrequency").val()+'",'+
$("#g2_g2_payrolltaxservices").is(':checked')+',"'+
$("#g2_g2_prtaxdepositschedule").val()+'",'+
$("#g2_g2_1099preparation").is(':checked')+',"'+
$("#g2_g2_ein").val()+'","'+
$("#g2_g2_pin").val()+'","'+
$("#g2_g2_password").val()+'","'+
'"]]}'
if($("#isLoaded_group2_2").val()!=0){_saveData({group:"group2_2","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group2_3'})}
break;

case'group2_3':var json='{"DATA":[["'+
$("#client_id").val()+'",'+
$("#g2_g3_accountingServices").is(':checked')+','+
$("#g2_g3_bookkeeping").is(':checked')+','+
$("#g2_g3_compilation").is(':checked')+','+
$("#g2_g3_review").is(':checked')+','+
$("#g2_g3_audit").is(':checked')+',"'+
$("#g2_g3_financialstatementfreq").val()+'","'+
$("#g2_g3_fiscalyearend").val()+'","'+
$("#g2_g3_software").val()+'","'+
$("#g2_g3_version").val()+'","'+
$("#g2_g3_username").val()+'","'+
$("#g2_g3_accountingpassword").val()+'","'+
'"]]}'
if($("#isLoaded_group2_3").val()!=0){_saveData({group:"group2_3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group3'})}
break;

case'group3':var json='{"DATA":[["'+
$("#co_id").val()+'","'+
$("#client_id").val()+'",'+
$("#g3_acctsoftwareupdate").is(':checked')+',"'+
$("#g3_address1").val()+'","'+
$("#g3_address2").val()+'","'+
$("#g3_city").val()+'","'+
$("#g3_customlabel").val()+'",'+
$("#g3_customvalue").is(':checked')+',"'+
$("#g3_effectivedate").val()+'","'+
$("#g3_email1").val()+'","'+
$("#g3_email2").val()+'","'+
$("#g3_ext1").val()+'","'+
$("#g3_ext2").val()+'","'+
$("#g3_name").val()+'","'+
$("#g3_phone1").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g3_phone2").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g3_phone3").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g3_phone4").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g3_phone5").val().replace(/[^0-9\.]/g, '')+'","'+
$("#g3_state").val()+'",'+
$("#g3_taxupdate").is(':checked')+',"'+
$("#g3_title").val()+'","'+
$("#g3_type").val()+'","'+
$("#g3_website").val()+'","'+
$("#g3_zip").val()+'","'+
'"]]}'
if($("#isLoaded_group3").val()!=0){_saveData({group:"group3","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group5'})}
break;

case'group5':
$("#co_id").val(options["contact_id"]);
var json='{"DATA":[["'+
$("#si_id").val()+'","'+
$("#client_id").val()+'",'+
$("#g5_employees").is(':checked')+','+
$("#g5_nexus").is(':checked')+','+
$("#g5_property").is(':checked')+',"'+
$("#g5_reason").val()+'",'+
$("#g5_registered").is(':checked')+','+
$("#g5_revenue").is(':checked')+',"'+
$("#g5_state").val()+'",'+
$("#g5_value1").is(':checked')+','+
$("#g5_value2").is(':checked')+','+
$("#g5_value3").is(':checked')+','+
$("#g5_value4").is(':checked')+',"'+
'"]]}'
if($("#isLoaded_group5").val()!=0){_saveData({group:"group5","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group5_1'})}
break;

case'group5_1':var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#g5_g1_label1").val()+'","'+
$("#g5_g1_label2").val()+'","'+
$("#g5_g1_label3").val()+'","'+
$("#g5_g1_label4").val()+'","'+
'"]]}'
if($("#isLoaded_group5_1").val()!=0){_saveData({group:"group5_1","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'group6'})}
break;

case'group6':
var json='{"DATA":[["'+
$("#client_id").val()+'","'+
$("#g6_group").val()+'","'+
'"]]}'
if($("#isLoaded_group6").val()!=0){_saveData({group:"group6","payload":$.parseJSON(json),page:"clientmaintenance"})}
else{_saveDataCB({'group':'plugins'})}
break;
/*Start Saving Plugins*/
case'plugins':_pluginSaveData();break;
/*Other Events*/
case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
default:jqMessage({message: "A exception clientMaintenance.js in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;}}
catch(err){alert(err)}};