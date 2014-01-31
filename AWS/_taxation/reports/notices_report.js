$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});

_grid1=function(){
var grid1_config = [
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



];
 
	_jGrid({
	"grid":"grid1",
	"url":"notices_report.cfc",
	"title":"Notices",
	"fields":{NM_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,NM_NAME:{title:'Matter Name'}
			,N_1_TAXYEAR:{title:'Tax Year',width:'1%'}
			,N_1_TAXFORM:{title:'Tax Form'}
			,N_1_NOTICENUMBER:{title:'Notice Number'}
			,N_NOTICESTATUS:{title:'Notice Status'}
			,N_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,N_2_DATENOTICEREC:{title:'Date Notice Received',width:'1%'}
			,N_2_RESDUEDATE:{title:'Response Due Date',width:'1%'}
			,N_2_RESSUBMITED:{title:'Response Submitted',width:'1%'}
			,N_2_REVREQUIRED:{title:'Review Required',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,N_1_FEES:{title:'Fees'}
			,N_1_PAID:{title:'Payment Status'}
},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"8"}',
	//"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/notices.cfm?task_id="+record.NM_ID+"&nav=0","_blank")'
	})};



