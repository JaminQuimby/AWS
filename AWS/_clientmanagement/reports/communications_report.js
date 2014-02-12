$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
});
 
_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"briefmessage","t":"text","v":""}
,{"n":"caller","t":"text","v":""}
,{"n":"completed","t":"boolean","v":""}
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
	"fields":{CO_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CO_CALLER:{title:'Caller'}
			,CO_FORTEXT:{title:'For'}
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
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"10"}',
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
//	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/communications.cfm?task_id="+record.CO_ID+"&nav=0","_blank")'
	})};
