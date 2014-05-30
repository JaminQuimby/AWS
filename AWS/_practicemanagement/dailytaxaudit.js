$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
}
 
 
_grid1=function(){
	_jGrid({
	"grid":"grid1",
	"url":"dailytaxaudit.cfc",
	"title":"Daily Tax Audit",
	"fields":{ 
 
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"11"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_PracticeManagement/dailytaxaudit.cfm?task_id="+record.dta_ID+"&nav=0","_blank")'
	})};











