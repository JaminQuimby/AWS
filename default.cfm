<cfparam name="url.admin" default="0">
<cfif url.admin neq 1>
<cflocation url="/AWS/_practicemanagement/workinprogress.cfm?user_id=#Session.user.id#">
</cfif>

<html>
    <head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <style>
		body{height:100%}
            html {
                font-size:10px;
            }

            .iframetab {
                width:100%;
                height:100%
                border:0px;
                margin:0px;
                background:url("data/iframeno.png");
                position:relative;
                top:-13px;
            }

            .ui-tabs-panel {
                padding:5px !important;
            }

            .openout {
                float:right;
                position:relative;
                top:-28px;
                left:-5px;
            }
        </style>
        <script>
            $(document).ready(function() {
                var $tabs = $('#tabs').tabs();

                //get selected tab
                function getSelectedTabIndex() {
                    return $tabs.tabs('option', 'selected');
                }

                //get tab contents
                beginTab = $("#tabs ul li:eq(" + getSelectedTabIndex() + ")").find("a");

                loadTabFrame($(beginTab).attr("href"),$(beginTab).attr("rel"));

                $("a.tabref").click(function() {
                    loadTabFrame($(this).attr("href"),$(this).attr("rel"));
                });

                //tab switching function
                function loadTabFrame(tab, url) {
                    if ($(tab).find("iframe").length == 0) {
                        var html = [];
                        html.push('<div class="tabIframeWrapper">');
                        html.push('<div class="openout"><a href="' + url + '"><img src="data/world.png" border="0" alt="Open" title="Remove iFrame" /></a></div><iframe class="iframetab" src="' + url + '">Load Failed?</iframe>');
                        html.push('</div>');
                        $(tab).append(html.join(""));
                        $(tab).find("iframe").height($(window).height()-80);
                    }
                    return false;
                }
            });
        </script>
    </head>
    <body>
  <ul>
                <li><a class="tabref" href="#tabs-1" rel="AWS/_taxation/taxreturns.cfm">google</a></li>
                <li><a class="tabref" href="#tabs-2" rel="http://yahoo.com">yahoo</a></li>
                <li><a class="tabref" href="#tabs-3" rel="http://bing.com">bing</a></li>
            </ul>
            
            
        <div id="tabs">
          
            <div id="tabs-1" class="tabMain">
            </div>

            <div id="tabs-2">
            </div>

            <div id="tabs-3">
            </div>
        </div> 

    </body>
</html>