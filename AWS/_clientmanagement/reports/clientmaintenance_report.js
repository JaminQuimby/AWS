$(document).ready(function(){
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
});

_grid1=function(){
var grid1_config = [
{"n":"search","type":"text","v":""}    
,{"n":"active","t":"boolean","v":""}
,{"n":"credit_hold","t":"boolean","v":""}
,{"n":"disregard","t":"boolean","v":""}
,{"n":"group","t":"text","v":""}
,{"n":"name","t":"text","v":""}
,{"n":"notes","t":"text","v":""}
,{"n":"personal_property","t":"boolean","v":""}
,{"n":"referred_by","t":"text","v":""}
,{"n":"relations","t":"text","v":""}
,{"n":"salutation","t":"text","v":""}
,{"n":"schedule_c","t":"boolean","v":""}
,{"n":"schedule_e","t":"boolean","v":""}
,{"n":"since","t":"date","v":""}
,{"n":"spouse","t":"text","v":""}
,{"n":"statelabel1","t":"text","v":""}
,{"n":"statelabel2","t":"text","v":""}
,{"n":"statelabel3","t":"text","v":""}
,{"n":"statelabel4","t":"text","v":""}
,{"n":"tax_services","t":"boolean","v":""}
,{"n":"trade_name","t":"text","v":""}
,{"n":"type","t":"numeric","v":""}
];$.each(grid1_config, function(idx, obj) {$('#group1 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid1",
	"url":"clientmaintenance_report.cfc",
	"title":"Client Maintenance Report",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_SPOUSE:{title:'Spouse'}
			,CLIENT_TYPETEXT:{title:'Client Type',width:"1%"}
			,CLIENT_ACTIVE:{title:'Active',width:"1%",type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_CREDIT_HOLD:{title:'Credit Hold',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_C:{title:'Business (C)',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_E:{title:'Rental Property (E)',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_DISREGARD:{title:'Disregarded Entity',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_PERSONAL_PROPERTY:{title:'Personal Property',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			},
				"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group0","formid":"1"}',
//	"functions":'window.location=window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/clientmaintenance.cfm?task_id="+$("#task_id").val();'
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_clientmanagement/clientmaintenance.cfm?task_id="+record.CLIENT_ID+"&nav=0","_blank")'
	})};  
	
_grid2=function(){
var grid2_config = [
{"n":"search","type":"text","v":""}    
,{"n":"type","t":"numeric","v":""}
,{"n":"name","t":"text","v":""}
,{"n":"address1","t":"text","v":""}
,{"n":"address2","t":"text","v":""}
,{"n":"city","t":"text","v":""}
,{"n":"state","t":"numeric","v":""}
,{"n":"zip","t":"numeric","v":""}
,{"n":"phone1","t":"text","v":""}
,{"n":"phone2","t":"text","v":""}
,{"n":"phone3","t":"text","v":""}
,{"n":"phone4","t":"text","v":""}
,{"n":"phone5","t":"text","v":""}
,{"n":"email1","t":"text","v":""}
,{"n":"email2","t":"text","v":""}
,{"n":"website","t":"text","v":""}
,{"n":"effectivedate","t":"date","v":""}
,{"n":"acctsoftwareupdate","t":"boolean","v":""}
,{"n":"taxupdate","t":"boolean","v":""}
,{"n":"customLabel","t":"text","v":""}
,{"n":"customValue","t":"boolean","v":""}

];$.each(grid2_config, function(idx, obj) {$('#group2 .search-togcan div ul').append('<li>'+obj.n+' : '+obj.t+'</li>')});
 
	_jGrid({
	"grid":"grid2",
	"url":"clientmaintenance_report.cfc",
	"title":"Client Contacts Report",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CONTACT_NAME:{title:'Contact'}
			,CONTACT_TYPETEXT:{title:'Contact Type'}
			,CONTACT_ADDRESS2:{title:'Title'}
			,CONTACT_ADDRESS1:{title:'Address'}
			,CONTACT_CITY:{title:'City'}
			,CONTACT_STATETEXT:{title:'State'}
			,CONTACT_ZIP:{title:'Zip',width:'1%'}
			,CONTACT_PHONE1:{title:'Work Phone',width:'1%'}
			,CONTACT_PHONE2:{title:'Ext',width:'1%'}
			,CONTACT_PHONE3:{title:'Mobile Phone',width:'1%'}
			,CONTACT_PHONE4:{title:'Home Phone',width:'1%'}
			,CONTACT_PHONE5:{title:'Fax',width:'1%'}
			,CONTACT_EMAIL1:{title:'Email 1'}
			,CONTACT_EMAIL2:{title:'Email 2'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":'+_toReport($("#g2_filter").val(),grid2_config)+',"orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group2","formid":"1"}',
	"functions":''
	})}; 
	 