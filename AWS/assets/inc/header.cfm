<cfheader name="Access-Control-Allow-Origin" value="*">
<cfparam name="page.type" default="">
<cfset page.cache.users=CreateTimeSpan(0,0,0,0)>
<cfset page.cache.options=CreateTimeSpan(0,0,0,0)>
<cfset page.cache.clients=CreateTimeSpan(0,0,0,0)>
<cfset page.cache.roles=CreateTimeSpan(0,0,25,0)>
<cfset page.cache.reports=CreateTimeSpan(0,0,25,0)>
<cfquery name="selectOptions" cachedWithin="#page.cache.options#" datasource="AWS">SELECT[selectName],[optionvalue_id],[optionname],[option_1],[optionDescription]FROM[v_selectOptions]WHERE([form_id]='#page.formid#'OR[form_id]='0')AND([optionGroup]='#page.formid#'OR[optionGroup]='0')AND([optionHide]!='#page.formid#'OR[optionHide]IS NULL)</cfquery>
<cfquery name="selectClients" cachedWithin="#page.cache.clients#" datasource="AWS">SELECT[client_id]AS[optionvalue_id],[client_name]AS[optionname]FROM[client_listing]WHERE[client_active]=1</cfquery>
<cfquery name="selectUsers" cachedWithin="#page.cache.users#" datasource="AWS">SELECT[user_id]AS[optionvalue_id],[si_initials]AS[optionname]FROM[v_staffinitials]WHERE[si_active]=1 ORDER BY[si_initials]</cfquery>
<cfquery name="selectReports" cachedWithin="#page.cache.reports#" datasource="AWS">SELECT[report_name],[report_description],[report_query],[report_fields]FROM[ctrl_reports]WHERE[form_id]='#page.formid#'AND([user_id]=0)ORDER BY[report_order]</cfquery>
<cfquery name="selectRoles"  cachedWithin="#page.cache.roles#" datasource="AWS">SELECT[m_payrolltaxes],[m_accountingservices],[m_taxation],[m_clientmanagement],[m_maintenance],[g_delete]FROM[v_staffinitials]WHERE[user_id]=<cfqueryparam value="#Session.user.id#"/></cfquery>

<!---Required for Time Billing plugin--->
<cfquery dbtype="query" name="global_paid">SELECT[optionvalue_id],[optionname]FROM[selectOptions]WHERE[selectName]='global_paid'</cfquery>
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
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.min.css"/>
<cfswitch expression="#page.type#">
<cfcase value="report"><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/report.css"/></cfcase>
<cfdefaultcase><link rel="stylesheet" type="text/css" href="#this.url#/AWS/assets/css/aws.css"/></cfdefaultcase>
</cfswitch>
<link rel="stylesheet" type="text/css" href="#page.module#.css">
<!---
<script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
--->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

<script>
user = {"id":"","name":"","email":"","role":"","organization":"","g_delete":"0","g_payrolltaxes":"0","g_accountingservices":"0","g_taxation":"0","g_clientmanagement":"0","g_maintenance":"0"};
params={"id":"#Session.user.id#","name":"#Session.user.name#","email":"#Session.user.email#","role":"#Session.user.role#","organization":"#Session.user.organization#","g_delete":"#selectRoles.g_delete#","g_payrolltaxes":"#selectRoles.m_payrolltaxes#","g_accountingservices":"#selectRoles.m_accountingservices#","g_taxation":"#selectRoles.m_taxation#","g_clientmanagement":"#selectRoles.m_clientmanagement#","g_maintenance":"#selectRoles.m_maintenance#"};
$.extend(true, user, params);
</script>
<!---
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
--->
<script type="text/javascript" src="#this.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-sliderAccess.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jquery-Timepicker-Addon/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jtable/jquery.jtable.min.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jqMessage/jqmessage.jquery.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jqValid/jqValid.jquery.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/module/jquery-mask-plugin-master/jquery.mask.min.js"></script>
<script language="javascript"  src="#this.url#/AWS/assets/plugins/pluginsjs.cfm?id=#createUuid()#"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/plugins/jUpload/assets/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="#this.url#/AWS/assets/js/aws.js"></script>
<script type="text/javascript" src="#page.location#.js"></script>

</cfoutput>
</head>