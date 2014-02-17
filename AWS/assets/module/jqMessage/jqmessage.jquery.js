/*Messages
Writen by Jamin Quimby - All rights reserved
*/

jqMessage=function(params){
if($('#jqMessage').length){$('#jqMessage').remove()};
   // options array
    var options = { 
        'showAfter': 0, // number of sec to wait after page loads
        'duration': 180, // display duration
        'autoClose' : false, // flag to autoClose notification message
        'type' : 'success', // type of info message error/success/info/warning
        'message': '', // message to dispaly
        'description' :"",//Details {"Description":"Hello World This is the details about my error message","Link":"google.com"}
		'buttons':[] // Pass it a json array for buttons [{"name":"Save","on_click":"alert('Saved')","class":"optional"},{"name":"Exit","on_click":"alert('Exit')","class":"optional"}]

	}; 
 

    // Extending array from params
    $.extend(true, options, params);  
	var msgclass ="error";
	switch(options['type']){
	case"error":msgclass = 'error jqMessage';break;
	case"information":msgclass = 'info jqMessage';break;
	case"warning":msgclass = 'warning jqMessage';break;
	case"success":msgclass = 'success jqMessage';break;
	case"save":msgclass='save jqMessage';break;
	case"destroy":$('body').remove('#jqMessage');break;
	default:msgclass = 'error jqMessage';break;	
		}

 
   // Parent Div container
    var container = '<div id="jqMessage" class="'+msgclass+'"><div>'
		container +='<p>'+options['type']+'<p><h3>'+options['message']+'</h3>';
		if(options['type']=="save"){container+='<div class="jqImgSave"></div>'};
		container += '<div onclick="return _closeNotification(0,'+$(this)+')"></div></div>'
		container+='<div>';
		
	if(options["buttons"]!=''){
		var	buttonbox=$('<div class="jqButtonBox"></div>');
			$.each(options["buttons"], function(i, btn) {
		var	button=$('<a href="#" class="'+btn.class+'" >'+btn.name+'</a>').on( "click", function(){eval(btn.on_click)})
			buttonbox.append(button);
			})	
		}

   // Appeding notification to Body
      // see CSS top to minus of div height
   // showing notification message, default it will be hidden

	$('body').append(container);
	var msgbx=$('#jqMessage')
	
	msgbx.css({ top : '-'+msgbx.height()+'px' }).show();
    msgbx.append(buttonbox)
   // Slide Down notification message after startAfter seconds
    _slideDownNotification(options['showAfter'], options['autoClose'],options['duration'],msgbx);

if(options["autoClose"]=true){
    msgbx.on('click', function(){
		if(options['description']!=''){
		msgbx.html(_addDetails(options['description'])).slideDown('slow')
		}
		else{_closeNotification(0,msgbx)}})
}
		}

// sliding down the notification
_slideDownNotification = function(startAfter,autoClose,duration,msgbx){    
    setTimeout(function(){
        msgbx.animate({top: 0}
		,duration); 
        if(autoClose){
            setTimeout(function(){
            _closeNotification(duration,msgbx)}
			,duration)}}
	,parseInt(startAfter * 1000))
	}
	
// slideUp the message


_closeNotification=function(duration,msgbx){
    setTimeout(
		function(){
        	msgbx.slideUp('fast'
			,function(){})}
			,parseInt(duration * 50))
			
			}
//Add Details
_addDetails=function(details,msgbx){container='<div>'+details["message"]+'<a href="'+details["link"]+'">'+details["linkname"]+'</a><a href="#" onclick="_closeNotification(0,$(this))">X</a></div>';return container}	