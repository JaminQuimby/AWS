<cfparam name="page.type" default="">
<head>
<cfoutput><title>#page.title#</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" media="all" type="text/css" href="#Application.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-timepicker-addon.css" />
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/menu/menu.css"/>
<cfswitch expression="#page.module#">
<cfcase value="_accountingservices">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/blue/jtable.min.css">
</cfcase>
<cfcase value="_clientmanagement">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/green/jtable.min.css">
</cfcase>
<cfcase value="_payrolltaxes">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/red/jtable.min.css">
</cfcase>
<cfcase value="_payrolltaxes_report">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/red/jtable.min.css">
</cfcase>
<cfcase value="_practicemanagement">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/darkgray/jtable.min.css">
</cfcase>
<cfcase value="_taxation">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/darkorange/jtable.min.css">
</cfcase>
<cfdefaultcase>
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jtable/themes/metro/pink/jtable.min.css">
</cfdefaultcase>
</cfswitch>
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/chosen/chosen.css">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jqMessage/jqMessage.css">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/module/jqvalid/jqvalid.css">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/plugins/jUpload/assets/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css">

<cfswitch expression="#page.type#">
<cfcase value="report">
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/css/report.css"/>
</cfcase>
<cfdefaultcase>
<link rel="stylesheet" type="text/css" href="#Application.url#/AWS/assets/css/aws.css"/>
</cfdefaultcase>
</cfswitch>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-sliderAccess.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/jtable/jquery.jtable.min.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/jqMessage/jqmessage.jquery.min.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/module/jqValid/jqValid.jquery.js"></script>
<script language="javascript"  src="#Application.url#/AWS/assets/plugins/pluginsjs.cfm?id=#createUuid()#"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/plugins/jUpload/assets/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="#Application.url#/AWS/assets/js/aws.js"></script>
<link rel="stylesheet" type="text/css" href="#page.module#.css">
<script type="text/javascript" src="#page.location#.js"></script>
</cfoutput>
</head>