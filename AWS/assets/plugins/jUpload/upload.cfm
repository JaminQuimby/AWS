<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
$(function() {
$("##uploader").pluploadQueue({
// General settings
runtimes:'html5,flash',
url:'/AWS/assets/plugins/jUpload/upload.cfc?method=upload',
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
			{title:"Zip files", extensions:"zip"}],
flash_swf_url:'#Application.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.flash.swf',
silverlight_xap_url:'#Application.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.silverlight.xap',
init:{
	BeforeUpload:function(up, files){
		up.settings.multipart_params = {
			'description':$('##'+files.id+'_description').val(),
			'formid':'#page.formid#',
			'clientid':$('##client_id').val()			
						  }
		            },
	FileUploaded:function(up, file, response){
		alert(response.response)
			}
		}
    });
});
//Start Normal Template Functions
_group100=function(){_grid100()}
_grid100=function(){
	alert('click');
	_jGrid({
	"grid":"grid100",
	"url":"/AWS/assets/plugins/jUpload/upload.cfc",
	"title":"Files",
	"fields":{FILE_ID:{key:true,list:false,edit:false},FILE_NAME:{title:'File Name'},FILE_DESCRIPTION:{title:'Description'},FILE_YEAR:{title:'Year'},FILE_MONTH:{title:'Month'},FILE_DAY:{title:'Day'}},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g100_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","loadType":"group100","clientid":'+$("##client_id").val()+'}',
			"functions":'_loadData({"id":"client_id","group":"group100","page":"upload"});$("##group100").accordion({active:1});'
	})};
		
		
		
		
_loadDataCB=function(query){
/*LOAD DATA BASED ON QUERY RETURN*/
try{
if(query == null){jqMessage({message: "Error in js._loadDataCB, Record request was not found ",type: "error",autoClose: false})}else
{
switch(query.COLUMNS[0]){
/*File meta data*/case "FILE_NAME":var list='g100_name,g100_description,g100_year,g100_month,g100_day';_loadit({"query":query,"list":list});break;
default:jqMessage({message: "Error in js._loadDataCB, Query is empty",type: "error",autoClose: false})}}
}catch(err){jqMessage({message: "Error in js._loadData: "+err,"type":"error",autoClose: false})}
};
/*SAV//E DATA CALL BACK*/
//_saveDataCB=function(params){
//var options={
//	"id":"",//ID
//	"group":"",//Switch Group
//	"result":""//Call Back Response
//	}
//try{	
//$.extend(true, options, params);//turn options into array
//
//switch(options["group"]){
//	
//case'group100':
//var json='{"DATA":[["'+
//$("#client_id").val()+'","'+
//$("#g100_name").val()+'","'+
//$("#g100_description").val()+'","'+
//$("#g100_year").val()+'","'+
//$("#g100_month").val()+'","'+
//$("#g100_day").val()+'","'+
//'"]]}'
//if($("#isLoaded_group100").val()!=0){_saveData({group:"group100","payload":$.parseJSON(json),page:"upload"})}
//break;	
//	
//
///*Other Events*/
//case'error': jqMessage({message:"Error in _saveDataCB, General Error:"+options["id"]+"."+options["group"]+"."+options["result"],type: "error",autoClose: false});break;
//case'none':break;
//case'next':_saveData();break;
//case'saved':jqMessage({"type":"destroy"});jqMessage({message: "Your document has been saved. ",type: "success",autoClose: true,duration: 5});break;
//default:jqMessage({message: "A exception coccured in "+options["group"]+" json: "+json+"  id: "+options["id"],type: "sucess",autoClose: true,duration: 5});break;
//}
//}catch(err){alert(err)}};


})





</script>
</cfoutput>



<div id="group100" class="gf-checkbox" >
<h3 onClick="_group100(); ">Files</h3>
<div>
<div><label for="g100_filter">Filter</label><input id="g100_filter" onBlur="_grid100();"/></div>
<div id="grid100" class="tblGrid"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick='$("#group100").accordion({active:1});$("#isLoaded_group100").val(1);'>Add</a>
</div>
</div>
<h4>File Meta Data</h4>
<div><div><label for="g100_name">Name</label><input type="text" id="g100_name"></div>
<div><label for="g100_description">Description</label><select id="g100_description" ><option value="0">&nbsp;</option></select></div>
<div><label for="g100_year">Year</label><input type="text" id="g100_year"></div>
<div><label for="g100_month">Month</label><input type="text" id="g100_month"></div>
<div><label for="g100_day">Day</label><input type="text" id="g100_day"></div></div>
<h4>Upload Files</h4>
<div>
<div id="uploader"><p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p></div>	
</div>
</div>