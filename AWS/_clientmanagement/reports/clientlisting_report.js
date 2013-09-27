$(document).ready(function(){
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientlisting_report.cfc",
	"title":"Client Listing Status",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name',width:'15%'}
			,CLIENT_SALUTATION:{title:'Salutation',width:'5%'}
			,CLIENT_SPOUSE:{title:'Spouse',width:'5%'}
			,CLIENT_CREDIT_HOLD:{title:'Credit Hold',width:'5%'}
			,CONTACT_ID:{key:true,list:false,edit:false}
			,CONTACT_TYPE:{title:'Type',width:'5%'}
			,CONTACT_NAME:{title:'Contact',width:'5%'}
			,CONTACT_ADDRESS2:{title:'Title',width:'5%'}
			,CONTACT_ADDRESS1:{title:'Address',width:'5%'}
			,CONTACT_CITY:{title:'City',width:'5%'}
			,CONTACT_STATE:{title:'State',width:'5%'}
			,CONTACT_ZIP:{title:'Zip',width:'1%'}
			,CONTACT_PHONE1:{title:'Work Phone',width:'5%'}
			,CONTACT_PHONE2:{title:'Ext',width:'5%'}
			,CONTACT_PHONE3:{title:'Mobile Phone',width:'5%'}
			,CONTACT_PHONE4:{title:'Home Phone',width:'5%'}
			,CONTACT_PHONE5:{title:'Fax',width:'5%'}
			,CONTACT_EMAIL1:{title:'Email 1',width:'5%'}
			,CONTACT_EMAIL2:{title:'Email 2',width:'5%'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group0"}',
	"functions":''
	})};