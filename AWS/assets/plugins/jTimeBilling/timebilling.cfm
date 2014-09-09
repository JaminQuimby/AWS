<cfparam name="page.formid" default="0">
<cfquery dbtype="query" name="g102_description">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='g102_description'</cfquery>
<cfquery dbtype="query" name="g102_expense">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='g102_expense'</cfquery>
<cfquery dbtype="query" name="g102_ratetype">SELECT[optionvalue_id],[option_1],[optionname]FROM[selectOptions]WHERE[selectName]='g102_ratetype'</cfquery>
<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
//Start Normal Template Functions
/*
g102_manualtime 
g102_totaltime
g102_ratetype
g102_subtotal

*/
$( document ).ajaxComplete(function(event, xhr, settings){
var json=JSON.parse(xhr.responseText);



if (json.hasOwnProperty('COLUMNS')==='true') {

if( json.COLUMNS[0]='GROUP102' ){_group102_calculatedfields();}

}


});

_group102_calculatedfields=function(){var manualtime=Number($("##g102_manualtime").val());
var totaltime=Number($("##g102_totaltime").val());
var ratetype=Number($("##g102_ratetype :selected").text().match(/([0-9]+)(.*?)(?=\ -)/g));
$("##g102_subtotal").val((manualtime+totaltime)*ratetype);
}

_pluginURL102=function(){return "#this.url#/AWS/assets/plugins/jTimeBilling/"}
_pluginURL102_1=function(){return "#this.url#/AWS/assets/plugins/jTimeBilling/"}
_pluginLoadData102=function(){return "tb_id,tb_id,g102_employee,g102_date,g102_description,g102_manualtime,g102_notes,g102_paymentstatus,g102_ratetype,g102_totaltime"}
_pluginLoadData102_1=function(){return "t_id,t_id,g102_1_start,g102_1_stop"}
_pluginLoadData102_2=function(){return "ta_id,ta_amount,ta_discription,ta_billable"}
_group102=function(){_grid102();}
_group102_addtime=function(){$("##isLoaded_group102_1").val(1);
_loadData({"id":"t_id","group":"group102_subtask","page":"timebilling",plugin:"group102"});
 }
_group102_addExpense=function(){$("##isLoaded_group102_2").val(1); }


