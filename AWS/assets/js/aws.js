/*Developer: Jamin Quimby*/
//prototype 
String.prototype.replaceAll = function (find, replace){var str = this; return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace)};
String.prototype.has = function(text) { return this.toLowerCase().indexOf("" + text.toLowerCase() + "") != -1; };
String.prototype.insert = function (index, string) {if (index > 0) return this.substring(0, index) + string + this.substring(index, this.length); else return string + this;};
Array.prototype.removeValue = function(name, value){var array = $.map(this, function(v,i){return v[name] === value ? null : v;});this.length = 0;this.push.apply(this, array);}
String.prototype.escapeIt = function(text) {return text.replace(/[-[\]{}()*+?.,\\^$|#"]/g, "\\$&")};
Date.prototype.mmddyyyy = function(){var yyyy=this.getFullYear().toString(),mm=(this.getMonth()+1).toString(),dd=this.getDate().toString();return(mm[1]?mm:"0"+mm[0])+'/'+(dd[1]?dd:"0"+dd[0])+'/'+yyyy};


//Localisation 
var debug=true;
$(document).ready(function(){

$.ajaxSetup({cache:false});//Stop ajax cacheing
$.datepicker.setDefaults({showOn:"button",buttonImageOnly:true,buttonImage:"https://"+window.location.hostname+"/AWS/assets/img/datepicker.gif",showButtonPanel:true,constrainInput:true});
$(".datetime").datetimepicker({timeFormat: 'hh:mmtt'}).mask('00/00/0000 00:00:00');
$(".date").datepicker().mask('00/00/0000');
$(".time").timepicker().mask('00:00:00');
$('.phone').mask('(000)000-0000');
$('select').chosen();
$('.gf-checkbox').hide();
$('#entrance').show();
$('.gf-checkbox').accordion({collapsible:true,heightStyle:"content",active:false,active:0});

$('.accordianclose').hide();
var icons=$('.gf-checkbox').accordion( "option", "icons" );
$('.accordianopen').click(function(){
	$('.ui-accordion-header').removeClass('ui-corner-all').addClass('ui-accordion-header-active ui-state-active ui-corner-top').attr({'aria-selected': 'true','tabindex': '0'});
	$('.ui-accordion-header-icon').removeClass(icons.header).addClass(icons.headerSelected);
	$('.ui-accordion-content').addClass('ui-accordion-content-active').attr({'aria-expanded': 'true','aria-hidden': 'false'}).show();
	$(this).attr("disabled","disabled");
	$('.accordianclose').removeAttr("disabled");
	$('.accordianopen').hide();
	$('.accordianclose').show();
	});
$('.accordianclose').click(function(){
	$('.ui-accordion-header').removeClass('ui-accordion-header-active ui-state-active ui-corner-top').addClass('ui-corner-all').attr({'aria-selected': 'false','tabindex': '-1'});
	$('.ui-accordion-header-icon').removeClass(icons.headerSelected).addClass(icons.header);
	$('.ui-accordion-content').removeClass('ui-accordion-content-active').attr({'aria-expanded': 'false','aria-hidden': 'true'}).hide();
	$(this).attr("disabled","disabled");
	$('.accordianopen').removeAttr("disabled");
	$('.accordianopen').show();
	$('.accordianclose').hide();
	});
$('.ui-accordion-header').click(function(){
	$('.accordianopen').removeAttr("disabled");
	$('.accordianclose').removeAttr("disabled");
        
	});
$( "<div class='switch'></div>" ).insertAfter( ".ios-switch,.ios-switchb" );
	
	
_toCSV2=function($table, filename) {

        var $rows = $table.find('tr:has(td)'),

            tmpColDelim = String.fromCharCode(11), // vertical tab character
            tmpRowDelim = String.fromCharCode(0), // null character
            colDelim = '","',
            rowDelim = '"\r\n"',
            csv = '"' + $rows.map(function (i, row) {
                var $row = $(row),
                    $cols = $row.find('td');

                return $cols.map(function (j, col) {
                    var $col = $(col),
                        text = $col.text();

                    return text.replace('"', '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim) + '"',

            // Data URI
            csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
			window.location="data:application/csv;charset=utf-8," + encodeURIComponent(csv)

        $(this)
            .attr({
            'download': filename,
                'href': csvData,
                'target': '_blank'
        });
		
    }

    // This must be a hyperlink
    $(".export").on('click', function (event) {
        _toCSV.apply(this, [$('#'+$table+'>table'), 'export.csv']);
    });
});



(function($, window){
// i'll just put them here to get evaluated on script load
var htmlSpecialCharsRegEx = /[<>&\r\n"']/gm;
var htmlSpecialCharsPlaceHolders = {
'<': 'lt;',
'>': 'gt;',
'&': 'amp;',
'\r': "#13;",
'\n': "#10;",
'"': 'quot;',
"'": 'apos;' /*single quotes just to be safe*/
};

$.extend({
  fileDownload: function (fileUrl, options) {
        var settings = $.extend({
			preparingMessageHtml: null,
            failMessageHtml: null,
            androidPostUnsupportedMessageHtml: "Unfortunately your Android browser doesn't support this type of file download. Please try again with a different browser.",
            dialogOptions: { modal: true },
            prepareCallback: function (url) { },
            successCallback: function (url) { },
            failCallback: function (responseHtml, url) { },
            httpMethod: "POST",
            data: null,
            checkInterval: 100,
            cookieName: "fileDownload",
            cookieValue: "true",
            cookiePath: "/",
            popupWindowTitle: "Initiating file download...",
            encodeHTMLEntities: true
        }, options)
		,deferred=new $.Deferred()
		,userAgent=(navigator.userAgent || navigator.vendor || window.opera).toLowerCase()
		,isIos
		,isAndroid
		,isOtherMobileBrowser;

        if (/ip(ad|hone|od)/.test(userAgent)){isIos = true;} 
		else if (userAgent.indexOf('android') !== -1) {isAndroid = true;} 
		else {isOtherMobileBrowser = /avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|playbook|silk|iemobile|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(userAgent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i.test(userAgent.substr(0, 4));
        }

        var httpMethodUpper = settings.httpMethod.toUpperCase();

        if (isAndroid && httpMethodUpper !== "GET") {
            if ($().dialog) {$("<div>").html(settings.androidPostUnsupportedMessageHtml).dialog(settings.dialogOptions);}
			else {alert(settings.androidPostUnsupportedMessageHtml);}
			return deferred.reject();
        }

        var $preparingDialog = null
		   ,internalCallbacks = {
				 onPrepare: function (url) {
					if (settings.preparingMessageHtml) {
					$preparingDialog = jqMessage({message:settings.preparingMessageHtml,"type":"success",autoClose: true});}
					else if (settings.prepareCallback) {
					settings.prepareCallback(url);
					}},

            onSuccess: function (url) {
                if ($preparingDialog) {$preparingDialog.dialog('close');};
                settings.successCallback(url);
                deferred.resolve(url);
            },

            onFail: function (responseHtml, url) {
                if ($preparingDialog) {$preparingDialog.dialog('close');};
                if (settings.failMessageHtml) {
					jqMessage({message:settings.failMessageHtml,"type":"error",autoClose: false});
                }
                settings.failCallback(responseHtml, url);  
                deferred.reject(responseHtml, url);
            }
        };

        internalCallbacks.onPrepare(fileUrl);
        if (settings.data !== null && typeof settings.data !== "string") {settings.data = $.param(settings.data);}

        var $iframe,
            downloadWindow,
            formDoc,
            $form;

        if (httpMethodUpper === "GET") {

            if (settings.data !== null) {
                var qsStart = fileUrl.indexOf('?');
                if (qsStart !== -1) {
                    if (fileUrl.substring(fileUrl.length - 1) !== "&") {
                        fileUrl = fileUrl + "&";
                    }
                } else {

                    fileUrl = fileUrl + "?";
                }

                fileUrl = fileUrl + settings.data;
            }

            if (isIos || isAndroid) {

                downloadWindow = window.open(fileUrl);
                downloadWindow.document.title = settings.popupWindowTitle;
                window.focus();

            } else if (isOtherMobileBrowser) {

                window.location(fileUrl);

            } else {

                //create a temporary iframe that is used to request the fileUrl as a GET request
                $iframe = $("<iframe>")
                    .hide()
                    .prop("src", fileUrl)
                    .appendTo("body");
            }

        } else {

            var formInnerHtml = "";

            if (settings.data !== null) {

                $.each(settings.data.replace(/\+/g, ' ').split("&"), function () {

                    var kvp = this.split("=");

                    var key = settings.encodeHTMLEntities ? htmlSpecialCharsEntityEncode(decodeURIComponent(kvp[0])) : decodeURIComponent(kvp[0]);
                    if (key) {
                        var value = settings.encodeHTMLEntities ? htmlSpecialCharsEntityEncode(decodeURIComponent(kvp[1])) : decodeURIComponent(kvp[1]);
                    formInnerHtml += '<input type="hidden" name="' + key + '" value="' + value + '" />';
                    }
                });
            }

            if (isOtherMobileBrowser) {

                $form = $("<form>").appendTo("body");
                $form.hide()
                    .prop('method', settings.httpMethod)
                    .prop('action', fileUrl)
                    .html(formInnerHtml);

            } else {

                if (isIos) {

                    downloadWindow = window.open("about:blank");
                    downloadWindow.document.title = settings.popupWindowTitle;
                    formDoc = downloadWindow.document;
                    window.focus();

                } else {

                    $iframe = $("<iframe style='display: none' src='about:blank'></iframe>").appendTo("body");
                    formDoc = getiframeDocument($iframe);
                }

                formDoc.write("<html><head></head><body><form method='" + settings.httpMethod + "' action='" + fileUrl + "'>" + formInnerHtml + "</form>" + settings.popupWindowTitle + "</body></html>");
                $form = $(formDoc).find('form');
            }

            $form.submit();
        }


        //check if the file download has completed every checkInterval ms
        setTimeout(checkFileDownloadComplete, settings.checkInterval);


        function checkFileDownloadComplete() {

            //has the cookie been written due to a file download occuring?
            if (document.cookie.indexOf(settings.cookieName + "=" + settings.cookieValue) != -1) {

                //execute specified callback
                internalCallbacks.onSuccess(fileUrl);

                //remove the cookie and iframe
                document.cookie = settings.cookieName + "=; expires=" + new Date(1000).toUTCString() + "; path=" + settings.cookiePath;

                cleanUp(false);

                return;
            }

            //has an error occured?
            //if neither containers exist below then the file download is occuring on the current window
            if (downloadWindow || $iframe) {

                //has an error occured?
                try {

                    var formDoc = downloadWindow ? downloadWindow.document : getiframeDocument($iframe);

                    if (formDoc && formDoc.body != null && formDoc.body.innerHTML.length) {

                        var isFailure = true;

                        if ($form && $form.length) {
                            var $contents = $(formDoc.body).contents().first();

                            if ($contents.length && $contents[0] === $form[0]) {
                                isFailure = false;
                            }
                        }

                        if (isFailure) {
                            internalCallbacks.onFail(formDoc.body.innerHTML, fileUrl);

                            cleanUp(true);

                            return;
                        }
                    }
                }
                catch (err) {

                    //500 error less than IE9
                    internalCallbacks.onFail('', fileUrl);

                    cleanUp(true);

                    return;
                }
            }


            //keep checking...
            setTimeout(checkFileDownloadComplete, settings.checkInterval);
        }

        //gets an iframes document in a cross browser compatible manner
        function getiframeDocument($iframe) {
            var iframeDoc = $iframe[0].contentWindow || $iframe[0].contentDocument;
            if (iframeDoc.document) {
                iframeDoc = iframeDoc.document;
            }
            return iframeDoc;
        }

        function cleanUp(isFailure) {

            setTimeout(function() {

                if (downloadWindow) {

                    if (isAndroid) {
                        downloadWindow.close();
                    }

                    if (isIos) {
                        if (downloadWindow.focus) {
                            downloadWindow.focus(); //ios safari bug doesn't allow a window to be closed unless it is focused
                            if (isFailure) {
                                downloadWindow.close();
                            }
                        }
                    }
                }
                
                //iframe cleanup appears to randomly cause the download to fail
                //not doing it seems better than failure...
                //if ($iframe) {
                // $iframe.remove();
                //}

            }, 0);
        }


        function htmlSpecialCharsEntityEncode(str) {
            return str.replace(htmlSpecialCharsRegEx, function(match) {
                return '&' + htmlSpecialCharsPlaceHolders[match];
         });
        }

        return deferred.promise();
    }
});

})(jQuery, this);


function _toCSV(table,filename){
$.fileDownload('https://'+window.location.hostname+'/AWS/assets/inc/export/excel.cfm',{data:'data='+encodeURIComponent( $('.jtable')[0].innerHTML),name:filename
,preparingMessageHtml: "We are preparing your report, please wait..."
,failMessageHtml: "There was a problem generating your report, please try again."});
return false;
	  };
	
_duplicateCheck=function(params){
if(debug){window.console.log('_duplicateCheck Start');}
var options={"check":"","loadType":"","page":""},str='';
$.extend(true,options,params);
$.each(options['check'],function(idx,obj){
	if($('#'+obj.item).is(':checkbox')){str=str+$('#'+obj.item).is(':checkbox')}
	else if($('#'+obj.item).val().length == 0){str=str+" "}
	else{str=str+$('#'+obj.item).val()}
	
if(idx!=options['check'].length -1 ){str=str+','}});
if(debug){window.console.log('_duplicateCheck Check '+str);}

$.ajax({type:'GET',async:false,data:{"returnFormat":"json","argumentCollection":JSON.stringify({"check":""+str+"","loadType":options['loadType']})}
,url: options['page']+'.cfc?method=f_duplicateCheck'
,success:function(data){j=$.parseJSON(data);str=j.check;}
,error:function(data){str=false;}
});return str; if(debug){window.console.log('_duplicateCheck Return:'+str);}}; 

 
_addNewTask=function(params){
var options={"new":"task_id"},str='';
$.extend(true,options,params);
	
	
if($('#task_id').val()==0){
	 $('label .fa-lock').removeClass('fa-lock').addClass('fa-unlock');
	 $('label').siblings(':disabled').prop('disabled', false).trigger("chosen:updated");
	 $('label').siblings(':disabled').prop('disabled', false);	 
}
else if($('.'+options['new']).val()==0){
	 $('.'+options['new']+' label .fa-lock').removeClass('fa-lock').addClass('fa-unlock');
	 $('.'+options['new']+' label').siblings(':disabled').prop('disabled', false).trigger("chosen:updated");
	 $('.'+options['new']+' label').siblings(':disabled').prop('disabled', false);	 
	}


}


_schk=function(i){
if(user["role"]==1){
if($('#'+i).is(":disabled")){
	$('label[for="'+i+'"] i').removeClass('fa-lock').addClass('fa-unlock');
	if($('#'+i).is('select')){
	$('#'+i).prop("disabled", false).trigger("chosen:updated");
	}else{$('#'+i).prop("disabled", false);}}}}
	

_toReport=function(data,config){
//Build Report Groups
//Build a basic json object
	var jgroup = $.parseJSON('{"b":[]}');
//split human grouped input
	group = data.split(')');
$.each(group, function(i){	
//FIRST GROUP
if(group[i]!=''){
	if(!group[i].match(/(and\s*\()|(or\s*\()/gi)){		
	var a=group[i].replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	jgroup.b.push($.parseJSON('{"t":"NONE","g":'+JSON.stringify(_toBuild(a.replace(/\s*\(\s*/,''),config))+'}'))}			
//AND GROUP
	if(group[i].match(/\band\s*\(/gi)){
	//Remove AND and trim whitespace
	var b=group[i].replace(/\band\s*\(/gi, '').replace(/^\s\s*/, '').replace(/\s\s*$/, '')
	jgroup.b.push($.parseJSON('{"t":"AND","g":'+JSON.stringify(_toBuild(b.replace(/\s*\(\s*/,''),config))+'}'))}	
//OR GROUP
	if(group[i].match(/\bor\s*\(/gi)){
	var c=group[i].replace(/\bor\s*\(/gi, '').replace(/^\s\s*/, '').replace(/\s\s*$/, '')
	jgroup.b.push($.parseJSON('{"t":"OR","g":'+JSON.stringify(_toBuild(c.replace(/\s*\(\s*/,''),config))+'}'))}
}})
return JSON.stringify(jgroup);

	}


_toBuild=function(data,config,options){
try{
//Build Default Options if none provided	
if( $.type( options ) === "undefined"){
var list='"search":""';
$.each(config, function(i){
list=list+',"'+config[i].n+'":""';
list=list+',"'+config[i].n+'_less":""';
list=list+',"'+config[i].n+'_more":""';
list=list+',"'+config[i].n+'_not":""';
options='{'+list+'}'})
}


//Build json data string
var json=data;
$.each(config, function(i){
	if(json.has('#EMPLOYEE')){
		
if($("#filter_username").length == 0) {
if(debug){window.console.log('_toBuild : Element filter_username does not exsist');}
var filename = window.location.pathname.substring(window.location.pathname.lastIndexOf('/')+1).split(".");
var sel = $('<select id=\"filter_username\">').appendTo('body');
if(debug){window.console.log('_toBuild : Start Load Select '+filename[0]);}

_loadSelect({"selectName":"selectUsers","option1":"","selectObject":"filter_username","page":""+filename[0]+""});

sel.hide().change(function() {
if(debug){window.console.log('select onchange load _group1() ');}
_run.load_group1();
}).appendTo("#g1_searchOptions").chosen();
if(debug){window.console.log('_toBuild : append and chosen() ')}
sel.wrap( "<label for='filter_username'>Employee Name</label><div></div>");
if(debug){window.console.log('_toBuild : Load Select Complete ')}
}}
json=json.replaceAll('#EMPLOYEE', $('#filter_username').val());
json=json.replaceAll('#TODAY', new Date().mmddyyyy());
});

//Escape unecessary chars
json=json.escapeIt(json); //Escape

//expand options search types


$.each(config, function(i){

json=json.replaceAll(config[i].n+':', '","'+config[i].n+'":"');
json=json.replaceAll(config[i].n+'<', '","'+config[i].n+'_less":"').replaceAll(config[i].n+'>', '","'+config[i].n+'_more":"');
json=json.replaceAll(config[i].n+'!', '","'+config[i].n+'_not":"');

});


//remove unecessary whitespace
json=json.replaceAll(' "', '"').replaceAll('" ', '"'); //Trim

//format json structure
jdata='{"search":"' +  json  + '"}';
var params = $.parseJSON(jdata);
options = $.parseJSON(options);
$.extend(true, options, params);
var xgroup = $.parseJSON('[]');
$.each(options, function (i) {
    if (options[i] != "") {
        $.each(config,function(c){
		
		if(config[c].n===i||config[c].n+'_less'===i||config[c].n+'_more'===i||config[c].n+'_not'===i){
		
		
		 
		  switch(config[c].t){
                case'date':
				
					if(_isIt('date',options[i])){if(debug){window.console.log('_toBuild Date: i='+i+' t='+config[c].t+' v='+options[i]);}
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))
					}else{
						if(debug){window.console.log('_toBuild Date None: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					
					break;
					
                case'numeric':
				
					if(_isIt('numeric',options[i])){if(debug){window.console.log('_toBuild Numeric: i='+i+' t='+config[c].t+' v='+options[i]);}
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))
					}else{
						if(debug){window.console.log('_toBuild numeric None: i='+i+' t='+config[c].t+' v='+options[i]);}						
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					break;
					
				case'boolean':
			
					if(_isIt('boolean',options[i])){if(debug){window.console.log('_toBuild Boolean: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(options[i].match(/^True|^False|^true|^yes|^1/)){
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"1"}'))
					}else{	
					xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"0"}'))
					}}
					
					else{
						if(debug){window.console.log('_toBuild Boolean None: i='+i+' t='+config[c].t+' v='+options[i]);}
						if(_isIt('none',options[i])){xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"null"}'))}
						}
					break;
					
				default:
				if(debug){window.console.log('_toBuild Default: i='+i+' t='+config[c].t+' v='+options[i]);}
				xgroup.push($.parseJSON('{"n":"'+i+'","t":"'+config[c].t+'","v":"'+options[i] +'"}'))		
					
				
}}})}});


return xgroup;
}
catch (err) {
  return '{"n":"search","v":'+data+'}';
}}


/*jtable Helper Object*/
_jGrid=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":"",//&method=
		"showfields":""
	
	}
	$.extend(true,options,params);

var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});

$(grid).jtable('destroy');

$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
			toolbar: {
    items: [{
        icon: ' ',
        text: 'Export to Excel',
        click: function () {
         _toCSV($('#'+options['grid']+' table'), 'export.csv');
        }
    }]
},
	selecting:true,
	actions:{
	listAction:options['url']+"?returnFormat=json&method="+options['method']+"&argumentCollection="+options['arguments'],
	},
	fields:options['fields'],
		selectionChanged:function(){
			var $selectedRows=$(grid).jtable('selectedRows');//Get all selected rows
				$('#SelectedRowList').empty();
                if($selectedRows.length > 0){//Show selected rows
                   $selectedRows.each(function(){
					var record=$(this).data('record');
						eval(options['functions']);//Functions for onclick
					});
                }else{
                    //No rows selected
                 $('#SelectedRowList').append('No row selected! Select rows to see here...');
				 }}});
				 
//var loadColumns =options['showfields'].split(",");
//for(var i=0; i<loadColumns.length; i++){
//$(grid).jtable('changeColumnVisibility',loadColumns[i],'visible')
//}
if(debug){window.console.log('_jGrid : load jtable');}
$(grid).jtable('load')};

_jGridReport=function(params){
	var options={
		"grid":"", // jtable grid id
		"title":"",
		"fields":"",
		"arguments":"", //ajax json arguments
		"functions":"", //on click function
		"url":"",//&argumentCollection=
		"method":"",//&method=
		"sort":""
	}
	$.extend(true, options, params);
	var grid=$("#"+options['grid']);
$(grid).jtable({ajaxSettings:{ type:'GET', cache:false }});
$(grid).jtable('destroy');
$(grid).jtable({
	ajaxSettings:{ type:'GET', cache:false },
	title:options['title'],
	selecting:true,
	sorting: true, //Enable sorting
	defaultSorting: options['sort'], //Set default sorting
	columnResizable: true, //Actually, no need to set true since it's default
	columnSelectable: true, //Actually, no need to set true since it's default
	saveUserPreferences: true, //Actually, no need to set true since it's default
	actions:{
	listAction:options['url']+"?returnFormat=json&method="+options['method']+"&argumentCollection="+options['arguments'],
	},
	fields:options['fields'],
		selectionChanged:function(){
			var $selectedRows=$(grid).jtable('selectedRows');//Get all selected rows
				$('#SelectedRowList').empty();
                if($selectedRows.length > 0){//Show selected rows
                   $selectedRows.each(function(){
					var record=$(this).data('record');
						eval(options['functions']);//Functions for onclick
					});
                }else{
                    //No rows selected
                 $('#SelectedRowList').append('No row selected! Select rows to see here...');
				 }}});
$(grid).jtable('load')};

//Load Data
_loadData=function(params){
if(debug){window.console.log('_loadData - Starting');}
var options={"id":"","group":"","page":"","plugin":""}
try{$.extend(true, options, params);
if(debug){window.console.log('_loadData - id:'+options['id']+' group:'+options['group']+' page:'+options['page']+' plugin:'+options['plugin']+'');}
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
if($('#'+options["id"]).is("select")){
var i=$('#'+options["id"]+' option:selected').val();
	}else{
var i=$('#'+options["id"]).val();		
		}
$.ajax({type:'GET',url:options["url"]+options["page"]+'.cfc?method=f_loadData',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"id":i,"loadType":options["group"]})}
,success:function(json){
	_loadDataCB($.parseJSON(json))
	}
,error:function(data){errorHandle($.parseJSON(data))}})}
catch(err){jqMessage({message: "Error in js._loadData: "+err+' id'+options['id']+' group'+options['group']+' page'+options['page']+' plugin'+options['plugin'],"type":"error",autoClose: false})}};


//Save Data
_saveData=function(params){
var options={"group":"","payload":"","page":"","id":"","plugin":""}
try{	
$.extend(true, options, params);//turn options into array
if(options["payload"]!=""||options["payload"]=="undefined"){
if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"]);}else{options["url"]=""};
$.ajax({
  type: 'GET',
  url:options["url"]+options["page"]+'.cfc?method=f_saveData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"payload":JSON.stringify(options["payload"])})}
  ,success:function(json){_saveDataCB($.parseJSON(json))},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});}else{_saveDataCB({"id":options["id"],"group":options["group"]});}}
catch(err){
	if(debug){window.console.log('_SaveData Error'+' group'+options['group']+' payload'+options['payload']+' page'+options['page']+' id'+options['id']+' plugin'+options['plugin']);}
	jqMessage({message: "Error in js._SaveData: "+err,"type":"error",autoClose: false})}
}
//Load It
_loadit=function(params){
	var options={"query":"","list":""}
	$.extend(true, options, params);//turn options into array
if(debug){window.console.log('_loadit Start - query:'+options['query'].DATA[0]+' list:'+options['list']);}
	var list=options['list'].split(',');//Split List
try{if(options['query'].DATA!=""){
	for(var i=0;i<list.length;i++){
			switch(document.getElementById(list[i]).type){
				case"checkbox":$("#"+list[i]).prop('checked',options['query'].DATA[0][i]);break;
				case"select-one":
				$("#"+list[i]+' option').each(function(index){
					if(options['query'].DATA[0][i]==$(this).val()){
						$(this).attr('selected', true).prop('selected', true);
						//$(this).prop('selected', true);
	}})
	$('#'+list[i]).trigger("chosen:updated");
	break;
				case"select-multiple":
				var str=options['query'].DATA[0][i]+",";
				if(str!=null){
				var sstr=str.split(',');
				$("#"+list[i]+' option').each(function(index){
					for(var i=0;i<sstr.length;i++){
						if(sstr[i]==$(this).val()){
							$(this).attr('selected', true).prop('selected', true);
							//$(this).prop('selected', true);
	}}})
	$('#'+list[i]).trigger("chosen:updated");
	}
	break;
				case undefined:/*Detection for undefined objects such as <LABEL>*/
				$("#"+list[i]).html(options['query'].DATA[0][i]);break;
				default:$("#"+list[i]).val(options['query'].DATA[0][i])}
if(document.getElementById(list[i]).getAttribute("onblur")!=null){document.getElementById(list[i]).onblur()}}}}
catch(err){jqMessage({message: "Error in js._loadit: "+err,type: "error",autoClose: false})}};

_removeData=function(params){
var options={"group":"","page":"","id":"","plugin":""}
try{	
$.extend(true, options, params);//turn options into array

if(options["plugin"]!=""){options["url"]= _pluginURL(options["plugin"])}else{options["url"]=""};
$.ajax({
  type: 'GET',
  url:options["url"]+options["page"]+'.cfc?method=f_removeData',
  data: {"returnFormat":"json","argumentCollection":JSON.stringify({"group":options["group"],"id":options["id"]})
  },
  success:function(json){_removeDataCB($.parseJSON(json))},   // successful request; do something with the data
  error:function(data){errorHandle($.parseJSON(data))}      // failed request; give feedback to user
});

}
catch(err){jqMessage({message: "Error in js._loadIt: "+err,"type":"error",autoClose: false})}
}
_removeDataCB=function(params){
var options={"id":"","group":"","result":"fail"}
$.extend(true,options,params);
if(options["result"]=="ok"){
	jqMessage({"type":"destroy"});
	jqMessage({message: "The task has been removed.",type: "success",autoClose: true,duration: 5});
	}
	}
_toggle=function(list){var arr=list.split(",");for(var i=0;i<arr.length;i++){$('#'+arr[i]).toggle();}};
_hide=function(list){var arr=list.split(",");for(var i=0;i<arr.length;i++){$('#'+arr[i]).hide();}};
_highlight=function(on){var lis=on.parentNode.parentNode.getElementsByTagName("li");for (var i=0;i<lis.length;++i){lis[i].firstChild.className=lis[i].firstChild.className.replace(/\bhighlight\b/g,"");if(on==lis[i].firstChild){lis[i].firstChild.className ="highlight"}}};
_updateh3=function(msg){var e=document.getElementsByTagName("h3");for(var i=0;i<e.length;i++){var arr=e[i].innerHTML.split(" [ ");e[i].innerHTML=arr[0]+" [ "+msg+" ]";};}

_isIt=function(it,is){
switch(it){
case"rationalNumbers":re=/^[1-9]\d*$/;if(is.match(re)){return true;}else{return false;};break;
case"numeric":re=/^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;if(is.match(re)){return true;}else{return false;};break;
case"date":re=/^\d{1,2}\/\d{1,2}\/\d{4}$/;if(is.match(re)){return true;}else{return false;}break;
case"time":re=/(?:0[0-9]|1[0-1]):[0-5][0-9]/;if(is.match(re)){return true;}else{return false;}break;
case"empty":if((is.length!=0)&&(is!=null)){return true}else{return false};break;
case"email":re=/^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;if(is.match(re)){return true;}else{return false;};break;
case"zip":re=/^([0-9]{5})$/;if(is.match(re)){return true;}else{return false;};break;
case"zip9":re=/^([0-9]{5}-[0-9]{4})$/;if(is.match(re)){return true;}else{return false;};break;
case"cc_visa":re=/^4[0-9]{12}(?:[0-9]{3})?$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_mastercard":re=/^5[1-5][0-9]{14}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_dinersclub":re=/^3[47][0-9]{13}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_discover":re=/^6(?:011|5[0-9]{2})[0-9]{12}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_dinersclub":re=/^3[47][0-9]{13}$/;if(is.match(re)){return true;}else{return false;}break;
case"cc_jcb":re=/^(?:2131|1800|35\d{3})\d{11}$/;if(is.match(re)){return true;}else{return false;}break;
case"socialsecurity":re=/^[0-9]{3}[\- ]?[0-9]{2}[\- ]?[0-9]{4}$/;if(is.match(re)){return true;}else{return false;}break;
case"ipaddress":re=/^[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}$/;if(is.match(re)){return true;}else{return false;}break;
case"macaddress":re=/^[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}-[0-9A-F]{2}$/;if(is.match(re)){return true;}else{return false;}break;
case"phone":re=/^(\+\d)*\s*(\(\d{3}\)\s*)*\d{3}(-{0,1}|\s{0,1})\d{2}(-{0,1}|\s{0,1})\d{2}$/;if(is.match(re)){return true;}else{return false;}break;
case"url":re=/^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/;if(is.match(re)){return true;}else{return false;}break;
case"filename":re=/^[^\\\/\:\*\?\"\<\>\|\.]+(\.[^\\\/\:\*\?\"\<\>\|\.]+)+$/;if(is.match(re)){return true;}else{return false;}break;
case"ip6":re=/^(?:(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9](?::|$)){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))$/i;if(is.match(re)){return true;}else{return false;}break;
case"hex":re=/^#?([a-f0-9]{6}|[a-f0-9]{3})$/;if(is.match(re)){return true;}else{return false;}break;
case"html":re=/^<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)$/;if(is.match(re)){return true;}else{return false;}break;
case"image":re=/.*(\.[Jj][Pp][Gg]|\.[Gg][Ii][Ff]|\.[Jj][Pp][Ee][Gg]|\.[Pp][Nn][Gg])/;if(is.match(re)){return true;}else{return false;}break;
case"boolean":re=/^True|^False|^true|^false|^yes|^no|^1|^0/;if(is.match(re)){return true;}else{return false;}break;
case"none":re=/^none|^None|^null|^Null|^empty|^Empty|^0/;if(is.match(re)){return true;}else{return false;}break;
default:return false;
}}

_clearfields=function(params){
var options={"sel":"","list":""}
$.extend(true,options,params)
var list=options['list'].split(','),sel=options['sel'].split(',');
		for(var i=0;i<list.length;i++){$('#'+list[i]).val('');}
		for(var i=0;i<sel.length;i++){
			
$('#'+sel[i]).find('option').prop('selected',false);
$('#'+sel[i]).each(function(){$('#'+sel[i]+'option').removeAttr("selected")})
}}
	
_loadSelect=function(params){
if(debug){window.console.log('_loadSelect : Starting');}
var options={"selectName":"","selectObject":"","option1":"","page":""}
$.extend(true,options,params);
if(debug){window.console.log('_loadSelect : options '+options["selectName"]+' '+options["selectObject"]+' '+options["option1"]+' '+options["page"]+' ');}
$.ajax({type:'GET',url:options['page']+'.cfc?method=f_loadSelect',data:{"returnFormat":"json","argumentCollection":JSON.stringify({"selectName":options['selectName'],"option1":options['option1']})}
,success:function(json){
 var j=$.parseJSON(json),items='';
	for(var i=0;i<j.Records.length;i++){items+='<option value="'+ j.Records[i].optionvalue_id+'">'+j.Records[i].optionname+'</option>'}
	  $("select#"+options['selectObject']).html(items).trigger("chosen:updated");
	if(debug){window.console.log('_loadSelect : complete');}
	  },
  error:function(data){errorHandle($.parseJSON(data))}})};



errorHandle=function(code,msg){jqMessage({message: "General error in from database: "+code+":"+msg,type: "error",autoClose: false});};