<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
$(function() {
$("##uploader").pluploadQueue({
// General settings
preinit:_FileUploadedCB,
runtimes:'html5,flash',
url:'#this.url#/AWS/assets/plugins/jUpload/upload.cfc?method=upload',
max_file_size:'10mb',
chunk_size:'1mb',
unique_names:true,
multiple_queues:true,
drop_element:"uploader",
browse_button:"selectFiles",
container:"uploader",
flash_swf_url:"./assets/plupload/js/plupload.flash.swf",
urlstream_upload:true,
multipart:true,
multipart_params:{ },
resize:{width:320, height:240, quality:90},
filters:[	{title:"Image files", extensions:"jpg,gif,png"},
			{title:"Zip files", extensions:"zip"},
			{title:"QuickBooks", extensions:"qbb,qbw"},
			{title:"Document Files", extensions:"pdf,doc,docx,xlsx,xls,ppt,pptx"}],
			
flash_swf_url:'#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.flash.swf',
silverlight_xap_url:'#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.silverlight.xap',
init:{
	BeforeUpload:function(up, files){
		up.settings.multipart_params = {
			'formid':'#page.formid#',
			'clientid':$('##client_id').val(),
			'userid':'#session.user.id#',
			'taskid':$('##task_id').val(),
						  }
		            }
					//ADD LINE

		}
    });
});
//Start Normal Template Functions

_FileUploadedCB=function(Uploader){
Uploader.bind('FileUploaded', function(Up, File, Response){
if((Uploader.total.uploaded + 1) == Uploader.files.length){_group100();$("##group100").accordion({active:0});}
})}

_pluginURL100=function(){return "https://"+window.location.hostname+"/AWS/assets/plugins/jUpload/"}
_pluginLoadData100=function(){return 'file_id,file_id,g100_name,g100_description,g100_year,g100_month,g100_day'}
_pluginSaveData100=function(){
	var json='{"DATA":[["'+
		$("##file_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##g100_day").val()+'","'+
		$("##g100_description").val()+'","'+
		$("##g100_month").val()+'","'+
		$("##g100_name").val()+'","'+
		$("##g100_year").val()+'","'+
		'"]]}'
		if($("##isLoaded_group100").val()!=0){
			_saveData({"group":"group100",payload:$.parseJSON(json),page:"upload",plugin:"group100"})}
		else{jqMessage({message: "Your data has been saved.",type: "success",autoClose: true})}
	}
_group100=function(){_grid100()}
_grid100=function(){
	_jGrid({
	"grid":"grid100",
	"url":"/AWS/assets/plugins/jUpload/upload.cfc",
	"title":"Files",
	"fields":{FILE_ID:{key:true,list:false,edit:false},FILE_SAVEDNAME:{list:true,edit:false,title:'',width: '1%',display: function (data1) {
                         var $img = $('<i class="fa fa-cloud-download fa-2x" style="cursor:pointer"></i>'); 
						$img.click(function () {
    						window.location.href = '//cj.qutera.com/AWS/assets/plugins/jUpload/download.cfm?FILE_SAVEDNAME='+data1.record.FILE_SAVEDNAME+'&FILE_TYPE='+data1.record.FILE_TYPE+'&FILE_SUBTYPE='+data1.record.FILE_SUBTYPE+'&FILE_NAME='+data1.record.FILE_NAME+'';
						});return $img;}} ,FILE_NAME:{title:'File Name'},FILE_DESCRIPTION:{title:'Description'},FILE_YEAR:{title:'Year'},FILE_MONTH:{title:'Month'},FILE_DAY:{title:'Day'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g100_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","loadType":"group100","clientid":'+$("##client_id").val()+'}',
	"functions":'$("##file_id").val(record.FILE_ID);$("##isLoaded_group100").val(1);_loadData({"id":"file_id","group":"group100","page":"upload","plugin":"group100"});$("##group100").accordion({active:1});'
	})};

})

</script>
</cfoutput>
<cfquery dbtype="query" name="plugin_documents">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='plugin_documents'</cfquery>
<span class="trackers">
<input type="hidden" id="file_id" value="0" />
<input type="hidden" id="isLoaded_group100" value="0" />
</span>
<div id="group100" class="gf-checkbox" >
<h3 onClick="_group100(); ">Files</h3>
<div>
<div><label for="g100_filter">Filter</label><input id="g100_filter" onBlur="_grid100();" onKeyPress="if(event.keyCode==13){_grid100();}"/></div>
<div id="grid100" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group100").accordion({active:2});'>Add</a>
</div>
</div>
<h4 onClick='_loadData({"id":"file_id","group":"group100","page":"upload",plugin:"group100"});$("#isLoaded_group100").val(1);'>File Meta Data</h4>
<div><div><label for="g100_name">Name</label><input type="text" id="g100_name"></div>
<div><label for="g100_description">Description</label><select id="g100_description" ><option value="0">&nbsp;</option><cfoutput query="plugin_documents"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<cfoutput>
<div><label for="g100_year">Year</label><input type="text" id="g100_year" value="#Year(Now())#"></div>
<div><label for="g100_month">Month</label><input type="text" id="g100_month" value="#Month(Now())#"></div>
<div><label for="g100_day">Day</label><input type="text" id="g100_day" value="#Day(Now())#"></div>
</cfoutput>
</div>
<h4>Upload Files</h4>
<div>
<div id="uploader"><p>You browser doesn't have Flash or HTML5 support.</p></div>	
</div>
</div>