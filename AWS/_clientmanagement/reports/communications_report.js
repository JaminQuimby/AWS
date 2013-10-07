$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"Communications_report.cfc",
	"title":"Communications Report",
	"fields":{CO_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_FOR:{title:'For'}
			,CO_FEES:{title:'Fees'}
			,CO_PAID:{title:'Paid'}
			,CO_DATE:{title:'Date',width:'1%'}
			,CO_TELEPHONE:{title:'Phone'}
			,CO_EXT:{title:'Ext'}
			,CO_EMAILADDRESS:{title:'Email Address'}
			,CO_RESPONSENEEDED:{title:'Response Needed',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_RETURNCALL:{title:'Return Call',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_COMPLETED:{title:'Completed',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};
	
	_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"Communications_report.cfc",
	"title":"Communications Responses",
	"fields":{COMMENT_ID:{key:true,list:false,edit:false}
			 ,C_DATE:{title:'Date'}
			 ,U_NAME:{title:'Name'}
			 ,C_NOTES:{title:'Comment'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","formid":"4","clientid":"'+$("#client_id").val()+'","taskid":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":''
	})};
