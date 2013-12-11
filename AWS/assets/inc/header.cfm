<cfparam name="page.type" default="">
<cfparam name="url.taskid" default="0">
<cfset page.cache.users=CreateTimeSpan(0,0,25,0)>
<cfset page.cache.options=CreateTimeSpan(0,0,25,0)>
<cfset page.cache.clients=CreateTimeSpan(0,0,25,0)>
<cfquery name="selectOptions" cachedWithin="#page.cache.options#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[optionDescription]FROM[v_selectOptions]WHERE([form_id]='#page.formid#'OR[form_id]='0')AND([optionGroup]='#page.formid#'OR[optionGroup]='0')</cfquery>
<cfquery name="selectClients" cachedWithin="#page.cache.clients#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#page.cache.users#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<head>

<cfoutput><title>#page.title#</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" media="all" type="text/css" href="#this.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-timepicker-addon.css" />

<link rel="stylesheet" id="size-stylesheet"  media='screen and (min-width: 1000px)'  href="#this.url#/AWS/assets/module/menu/menu.css"/>
<link rel='stylesheet' media='screen and (max-width: 1000px)'  href="#this.url#/AWS/assets/module/menu/menusmall.css" />

<cfswitch expression="#page.module#">
<cfcase value="_accountingservices"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/blue/jtable.min.css"></cfcase>
<cfcase value="_clientmanagement"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/green/jtable.min.css"></cfcase>
<cfcase value="_payrolltaxes"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/red/jtable.min.css"></cfcase>
<cfcase value="_payrolltaxes_report"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/red/jtable.min.css"></cfcase>
<cfcase value="_practicemanagement"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/darkgray/jtable.min.css"></cfcase>
<cfcase value="_taxation"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/darkorange/jtable.min.css"></cfcase>
<cfdefaultcase><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jtable/themes/metro/darkgray/jtable.min.css"></cfdefaultcase>
</cfswitch>
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/chosen/chosen.css">
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jqMessage/jqMessage.css">
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/module/jqvalid/jqvalid.css">
<link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css">
<cfswitch expression="#page.type#">
<cfcase value="report"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/report.css"/></cfcase>
<cfdefaultcase><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/aws.css"/></cfdefaultcase>
</cfswitch>

<script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<!---
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
--->
<script type="text/javascript" src="#this.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-sliderAccess.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jtable/jquery.jtable.min.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jqMessage/jqmessage.jquery.min.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jqValid/jqValid.jquery.js"></script>
<script language="javascript"  src="#this.url#/AWS/assets/plugins/pluginsjs.cfm?id=#createUuid()#"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/js/aws.js"></script>
<link rel="stylesheet" type="text/css" href="#page.module#.css">
<script type="text/javascript" src="#page.location#.js"></script>
<script>
function adjustStyle(width) {
    width = parseInt(width);
    if (width < 701) {
        $("##size-stylesheet").attr("href", "#this.url#/AWS/assets/module/menu/menusmall.css");
    } else if ((width >= 701) && (width < 900)) {
        $("##size-stylesheet").attr("href", "#this.url#/AWS/assets/module/menu/menu.css");
    } else {
       $("##size-stylesheet").attr("href", "#this.url#/AWS/assets/module/menu/menu.css"); 
    }
}

$(function() {
    adjustStyle($(this).width());
    $(window).resize(function() {
        adjustStyle($(this).width());
    });
});

</script>
<cfif url.taskid GT 0>
<cfquery dbtype="query" name="clientName">SELECT[optionname]FROM[selectClients]WHERE[optionvalue_id]=#url.taskid#</cfquery>
<script>
// A $( document ).ready() block.
$( document ).ready(function() {
$("##task_id").val('#url.taskid#');	
_toggle('group1,largeMenu');
_hide('entrance');
$("##content").removeClass();
$("##content").addClass("contentbig");
_loadData({"id":"task_id","group":"group1","page":"#page.location#"});
_updateh3("#clientName.optionname#");
});
</script>
<cfdump var="#clientName#">
</cfif>

</cfoutput>
</head>