$(document).ready(function(){_grid1()});

var _run={
	  load_group1:function(){_grid1()}
	 ,load_group2:function(){_grid2()}
}
 
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"briefmessage","t":"text","v":""}
,{"n":"caller","t":"text","v":""}
,{"n":"status","t":"numeric","v":""}
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
];$.each(grid1_config, function(idx, obj) {$('.search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"Communications_report.cfc",
	"title":"Communications Report",
	"fields":{CO_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_DATE:{title:'Date and Time',width:'2%'}
			,CO_DUEDATE:{title:'Due Date',width:'2%'}
			,CO_STATUSTEXT:{title:'Status',width:'2%'}
			,CO_FORTEXT:{title:'For'}
			,CO_RESPONSENEEDED:{title:'Response Required',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_RETURNCALL:{title:'Return Call',width:'2%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CO_BRIEFMESSAGE:{title:'Brief Message'}
			,CO_TELEPHONE:{title:'Phone'}
			,CO_EXT:{title:'Ext'}
			,CO_EMAILADDRESS:{title:'Email'}
			,CO_FEES:{title:'Fees'}
			,CO_PAIDTEXT:{title:'Payment Staus'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"10"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID+"&nav=0","_blank")'

	})};
	
	_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"Communications_report.cfc",
	"title":"Communications Responses",
	"fields":{COMMENT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			 ,C_DATE:{title:'Date'}
			 ,U_NAME:{title:'Name'}
			 ,C_NOTES:{title:'Comment'}
			},
 	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","formid":"4","clientid":"'+$("#client_id").val()+'","taskid":"'+$("#task_id").val()+'","loadType":"group2"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID+"&nav=0","_blank")'
	})};
