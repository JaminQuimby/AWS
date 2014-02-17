<cfajaximport tags="cfmessagebox">
      <script language="JavaScript">
noticeConfirm = function(title,msg){
/*Get window object*/if(!ColdFusion.MessageBox.isMessageBoxDefined('noticeConfirm')){myWindow =  ColdFusion.MessageBox.create('noticeConfirm','confirm',title,msg,noticeConfirmCB,{width:200, modal:false,buttontype:'yesno'});};
myWindow = ColdFusion.MessageBox.getMessageBoxObject('noticeConfirm');
         /*Show the window*/ColdFusion.MessageBox.show('noticeConfirm');
}
/*noticeAlert Callbackhandler*/   
noticeConfirmCB = function(btn){ if(btn=='yes'){window.resetTimer();window.focus();self.close();};if(btn=='no'){alert('no');};};
noticeConfirmCB = function(btn){ if(btn=='yes'){window.resetTimer();window.focus();self.close();alert('hello2')};if(btn=='no'){alert('no');};};

if (document.getElementsByTagName("*")){
window.captureEvents(Event.MOUSEMOVE);}
window.onMouseMove = resetTimer;
window.onkeydown = resetTimer;
var tID = '';
	
function resetTimer(e){
	/*Reset the timer*/
	  clearTimeout(tID);
	/*NOTE: The first argument must be in quotes. Otherwise the executeTimer() 
function will execute first. The time is in milliseconds (10000 = 10 seconds).*/
	  tID = setTimeout('executeTimer()', 10000);
	}
executeTimer=function(){noticeConfirm('Warning','Your session is about to end. Would you like to stay connected?');}

	</script>

<body onLoad=" tID=setTimeout('executeTimer()', 10000)" onMouseMove="resetTimer();">
</body>
