<!--- VERTICAL MENUS --->
<div class="menus">
<!--- SMALL MENU --->
<nav id="smallMenu" style="display:inherit;">
<cfoutput><h1 class="#session.module#">&nbsp;</h1></cfoutput>
</nav>
<!--- LARGE MENU --->
<nav id="largeMenu" style="display:none;">
<cfoutput><h1 class="#session.module#">#page.title#</h1></cfoutput>
<ul id="menuLeft">
<cfset i="0">
<cfoutput>
<cfloop list="#page.menuLeft#" index="name">
<cfset i=i+1>
<li><a href="##" onclick="$('.gf-checkbox').hide();$('##group#i#').show();_highlight(this);">#name#</a></li>
</cfloop>
</cfoutput>
</ul>
</nav>
</div>