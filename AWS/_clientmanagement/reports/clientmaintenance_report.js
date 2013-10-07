$(document).ready(function(){
		jqMessage({message: "Actively being changed by: Raymond Smith. Please do not add data to the database for this module.",type: "information",autoClose: false});
_grid1()
_group1=function(){_grid1()}
_group2=function(){_grid2()}
});
 
_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"clientmaintenance_report.cfc",
	"title":"Client Maintenance Report",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CLIENT_TYPE:{title:'Client Type',width:"1%"}
			,CLIENT_TRADE_NAME:{title:'Trade Name'}
			,CLIENT_ACTIVE:{title:'Active',width:"1%"}
			,CLIENT_SALUTATION:{title:'Salutation'}
			,CLIENT_SPOUSE:{title:'Spouse'}
			,CLIENT_CREDIT_HOLD:{title:'Credit Hold',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_C:{title:'Business (C)',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_SCHEDULE_E:{title:'Rental Property (E)',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_DISREGARD:{title:'Disregarded',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,CLIENT_PERSONAL_PROPERTY:{title:'Personal Property',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			},
			
/*			
			            //CHILD GRID DEFINITION FOR "CONTACTS"
                Contacts: {title: '',width: '5%',sorting: false,edit: false,create: false,display: function (clientData) {
                        //Create an image that will be used to open child table
                        var $img = $('<img src="" title="Contacts" />');
                        //Open child table when user clicks the image
                        $img.click(function () {
                            $('#ClientGridContainer').jgrid('openChildGrid',
                                    $img.closest('tr'),
                                    {
                                        title: 'Contacts',
                                        fields: {CLIENT_ID: {key:true,list:false,edit:false}
												,CONTACT_ID: {list:false,edit:false}
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
												,CONTACT_EMAIL2:{title:'Email 2'}

                                        }
                                    }, function (data) { //opened handler
                                        data.childGrid.jgrid('load');
                                    });
                        });
                        //Return image to show on the client row
                        return $img;
                    }
                },
*/


	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group0"}',
	"functions":''
	})};  
	
_grid2=function(){_jGrid({
	"grid":"grid2",
	"url":"clientmaintenance_report.cfc",
	"title":"Client Contacts Report",	
	"fields":{CLIENT_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,CONTACT_NAME:{title:'Contact'}
			,CONTACT_TYPE:{title:'Contact Type'}
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
			,CONTACT_EMAIL2:{title:'Email 2'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g2_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("#client_id").val()+'","loadType":"group2"}',
	"functions":''
	})}; 
	 