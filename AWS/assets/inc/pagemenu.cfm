
<!--- VERTICAL MENUS --->
<div class="menus">
<!--- SMALL MENU ---><cfoutput>
<div id="smallMenu" style="display:inherit;">

</div></cfoutput>
<!--- LARGE MENU --->
<div id="largeMenu" style="display:none;">
<cfoutput><h1 class="#page.module#"><a href="#this.url##CGI.SCRIPT_NAME#">#page.title#</a></h1></cfoutput>
<ul id="menuLeft">
<cfset i="0">
<cfoutput>



<cfloop list="#page.menuLeft#"  index="name">
<cfset i=i+1><li ><a href="##" #IIF( i eq 1, DE("class='highlight'"), DE("") )# onclick="$('.gf-checkbox').hide();$('##group#i#').show();_highlight(this);_run.load_group#i#();$('##g0_filter').val('');">#name#</a></li>
</cfloop>

<cfif page.menuLeft_report neq "">
<cfloop query="#selectReports#">
<cfset i=i+1><li ><a href="##" #IIF( i eq 1, DE("class='highlight'"), DE("") )# onclick="_highlight(this);$('##g0_filter').val('#report_query#');_run.load_group1();">#report_name#</a></li>
</cfloop>
</cfif>

<cfinclude template="/assets/plugins/menu.cfm">
</ul>
</cfoutput>
<cfif url.debug eq true>
<div style=" position:fixed; bottom:45px; width:300px; overflow:scroll;">
<cfdump var="#Session.user#">
<cfdump var="#page#">
</div>
</cfif>

</div>
</div>
<!---cfinclude template="../addins/menu.cfm"--->
<span class="trackers">
<cfoutput><cfloop list="#page.trackers#" index="name"><cfset i=i+1><input type="hidden" id="#name#" value="0" /></cfloop><cfif page.formid neq 0><input type="hidden" id="form_id" value="#page.formid#" /></cfif><input type="hidden" id="user_id" value="#session.user.id#" /></cfoutput>
</span>
