<cfparam name="URL.data" default="">
    <cfsavecontent variable="strExcelData">
    <cfoutput>
    #URL.data#
     </cfoutput>
    </cfsavecontent>
     
     
    <!---
    Check to see if we are previewing the excel data. This
    will output the HTML/XLS to the web browser without
    invoking the MS Excel applicaiton.
    --->
    <cfif StructKeyExists( URL, "preview" )>
     
    <!--- Output the excel data for preview. --->
    <html>
    <head>
    <title>Excel Data Preview</title>
    </head>
    <body>
    <cfset WriteOutput( strExcelData ) />
    </body>
    </html>
     
    <!---
    Exit out of template so that the attachment
    does not process.
    --->
    <cfexit />
     
    </cfif>
     
     
    <!---
    ASSERT: At this point, we are definately not previewing the
    data. We are planning on streaming it to the browser as
    an attached file.
    --->
     
     
    <!---
    Set the header so that the browser request the user
    to open/save the document. Give it an attachment behavior
    will do this. We are also suggesting that the browser
    use the name "phrases.xls" when prompting for save.
    --->
    <cfheader
    name="Content-Disposition"
    value="attachment; filename=phrases.xls"
    />
     
     
    <!---
    There are several ways in which we can stream the file
    to the browser:
     
    - Binary variable stream
    - Binary file stream
    - Text stream
     
    Check the URL to see which of these we are going to end
    up using.
    --->
    <cfif StructKeyExists( URL, "text" )>
     
    <!---
    We are going to stream the excel data to the browser
    through the standard text output stream. The browser
    will then collect this data and execute it as if it
    were an attachment.
     
    Be careful to reset the content when streaming the
    text as you don't want white-space to be part of the
    streamed data.
    --->
    <cfcontent
    type="application/msexcel"
    reset="true"
     
    <!--- Write the output. --->
    /><cfset WriteOutput( strExcelData.Trim() )
     
    <!---
    Exit out of template to prevent unexpected data
    streaming to the browser (on request end??).
    --->
    /><cfexit />
     
     
    <cfelseif StructKeyExists( URL, "file" )>
     
    <!---
    We are going to stream the excel data to the browser
    using a file stream from the server. To do this, we
    will have to save a temp file to the server.
    --->
     
    <!--- Get the temp file for streaming. --->
    <cfset strFilePath = GetTempFile(
    GetTempDirectory(),
    "excel_"
    ) />
     
    <!--- Write the excel data to the file. --->
    <cffile
    action="WRITE"
    file="#strFilePath#"
    output="#strExcelData.Trim()#"
    />
     
    <!---
    Stream the file to the browser. By doing this, the
    content buffer is automatically cleared and the file
    is streamed. We don't have to worry about anything
    after the file as no page content is taken into
    account any more.
     
    Additionally, we are requesting that the file be
    deleted after it is done streaming (deletefile). Now,
    we don't have to worry about cluttering up the server.
    --->
    <cfcontent
    type="application/msexcel"
    file="#strFilePath#"
    deletefile="true"
    />
     
     
    <cfelse>
     
    <!---
    Bey default, we are going to stream the text as a
    binary variable. By using the Variable attribute, the
    content of the page is automatically reset; we don't
    have to worry about clearing the buffer. In order to
    use this method, we have to convert the excel text
    data to base64 and then to binary.
     
    This method is available in ColdFusion MX 7 and later.
    --->
    <cfcontent
    type="application/msexcel"
    variable="#ToBinary( ToBase64( strExcelData.Trim() ) )#"
    />
     
    </cfif>