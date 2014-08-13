<cfparam name="page.formid" default="0">
<cfquery dbtype="query" name="g102_description">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='g102_description'</cfquery>
<cfquery dbtype="query" name="g102_ratetype">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='g102_ratetype'</cfquery>
<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
//Start Normal Template Functions
_pluginURL102=function(){return "#this.url#/AWS/assets/plugins/jTimeBilling/"}
_pluginURL102_1=function(){return "#this.url#/AWS/assets/plugins/jTimeBilling/"}
_pluginLoadData102=function(){return "tb_id,tb_id,user_id,g102_adjustment,g102_date,g102_description,g102_flatfee,g102_manualtime,g102_mileage,g102_notes,g102_paymentstatus,g102_ratetype,g102_reimbursement"}
_pluginLoadData102_1=function(){return "t_id,t_id,g102_1_start,g102_1_stop"}
_group102=function(){_grid102();}
_group102_1=function(){_grid102_1();}
_pluginSaveData102=function(){

	var json='{"DATA":[["'+
		$("##tb_id").val()+'","'+
		$("##form_id").val()+'","'+
		$("##task_id").val()+'","'+
        $("##g102_adjustment").val().replace(/([$,])/g, '')+'","'+
    	$("##g102_date").val()+'","'+
    	$("##g102_description").val()+'","'+
        $("##g102_flatfee").val().replace(/([$,])/g, '')+'","'+
		$("##g102_manualtime").val()+'","'+
        $("##g102_mileage").val()+'","'+
		$("##g102_notes").val()+'","'+
    	$("##g102_paymentstatus").val()+'","'+
    	$("##g102_ratetype").val()+'","'+
        $("##g102_reimbursement").val().replace(/([$,])/g, '')+'","'+
		'"]]}'
		if($("##isLoaded_group102").val()!=0){
			_saveData({"group":"group102",payload:$.parseJSON(json),page:"timebilling",plugin:"group102"})}
		else{
			_pluginSaveDataCB({'subgroup':'102_1'})
			}
		}

_pluginSaveData102_1=function(){
	var json='{"DATA":[["'+
		$("##t_id").val()+'","'+
		$("##tb_id").val()+'","'+
        $("##g102_1_start").val()+'","'+
		$("##g102_1_stop").val()+'","'+
		'"]]}'
		if($("##isLoaded_group102_1").val()!=0){
			_saveData({"group":"group102_1",payload:$.parseJSON(json),page:"timebilling",plugin:"102_1"})}
		else{jqMessage({message: "Your data has been saved.",type: "success",autoClose: true})}
		}


