<cfparam name="page.trackers" default="">
<cfparam name="page.menuLeft" default="">
<cfparam name="page.formid" default="0">
<cfparam name="url.debug" default="false">

<!--- VERTICAL MENUS --->
<div class="menus">
<!--- SMALL MENU --->
<nav id="smallMenu" style="display:inherit;">
<cfoutput><h1 class="#page.module#">&nbsp;</h1></cfoutput>
</nav>
<!--- LARGE MENU --->
<nav id="largeMenu" style="display:none;">
<cfoutput><h1 class="#page.module#"><a href="#this.url##CGI.SCRIPT_NAME#">#page.title#</a></h1></cfoutput>
<ul id="menuLeft">
<cfset i="0">
<cfoutput>
<cfloop list="#page.menuLeft#"  index="name">
<cfset i=i+1><li ><a href="##" #IIF( i eq 1, DE("class='highlight'"), DE("") )# onclick="$('.gf-checkbox').hide();$('##group#i#').show();_highlight(this);_group#i#();">#name#</a></li>
</cfloop>

<cfinclude template="/assets/plugins/menu.cfm">

</ul>
</cfoutput>
<cfif url.debug eq true>
<div style=" position:fixed; bottom:45px; width:300px; overflow:scroll;">
<cfdump var="#Session.user#">
<cfdump var="#page#">
</div>
</cfif>

</nav>
</div>
<!---cfinclude template="../addins/menu.cfm"--->
<span class="trackers">
<cfoutput><cfloop list="#page.trackers#" index="name"><cfset i=i+1><input type="hidden" id="#name#" value="0" /></cfloop><cfif page.formid neq 0><input type="hidden" id="form_id" value="#page.formid#" /></cfif><input type="hidden" id="user_id" value="#session.user.id#" /></cfoutput>
</span>