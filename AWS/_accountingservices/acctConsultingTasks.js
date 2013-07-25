/*
Javascript for Client Acct Consulting Tasks
Developers: Jamin Quimby
*/


/*LOAD jQUERY UI*/
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
$("#g1_duedate").datepicker();
$("#g1_requestforservices").datepicker();
$("#g1_workinitiated").datepicker();
$("#g1_duedate").datepicker();
$("#g1_projectcompleted").datepicker();
$("#g2_duedate").datepicker();
$("#g2_completed").datepicker();

});

/*Javascript Functions
getDataFunction = returns a function for buildGrid in aws.js
resetDocument = Reset form to default
*/
getDataFunction=function(id,tbl,name){var e=document.getElementById('cl_id');
switch(tbl){
	
//case'gridClients': return function(){e.value=id;updateh3(name);loadData(id,"client");lookupData('',e.value,'contact');toggle('client,largeMenu');lookupData('',e.value,'customfields');hide('entrance,services,contacts,maintenance,state,smallMenu');document.getElementById('content').className='contentbig';};break;
//case'gridContacts': return function(){loadData(id,"contact");};break;


default:return function(){alert('Error - Missing Table')}
}};


resetDocument=function(){
	resetFields(null,'');
	lookupData('','','client');
	document.getElementById('content').className='contentsmall';
	toggle('entrance,smallMenu');hide('group1,group2,group3,group4,largeMenu');
	highlight(document.getElementById('menuLeft').firstChild.firstChild);};


/*Ajax Functions
saveData = Ajax send data to clientManagement.cfc
getData = Ajax 
loadData = Ajax return data populate the dom elements
lookupData = Ajax lookup data in a query
*/


lookupData=function(id,clid,group){
	var e=new cm();e.setCallbackHandler(lookupDataCB);e.setErrorHandler(errorHandle);
	switch(group){
	
//case'client':e.f_lookupData(id,'0','0','0','client');break;
//case'contact':e.f_lookupData(id,'0','0',clid,'contact');break;

	}};
	
lookupDataCB=function(query){
switch(query.COLUMNS[0]){
	
/*Load Grid Clients*/
//case'CLIENT_ID':buildGrid(query,'gridClients');break;

	}};
	
	
loadData=function(id,group){var e=new cm();e.setCallbackHandler(loadDataCB);e.setErrorHandler(errorHandle);
switch(group){

//case'client':e.f_loadData(id,group,'client');break;
//case'contact':e.f_loadData(id,group,'contact');break;

	}};

loadDataCB=function(query){
/*TRIGGER CALLS IN SUSESSION WHEN NEEDED*/
var e=new cm(),cl_id=document.getElementById("cl_id").value;e.setCallbackHandler(loadDataCB);e.setErrorHandler(errorHandle);
/*LOAD DATA BASED ON QUERY RETURN*/
switch(query.COLUMNS[0]){
	
	
//case "CLIENT_NAME":var list='cl_name,cl_salutation,cl_type,cl_since,cl_trade_name,cl_referred_by,cl_spouse,cl_dms_reference,cl_active,cl_credit_hold,cl_notes';loadit(query,list);e.f_loadData(cl_id,"taxes");break;
/*get Elements for Taxes*/
//case "CLIENT_TAX_SERVICES":var list='t_taxservices,t_formtype,t_businessc,t_rentalpropertye,t_disregardedentity,t_personalproperty';loadit(query,list);e.f_loadData(cl_id,"payroll");break;


default: alert("QUERY EMPTY");}};


saveData=function(){

/*
var e0=document.getElementById("cl_id").value,
e1=document.getElementById("cl_name").value,
e2=document.getElementById("cl_salutation").value,
e3=document.getElementById("cl_type").value,
e4=document.getElementById("cl_since").value,
e5=document.getElementById("cl_trade_name").value,
e6=document.getElementById("cl_referred_by").value,
e7=document.getElementById("cl_spouse").value,
e8=document.getElementById("cl_dms_reference").value,
e9=document.getElementById("cl_active").checked,
e10=document.getElementById("cl_credit_hold").checked,
e11=document.getElementById("cl_notes").value,
json='{"DATA":[["'+e0+'","'+e1+'","'+e2+'","'+e3+'","'+e4+'","'+e5+'","'+e6+'","'+e7+'","'+e8+'","'+e9+'","'+e10+'","'+e11+'"]]}',e=new cm();
e.setCallbackHandler(saveDataCB);e.setErrorHandler(errorHandle); 
if(e0==0){e.f_saveData('insert','client',json);}else{e.f_saveData('update','client',json);}
*/
};

saveDataCB=function(e0){
	
/*Build arguments for Taxes
var e1=document.getElementById("t_taxservices").checked
,e2=document.getElementById("t_formtype").value
,e3=document.getElementById("t_businessc").checked
,e4=document.getElementById("t_rentalpropertye").checked
,e5=document.getElementById("t_disregardedentity").checked
,e6=document.getElementById("t_personalproperty").checked;
*/
var e=new cm();e.setCallbackHandler(saveDataCB);e.setErrorHandler(errorHandle); 
switch(e0.NEXT){
//case'taxes':var json='{"DATA":[["'+e0.ID+'","'+e1+'","'+e2+'","'+e3+'","'+e4+'","'+e5+'","'+e6+'"]]}';e.f_saveData('update','taxes',json);document.getElementById('cl_id').value=e0.ID;break;

case'error':var err="ErrorID:"& e0.ID +"Details:"+ e0.ERROR; notice(err,'error'); break;
case'none': resetDocument(); alert(e0.ID); break;
case'saved':alert('Your document has been saved.');break;
default:alert(e0.ID);
}};


/*Error Handelers*/
errorHandle=function(code,msg){alert(code+":"+msg);};