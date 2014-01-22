$(document).ready(function(){

	
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){

<<<<<<< HEAD
<<<<<<< HEAD
var grid1_config = [
{"n":"search","type":"text","v":""}
,{"n":"altfreq","t":"boolean","v":""}
,{"n":"assembly_assignedto","t":"date","v":""}
,{"n":"assembly_datecompleted","t":"date","v":""}
,{"n":"assembly_completedby","t":"date","v":""}
,{"n":"assembly_esttime","t":"numeric","v":""}
,{"n":"clientname","t":"date","v":""}
,{"n":"datedue","t":"date","v":""}
,{"n":"deliverymethod","t":"numeric","v":""}
,{"n":"delivery_assignedto","t":"date","v":""}
,{"n":"delivery_datecompleted","t":"date","v":""}
,{"n":"delivery_completedby","t":"date","v":""}
,{"n":"delivery_esttime","t":"numeric","v":""}
,{"n":"esttime","t":"date","v":""}
,{"n":"fees","t":"numeric","v":""}
,{"n":"missinginfo","t":"date","v":""}
,{"n":"missinginforeceived","t":"boolean","v":""}
,{"n":"obtaininfo_assignedto","t":"date","v":""}
,{"n":"obtaininfo_datecompleted","t":"date","v":""}
,{"n":"obtaininfo_completedby","t":"date","v":""}
,{"n":"obtaininfo_esttime","t":"numeric","v":""}
,{"n":"paid","t":"text","v":""}
,{"n":"payenddate","t":"date","v":""}
,{"n":"paydate","t":"date","v":""}
,{"n":"preparation_assignedto","t":"date","v":""}
,{"n":"preparation_datecompleted","t":"date","v":""}
,{"n":"preparation_completedby","t":"date","v":""}
,{"n":"preparation_esttime","t":"numeric","v":""}
,{"n":"review_assignedto","t":"date","v":""}
,{"n":"review_datecompleted","t":"date","v":""}
,{"n":"review_completedby","t":"date","v":""}
,{"n":"review_esttime","t":"numeric","v":""}
,{"n":"year","t":"numeric","v":""}
];
=======
=======
>>>>>>> 11cc8cac59cb80c2ef6f955de8efff87ab9ebfd3
var config = [
{"name":"datedue","type":"date","value":""}
,{"name":"year","type":"date","value":""}
,{"name":"payenddate","type":"date","value":""}
,{"name":"missinginfo","type":"boolean","value":""}
,{"name":"obtaininfo_datecompleted","type":"date","value":""}
,{"name":"assembly_datecompleted","type":"date","value":""}
,{"name":"delivery_datecompleted","type":"date","value":""}
,{"name":"fees","type":"text","value":""}
,{"name":"paid","type":"text","value":""}
];


_toSearch=function(data,config,options){
try{
//Build Default Options if none provided	
if( $.type( options ) === "undefined"){
var list='"search":""';
$.each(config, function(i){
list=list+',"'+config[i].name+'":""';
switch(config[i].type){
case'date':list=list+',"'+config[i].name+'_less":""';list=list+',"'+config[i].name+'_more":""';break;
default:}
options = '{'+list+'}'})}
//Build json data string
var json=data;
//Escape unecessary chars
json=json.escapeIt(json); //Escape
//expand options search types
$.each(config, function(i){
json=json.replaceAll(config[i].name+':', '","'+config[i].name+'":"');	
switch(config[i].type){
case'date':
json=json.replaceAll(config[i].name+'<', '","'+config[i].name+'_less":"')
json=json.replaceAll(config[i].name+'>', '","'+config[i].name+'_more":"')
break;
default:
//  code to be executed if n is different from case 1 and 2
}});
//remove unecessary whitespace
json=json.replaceAll(' "', '"').replaceAll('" ', '"'); //Trim
//format json structure
jdata='{"Search":"' +  json  + '"}';
var params = $.parseJSON(jdata);
$.extend(true, options, params);
//remove junk data to avoid unecessary error prompts from server
$.each(config, function(i){
switch(config[i].type){
case'date':
if(!_isIt('date',options[config[i].name])){options[config[i].name]=""}
if(!_isIt('date',options[config[i].name+'_less'])){options[config[i].name+'_less']=""}
if(!_isIt('date',options[config[i].name+'_more'])){options[config[i].name+'_more']=""}
break;
case'boolean':if(!_isIt('boolean',options['missinginfo'])){options['missinginfo']=""}break;
case'text': break;
}});
//Return formated data
return JSON.stringify(options);

}
catch (err) {
  // Do something about the exception here
	  return data;
}
 

	
}
>>>>>>> 11cc8cac59cb80c2ef6f955de8efff87ab9ebfd3
	_jGrid({
	"grid":"grid1",
	"url":"payrollchecks_report.cfc",
	"title":"Payroll Check Status",
	"fields":{PC_ID:{key:true,list:false,edit:false}
			,CLIENT_NAME:{title:'Client Name'}
			,PC_DATEDUE:{title:'Due Date',width:'1%'}
			,PC_YEAR:{title:'Year',width:'1%'}
			,PC_PAYENDDATE:{title:'Pay End',width:'1%'}
			,PC_PAYDATE:{title:'Pay Date',width:'1%'}
			,PC_MISSINGINFO:{title:'Missing Info',width:'1%',type:"checkbox",values:{ '0' : 'No', '1' : 'Yes' }}
			,PC_OBTAININFO_DATECOMPLETED:{title:'Information Received',width:'1%'}
			,PC_ASSEMBLY_DATECOMPLETED:{title:'Assembled',width:'1%'}
			,PC_DELIVERY_DATECOMPLETED:{title:'Delivered',width:'1%'}
			,PC_FEES:{title:'Fees'}
			,PC_PAIDTEXT:{title:'Payment Status'}
			},
	"method":"f_lookupData",
<<<<<<< HEAD
<<<<<<< HEAD
	"arguments":'{"search":'+_toReport($("#g0_filter").val(),grid1_config)+',"orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0","formid":"10"}',
=======
	"arguments":'{"search":"'+_toSearch($("#g0_filter").val(),config)+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
>>>>>>> 11cc8cac59cb80c2ef6f955de8efff87ab9ebfd3
=======
	"arguments":'{"search":"'+_toSearch($("#g0_filter").val(),config)+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
>>>>>>> 11cc8cac59cb80c2ef6f955de8efff87ab9ebfd3
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID+"&nav=0","_blank")'
	})};