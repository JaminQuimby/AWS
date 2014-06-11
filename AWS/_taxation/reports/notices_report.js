$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
}
 

_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"assignedto","t":"numeric","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"esttime","t":"numeric","v":""}
,{"n":"missinginfo","t":"boolean","v":""}
,{"n":"missinginforeceived","t":"date","v":""}
,{"n":"status","t":"numeric","v":""}
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



];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"notices_report.cfc",
	"title":"Notices",
	"fields":{N_ID:{key:true,list:false,edit:false}
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
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"8"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.N_ID+"&nav=0","_blank")'
	})};



