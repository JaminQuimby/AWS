/*
Developer: Jamin Quimby
_toggle = changes the style.display on and off
hide = will hide a list of objects. requies a csv list of element names
highlight = light up current selected vertical tab; varibales on
isit = regexp validation of a string
updateh3 = updates <h3> elements with a msg contined in brakets. Example <h3>Client</h3> when you run updateh3("Qutera") it will become <h3>Client [Qutera]</h3>  
*/
/*jtable Helper Object*/
_jGrid=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":""//&method=
	}
	$.extend(true, options, params);
	var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});
$(grid).jtable('destroy');
$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
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
var options={"id":"","group":"","page":"","plugin":""}
try{$.extend(true, options, params);
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
$.ajax({type:'GET',url:options["url"]+options["page"]+'.cfc?method=f_loadData',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"id":$('#'+options["id"]).val(),"loadType":options["group"]})}
,success:function(json){
	_loadDataCB($.parseJSON(json))
	}
,error:function(data){errorHandle($.parseJSON(data))}})}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}};
//Save Data
_saveData=function(params){
var options={
	"group":"",
	"payload":"",
	"page":"",
	"id":"",
	"plugin":""
	}
try{	
$.extend(true, options, params);//turn options into array
if(options["payload"]!=""||options["payload"]=="undefined"){
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
$.ajax({
  type: 'GET',
  url:options["url"]+options["page"]+'.cfc?method=f_saveData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"payload":JSON.stringify(options["payload"])})
  },
  success:function(json){_saveDataCB($.parseJSON(json))},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});}else{_saveDataCB({"id":options["id"],"group":options["group"]});}}
catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
}
//Load It
_loadit=function(params){
	var options = {
	"query":"",//Returned Ajax Query
	"list":"", //List of Fields
	}
	$.extend(true, options, params);//turn options into array
	var list=options['list'].split(',');//Split List
try{if(options['query'].DATA!=""){
	for(var i=0;i<list.length;i++){
			switch(document.getElementById(list[i]).type){
				case"checkbox":$("#"+list[i]).prop('checked',options['query'].DATA[0][i]);break;
				case"select-one":
				$("#"+list[i]+' option').each(function(index){
					if(options['query'].DATA[0][i]==$(this).val()){
						$(this).attr('selected', true);
	}}).trigger("liszt:updated");break;
				case"select-multiple":
				var str=options['query'].DATA[0][i]+",";
				if(str!=null){
				var sstr=str.split(',');
				$("#"+list[i]+' option').each(function(index){
					for(var i=0;i<sstr.length;i++){
						if(sstr[i]==$(this).val()){
							$(this).attr('selected', true);
	}}}).trigger("liszt:updated");}break;
				case undefined:/*Detection for undefined objects such as <LABEL>*/
				$("#"+list[i]).html(options['query'].DATA[0][i]);break;
				default:$("#"+list[i]).val(options['query'].DATA[0][i])}
if(document.getElementById(list[i]).getAttribute("onblur")!=null){document.getElementById(list[i]).onblur()}}}}
catch(err){jqMessage({message: "Error in js._loadit: "+err,type: "error",autoClose: false})}};

_toggle=function(list){try{var arr=list.split(",");for(var i=0;i<arr.length;i++){var el=document.getElementById(arr[i]);el.style.display=(el.style.display!="none"?"none":"");}}catch(error){ jqMessage({message: "Error in js._toggle: "+error,type: "error",autoClose: false})}};
_hide=function(list){var arr=list.split(",");for(var i=0;i<arr.length;i++){document.getElementById(arr[i]).style.display="none";}};
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
default:return false;
}}

	
_loadSelect=function(params){
var options={"selectName":"","selectObject":"","page":""}
$.extend(true, options, params);//turn options into array
$.ajax({
  type: 'GET',
  url: options['page']+'.cfc?method=f_loadSelect',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"selectName":options['selectName']})
  },
 success:function(json){
 var j=$.parseJSON(json),items='';
      for(var i=0;i<j.Records.length;i++){
        items+='<option value="'+ j.Records[i].optionvalue_id+'">'+j.Records[i].optionname+'</option>';
      }$("select#"+options['selectObject']).html(items)},
  error:function(data){errorHandle($.parseJSON(data))}})};

$(document).ready(function(){
$.ajaxSetup({cache:false});//Stop ajax cacheing


$.datepicker.setDefaults({
showOn:"both",
buttonImageOnly:true,
buttonImage: "https://"+ window.location.hostname + "/AWS/assets/img/datepicker.gif",
constrainInput:true
});
//$('.gf-checkbox').accordion({heightStyle:"content", active:false});
$(".datetime").datetimepicker({timeFormat: 'hh:mmtt'});
$(".date").datepicker();
$(".time").timepicker();
$('select').chosen();
$('.gf-checkbox').hide();
$('#entrance').show();
});

// Accordion - Expand All #01
$(function () {
    $('.gf-checkbox').accordion({
        collapsible:true,
		heightStyle:"content",
        active:false
    });
	$('.gf-checkbox').accordion({active:0});
		$('.accordianclose').hide();
    var icons =   $('.gf-checkbox').accordion( "option", "icons" );
  
  
  $('.accordianopen').click(function () {
        $('.ui-accordion-header').removeClass('ui-corner-all').addClass('ui-accordion-header-active ui-state-active ui-corner-top').attr({
            'aria-selected': 'true',
            'tabindex': '0'
        });
        $('.ui-accordion-header-icon').removeClass(icons.header).addClass(icons.headerSelected);
        $('.ui-accordion-content').addClass('ui-accordion-content-active').attr({
            'aria-expanded': 'true',
            'aria-hidden': 'false'
        }).show();
        $(this).attr("disabled","disabled");
        $('.accordianclose').removeAttr("disabled");
		$('.accordianopen').hide();
		$('.accordianclose').show();
    });
  
   $('.accordianclose').click(function () {
        $('.ui-accordion-header').removeClass('ui-accordion-header-active ui-state-active ui-corner-top').addClass('ui-corner-all').attr({
            'aria-selected': 'false',
            'tabindex': '-1'
        });
        $('.ui-accordion-header-icon').removeClass(icons.headerSelected).addClass(icons.header);
        $('.ui-accordion-content').removeClass('ui-accordion-content-active').attr({
            'aria-expanded': 'false',
            'aria-hidden': 'true'
        }).hide();
        $(this).attr("disabled","disabled");
        $('.accordianopen').removeAttr("disabled");
		$('.accordianopen').show();
		$('.accordianclose').hide();
    });
    $('.ui-accordion-header').click(function () {
        $('.accordianopen').removeAttr("disabled");
        $('.accordianclose').removeAttr("disabled");
        
    });
});


errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};