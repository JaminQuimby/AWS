<cfparam name="url.FILE_SAVEDNAME" default="">
<cfparam name="url.FILE_NAME" default="unknown.txt">
<cfparam name="url.FILE_TYPE" default="">
<cfparam name="url.FILE_SUBTYPE" default="">

<cfheader name="Content-Disposition" value="inline; filename=#url.FILE_NAME#"> 
<cfcontent type="application/octet-stream" file="#Session.user.storage##url.FILE_SAVEDNAME#">