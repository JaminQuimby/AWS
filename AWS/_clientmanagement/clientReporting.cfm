<cfset ARGUMENTS.clientid="0">
<cfset ARGUMENTS.id="0">
<cfset ARGUMENTS.search="%">
<cfset ARGUMENTS.orderBy=0>


<cfquery datasource="AWS" name="data">
SELECT[client_listing].[CLIENT_ID]
,[client_listing].[CLIENT_NAME]
,[client_listing].[CLIENT_SALUTATION]
,CONVERT(VARCHAR(10),[client_listing].[CLIENT_SINCE], 101)AS[CLIENT_SINCE]
,[ctrl_selectoptions].[optionName]AS[CLIENT_TYPETEXT]
FROM[client_listing]
LEFT OUTER JOIN[ctrl_selectoptions]
ON[client_listing].[client_type]=[ctrl_selectoptions].[optionValue_id]

</cfquery>
<cfdump var="#data#">