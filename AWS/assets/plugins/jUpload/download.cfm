<cfparam name="url.FILE_SAVEDNAME" default="">
<cfparam name="url.FILE_NAME" default="unknown.txt">
<cfparam name="url.FILE_TYPE" default="">
<cfparam name="url.FILE_SUBTYPE" default="">
<cfheader name="Content-Disposition" value="inline; filename=""#url.FILE_NAME#"" "> 
<cfswitch expression="#ListLast(URL.FILE_NAME,'.')#" >
<cfcase value="pdf"><cfcontent type="application/pdf" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="xml"><cfcontent type="application/xml" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="zip"><cfcontent type="application/zip" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="csv"><cfcontent type="application/csv" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="rtf"><cfcontent type="application/rtf" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="mp4"><cfcontent type="audio/mp4" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="mpeg"><cfcontent type="audio/mpeg" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="gif"><cfcontent type="image/gif" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="pjpeg"><cfcontent type="image/pjpeg" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="png"><cfcontent type="image/png" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="jpeg,jpe,jpg"><cfcontent type="image/jpeg" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="xla,xlc,xlm,xls,xlt,xlw" delimiters=","><cfcontent type="application/vnd.ms-excel" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="msg" delimiters=","><cfcontent type="application/vnd.ms-outlook" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="sst" delimiters=","><cfcontent type="application/vnd.ms-pkicertstore" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="pot,pps,ppt" delimiters=","><cfcontent type="application/vnd.ms-powerpoint" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfcase value="wcm,wdb,wks,wps" delimiters=","><cfcontent type="application/vnd.ms-works" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfcase>
<cfdefaultcase><cfcontent type="application/octet-stream" file="#Session.user.storage##url.FILE_SAVEDNAME#"></cfdefaultcase>
</cfswitch>