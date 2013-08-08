<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset session.module="_accountingservices">
<cfset page.location="financialstatements">
<cfset page.formid=5>
<cfset page.title="Financial Statements">
<cfset page.menuLeft="General,SubTasks,Comment">
<cfset page.trackers="cf_isLoaded,client_id,fds_id">


<!--- Load ALL Select Options for this page--->
<cfquery name="selectOptions" cachedWithin="#CreateTimeSpan(0, 1, 0, 0)#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE[formName]='Client Maintenance'</cfquery>
<!--- Load Select Options for each dropdown--->

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="../assets/inc/header.cfm">
<body onLoad=" ">
<!--- Load Left Menus --->
<cfinclude template="../assets/inc/pagemenu.cfm">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../assets/module/menu/menu.cfm"></nav>


<!--- ENTRANCE --->
<div id="entrance">
<cfoutput><h3>#page.title# Search</h3></cfoutput>
<div>
<div><label for="fss_filter">Filter</label><input id="fss_filter" onBlur="_grid1();"/></div>
<!--- Entrace Grid --->
<div class="tblGrid" id="grid1"></div>
<div class="buttonbox">
<a href="#" class="button optional" onClick="document.getElementById('content').className='contentbig';_toggle('client,largeMenu');_hide('entrance,upload,contacts,services,maintenance,state,rclients');">Add</a>
</div>
</div>
</div>

<!--- FIELD DATA --->

