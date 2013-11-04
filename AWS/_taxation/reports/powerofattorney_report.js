$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"powerofattorney_report.cfc",
	"title":"Power of Attorney",
	"fields":{PA_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PA_TAXYEARS:{title:'Tax Years'}
			,PA_TAXFORMS:{title:'Tax Forms'}
			,PA_PREPARERS:{title:'Preparers'}
			,PA_DATESIGNEDBYCLIENT:{title:'Date Signed',width:'1%'}
			,PA_DATESENTTOIRS:{title:'Date Sent',width:'1%'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_taxation/powerofattorney.cfm?task_id="+record.PA_ID'
	})};



