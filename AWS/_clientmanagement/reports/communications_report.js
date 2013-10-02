$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
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
			,CO_DATE:{title:'Date',width:"1%"}
			,CO_TELEPHONE:{title:'Phone'}
			,CO_EXT:{title:'Ext'}
			,CO_EMAILADDRESS:{title:'Email Address'}
			,CO_RESPONSENEEDED:{title:'Response Needed',width:"1%"}
			,CO_RETURNCALL:{title:'Return Call',width:"1%"}
			,CO_COMPLETED:{title:'Completed',width:"1%"}
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":''
	})};