_group102_addtimecard=function(){
$("##isLoaded_group102").val(1);
$("##g102_employee").val(10000).trigger("chosen:updated");
$("##g102_date").val("#DateFormat(Now(),Session.localization.formatdate)#" );
_loadData({"id":"tb_id","group":"group102","page":"timebilling",plugin:"group102"});

switch(#page.formid#){

case 2: //Accounting and Consulting
$("label[for='g102_field1']").text("Consulting Category");
$("label[for='g102_field2']").text("Task Description");
$("label[for='g102_field3']").hide();
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_consultingcategory :selected").text());
$("##g102_field2").val($("##g1_taskdescription").val());
$("##g102_field3").hide();
$("##g102_field4").hide();
break;

case 4: // Administrative Tasks
$("label[for='g102_field1']").text("Category");
$("label[for='g102_field2']").text("Task Description");
$("label[for='g102_field3']").text("Date Requested");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_category :selected").text());
$("##g102_field2").val($("##g1_taskdescription").val());
$("##g102_field3").val($("##g1_daterequested").val());
$("##g102_field4").hide();
break;

case 3: //Business Formation
$("label[for='g102_field1']").text("Owners");
$("label[for='g102_field2']").text("Activity");
$("label[for='g102_field3']").text("Date Initiated");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_owners").val());
$("##g102_field2").val($("##g1_activity").val());
$("##g102_field3").val($("##g1_dateinitiated").val());
$("##g102_field4").hide();
break;

case 12: //Communication
$("label[for='g102_field1']").text("Communication Date");
$("label[for='g102_field2']").text("Caller");
$("label[for='g102_field3']").hide();
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_date").val());
$("##g102_field2").val($("##g1_caller").val());
$("##g102_field3").hide();
$("##g102_field4").hide();
break;

case 9: //Financial & Tax Planning
$("label[for='g102_field1']").text("Category");
$("label[for='g102_field2']").text("Task Description");
$("label[for='g102_field3']").text("Request for Services");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_category :selected").text());
$("##g102_field2").val($("##g1_description").val());
$("##g102_field3").val($("##g1_requestforservices").val());
$("##g102_field4").hide();
break;

case 5: //Financial Statements
$("label[for='g102_field1']").text("Year");
$("label[for='g102_field2']").text("Month");
$("label[for='g102_field3']").text("Period End");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_year").val());
$("##g102_field2").val($("##g1_month").val());
$("##g102_field3").val($("##g1_periodend :selected").text());
$("##g102_field4").hide();
break;

case 8: //Notices
$("label[for='g102_field1']").text("Tax Year");
$("label[for='g102_field2']").text("Tax Form");
$("label[for='g102_field3']").text("Matter Name");
$("label[for='g102_field4']").text("Notice Number");

$("##g102_field1").val($("##g2_1_taxyear :selected").text());
$("##g102_field2").val($("##g2_1_taxform :selected").text());
$("##g102_field3").val($("##g1_mattername").val());
$("##g102_field4").val($("##g2_1_noticenumber :selected").text());
break;

case 11: //Other Filings
$("label[for='g102_field1']").text("Year");
$("label[for='g102_field2']").text("Period");
$("label[for='g102_field3']").text("State");
$("label[for='g102_field4']").text("Form");

$("##g102_field1").val($("##g1_taxyear :selected").text());
$("##g102_field2").val($("##g1_period :selected").text());
$("##g102_field3").val($("##g1_state :selected").text());
$("##g102_field4").val($("##g1_form :selected").text());
break;

case 10: //Payroll Checks
$("label[for='g102_field1']").text("Year");
$("label[for='g102_field2']").text("Pay End Date");
$("label[for='g102_field3']").text("Pay Date");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_year :selected").text());
$("##g102_field2").val($("##g1_payenddate").val());
$("##g102_field3").val($("##g1_paydate").val());
$("##g102_field4").hide();
break;

case 13: //Payroll Taxes
$("label[for='g102_field1']").text("Year");
$("label[for='g102_field2']").text("Month");
$("label[for='g102_field3']").text("Type");
$("label[for='g102_field4']").text("Last Pay");

$("##g102_field1").val($("##g1_year :selected").text());
$("##g102_field2").val($("##g1_month :selected").text());
$("##g102_field3").val($("##g1_type :selected").text());
$("##g102_field4").val($("##g1_lastpay").val());
break;

case 6: //Personal Property Tax Returns & Tax Returns
$("label[for='g102_field1']").text("Tax Year");
$("label[for='g102_field2']").text("Tax Form");
$("label[for='g102_field3']").hide();
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_taxyear :selected").text());
$("##g102_field2").val($("##g1_taxform :selected").text());
$("##g102_field3").hide();
$("##g102_field4").hide();
break;

case 7: //Power of Attorney
$("label[for='g102_field1']").text("Tax Years");
$("label[for='g102_field2']").text("Tax Forms");
$("label[for='g102_field3']").text("Tax Matters");
$("label[for='g102_field4']").hide();

$("##g102_field1").val($("##g1_taxyears :selected").map(function() { return $(this).text()}).get() );
$("##g102_field2").val($("##g1_taxforms :selected").map(function() { return $(this).text()}).get() );
$("##g102_field3").val($("##g1_taxmatters :selected").map(function() { return $(this).text()}).get() );
$("##g102_field4").hide();
break;

default:
$("label[for='g102_field1']").hide();
$("label[for='g102_field2']").hide();
$("label[for='g102_field3']").hide();
$("label[for='g102_field4']").hide();

$("##g102_field1").hide();
$("##g102_field2").hide();
$("##g102_field3").hide();
$("##g102_field4").hide();
}

  }

