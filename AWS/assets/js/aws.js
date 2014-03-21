/*Developer: Jamin Quimby*/
//prototype 
String.prototype.replaceAll = function (find, replace){var str = this; return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace)};
String.prototype.has = function(text) { return this.toLowerCase().indexOf("" + text.toLowerCase() + "") != -1; };
String.prototype.insert = function (index, string) {if (index > 0) return this.substring(0, index) + string + this.substring(index, this.length); else return string + this;};
Array.prototype.removeValue = function(name, value){var array = $.map(this, function(v,i){return v[name] === value ? null : v;});this.length = 0;this.push.apply(this, array);}
String.prototype.escapeIt = function(text) {return text.replace(/[-[\]{}()*+?.,\\^$|#"]/g, "\\$&")};
Date.prototype.mmddyyyy = function(){var yyyy=this.getFullYear().toString(),mm=(this.getMonth()+1).toString(),dd=this.getDate().toString();return(mm[1]?mm:"0"+mm[0])+'/'+(dd[1]?dd:"0"+dd[0])+'/'+yyyy};


//Localisation 
var debug=true;
$(document).ready(function(){

$.ajaxSetup({cache:false});//Stop ajax cacheing
$.datepicker.setDefaults({showOn:"button",buttonImageOnly:true,buttonImage:"https://"+window.location.hostname+"/AWS/assets/img/datepicker.gif",showButtonPanel:true,constrainInput:true});
$(".datetime").datetimepicker({timeFormat: 'hh:mmtt'}).mask('00/00/0000 00:00:00');
$(".date").datepicker().mask('00/00/0000');
$(".time").timepicker().mask('00:00:00');
$('.phone').mask('(000)000-0000');
$('select').chosen();
$('.gf-checkbox').hide();
$('#entrance').show();
$('.gf-checkbox').accordion({collapsible:true,heightStyle:"content",active:false,active:0});

$('.accordianclose').hide();
var icons=$('.gf-checkbox').accordion( "option", "icons" );
$('.accordianopen').click(function(){
	$('.ui-accordion-header').removeClass('ui-corner-all').addClass('ui-accordion-header-active ui-state-active ui-corner-top').attr({'aria-selected': 'true','tabindex': '0'});
	$('.ui-accordion-header-icon').removeClass(icons.header).addClass(icons.headerSelected);
	$('.ui-accordion-content').addClass('ui-accordion-content-active').attr({'aria-expanded': 'true','aria-hidden': 'false'}).show();
	$(this).attr("disabled","disabled");
	$('.accordianclose').removeAttr("disabled");
	$('.accordianopen').hide();
	$('.accordianclose').show();
	});
$('.accordianclose').click(function(){
	$('.ui-accordion-header').removeClass('ui-accordion-header-active ui-state-active ui-corner-top').addClass('ui-corner-all').attr({'aria-selected': 'false','tabindex': '-1'});
	$('.ui-accordion-header-icon').removeClass(icons.headerSelected).addClass(icons.header);
	$('.ui-accordion-content').removeClass('ui-accordion-content-active').attr({'aria-expanded': 'false','aria-hidden': 'true'}).hide();
	$(this).attr("disabled","disabled");
	$('.accordianopen').removeAttr("disabled");
	$('.accordianopen').show();
	$('.accordianclose').hide();
	});
$('.ui-accordion-header').click(function(){
	$('.accordianopen').removeAttr("disabled");
	$('.accordianclose').removeAttr("disabled");
        
	});
$( "<div class='switch'></div>" ).insertAfter( ".ios-switch,.ios-switchb" );
	
	
_toCSV=function($table, filename) {

        var $rows = $table.find('tr:has(td)'),

            // Temporary delimiter characters unlikely to be typed by keyboard
            // This is to avoid accidentally splitting the actual contents
            tmpColDelim = String.fromCharCode(11), // vertical tab character
            tmpRowDelim = String.fromCharCode(0), // null character

            // actual delimiter characters for CSV format
            colDelim = '","',
            rowDelim = '"\r\n"',

            // Grab text from table into CSV formatted string
            csv = '"' + $rows.map(function (i, row) {
                var $row = $(row),
                    $cols = $row.find('td');

                return $cols.map(function (j, col) {
                    var $col = $(col),
                        text = $col.text();

                    return text.replace('"', '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim) + '"',

            // Data URI
            csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
			window.location="data:application/csv;charset=utf-8," + encodeURIComponent(csv)

        $(this)
            .attr({
            'download': filename,
                'href': csvData,
                'target': '_blank'
        });
		
    }

    // This must be a hyperlink
    $(".export").on('click', function (event) {
        // CSV
        _toCSV.apply(this, [$('#'+$table+'>table'), 'export.csv']);
        
        // IF CSV, don't do event.preventDefault() or return false
        // We actually need this to be a typical hyperlink
    });
});

_duplicateCheck=function(params){
if(debug){window.console.log('_duplicateCheck Start');}
var options={"check":"","loadType":"","page":""},str='';
$.extend(true,options,params);
$.each(options['check'],function(idx,obj){if($('#'+obj.item).is(':checkbox')){str=str+$('#'+obj.item).is(':checkbox')}else{str=str+$('#'+obj.item).val()}
if(idx!=options['check'].length -1 ){str=str+','}});
if(debug){window.console.log('_duplicateCheck Check '+str);}
$.ajax({type:'GET',async:false,data:{"returnFormat":"json","argumentCollection":JSON.stringify({"check":""+str+"","loadType":options['loadType']})}
,url: options['page']+'.cfc?method=f_duplicateCheck'
,success:function(data){j=$.parseJSON(data);str=j.check;}
,error:function(data){str=false;}
});return str; if(debug){window.console.log('_duplicateCheck Return:'+str);}}; 

 
_addNewTask=function(){
if($('#task_id').val()==0){
	 $('label .fa-lock').removeClass('fa-lock').addClass('fa-unlock');
	 $('label').siblings(':disabled').prop('disabled', false).trigger("chosen:updated");
	 $('label').siblings(':disabled').prop('disabled', false);	 
}}
_schk=function(i){
if(user["role"]==1){
if($('#'+i).is(":disabled")){
	$('label[for="'+i+'"] i').removeClass('fa-lock').addClass('fa-unlock');
	if($('#'+i).is('select')){
	$('#'+i).prop("disabled", false).trigger("chosen:updated");
	}else{$('#'+i).prop("disabled", false);}}}}
	

_toReport=function(data,config){
//Build Report Groups
//Build a basic json object
	var jgroup = $.parseJSON('{"b":[]}');
//split human grouped input
	group = data.split(')');
$.each(group, function(i){	
//FIRST GROUP
if(group[i]!=''){
	if(!group[i].match(/(and\s*\()|(or\s*\()/gi)){		
	var a=group[i].replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	jgroup.b.push($.parseJSON('{"t":"NONE","g":'+JSON.stringify(_toBuild(a.replace(/\s*\(\s*/,''),config))+'}'))}			
//AND GROUP
	if(group[i].match(/\band\s*\(/gi)){
	//Remove AND and trim whitespace
	var b=group[i].replace(/\band\s*\(/gi, '').replace(/^\s\s*/, '').replace(/\s\s*$/, '')
	jgroup.b.push($.parseJSON('{"t":"AND","g":'+JSON.stringify(_toBuild(b.replace(/\s*\(\s*/,''),config))+'}'))}	
//OR GROUP
	if(group[i].match(/\bor\s*\(/gi)){
	var c=group[i].replace(/\bor\s*\(/gi, '').replace(/^\s\s*/, '').replace(/\s\s*$/, '')
	jgroup.b.push($.parseJSON('{"t":"OR","g":'+JSON.stringify(_toBuild(c.replace(/\s*\(\s*/,''),config))+'}'))}
}})
return JSON.stringify(jgroup);

	}


_toBuild=function(data,config,options){
try{
//Build Default Options if none provided	
if( $.type( options ) === "undefined"){
var list='"search":""';
$.each(config, function(i){
list=list+',"'+config[i].n+'":""';
list=list+',"'+config[i].n+'_less":""';
list=list+',"'+config[i].n+'_more":""';
list=list+',"'+config[i].n+'_not":""';
options='{'+list+'}'})
}


//Build json data string
var json=data;
$.each(config, function(i){
	if(json.has('#EMPLOYEE')){
		
if($("#filter_username").length == 0) {
if(debug){window.console.log('_toBuild : Element filter_username does not exsist');}
var filename = window.location.pathname.substring(window.location.pathname.lastIndexOf('/')+1).split(".");
var sel = $('<select id=\"filter_username\">').appendTo('body');
if(debug){window.console.log('_toBuild : Start Load Select '+filename[0]);}

_loadSelect({"selectName":"selectUsers","option1":"","selectObject":"filter_username","page":""+filename[0]+""});

sel.hide().change(function() {
if(debug){window.console.log('select onchange load _group1() ');}
_group1();
}).appendTo("#g1_searchOptions").chosen();
if(debug){window.console.log('_toBuild : append and chosen() ')}
sel.wrap( "<label for='filter_username'>Employee Name</label><div></div>");
if(debug){window.console.log('_toBuild : Load Select Complete ')}
}}
json=json.replaceAll('#EMPLOYEE', $('#filter_username').val());
json=json.replaceAll('#TODAY', new Date().mmddyyyy());
});

//Escape unecessary chars
json=json.escapeIt(json); //Escape

//expand options search types


$.each(config, function(i){

json=json.replaceAll(config[i].n+':', '","'+config[i].n+'":"');
json=json.replaceAll(config[i].n+'<', '","'+config[i].n+'_less":"').replaceAll(config[i].n+'>', '","'+config[i].n+'_more":"');
json=json.replaceAll(config[i].n+'!', '","'+config[i].n+'_not":"');

});


//remove unecessary whitespace
json=json.replaceAll(' "', '"').replaceAll('" ', '"'); //Trim

//format json structure
jdata='{"search":"' +  json  + '"}';
var params = $.parseJSON(jdata);
options = $.parseJSON(options);
$.extend(true, options, params);
var xgroup = $.parseJSON('[]');
$.each(options, function (i) {
    if (options[i] != "") {
        $.each(config,function(c){
		
		if(config[c].n===i||config[c].n+'_less'===i||config[c].n+'_more'===i||config[c].n+'_not'===i){
		
		
		 
		  switch(config[c].t){
                case'date':
				
					if(_isIt('date',options[i])){if(debug){window.console.log('_toBuild Date: i='+i+' t='+config[c].t+' v='+options[i]);}
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))
					}else{
						if(debug){window.console.log('_toBuild Date None: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					
					break;
					
                case'numeric':
				
					if(_isIt('numeric',options[i])){if(debug){window.console.log('_toBuild Numeric: i='+i+' t='+config[c].t+' v='+options[i]);}
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))
					}else{
						if(debug){window.console.log('_toBuild numeric None: i='+i+' t='+config[c].t+' v='+options[i]);}						
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					break;
					
				case'boolean':
			
					if(_isIt('boolean',options[i])){if(debug){window.console.log('_toBuild Boolean: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(options[i].match(/^True|^False|^true|^yes|^1/)){
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"1"}'))
					}else{	
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"0"}'))
					}}
					
					else{
						if(debug){window.console.log('_toBuild Boolean None: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					break;
					
				default:
				if(debug){window.console.log('_toBuild Default: i='+i+' t='+config[c].t+' v='+options[i]);}
				xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))		
					
				
}}})}});


return xgroup;
}
catch (err) {
  return '{"n":"search","v":'+data+'}';
}}


/*jtable Helper Object*/
_jGrid=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":"",//&method=
		"showfields":""
	
	}
	$.extend(true,options,params);

var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});

$(grid).jtable('destroy');

$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
			toolbar: {
    items: [{
        icon: ' ',
        text: 'Export to Excel',
        click: function () {
         _toCSV($('#'+options['grid']+' table'), 'export.csv');
        }
    }]
},
	selecting:true,
	actions:{
	listAction:options['url']+"?returnFormat=json&method="+options['method']+"&argumentCollection="+options['arguments'],
	},
	fields:options['fields'],
		selectionChanged:function(){
			var $selectedRows=$(grid).jtable('selectedRows');//Get all selected rows
				$('#SelectedRowList').empty();
                if($selectedRows.length > 0){//Show selected rows
                   $selectedRows.each(function(){
					var record=$(this).data('record');
						eval(options['functions']);//Functions for onclick
					});
                }else{
                    //No rows selected
                 $('#SelectedRowList').append('No row selected! Select rows to see here...');
				 }}});
				 
//var loadColumns =options['showfields'].split(",");
//for(var i=0; i<loadColumns.length; i++){
//$(grid).jtable('changeColumnVisibility',loadColumns[i],'visible')
//}
if(debug){window.console.log('_jGrid : load jtable');}
$(grid).jtable('load')};

_jGridReport=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":"",//&method=
		"sort":""
	}
	$.extend(true, options, params);
	var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});
$(grid).jtable('destroy');
$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
	selecting:true,
	sorting: true, //Enable sorting
	defaultSorting: options['sort'], //Set default sorting
	columnResizable: true, //Actually, no need to set true since it's default
	columnSelectable: true, //Actually, no need to set true since it's default
	saveUserPreferences: true, //Actually, no need to set true since it's default
	actions:{
	listAction:options['url']+"?returnFormat=json&method="+options['method']+"&argumentCollection="+options['arguments'],
	},
	fields:options['fields'],
		selectionChanged:function(){
			var $selectedRows=$(grid).jtable('selectedRows');//Get all selected rows
				$('#SelectedRowList').empty();
                if($selectedRows.length > 0){//Show selected rows
                   $selectedRows.each(function(){
					var record=$(this).data('record');
						eval(options['functions']);//Functions for onclick
					});
                }else{
                    //No rows selected
                 $('#SelectedRowList').append('No row selected! Select rows to see here...');
				 }}});
$(grid).jtable('load')};

//Load Data
_loadData=function(params){
if(debug){window.console.log('_loadData : Starting');}
var options={"id":"","group":"","page":"","plugin":""}
try{$.extend(true, options, params);
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
if($('#'+options["id"]).is("select")){
var i=$('#'+options["id"]+' option:selected').val();
	}else{
var i=$('#'+options["id"]).val();		
		}
$.ajax({type:'GET',url:options["url"]+options["page"]+'.cfc?method=f_loadData',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"id":i,"loadType":options["group"]})}
,success:function(json){
	_loadDataCB($.parseJSON(json))
	}
,error:function(data){errorHandle($.parseJSON(data))}})}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};
//Save Data
_saveData=function(params){
var options={"group":"","payload":"","page":"","id":"","plugin":""}
try{	
$.extend(true, options, params);//turn options into array
if(options["payload"]!=""||options["payload"]=="undefined"){
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
$.ajax({
  type: 'GET',
  url:options["url"]+options["page"]+'.cfc?method=f_saveData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"payload":JSON.stringify(options["payload"])})}
  ,success:function(json){_saveDataCB($.parseJSON(json))},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});}else{_saveDataCB({"id":options["id"],"group":options["group"]});}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
}
//Load It
_loadit=function(params){
	var options={"query":"","list":""}
	$.extend(true, options, params);//turn options into array
	var list=options['list'].split(',');//Split List
try{if(options['query'].DATA!=""){
	for(var i=0;i<list.length;i++){
			switch(document.getElementById(list[i]).type){
				case"checkbox":$("#"+list[i]).prop('checked',options['query'].DATA[0][i]);break;
				case"select-one":
				$("#"+list[i]+' option').each(function(index){
					if(options['query'].DATA[0][i]==$(this).val()){
						$(this).attr('selected', true).prop('selected', true);
						//$(this).prop('selected', true);
	}})
	$('#'+list[i]).trigger("chosen:updated");
	break;
				case"select-multiple":
				var str=options['query'].DATA[0][i]+",";
				if(str!=null){
				var sstr=str.split(',');
				$("#"+list[i]+' option').each(function(index){
					for(var i=0;i<sstr.length;i++){
						if(sstr[i]==$(this).val()){
							$(this).attr('selected', true).prop('selected', true);
							//$(this).prop('selected', true);
	}}})
	$('#'+list[i]).trigger("chosen:updated");
	}
	break;
				case undefined:/*Detection for undefined objects such as <LABEL>*/
				$("#"+list[i]).html(options['query'].DATA[0][i]);break;
				default:$("#"+list[i]).val(options['query'].DATA[0][i])}
if(document.getElementById(list[i]).getAttribute("onblur")!=null){document.getElementById(list[i]).onblur()}}}}
catch(err){jqMessage({message: "Error in js._loadit: "+err,type: "error",autoClose: false})}};

_removeData=function(params){
var options={"group":"","page":"","id":"","plugin":""}
try{	
$.extend(true, options, params);//turn options into array

if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"])}else{options["url"]=""};
$.ajax({
  type: 'GET',
  url:options["url"]+options["page"]+'.cfc?method=f_removeData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"id":options["id"]})
  },
  success:function(json){_removeDataCB($.parseJSON(json))},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});

}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
}
_removeDataCB=function(params){
var options={"id":"","group":"","result":"fail"}
$.extend(true,options,params);
if(options["result"]=="ok"){
	jqMessage({"type":"destroy"});
	jqMessage({message: "The task has been removed.",type: "success",autoClose: true,duration: 5});
	}
	}
_toggle=function(list){var arr=list.split(",");for(var i=0;i<arr.length;i++){$('#'+arr[i]).toggle();}};
_hide=function(list){var arr=list.split(",");for(var i=0;i<arr.length;i++){$('#'+arr[i]).hide();}};
_highlight=function(on){var lis=on.parentNode.parentNode.getElementsByTagName("li");for (var i=0;i<lis.length;++i){lis[i].firstChild.className=lis[i].firstChild.className.replace(/\bhighlight\b/g,"");if(on==lis[i].firstChild){lis[i].firstChild.className ="highlight"}}};
_updateh3=function(msg){var e=document.getElementsByTagName("h3");for(var i=0;i<e.length;i++){var arr=e[i].innerHTML.split(" [ ");e[i].innerHTML=arr[0]+" [ "+msg+" ]";};}

_isIt=function(it,is){
switch(it){
case"rationalNumbers":re=/^[1-9]\d*$/;if(is.match(re)){return true;}else{return false;};break;
case"numeric":re=/^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;if(is.match(re)){return true;}else{return false;};break;
case"date":re=/^\d{1,2}\/\d{1,2}\/\d{4}$/;if(is.match(re)){return true;}else{return false;}break;
case"time":re=/(?:0[0-9]|1[0-1]):[0-5][0-9]/;if(is.match(re)){return true;}else{return false;}break;
case"empty":if((is.length!=0)&&(is!=null)){return true}else{return false};break;
case"email":re=/^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;if(is.match(re)){return true;}else{return false;};break;
case"zip":re=/^([0-9]{5})$/;if(is.match(re)){return true;}else{return false;};break;
case"zip9":re=/^([0-9]{5}-[0-9]{4})$/;if(is.match(re)){return true;}else{return false;};break;
case"cc_visa":re=/^4[0-9]{12}(?:[0-9]{3})?$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_mastercard":re=/^5[1-5][0-9]{14}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_dinersclub":re=/^3[47][0-9]{13}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_discover":re=/^6(?:011|5[0-9]{2})[0-9]{12}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_dinersclub":re=/^3[47][0-9]{13}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_jcb":re=/^(?:2131|1800|35\d{3})\d{11}$/;if(is.match(re)){return true;}else{return false;}break;
case"socialsecurity":re=/^[0-9]{3}[\- ]?[0-9]{2}[\- ]?[0-9]{4}$/;if(is.match(re)){return true;}else{return false;}break;
case"ipaddress":re=/^[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}$/;if(is.match(re)){return true;}else{return false;}break;
case"macaddress":re=/^[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}$/;if(is.match(re)){return true;}else{return false;}break;
case"phone":re=/^(\+\d)*\s*(\(\d{3}\)\s*)*\d{3}(-{0,1}|\s{0,1})\d{2}(-{0,1}|\s{0,1})\d{2}$/;if(is.match(re)){return true;}else{return false;}break;
case"url":re=/^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/;if(is.match(re)){return true;}else{return false;}break;
case"filename":re=/^[^\\\/\:\*\?\"\<\>\|\.]+(\.[^\\\/\:\*\?\"\<\>\|\.]+)+$/;if(is.match(re)){return true;}else{return false;}break;
case"ip6":re=/^(?:(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9](?::|$)){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))$/i;if(is.match(re)){return true;}else{return false;}break;
case"hex":re=/^#?([a-f0-9]{6}|[a-f0-9]{3})$/;if(is.match(re)){return true;}else{return false;}break;
case"html":re=/^<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)$/;if(is.match(re)){return true;}else{return false;}break;
case"image":re=/.*(\.[Jj][Pp][Gg]|\.[Gg][Ii][Ff]|\.[Jj][Pp][Ee][Gg]|\.[Pp][Nn][Gg])/;if(is.match(re)){return true;}else{return false;}break;
case"boolean":re=/^True|^False|^true|^false|^yes|^no|^1|^0/;if(is.match(re)){return true;}else{return false;}break;
case"none":re=/^none|^None|^null|^Null|^empty|^Empty|^0/;if(is.match(re)){return true;}else{return false;}break;
default:return false;
}}

_clearfields=function(params){
var options={"sel":"","list":""}
$.extend(true,options,params)
var list=options['list'].split(','),sel=options['sel'].split(',');
		for(var i=0;i<list.length;i++){$('#'+list[i]).val('');}
		for(var i=0;i<sel.length;i++){
			
$('#'+sel[i]).find('option').prop('selected',false);
$('#'+sel[i]).each(function(){$('#'+sel[i]+'option').removeAttr("selected")})
}}
	
_loadSelect=function(params){
if(debug){window.console.log('_loadSelect : Starting');}
var options={"selectName":"","selectObject":"","option1":"","page":""}
$.extend(true,options,params);
if(debug){window.console.log('_loadSelect : options '+options["selectName"]+' '+options["selectObject"]+' '+options["option1"]+' '+options["page"]+' ');}
$.ajax({type:'GET',url:options['page']+'.cfc?method=f_loadSelect',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"selectName":options['selectName'],"option1":options['option1']})}
,success:function(json){
 var j=$.parseJSON(json),items='';
	for(var i=0;i<j.Records.length;i++){items+='<option value="'+ j.Records[i].optionvalue_id+'">'+j.Records[i].optionname+'</option>'}
	  $("select#"+options['selectObject']).html(items).trigger("chosen:updated");
	if(debug){window.console.log('_loadSelect : complete');}
	  },
  error:function(data){errorHandle($.parseJSON(data))}})};



errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};