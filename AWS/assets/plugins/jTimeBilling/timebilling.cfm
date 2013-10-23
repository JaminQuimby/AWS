<cfparam name="page.formid" default="0">


<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
//Start Normal Template Functions
_pluginURL102=function(){return "https://"+window.location.hostname+"/AWS/assets/plugins/jTimeBilling/"}
_pluginLoadData102=function(){return "tb_id,tb_id,g102_adjustment,g102_billingtype,g102_date,g102_description,g102_flatfee,g102_manualtime,g102_mileage,g102_notes,g102_paymentstatus,g102_ratetype,g102_reimbursement"}
_pluginSaveData102=function(){
	var json='{"DATA":[["'+
		$("##tb_id").val()+'","'+
		$("##form_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##task_id").val()+'","'+
        $("##g102_adjustment").val()+'","'+
		$("##g102_billingtype").val()+'","'+
    	$("##g102_date").val()+'","'+
    	$("##g102_description").val()+'","'+
        $("##g102_flatfee").val()+'","'+
		$("##g102_manualtime").val()+'","'+
        $("##g102_mileage").val()+'","'+
		$("##g102_notes").val()+'","'+
    	$("##g102_paymentstatus").val()+'","'+
    	$("##g102_ratetype").val()+'","'+
        $("##g102_reimbursement").val()+'","'+
		'"]]}'
		if($("##isLoaded_group102").val()!=0){_saveData({"group":"group102",payload:$.parseJSON(json),page:"timebilling",plugin:"group102"})}
		else{ _pluginSaveDataCB({'group':'group102_1'}) }}
/*
_pluginSaveData102_1=function(){
	var json='{"DATA":[["'+
		$("##t_id").val()+'","'+
		$("##tb_id").val()+'","'+
		$("##form_id").val()+'","'+
		$("##client_id").val()+'","'+
		$("##task_id").val()+'","'+
        $("##g102_1_start").val()+'","'+
		$("##g102_1_stop").val()+'","'+
		'"]]}'
		if($("##isLoaded_group102_1").val()!=0){_saveData({"group":"group102_1",payload:$.parseJSON(json),page:"timebilling",plugin:"group102_1"})}
		else{jqMessage({message: "Your data has been saved.",type: "success",autoClose: true})}}
*/
_group102=function(){_grid102(), jqMessage({message: "Time And Billing under construction.",type: "information",autoClose: true})}
_group102_1=function(){_grid102_1()}
_grid102=function(){
	_jGrid({
	"grid":"grid102",
	"url":"/AWS/assets/plugins/jTimeBilling/timebilling.cfc",
	"title":"Time &amp; Billing",
	"fields":{TB_ID:{key:true,list:false,edit:false}
			,TB_DATE:{title:'Date',width:'1%'}
			,U_NAME:{title:'Name'}
			,TB_DESCRIPTION:{title:'Description'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","clientid":"'+$("##client_id").val()+'","taskid":"'+$("##task_id").val()+'","loadType":"group102"}',
	"functions": '$("##tb_id").val(record.TB_ID);$("##isLoaded_group102").val(1);$("##group102").accordion({active:1}); _loadData({"id":"tb_id","group":"group102","page":"timebilling","plugin":"group102"});	'
})};
	
_grid102_1=function(){
	_jGrid({
	"grid":"grid102_1",
	"url":"/AWS/assets/plugins/jTimeBilling/timebilling.cfc",
	"title":"Time",
	"fields":{T_ID:{key:true,list:false,edit:false}
			,T_START:{title:'Start Time',width:'1%'}
			,T_STOP:{title:'End Time',width:'1%'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("##tb_id").val()+'","loadType":"group102_1"}',
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
	<h3 onClick="_group102(); ">Time Card</h3>
	<div>
			<div><label for="g102_filter">Filter</label><input id="g102_filter" onBlur="_grid102();" onKeyPress="if(event.keyCode==13){_grid102();}"/></div>
			<div id="grid102" class="tblGrid"></div>
			<div class="buttonbox"><a href="#" class="button optional" onClick='$("#group102").accordion({active:1});$("#isLoaded_group102").val(1);'>Add</a></div>
	</div>
    
	<h4 onClick='_loadData({"id":"tb_id","group":"group102","page":"timebilling",plugin:"group102"});$("#isLoaded_group102").val(1);'>Add Time Card</h4>
	<div>
    	<div><label for="client_id">Client</label><select id="client_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectClients"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
        <cfswitch expression="#page.formid#">
        <cfcase value="6">
        <!--- TAX RETURNS --->
        <div>Subtask1</div>
        <div>Subtask2</div>
        </cfcase>
        </cfswitch>
        <div><label for="user_id">Employee</label><select id="user_id" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
		<div><label for="g102_date">Date</label><input type="text" class="date" id="g102_date"/></div>
    	<div><label for="g102_description">Description</label><select id="g102_description" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option></select></div>
		<div><label for="g102_notes">Notes</label><textarea type="text" id="g102_notes" cols="4" rows="4"  maxlength="1000"></textarea></div>
		<div><label for="g102_paymentstatus">Payment Status</label><select id="g102_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
        <div><label for="g102_mileage">Mileage</label><input type="text" id="g102_mileage" ></div>
        <div><label for="g102_reimbursement">Reimbursement</label><input type="text" id="g102_reimbursement" ></div>


        <div><label for="g102_manualtime">Manual Time</label><input type="text" class="time" id="g102_manualtime" ></div>
    	<div><label for="g102_billingtype">Billing Type</label><select id="g102_billingtype"><option value="0">&nbsp;</option></select></div>
    	<div><label for="g102_ratetype">Rate Type</label><select id="g102_ratetype"><option value="0">&nbsp;</option></select></div>
        
        <div><label for="g102_rate">Rate</label><input type="text" class="readonly" readonly="readonly" id="g102_rate" ></div>
        <div><label for="g102_totaltime">Total Time</label><input type="text" class="readonly time" readonly="readonly" id="g102_totaltime" ></div>
        <div><label for="g102_subtotal">Subtotal</label><input type="text" class="readonly" readonly="readonly" id="g102_subtotal" ></div>   
            
        <div><label for="g102_flatfee">Flat Fee</label><input type="text" id="g102_flatfee" ></div>
        <div><label for="g102_adjustment">Adjustment</label><input type="text" id="g102_adjustment" ></div>
	</div>  
    
    
    <h3 id="group102_1" onClick="_group102_1();">Time</h3>
	<div>
		<div><label for="g102_1_filter">Filter</label><input id="g102_1_filter" onBlur="_grid102_1();" onKeyPress="if(event.keyCode==13){_grid102_1();}"/></div>
		<div id="grid102_1" class="tblGrid"></div>
		<div class="buttonbox"><a href="#" class="button optional" onClick='$("#group102").accordion({active:3});$("#isLoaded_group102_1").val(1);'>Add</a></div>
	</div>
    
	<h4 onClick='_loadData({"id":"t_id","group":"group102_1","page":"timebilling",plugin:"group102_1"});$("#isLoaded_group102_1").val(1);'>Add Time</h4>
	<div>
        <div><label for="g102_1_start">Start Time</label><input type="text" class="time" id="g102_1_start" ></div>
        <div><label for="g102_1_stop">End Time</label><input type="text" class="time" id="g102_1_stop" ></div>
	</div>  

</div>

 