_pluginSaveData102=function(){
	var json='{"DATA":[["'+
		$("##tb_id").val()+'","'+
		$("##form_id").val()+'","'+
		$("##task_id").val()+'","'+
        //$("##g102_adjustment").val().replace(/([$,])/g, '')+'","'+
    	$("##g102_date").val()+'","'+
    	$("##g102_description").val()+'","'+
        //$("##g102_flatfee").val().replace(/([$,])/g, '')+'","'+
		$("##g102_manualtime").val()+'","'+
        //$("##g102_mileage").val()+'","'+
		$("##g102_notes").val()+'","'+
    	$("##g102_paymentstatus").val()+'","'+
    	$("##g102_ratetype").val()+'","'+
        //$("##g102_reimbursement").val().replace(/([$,])/g, '')+'","'+
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
	"fields":{

edit:{title:'Edit',width:'1%', list:user['g_delete'] ,display:function(d){var $img=$('<i class="fa fa-pencil-square-o" style="cursor:pointer"></i>');$img.click(function(){ $("##group102").accordion({active:1}); _group102_addtimecard(); });return $img}}	

			  //CHILD TABLE DEFINITION FOR SUBTAKS
 			    ,Subtasks: {
                    title: 'Time',
                    width: '1%',
                    sorting: false,
                    edit: false,
                    create: false,
                    display: function (subtasks) {
                        var $img = $('<i class="fa fa-tasks "></i>'+subtasks.record.TB_ID);
                        $img.click(function () {
                            $('##grid102').jtable('openChildTable',
                                    $img.closest('tr'),
                                    {
                                        title: 'Time Card',
                                        actions: {
                                        listAction: '#this.url#/AWS/assets/plugins/jTimeBilling/timebilling.cfc?returnFormat=json&method=f_lookupData&argumentCollection={"search":"","orderBy":"0","row":"0","ID":"'+subtasks.record.TB_ID+'","loadType":"group102_subtask","userid":"","clientid":"'+$("##client_id").val()+'","formid":"2"}',
                                        },
                                        fields: {
                                        	edit:{title:'',width:'1%', list:user['g_delete'] ,display:function(d){var $img=$('<i class="fa fa-pencil-square-o" style="cursor:pointer"></i>');$img.click(function(){ $("##group102").accordion({active:2});_group102_addtime(); });return $img}}	
											,T_ID:{key:true,edit:false,visibility:'hidden',title:'ID',width: '1%'}
                                            ,T_START:{"title":"Start",width: '2%'}
                                            ,T_STOP:{"title":"Stop",width: '2%'}
                                            ,T_DIFF:{"title":"Hours"}
                                        }
                                    }, function(data){ //opened handler
                                    	data.childTable.jtable('load');
                                    });
                        });
                        //Return image to show on the person row
                        return $img;
                    }
                }
			  //CHILD TABLE DEFINITION FOR SUBTAKS
 			    ,Subtasks2: {
                    title: 'Expense',
                    width: '1%',
                    sorting: false,
                    edit: false,
                    create: false,
                    display: function (subtasks2) {
                        var $img = $('<i class="fa fa-money "></i>'+subtasks2.record.TB_ID);
                        $img.click(function () {
                            $('##grid102').jtable('openChildTable',
                                    $img.closest('tr'),
                                    {
                                        title: 'Expense Card',
                                        actions: {
                                        listAction: '#this.url#/AWS/assets/plugins/jTimeBilling/timebilling.cfc?returnFormat=json&method=f_lookupData&argumentCollection={"search":"","orderBy":"0","row":"0","ID":"'+subtasks2.record.TB_ID+'","loadType":"group102_subtask","userid":"","clientid":"'+$("##client_id").val()+'","formid":"2"}',
                                        },
                                        fields: {
                                        	edit:{title:'',width:'1%', list:user['g_delete'] ,display:function(d){var $img=$('<i class="fa fa-pencil-square-o" style="cursor:pointer"></i>');$img.click(function(){ $("##group102").accordion({active:2}); _group102_addExpese();});return $img}}	
											,TA_ID:{key:true,edit:false,visibility:'hidden',title:'ID',width: '1%'}
                                            ,TA_AMOUNT:{"title":"Amount"}
                                            ,TA_DESCRIPTION:{"title":"Description"}
                                            ,TA_BILLCLIENT:{"title":"Bill Client"}
                                        }
                                    }, function(data){ //opened handler
                                    	data.childTable.jtable('load');
                                    });
                        });
                        //Return image to show on the person row
                        return $img;
                    }
                }

                ,TB_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}

			,TB_DATE:{title:'Date'}
			,U_NAME:{title:'Name'}
			,TB_DESCRIPTIONTEXT:{title:'Description'}
			,remove:{title:'',width:'1%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.TB_ID+"',page:'timebilling',group:'group102',plugin:'102'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}	

			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_filter").val()+'","orderBy":"0","row":"0","formid":"#page.formid#","clientid":"'+$("##client_id").val()+'","taskid":"'+$("##task_id").val()+'","loadType":"group102"}',
	"functions": '$("##tb_id").val(record.TB_ID);$("##isLoaded_group102").val(1); _loadData({"id":"tb_id","group":"group102","page":"timebilling","plugin":"group102"});'
})};
/*
_grid102_1=function(){
	_jGrid({
	"grid":"grid102_1",
	"url":"#this.url#/AWS/assets/plugins/jTimeBilling/timebilling.cfc",
	"title":"Time",
	"fields":{

T_ID:{key:true,edit:false,visibility:'hidden',title:'ID'}
			,remove:{title:'',width:'2%', list:user["g_delete"],display:function(d){var $img=$('<i class="fa fa-trash-o fa-2x" style="cursor:pointer"></i>');$img.click(function(){jqMessage({message:"Are you sure you want to delete this task?","type":"error",buttons:[{"name":"yes","on_click":"_removeData({id:'"+d.record.T_ID+"',page:'timebilling',group:'group102_1',plugin:'102'})","class":"button"},{"name":"no","on_click":"","class":"button"}], autoClose: false})});return $img}}	
			,T_START:{title:'Start Time',width:'2%'}
			,T_STOP:{title:'End Time',width:'2%'}
			,T_DIFF:{title:'Time Diffrence'}
			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("##g102_1_filter").val()+'","orderBy":"0","row":"0","ID":"'+$("##tb_id").val()+'","loadType":"group102_1"}',
	"functions":''
})};
*/
})

