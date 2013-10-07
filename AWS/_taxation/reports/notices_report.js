$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
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
			,N_3_MISSINGINFO:{title:'Missing Information',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,N_2_DATENOTICEREC:{title:'Date Notice Received',width:'1%'}
			,N_2_RESDUEDATE:{title:'Response Due Date',width:'1%'}
			,N_2_RESSUBMITED:{title:'Response Submitted',width:'1%'}
			,N_2_REVREQUIRED:{title:'Review Required',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,N_1_FEES:{title:'Fees'}
			,N_1_PAID:{title:'Payment Status'}
},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};



