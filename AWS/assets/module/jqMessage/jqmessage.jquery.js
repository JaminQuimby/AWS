/*Messages
Writen by Jamin Quimby - All rights reserved

*/
jqMessage=function(params){
$('#jqMessage').remove();
    // options array
    var options = { 
        'showAfter': 0, // number of sec to wait after page loads
        'duration': 180, // display duration
        'autoClose' : false, // flag to autoClose notification message
        'type' : 'success', // type of info message error/success/info/warning
        'message': '', // message to dispaly
        'description' :{"message":"Hello World This is the details about my error message","link":"google.com","linkname":"Learn More"}, //Details {"Description":"Hello World This is the details about my error message","Link":"google.com"}
		'buttons':[{"name":"Save","function":"alert('Saved')"},{"name":"Exit","function":"alert('Exit')"}] // Pass it a json array for buttons [{"name":"Save","function":"alert('Saved')"},{"name":"Exit","function":"alert('Exit')"}]

	}; 
    // Extending array from params
    $.extend(true, options, params);  
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
		if(options["buttons"]!=''){container+=_addButtons(options["buttons"],msgbx);}
		container+='<div>';
	
   // Appeding notification to Body
	$('body').append(container);
	var msgbx=$('#jqMessage')
   // see CSS top to minus of div height
	msgbx.css({ top : '-'+msgbx.height()+'px' });
   // showing notification message, default it will be hidden
	msgbx.show();
    
   // Slide Down notification message after startAfter seconds
    _slideDownNotification(options['showAfter'], options['autoClose'],options['duration'],msgbx);
    msgbx.on('click', function(){
		if(options['description']!=''){
		msgbx.html(_addDetails(options['description'])).slideDown('slow')
		}
		else{_closeNotification(0,msgbx)}})}

// sliding down the notification
_slideDownNotification = function(startAfter,autoClose,duration,msgbx){    
    setTimeout(function(){
        msgbx.animate({top: 0}
		,duration); 
        if(autoClose){
            setTimeout(function(){
            _closeNotification(duration,msgbx)}
			,duration)}}
	,parseInt(startAfter * 1000))}
	
// slideUp the message
_closeNotification=function(duration,msgbx){
    setTimeout(
		function(){
        	msgbx.slideUp('fast'
			,function(){$('body').remove(msgbx)})}
			,parseInt(duration * 50))}

//Build Buttons
_addButtons=function(buttons){
container='<div class="jqButtonBox">';
for(var key in eval(buttons)){
   if(buttons.hasOwnProperty(key)){
	container+='<a href="#" onclick="'+buttons[key].function+'">'+buttons[key].name+'</a>'}}
	container+='</div>';
	return container;
}

//Add Details
_addDetails=function(details,msgbx){container='<div>'+details["message"]+'<a href="'+details["link"]+'">'+details["linkname"]+'</a><a href="#" onclick="_closeNotification(0,$(this))">X</a></div>';return container}

			
			