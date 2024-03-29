<!--- Required for AJAX --->
<cfheader name="Cache-Control" value="no-cache"/>
<cfheader name="Expires" value="0"/>
<cfset page.module="_accountingservices">
<cfset page.location="financialstatements_report">
<cfset page.formid=5>
<cfset page.title="Financial Statements Report">
<cfset page.menuLeft="Financial Statement Status, Financial Data Status">
<cfset page.menuLeft_report="Yes">
<cfset page.type="report">
<cfset page.trackers="task_id">
<cfset page.plugins.disable="ALL">
<cfset page.footer="0">
<!DOCTYPE html> 

<html xmlns="http://www.w3.org/1999/xhtml">
<!---Head & Supporting Documents--->
<cfinclude template="/assets/inc/header.cfm">
<cfinclude template="/assets/inc/pagemenu.cfm">


<body onLoad="document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu'); ">
<!---PAGE CONTENTS--->
<div id="content" class="contentsmall"><nav id="topMenu">
<cfinclude template="/assets/module/menu2/menu.cfm"></nav>

 <div id="group1" class="gf-checkbox">
	<cfoutput><h3>#page.title# Search</h3></cfoutput>
	<div>
	<div>
    <label for="g0_filter">Filter</label><span class="search-bar"><input id="g0_filter" onBlur="_grid1();" onKeyPress="if(event.keyCode==13){_grid1();}"/></span><span class="search-bar search-btn">&nbsp;</span><div class="search-tog"><div class="search-togcan"><div>Methods:<br/><ul></ul></div><div></div><div class="search-togfooter" onClick="$('#group1 .search-tog').slideToggle('fast');">&and;</div></div></div><span class="search-togbtn" onClick="$('#group1 .search-tog').slideToggle('fast');">&or;</span></div>
	<div id="g1_searchOptions"></div>
    <div class="tblGrid" id="grid1"></div>
    </div>
 </div>
 
 <div id="group2" class="gf-checkbox">
	<cfoutput><h3>#page.title# Search</h3></cfoutput>
	<div>
	<div><label for="g2_filter">Filter</label><span class="search-bar"><input id="g2_filter" onBlur="_grid2();" onKeyPress="if(event.keyCode==13){_grid2();}"/></span><span class="search-bar search-btn">&nbsp;</span><div class="search-tog"><div class="search-togcan"><div>Methods:<br/><ul></ul></div><div></div><div class="search-togfooter" onClick="$('#group2 .search-tog').slideToggle('fast');">&and;</div></div></div><span class="search-togbtn" onClick="$('#group2 .search-tog').slideToggle('fast');">&or;</span></div>
	<div id="g2_searchOptions"></div><div class="tblGrid" id="grid2"></div>
    </div>
 </div>

<!--- Start Plugins --->
<cfinclude template="/assets/plugins/plugins.cfm">

<!--- END FIELD DATA --->
<!--- END CONTENTS --->
</div>
<!---Start of footer--->
<cfinclude template="/assets/inc/footer.cfm" />
</body>
</html>