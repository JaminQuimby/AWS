<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_taxation">
<cfset page.location="notices_report">
<cfset page.formid=8>
<cfset page.title="Notices Report">
<cfset page.menuLeft="General">
<cfset page.type="report">
<cfset page.trackers="task_id,subtask1_id">
<cfset page.plugins.disable="ALL">
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="../../assets/inc/header.cfm">
<cfinclude template="../../assets/inc/pagemenu.cfm">


<body onLoad="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu,group2'); ">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="../../assets/module/menu/menu.cfm"></nav>

<!--- ENTRANCE --->
  <div id="group1" class="gf-checkbox">
  <cfoutput><h3>#page.title# Search</h3></cfoutput>
	<div>
	<div><label for="g0_filter">Filter</label><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></div>
	<div class="tblGrid" id="grid1"></div>
	<div class="buttonbox"><a href="#" class="button optional" onClick="">Add</a></div>
    </div>
  </div>


<!--- Start Plugins --->
<cfinclude template="../assets/plugins/plugins.cfm">
<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="../assets/inc/footer.cfm" />
</body>
</html>