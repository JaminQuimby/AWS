<cfoutput>
<script type="text/javascript">
$(document).ready(function(){

    

//Start Normal Template Functions
_pluginURL101=function(){return "#this.url#/AWS/assets/plugins/jComment/"}
_pluginLoadData101=function(){return ''}
_pluginSaveData101=function(){var json='{"DATA":[["'+
		$("##comment_id").val()+'","'+
		$("##form_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##task_id").val()+'","'+
		$("##g101_commentdate").val()+'","'+
		$("##g101_commenttext").val()+'","'+
		'"]]}'
		if($("##isLoaded_group101").val()!=0){_saveData({"group":"group101",payload:$.parseJSON(json),page:"comment",plugin:"group101"});$("##group101").accordion({active:0});_grid101();$("##isLoaded_group101").val(0);}
		else{jqMessage({message: "Your data has been saved.",type: "success",autoClose: true})}}

_group101=function(){_grid101()}
_grid101=function(){
	_jGrid({
	"grid":"grid101",
	"url":"#this.url#/AWS/assets/plugins/jComment/comment.cfc",
	"title":"Comments",
	"fields":{COMMENT_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.COMMENT_ID+"',page:'comment',group:'group101',plugin:'101'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}	
			,C_DATE:{title:'Date',width:'2%'}
			,U_NAME:{title:'Name'}
			,C_NOTES:{title:'Comment'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g101_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","clientid":"'+$("##client_id").val()+'","taskid":"'+$("##task_id").val()+'","loadType":"group101"}',
	"functions":''
	})};

})

</script>
</cfoutput>
<span class="trackers">
<input type="hidden" id="comment_id" value="0" />
<input type="hidden" id="isLoaded_group101" value="0" />
</span>
<div id="group101" class="gf-checkbox" >
	<h3 onClick="_group101(); ">Comment</h3>
	<div>
		<div><label for="g101_filter">Filter</label><input id="g101_filter" onBlur="_grid101();" onKeyPress="if(event.keyCode==13){_grid101();}"/></div>
		<div id="grid101" class="tblGrid"></div>
		<div class="buttonbox"><cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='$("#group101").accordion({active:1});$("#isLoaded_group101").val(1);$("#g101_commentdate").val( new Date().mmddyyyy() )'>Add</a></cfif></div>
	</div>
 <cfoutput>
<h4 #iif(Session.user.role neq '3',DE(''),DE('style="display:none;"'))# onClick='_loadData({"id":"comment_id","group":"group101","page":"comment",plugin:"group101"});$("##isLoaded_group101").val(1);'>Add Comment</h4>
	<div>
		<div><label for="g101_commentdate">Date</label><input type="text" class="date" id="g101_commentdate"/></div>
		<div><label for="g101_commenttext">Comment</label><textarea type="text" id="g101_commenttext" cols="4" rows="4"  maxlength="1000"></textarea></div>
	</div>
</div>
</cfoutput>