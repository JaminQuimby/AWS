// JavaScript Document


/*Create Table Instance - accountingSoftware*/   
 $(document).ready(function () {
        $('#accountingSoftware').jtable({
            title: 'Software Name',
            actions: {
                listAction: 'maintenance.cfc?method=myFun&loadType=true',
		
                createAction: '/maintenance.cfc/myFunction',
                updateAction: '/maintenance.cfc/myFunction',
                deleteAction: '/maintenance.cfc/myFunction'
            },
            fields: {
                PersonId: {
                    key: true,
                    list: false
                },
                Name: {
                    title: 'Author Name',
                    width: '40%'
                },
                Age: {
                    title: 'Age',
                    width: '20%'
                },
                RecordDate: {
                    title: 'Record date',
                    width: '30%',
                    type: 'date',
                    create: false,
                    edit: false
                }
            }
        });
    });
/*Load jQuery UI Objects*/	
$(function(){

$("#entrance").accordion({heightStyle:"content"});
$("#group1").accordion({heightStyle:"content"});
$("#group2").accordion({heightStyle:"content"});
$("#group3").accordion({heightStyle:"content"});
$("#group4").accordion({heightStyle:"content"});
$.datepicker.setDefaults({
showOn: "both",
buttonImageOnly: true,
buttonImage: "../assets/img/datepicker.gif",
constrainInput: true
});

$('#accountingSoftware').jtable('load');

});