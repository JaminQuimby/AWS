/*
Copy Right Jamin Quimby all rights reserverd. 
Heavy Modification needed!
*/
jqValid=function(params){

var options = {
	"type":"", //Type of validation
	"object":"", //Must be an element
	"message":""//Message to return	
	};
// Extending array from params
$.extend(true, options, params);

try{
if(_isIt(options['type'],options['object'].value)){
options['object'].className="valid_on";

if(options['object'].nextSibling){
	if(options['object'].nextSibling.className=="help"){options['object'].nextSibling.innerHTML="&nbsp;"}
	if(options['object'].nextSibling.nextSibling){if(options['object'].nextSibling.nextSibling.className=="help"){options['object'].nextSibling.nextSibling.innerHTML="&nbsp;"}else{}}
	};
options['object'].style.borderRightColor="rgb(153, 153, 153)";
options['object'].style.borderRightStyle="solid";
options['object'].style.borderRightWidth="1px";
}else{
options['object'].className="valid_off";
options['object'].style.borderRightColor="rgb(0, 0, 153)";
options['object'].style.borderRightStyle="solid";
options['object'].style.borderRightWidth="5px";
var el=document.createElement("span");
el.className="help";
el.innerHTML=options['message'];

if(!options['object'].nextSibling){options['object'].parentNode.insertBefore(el, options['object'].nextSibling);}

if(options['object'].nextSibling){
	switch(options['object'].nextSibling.nodeName){
	case"IMG":
	if(options['object'].nextSibling.nextSibling){
		if(options['object'].nextSibling.nextSibling.className=="help"){options['object'].nextSibling.nextSibling.innerHTML=options['message'];}
		}
	if(!options['object'].nextSibling.nextSibling){options['object'].parentNode.insertBefore(el, options['object'].nextSibling.nextSibling);}
	break;
	default:
	if(options['object'].nextSibling){
		if(options['object'].nextSibling.className=="help"){options['object'].nextSibling.innerHTML=options['message'];}
		}
	if(!options['object'].nextSibling){options['object'].parentNode.insertBefore(el, options['object'].nextSibling);}
	;
}}}}
catch(error){
	if(typeof jqMessage ==='undefined'){alert("Error in js.jqValid: "+error)}
	else{jqMessage({message: "Error in js.jqValid: "+error,type: "error",autoClose: false})}}}