<div  id="group1" class="gf-checkbox">
	<h3>General</h3>
	<div>
		<div><label for="g_year">Year</label><input type="text" id="g_year" /></div>
		<div><label for="g_month">Month</label><select id="g_month"></select></div>
		<div><label for="g_periodend">Period End</label><input type="text" id="g_periodend" /></div>
		<div><label for="g_status">Status</label><select id="g_status" ></select></div>
		<div><label for="g_duedate">Due Date</label><input type="text" id="g_duedate"  /></div>
		<div><label for="g_priority">Priority</label><input type="text" id="g_priority"  /></div>
		<div><label for="g_esttime">Est. Time</label><input type="text" id="g_esttime"  /></div>
		<div><input type="checkbox" id="g_missinginfo"><label for="g_missinginfo">Missing Info</label></div>
		<div><label for="g_mireceived">MI Received</label><input type="text"id="g_mireceived"/></div>
		<div><input type="checkbox" id="g_compilemi"/><label for="g_compilemi">Compile MI</label></div>
		<div><label for="g_cmireceived">CMI Received</label><input type="text" id="g_cmireceived"  /></div>
		<div><label for="g_fees">Fees</label><input type="text" id="g_fees"  /></div>
		<div><label for="g_paymentstatus">Payment Status</label><select id="g_paymentstatus" ></select></div>
		<div><label for="g_deliverymethod">Delivery Method</label><select id="g_deliverymethod" ></select></div>
	</div>
    

	<h4>Obtain Info</h4>   
	<div>
		<div><label for="oi_assignedto">Assigned to</label><select id="oi_assignedto" ></select></div>
		<div><label for="g_oi_datecompleted">Date Completed</label><input type="text" id="oi_datecompleted"  /></div>
		<div><label for="oi_completedby">Competed By</label><select id="oi_completedby" ></select></div>
		<div><label for="oi_estimatedtime">Estimated Time</label><input type="text" id="oi_estimatedtime"  /></div>
	</div>
	<h4>Sort</h4>
	<div>
		<div><label for="so_assignedto">Assigned to</label><select id="so_assignedto" ></select></div>
		<div><label for="so_datecompleted">Date Completed</label><input type="text" id="so_datecompleted"  /></div>
		<div><label for="so_completedby">Competed By</label><select id="so_completedby" ></select></div>
		<div><label for="so_estimatedtime">Estimated Time</label><input type="text" id="so_estimatedtime"  /></div>
	</div>
	<h4>Checks</h4>
	<div>
		<div><label for="ch_assignedto">Assigned to</label><select id="ch_assignedto" ></select></div>
		<div><label for="ch_datecompleted">Date Completed</label><input type="text" id="ch_datecompleted" /></div>
		<div><label for="ch_completedby">Competed By</label><select id="ch_completedby" ></select></div>
		<div><label for="ch_estimatedtime">Estimated Time</label><input type="text" id="ch_estimatedtime"  /></div>
	</div>
	<h4>Sales</h4>
	<div>
		<div><label for="sa_assignedto">Assigned to</label><select id="sa_assignedto" ></select></div>
		<div><label for="sa_datecompleted">Date Completed</label><input type="text" id="sa_datecompleted"  /></div>
		<div><label for="sa_completedby">Competed By</label><select id="sa_completedby" ></select></div>
		<div><label for="sa_estimatedtime">Estimated Time</label><input type="text" id="sa_estimatedtime" /></div>
	</div>
	<h4>Entry</h4>
	<div>
		<div><label for="en_assignedto">Assigned to</label><select id="en_assignedto" ></select></div>
		<div><label for="en_datecompleted">Date Completed</label><input type="text" id="en_datecompleted"  /></div>
		<div><label for="en_completedby">Competed By</label><select id="en_completedby" ></select></div>
		<div><label for="en_estimatedtime">Estimated Time</label><input type="text" id="en_estimatedtime"  /></div>
	</div>
	<h4>Bank Reconcile</h4>
	<div>
		<div><label for="br_assignedto">Assigned to</label><select id="br_assignedto"></select></div>
		<div><label for="br_datecompleted">Date Completed</label><input type="text" id="br_datecompleted"  /></div>
		<div><label for="br_completedby">Competed By</label><select id="br_completedby" ></select></div>
		<div><label for="br_estimatedtime">Estimated Time</label><input type="text" id="br_estimatedtime"/></div>
	</div>
	<h4>Compile</h4>
	<div>
		<div><label for="co_assignedto">Assigned to</label><select id="co_assignedto" ></select></div>
		<div><label for="co_datecompleted">Date Completed</label><input type="text" id="co_datecompleted"  /></div>
		<div><label for="co_completedby">Competed By</label><select id="co_completedby"></select></div>
		<div><label for="co_estimatedtime">Estimated Time</label><input type="text" id="co_estimatedtime"  /></div>
	</div>
	<h4>Review</h4>
	<div>
		<div><label for="re_assignedto">Assigned to</label><select id="re_assignedto" ></select></div>
		<div><label for="re_datecompleted">Date Completed</label><input type="text" id="re_datecompleted"  /></div>
		<div><label for="re_completedby">Competed By</label><select id="re_completedby" ></select></div>
		<div><label for="re_estimatedtime">Estimated Time</label><input type="text" id="re_estimatedtime" /></div>
	</div>
	<h4>Assembly</h4>
	<div>
		<div><label for="as_assignedto">Assigned to</label><select id="as_assignedto" ></select></div>
		<div><label for="as_datecompleted">Date Completed</label><input type="text" id="as_datecompleted"  /></div>
		<div><label for="as_completedby">Competed By</label><select id="as_completedby" ></select></div>
		<div><label for="as_estimatedtime">Estimated Time</label><input type="text" id="as_estimatedtime"  /></div>
	</div>
	<h4>Delivery</h4>
	<div>
		<div><label for="g_assignedto">Assigned to</label><select id="de_assignedto" ></select></div>
		<div><label for="g_datecompleted">Date Completed</label><input type="text" id="de_datecompleted"/></div>
		<div><label for="g_completedby">Competed By</label><select id="de_completedby"></select></div>
		<div><label for="g_estimatedtime">Estimated Time</label><input type="text" id="de_estimatedtime"  /></div>
	</div>
	<h4>Accountant's Rpt</h4>
	<div>
		<div><label for="ar_assignedto">Assigned to</label><select id="ar_assignedto" ></select></div>
		<div><label for="ar_datecompleted">Date Completed</label><input type="text" id="ar_datecompleted"  /></div>
		<div><label for="ar_completedby">Competed By</label><select id="ar_completedby"></select></div>
		<div><label for="ar_estimatedtime">Estimated Time</label><input type="text" id="ar_estimatedtime"  /></div>
	</div>
</div>

<!--- SubTasks Group --->
<div id="group2" class="gf-checkbox">
	<h4>SubTasks</h4>
	<div>
		<div><label for="st_sequence">Sequence</label><input type="text" id="st_sequence"  /></div>
		<div><label for="st_subtask">SubTask</label><select id="st_subtask" ></select></div>
		<div><label for="st_status">Status</label><select id="st_status"></select></div>
		<div><label for="st_assignedto">Assigned To</label><input type="text" id="st_assignedto"/></div>
		<div><label for="st_duedate">Due Date</label><input type="text" id="st_duedate" /></div>
		<div><label for="st_completed">Completed</label><input type="text" id="st_completed"  /></div>
		<div><label for="st_notes">Notes</label><textarea id="st_notes" ></textarea></div>
	</div>
</div>
<!--- Comments Group --->
<div id="group3" class="gf-checkbox">
<h4>Comments</h4>
<div>
<div><label for="g_date">Date:</label><input type="text" id="g_date"  /></div>
<div><label for="g_employee">Employee:</label><select id="g_employee" ></select></div>
<div><label for="g_comments">Comments:</label><textarea id="g_comments" ></textarea></div>
</div>
</div>

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
</div>
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>