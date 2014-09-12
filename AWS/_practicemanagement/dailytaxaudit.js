$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
}
 
 
_grid1=function(){
	_jGrid({
	"grid":"grid1",
	"url":"dailytaxaudit.cfc",
	"title":"Daily Tax Audit",
	"fields":{COLUMN_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,COLUMN1:{title:''}
			,COLUMN3:{title:'Today',width:'2%'}
			,COLUMN4:{title:'Year to Date',width:'2%'}
			,COLUMN5:{title:'Prior Year to Date',width:'2%'}
			,COLUMN6:{title:'Prior Year',width:'2%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group0","formid":"11"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_PracticeManagement/dailytaxaudit.cfm?task_id="+record.dta_ID+"&nav=0","_blank")'
	})};