_grid102=function(){
	_jGrid({
	"grid":"grid102",
	"url":"#this.url#/AWS/assets/plugins/jTimeBilling/timebilling.cfc",
	"title":"Time &amp; Billing",
	"fields":{TB_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.TB_ID+"',page:'timebilling',group:'group102',plugin:'102'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}	
			,TB_DATE:{title:'Date',width:'2%'}
			,U_NAME:{title:'Name'}
			,TB_DESCRIPTIONTEXT:{title:'Description'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","clientid":"'+$("##client_id").val()+'","taskid":"'+$("##task_id").val()+'","loadType":"group102"}',
	"functions": '$("##tb_id").val(record.TB_ID);$("##isLoaded_group102").val(1);$("##group102").accordion({active:1}); _loadData({"id":"tb_id","group":"group102","page":"timebilling","plugin":"group102"});'
})};

_grid102_1=function(){
	_jGrid({
	"grid":"grid102_1",
	"url":"#this.url#/AWS/assets/plugins/jTimeBilling/timebilling.cfc",
	"title":"Time",
	"fields":{T_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.T_ID+"',page:'timebilling',group:'group102_1',plugin:'102'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}	
			,T_START:{title:'Start Time',width:'2%'}
			,T_STOP:{title:'End Time',width:'2%'}
			,T_DIFF:{title:'Time Diffrence'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_1_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("##tb_id").val()+'","loadType":"group102_1"}',
	"functions":''
})};
})

</script>
</cfoutput>
<span class="trackers">
<input type="hidden" id="tb_id" value="0" />
<input type="hidden" id="t_id" value="0" />
<input type="hidden" id="isLoaded_group102" value="0" />
<input type="hidden" id="isLoaded_group102_1" value="0" />
</span>
<div id="group102" class="gf-checkbox" >
<h3 onClick="_group102();">Time Card</h3>
<div>
		<div><label for="g102_filter">Filter</label><input id="g102_filter" onBlur="_grid102();" onKeyPress="if(event.keyCode==13){_grid102();}"/></div>
		<div id="grid102" class="tblGrid"></div>
		<div class="buttonbox"><cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='$("#group102").accordion({active:1});$("#isLoaded_group102").val(1);'>Add</a></cfif></div>
</div>
<cfoutput>
<h4 #iif(Session.user.role neq '3',DE(''),DE('style="display:none;"'))# onClick='_loadData({"id":"tb_id","group":"group102","page":"timebilling",plugin:"group102"});$("##isLoaded_group102").val(1);'>Add Time Card</h4>
</cfoutput>
<div>
    <div><label for="user_id">Employee</label><select id="user_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g102_date">Date</label><input type="text" class="date" id="g102_date"/></div>
   	<div><label for="g102_description">Description</label><select id="g102_description" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="g102_description"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g102_notes">Notes</label><textarea type="text" id="g102_notes" cols="4" rows="4"  maxlength="1000"></textarea></div>
	<div><label for="g102_paymentstatus">Billing Status</label><select id="g102_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g102_mileage">Mileage</label><input type="text" maxlength="10" id="g102_mileage" ></div>
    <div><label for="g102_reimbursement">Reimbursement</label><input type="text" maxlength="10" id="g102_reimbursement" ></div>
    <div><label for="g102_manualtime">Manual Time</label><input type="text" class="time" id="g102_manualtime" ></div>
  	<div><label for="g102_ratetype">Rate Type</label><select id="g102_ratetype"><option value="0">&nbsp;</option><cfoutput query="g102_ratetype"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
    <div><label for="g102_rate">Rate</label><input type="text" class="readonly" readonly id="g102_rate" ></div>
    <div><label for="g102_totaltime">Total Time</label><input type="text" class="readonly time" readonly id="g102_totaltime" ></div>
    <div><label for="g102_subtotal">Subtotal</label><input type="text" class="readonly" readonly id="g102_subtotal" ></div>   
    <div><label for="g102_flatfee">Flat Fee</label><input type="text" maxlength="10" id="g102_flatfee" ></div>
    <div><label for="g102_adjustment">Adjustment</label><input type="text" maxlength="10" id="g102_adjustment" ></div>
</div>  
<cfoutput>
<h3 #iif(Session.user.role neq '3',DE(''),DE('style="display:none;"'))# group="group102_1" onClick="_grid102_1();">Time</h3>
</cfoutput>
<div>
	<div><label for="g102_1_filter">Filter</label><input id="g102_1_filter" onBlur="_grid102_1();" onKeyPress="if(event.keyCode==13){_grid102_1();}"/></div>
	<div id="grid102_1" class="tblGrid"></div>
	<div class="buttonbox"><cfif Session.user.role neq '3'><a href="#" class="button optional" onClick='$("#group102").accordion({active:3});$("#isLoaded_group102_1").val(1);'>Add</a></cfif></div>
</div>

<h4 onClick='$("#isLoaded_group102_1").val(1);'>Add Time</h4>
<div>
        <div><label for="g102_1_start">Start Time</label><input type="text" class="time" id="g102_1_start" ></div>
        <div><label for="g102_1_stop">End Time</label><input type="text" class="time" id="g102_1_stop" ></div>
</div>
</div>