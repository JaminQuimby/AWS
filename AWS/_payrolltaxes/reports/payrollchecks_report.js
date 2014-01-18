$(document).ready(function(){

	
_grid1()
_group1=function(){_grid1()}
});
 
_grid1=function(){

	



_toSearch=function(data,options){
try{
var json=data;
json=json.escapeIt(json); //Escape

//Search features
json=json.replaceAll('datedue<', '","datedue_less":"').replaceAll('datedue>', '","datedue_more":"').replaceAll('datedue:', '","datedue":"');
json=json.replaceAll('year<', '","year_less":"').replaceAll('year>', '","year_more":"').replaceAll('year:', '","year":"');
json=json.replaceAll('payenddate<', '","payenddate_less":"').replaceAll('payenddate>', '","payenddate_more":"').replaceAll('payenddate:', '","payenddate":"');
json=json.replaceAll('paydate<', '","paydate_less":"').replaceAll('paydate>', '","paydate_more":"').replaceAll('paydate:', '","paydate":"');
json=json.replaceAll('missinginfo:', '","missinginfo":"');
json=json.replaceAll('obtaininfo_datecompleted<', '","obtaininfo_datecompleted_less":"').replaceAll('obtaininfo_datecompleted>', '","obtaininfo_datecompleted_more":"').replaceAll('obtaininfo_datecompleted:', '","obtaininfo_datecompleted":"');
json=json.replaceAll('assembly_datecompleted<', '","assembly_datecompleted_less":"').replaceAll('assembly_datecompleted>', '","assembly_datecompleted_more":"').replaceAll('assembly_datecompleted:', '","assembly_datecompleted":"');
json=json.replaceAll('delivery_datecompleted<', '","delivery_datecompleted_less":"').replaceAll('delivery_datecompleted>', '","delivery_datecompleted_more":"').replaceAll('delivery_datecompleted:', '","delivery_datecompleted":"');
json=json.replaceAll('fees<', '","fees_less":"').replaceAll('fees>', '","fees__more":"').replaceAll('fees:', '","fees_":"');
json=json.replaceAll('paid:', '","paid":"');

json=json.replaceAll(' "', '"').replaceAll('" ', '"'); //Trim
jdata='{"Search":"' +  json  + '"}';
	

var params = $.parseJSON(jdata);

//Custom Options
var options = {
	datedue:""
		,datedue_less:""
		,datedue_more:""
	,year:""
	,payenddate:""
		,payenddate_less:""
		,payenddate_more:""
	,paydate:""
		,paydate_less:""
		,paydate_more:""
	,missinginfo:""
	,obtaininfo_datecompleted:""
		,obtaininfo_datecompleted_less:""
		,obtaininfo_datecompleted_more:""
	,assembly_datecompleted:""
		,assembly_datecompleted_less:""
		,assembly_datecompleted_more:""
	,delivery_datecompleted:""
		,delivery_datecompleted_less:""
		,delivery_datecompleted_more:""
	,fees:""
	,paid:""};

$.extend(true, options, params);
//Fist validation


if(!_isIt('date',options['datedue'])){options['datedue']=""}
if(!_isIt('date',options['datedue_less'])){options['datedue_less']=""}
if(!_isIt('date',options['datedue_more'])){options['datedue_more']=""}

if(!_isIt('date',options['year'])){options['year']=""}

if(!_isIt('date',options['payenddate'])){options['payenddate']=""}
if(!_isIt('date',options['payenddate_less'])){options['payenddate_less']=""}
if(!_isIt('date',options['payenddate_more'])){options['payenddate_more']=""}

if(!_isIt('boolean',options['missinginfo'])){options['missinginfo']=""}
if(!_isIt('date',options['obtaininfo_datecompleted'])){options['obtaininfo_datecompleted']=""}
if(!_isIt('date',options['obtaininfo_datecompleted_less'])){options['obtaininfo_datecompleted_less']=""}
if(!_isIt('date',options['obtaininfo_datecompleted_more'])){options['obtaininfo_datecompleted_more']=""}

if(!_isIt('date',options['assembly_datecompleted'])){options['assembly_datecompleted']=""}
if(!_isIt('date',options['assembly_datecompleted_less'])){options['assembly_datecompleted_less']=""}
if(!_isIt('date',options['assembly_datecompleted_more'])){options['assembly_datecompleted_more']=""}

if(!_isIt('date',options['delivery_datecompleted'])){options['delivery_datecompleted']=""}
if(!_isIt('date',options['delivery_datecompleted_less'])){options['delivery_datecompleted_less']=""}
if(!_isIt('date',options['delivery_datecompleted_more'])){options['delivery_datecompleted_more']=""}
if(!_isIt('numeric',options['fees'])){options['fees']=""}

/**/
//if(!_isIt('date',options['paid'])){options['paid']=""}


//alert(options)

return JSON.stringify(options);




}
catch (err) {
  // Do something about the exception here
	  return data;
}
 

	
}
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
			,PC_PAID:{title:'Payment Status'}
			},
	"method":"f_lookupData",
	
	"arguments":'{"search":"'+_toSearch($("#g0_filter").val())+'","orderBy":"0","row":"0","ID":"'+$("#task_id").val()+'","loadType":"group0"}',
	"functions":'window.open(window.location.protocol+"//"+window.location.hostname+"/AWS/_payrolltaxes/payrollchecks.cfm?task_id="+record.PC_ID+"&nav=0","_blank")'
	})};