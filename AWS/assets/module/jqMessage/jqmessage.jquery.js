/*Messages
Writen by Jamin Quimby - All rights reserved

*/
jqMessage=function(params){
    // options array
    var options = { 
        'showAfter': 0, // number of sec to wait after page loads
        'duration': 50, // display duration
        'autoClose' : false, // flag to autoClose notification message
        'type' : 'success', // type of info message error/success/info/warning
        'message': '', // message to dispaly
        'link_notification' : '', // link flag to show extra description
        'description' : '' // link to desciption to display on clicking link message
    }; 
    // Extending array from params
    $.extend(true, options, params);
	$('#jqMessage').remove();
    
	switch(options['type']){
	case"error":msgclass = 'error message';break;
	case"information":msgclass = 'info message';break;
	case"warning":msgclass = 'warning message';break;
	case"success":msgclass = 'success message';break;
	case"save":msgclass='save message';break;
	case"destroy":$('body').remove('#jqMessage');break;
	default:break;	
		}
		

    
   // Parent Div container
    var container = '<div id="jqMessage" class="'+msgclass+'"><div><p>'+options['type']+'<p><h3>'+options['message']+'</h3>';
	if(options['type']=="save"){container +="<div class='imgSave'></div>"};
    container += '<div onclick="return closeNotification()"></div></div><div>';
    
   // $notification = ;
    
   // Appeding notification to Body
    $('body').append(container);
    
   // see CSS top to minus of div height
    $('#jqMessage').css({ top : '-'+$("#jqMessage").height()+'px' });
    
   // showing notification message, default it will be hidden
   // $('#jqMessage').show();
    
   // Slide Down notification message after startAfter seconds
    _slideDownNotification(options['showAfter'], options['autoClose'],options['duration']);
    
    $('#jqMessage').on('click', function(){$('#jqMessage').html(options['description']).slideDown('slow');
    });
}

// function to close notification message


// sliding down the notification
_slideDownNotification = function(startAfter, autoClose, duration){    
    setTimeout(function(){
        $('#jqMessage').animate({
            top: 0
        }); 
        if(autoClose){
            setTimeout(function(){
                _closeNotification(duration);
            }, duration);
        }
    }, parseInt(startAfter * 1000));    
}
// slideUp the message
_closeNotification=function(duration){
    var divHeight = $('#jqMessage').height();
    setTimeout(function(){
        $('#jqMessage').animate({
            top: '-'+divHeight+42
        }); 
        // removing the notification from body
        setTimeout(function(){
            	$('#jqMessage').remove();
        },200);
    }, parseInt(duration * 1000));
	      
}