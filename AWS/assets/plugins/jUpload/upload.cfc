<cfcomponent output="true">
<!--- LOOKUP DATA --->
<cffunction name="f_lookupData" access="remote" output="false">
<cfargument name="clientid" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">

<cfcase value="group100">
<cfquery datasource="AWS" name="fquery">
SELECT [file_id]
      ,[form_id]
      ,[client_id]
      ,[file_name]
      ,[file_savedname]
      ,[file_description]
      ,[file_size]
      ,[file_type]
      ,[file_year]
      ,[file_month]
      ,[file_day]
      ,[file_timestamp]
      ,[file_subtype]
      ,[file_ext]
FROM[v_ctrl_files]
WHERE[client_id]=<cfqueryparam value="#ARGUMENTS.clientid#"/>
AND[form_id]=<cfqueryparam value="#ARGUMENTS.formid#"/>
ORDER BY[file_name]
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FILE_ID":"'&FILE_ID&'","FILE_NAME":"'&FILE_NAME&'","FILE_DESCRIPTION":"'&FILE_DESCRIPTION&'","FILE_YEAR":"'&FILE_YEAR&'","FILE_MONTH":"'&FILE_MONTH&'","FILE_DAY":"'&FILE_DAY&'"}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>
<cfswitch expression="#ARGUMENTS.loadType#">
<cfcase value="group100">
<cfquery datasource="AWS" name="fQuery">

SELECT 
'group100'AS[group100]
,[FILE_ID]
,[file_name]
,[file_description]
,[file_year]
,[file_month]
,[file_day]
      <!---
      ,[file_savedname]
      ,[file_size]
      ,[file_type]

      ,[file_timestamp]
      ,[file_subtype]
      ,[file_ext]
	  
	  --->
 FROM[ctrl_files]
WHERE[file_id]=<cfqueryparam value="#ARGUMENTS.ID#"/>
</cfquery>
</cfcase>
</cfswitch>
<cfreturn SerializeJSON(fQuery)>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#arguments.cl_id#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>



<!--- SAVE DATA --->
<cffunction name="f_saveData" access="remote" output="false" returntype="any">
<cfargument name="group" type="string" required="true">
<cfargument name="payload" type="string" required="true">
<cfset j=DeserializeJSON("#ARGUMENTS.payload#")>
<cfswitch expression="#ARGUMENTS.group#">
<cfcase value="group100">
<cftry>
<cfquery name="fquery" datasource="AWS">
UPDATE[ctrl_files]
SET[client_id]=<cfqueryparam value="#j.DATA[1][2]#"/>
,[file_day]=<cfqueryparam value="#j.DATA[1][3]#"/>
,[file_description]=<cfqueryparam value="#j.DATA[1][4]#"/>
,[file_month]=<cfqueryparam value="#j.DATA[1][5]#"/>
,[file_name]=<cfqueryparam value="#j.DATA[1][6]#"/>
,[file_year]=<cfqueryparam value="#j.DATA[1][7]#"/>
WHERE[FILE_ID]=<cfqueryparam value="#j.DATA[1][1]#"/>
</cfquery>


<cfreturn '{"id":#j.DATA[1][1]#,"group":"saved","result":"ok"}'>

<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"group":""#cfcatch.message#","#cfcatch.detail#"","result":"error"}'> 
</cfcatch>
</cftry>
</cfcase>
</cfswitch>
</cffunction>

<!--- UPLOAD FILES --->
<cffunction name="upload" access="remote" returnformat="json" output="false">
<cfargument name="FORMID" type="numeric" required="no" default="0">
<cfargument name="CLIENTID" type="numeric" required="no" default="0">
<cfargument name="TASKID" type="numeric" required="no" default="0">
<cfargument name="USERID" type="numeric" required="no" default="0">
<cfargument name="DESCRIPTION" type="string" required="no">

<cftry>
<cfscript>
var uploadDir = Session.user.storage; // should be a temp directory that you clear periodically to flush orphaned files
var uploadFile = uploadDir & arguments.NAME;
var response = {'result' = arguments.NAME, 'id' = 0};
var result = {};
// if chunked append chunk number to filename for reassembly
if (structKeyExists(arguments, 'CHUNKS')){
uploadFile = uploadFile & '.' & arguments.CHUNK;
response.id = arguments.CHUNK;
}
</cfscript>	
<!--- save file data from multi-part form.FILE --->
<cffile action="upload" result="result" filefield="FILE" destination="#uploadFile#" nameconflict="overwrite"/>
<cfoutput>
<cfquery datasource="AWS" name="fQuery">
INSERT INTO[ctrl_files]
(
[file_name]
,[file_savedname]
,[file_type]
,[file_subtype]
,[file_size]
,[file_ext]
,[form_id]
,[client_id]
,[task_id]
,[user_id]
,[file_description]
)
VALUES(
<cfqueryparam value="#result.clientFile#"/>
,<cfqueryparam value="#result.serverFile#"/>
,<cfqueryparam value="#result.contentType#"/>
,<cfqueryparam value="#result.contentSubType#"/>
,<cfqueryparam value="#result.fileSize#"/>
,<cfqueryparam value="#result.clientFileExt#"/>
,<cfqueryparam value="#arguments.FORMID#"/>
,<cfqueryparam value="#arguments.CLIENTID#"/>
,<cfqueryparam value="#arguments.TASKID#"/>
,<cfqueryparam value="#arguments.USERID#"/>
,<cfqueryparam value="#arguments.DESCRIPTION#"/>
)
</cfquery>
</cfoutput>
<cfscript>
// Example: you can return uploaded file data to client
response['size'] = result.fileSize;
response['type'] = result.contentType;
response['saved'] = result.fileWasSaved;
// reassemble chunked file
if (structKeyExists(arguments, 'CHUNKS') && arguments.CHUNK + 1 == arguments.CHUNKS){
try {
var uploadFile = uploadDir & arguments.NAME; // file name for reassembled file - if using a temp directory then this should be the final output path/file
if (fileExists(uploadFile)){
fileDelete(uploadFile); // delete otherwise append will add chunks to an existing file
}
 
var tempFile = fileOpen(uploadFile,'append');
for (var i = 0; i < arguments.CHUNKS; i++) {
var chunk = fileReadBinary('#uploadDir#/#arguments.NAME#.#i#');
fileDelete('#uploadDir#/#arguments.NAME#.#i#');
fileWrite(tempFile, chunk);
}
fileClose(tempFile);
}
catch(any err){
// clean up chunks for incomplete upload
var d = directoryList(uploadDir,false,'name');
if (arrayLen(d) != 0){
for (var i = 1; i <= arrayLen(d); i++){
if (listFirst(d[i]) == arguments.NAME && val(listLast(d[i])) != 0){
fileDelete('#uploadDir##d[i]#');
}
}
}
 
// you could add more error handling and return info from err
response = {'error' = {'code' = 500, 'message' = 'Internal Server Error'}, 'id' = 0};
}
}
return response;
</cfscript>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cffunction>
</cfcomponent>