</script>
</cfoutput>
<span class="trackers">
<input type="hidden" id="tb_id" value="0" />
<input type="hidden" id="ta_id" value="0" />
<input type="hidden" id="t_id" value="0" />
<input type="hidden" id="isLoaded_group102" value="0" />
<input type="hidden" id="isLoaded_group102_1" value="0" />
<input type="hidden" id="isLoaded_group102_2" value="0" />
</span>
<div id="group102" class="gf-checkbox" >
<h3 onClick="_group102();">Time Card</h3>
<div>
		<div><label for="g102_filter">Filter</label><input id="g102_filter" onBlur="_grid102();" onKeyPress="if(event.keyCode==13){_grid102();}"/></div>
		<div id="grid102" class="tblGrid"></div>

</div>
<cfoutput>
<h4 #iif(Session.user.role neq '3',DE(''),DE('style="display:none;"'))# onClick='_group102_addtimecard();'>Add Time Card</h4>
</cfoutput>
<div>
    <div><label for="g102_employee">Employee</label><select id="g102_employee" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="selectUsers"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	<div><label for="g102_date">Date</label><input type="text" class="date" id="g102_date"/></div>
   	
 	<div><label for="g102_field1">Field1</label><input type="text"id="g102_field1" class="readonly" readonly="readonly"></div>
  	<div><label for="g102_field2">Field2</label><input type="text"id="g102_field2" class="readonly" readonly="readonly"></div>
  	<div><label for="g102_field3">Field3</label><input type="text"id="g102_field3" class="readonly" readonly="readonly"></div>
  	<div><label for="g102_field4">Field4</label><input type="text"id="g102_field4" class="readonly" readonly="readonly"></div>
  

   	<div><label for="g102_description">Description</label><select id="g102_description" onchange="jqValid({'type':'rationalNumbers','object':this,'message':'You must select an option.'})"><option value="0">&nbsp;</option><cfoutput query="g102_description"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
	
	<div><label for="g102_notes">Notes</label><textarea type="text" id="g102_notes" cols="4" rows="4"  maxlength="1000"></textarea></div>
	<div><label for="g102_paymentstatus">Billing Status</label><select id="g102_paymentstatus"><option value="0">&nbsp;</option><cfoutput query="global_paid"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>



    <div><label for="g102_manualtime">Manual Time</label><input type="text" id="g102_manualtime"  onchange="_group102_calculatedfields()" ></div>
    <div><label for="g102_totaltime">Total Time</label><input type="text" class="readonly" readonly id="g102_totaltime" ></div>
  	<div><label for="g102_ratetype">Rate Type</label><select id="g102_ratetype" onchange="_group102_calculatedfields()"><option value="0">$0 - No Rate Selected</option><cfoutput query="g102_ratetype"><option value="#optionvalue_id#">$#option_1# - #optionname#</option></cfoutput></select></div>
    <div><label for="g102_subtotal">Subtotal</label><input type="text" class="readonly" readonly id="g102_subtotal" ></div>  
    <div><label for="g102_totalexpense">Total Expenses</label><input type="text" class="readonly" readonly id="g102_totalexpense" ></div>
    <div><label for="g102_total">Total</label><input type="text" class="readonly" readonly id="g102_total" ></div>
     
		<!---div><label for="g102_mileage">Mileage</label><input type="text" maxlength="10" id="g102_mileage" ></div--->
    	<!---div><label for="g102_reimbursement">Reimbursement</label><input type="text" maxlength="10" id="g102_reimbursement" ></div--->
   		<!---div><label for="g102_flatfee">Flat Fee</label><input type="text" maxlength="10" id="g102_flatfee" ></div--->
    	<!---div><label for="g102_adjustment">Adjustment</label><input type="text" maxlength="10" id="g102_adjustment" ></div--->
</div>  


<h4 onClick='_group102_addtime();'>Add Time</h4>
<div>
        <div><label for="g102_1_start">Start Time</label><input type="text" class="datetime" id="g102_1_start" ></div>
        <div><label for="g102_1_stop">End Time</label><input type="text" class="datetime" id="g102_1_stop" ></div>
</div>


<h4 onClick='_group102_addExpense();'>Add Expense</h4>
<div>
<div><label for="g102_2_description">Description</label><select id="g102_ratetype"><option value="0">&nbsp;</option><cfoutput query="g102_expense"><option value="#optionvalue_id#">#optionname#</option></cfoutput></select></div>
<div><label for="g102_2_amount">Amount</label><input type="text" id="g102_2_amount" ></div>
<div><label for="g102_2_billable"><input id="g1_credithold" type="checkbox" class="ios-switchb" value="true">Bill Client</label></div>

</div>
</div>