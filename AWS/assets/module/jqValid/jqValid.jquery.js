/*
Copywrite Jamin Quimby all rights reserverd. 
*/
jqValid=function(params){

var options = {
	"type":"", //Type of validation
	"object":"", //element name or element
	"message":"",//Message to return
	"link":""//add a help link
	};
// Extending array from params
$.extend(true, options, params);
if(typeof options["object"]=="object"){var obj=$(options["object"])}else{var obj="#"+$(options["object"])}
if(_isIt(options['type'],obj.val())){

//Add green light, remove helper message
if(obj.parent().children('.chzn-container').length>-1){
	
	obj.parent().children('.chzn-container').children(':first-child').removeClass("jqHelp_off").addClass("jqHelp_on");
	obj.parent().children('.chzn-container').children(':first-child').css({"border-left":"5px solid #32CD32","border-right":"1px solid #AAAAAA","width":"400px"})
}//plugin for chosen

obj.removeClass("jqHelp_off").addClass("jqHelp_on").parent().children('.jqHelp').remove()}



//{"borderLeft":"5px solid #32CD32","border":"1px solid #343434","width":"395px"}
//	.css("borderLeft: 5px solid #EA1717;borderRight:5px solid #006;border: 1px solid #343434;width: 395px;")
//{"borderLeft":" 5px solid #EA1717","borderRight":"5px solid #006","border":"1px solid #343434","width":"395px"}

else{
//Add red light, add helper object	
if(obj.parent().children('.chzn-container').length>-1){
	obj.parent().children('.chzn-container').children(':first-child').removeClass("jqHelp_on").addClass("jqHelp_off");
	obj.parent().children('.chzn-container').children(':first-child').css({"border-left":" 5px solid #EA1717","border-right":"5px solid #006","width":"400px"})
	}//plugin for chosen

	obj.removeClass("jqHelp_on").addClass("jqHelp_off");
var container = '<span class="jqHelp">'+options['message']+'<span>';

//If help object does not exsist add it
if(obj.parent().children('.jqHelp').length>-1){obj.parent().children(':last').after(container)}
//append the helper object message	
obj.parent().children('.jqHelp').append(container).text(options["message"])

}
}
	

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
