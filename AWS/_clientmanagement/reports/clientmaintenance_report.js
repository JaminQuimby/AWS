$(document).ready(function(){
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientmaintenance_report.cfc",
	"title":"Client Maintenance Report",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_SALUTATION:{title:'Salutation'}
			,CLIENT_SPOUSE:{title:'Spouse'}
			,CLIENT_CREDIT_HOLD:{title:'Credit Hold',width:'1%'}
			,CONTACT_TYPE:{title:'Type'}
			,CONTACT_NAME:{title:'Contact'}
			,CONTACT_ADDRESS2:{title:'Title'}
			,CONTACT_ADDRESS1:{title:'Address'}
			,CONTACT_CITY:{title:'City'}
			,CONTACT_STATE:{title:'State'}
			,CONTACT_ZIP:{title:'Zip',width:'1%'}
			,CONTACT_PHONE1:{title:'Work Phone',width:'1%'}
			,CONTACT_PHONE2:{title:'Ext',width:'1%'}
			,CONTACT_PHONE3:{title:'Mobile Phone',width:'1%'}
			,CONTACT_PHONE4:{title:'Home Phone',width:'1%'}
			,CONTACT_PHONE5:{title:'Fax',width:'1%'}
			,CONTACT_EMAIL1:{title:'Email 1'}
			,CONTACT_EMAIL2:{title:'Email 2'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group0"}',
	"functions":''
	})};