<cfcomponent output="true">
<!--- f_saveData = Insert or Update tables with json data from ajax--->
<!--- f_lookupData = Query SQL return json via Ajax to build table grids --->
<!--- f_loadData = Get data from SQL for Ajax deployment to elements --->
<!--- f_loadSelect = get select data--->

<!--- LOAD DATA --->
<cffunction name="f_loadData" access="remote" output="false">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="loadType" type="string" required="no">
<cftry>

<cfswitch expression="#ARGUMENTS.loadType#">
<!--- Load Group1--->
<cfcase value="group1">
<cfquery datasource="#Session.organization.name#" name="fQuery">
SELECT[]
FROM[]
WHERE[]=<cfqueryparam value="#ARGUMENTS.ID#"/>
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

<!--- [LOOKUP FUNCTIONS] --->
<cffunction name="f_lookupData"  access="remote"  returntype="string" returnformat="plain">
<cfargument name="search" type="any" required="no">
<cfargument name="orderBy" type="any" required="no">
<cfargument name="row" type="numeric" required="no">
<cfargument name="ID" type="string" required="no">
<cfargument name="formid" type="string" required="no">
<cfargument name="loadType" type="string" required="no">
<cfargument name="clientid" type="string" required="no" default="0">
<cfargument name="userid" type="string" required="no" default="0">
<cfargument name="duedate" type="string" required="no" default="">
<cfargument name="group" type="string" required="no" default="0">
<cfif ListFindNoCase('null',ARGUMENTS.userid)><cfset ARGUMENTS.userid=0></cfif>
<cfswitch expression="#ARGUMENTS.loadType#">
<!--- TOTAL TIME --->
<cfcase value="group1">
<cftry>

<cfquery datasource="#Session.organization.name#" name="aquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#" >
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">

SELECT'Accounting and Consulting'AS[name]
<cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT CASE WHEN ISNULL( mc_assignedto ,0)=@u  THEN ISNULL([mc_esttime],0) ELSE NULL END)AS[total_time]
,COUNT(DISTINCT CASE WHEN ISNULL( mc_assignedto ,0)=@u  THEN ISNULL([mc_id],0) ELSE NULL END)AS[count_assigned]
,SUM(DISTINCT CASE WHEN ISNULL( mcs_assignedto ,0)=@u  THEN ISNULL([mcs_esttime],0) ELSE NULL END)AS[total_subtask_time]
,COUNT(DISTINCT CASE WHEN ISNULL( mcs_assignedto ,0)=@u  THEN ISNULL([mcs_id],0) ELSE NULL END)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(mc_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT ISNULL([mc_id],0))AS[count_assigned]
,ISNULL(SUM(ISNULL([mcs_esttime],0)),0)AS[total_subtask_time]
,COUNT(DISTINCT ISNULL([mcs_id],0))AS[count_subtask_assigned]
</cfif>
,'A'AS[orderit]
FROM[v_managementconsulting_subtask]
WHERE([mc_status]NOT IN('2','3')OR[mc_status]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([mc_assignedto]=@u OR[mcs_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Administrative Tasks'AS[name]
<cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT CASE WHEN  cas_assignedto LIKE '%'+ @u +'%'    THEN ISNULL([cas_esttime],0) ELSE NULL END)AS[total_time]
,COUNT(DISTINCT CASE WHEN  cas_assignedto LIKE '%'+ @u +'%'  THEN[cas_id]ELSE NULL END)AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(cas_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[cas_id])AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
</cfif>
,'B'AS[orderit]
FROM [v_clientadministrativetasks]
WHERE([cas_status]NOT IN('2','3')OR([cas_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([cas_duedate]IS NULL OR[cas_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Business Formation'AS[name]
<cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT CASE WHEN ISNULL( bf_assignedto ,0)=@u  THEN ISNULL([bf_esttime],0) ELSE NULL END)AS[total_time]
,COUNT(DISTINCT CASE WHEN ISNULL(bf_assignedto,0)=@u THEN[bf_id]ELSE NULL END)AS[count_assigned]
,SUM(DISTINCT CASE WHEN ISNULL( bfs_assignedto ,0)=@u  THEN ISNULL([bfs_estimatedtime],0) ELSE NULL END)AS[total_subtask_time]
,COUNT(DISTINCT CASE WHEN ISNULL( bf_assignedto ,0)=@u  THEN [bfs_id] ELSE NULL END)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(bf_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[bf_id])AS[count_assigned]
,ISNULL(SUM(ISNULL([bfs_estimatedtime],0)),0)AS[total_subtask_time]
,COUNT(DISTINCT[bfs_id])AS[count_subtask_assigned]
</cfif>
,'C'AS[orderit]
FROM[v_businessformation_subtask]
WHERE([bf_status]NOT IN('2','3')OR([bf_status]IS NULL))
<cfif ARGUMENTS.userid neq "0">AND([bf_assignedto]=@u OR([bfs_assignedto]=@u OR[bfs_assignedto]IS NULL))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Communication'AS[name]
<cfif ARGUMENTS.userid neq "0">
,(0)AS[total_time]
,COUNT(DISTINCT CASE WHEN [co_for] LIKE'%'+ @u +'%' THEN[co_id]ELSE NULL END)AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
<cfelse>
,(0)AS[total_time]
,COUNT(DISTINCT[co_id])AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
</cfif>

,'D'AS[orderit]
FROM[v_communications]
WHERE([co_status]NOT IN('2','3')OR([co_status]IS NULL))
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](co_for)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Financial & Tax Planning'AS[name]
<cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT CASE WHEN ISNULL( ftp_assignedto ,0)=@u  THEN ISNULL([ftp_esttime],0) ELSE NULL END)AS[total_time]
,COUNT(DISTINCT CASE WHEN ISNULL(ftp_assignedto,0)=@u THEN[ftp_id]ELSE NULL END)AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(ftp_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[ftp_id])AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
</cfif>

,'E'AS[orderit]
FROM[v_financialtaxplanning]
WHERE([ftp_status]NOT IN('2','3')OR([ftp_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL OR[ftp_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([ftp_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Financial Statements'AS[name]

 <cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT 
CASE WHEN ISNULL(fds_obtaininfo_assignedto,0)=@u 
OR ISNULL(fds_sort_assignedto,0)=@u 
OR ISNULL(fds_checks_assignedto,0)=@u
OR ISNULL(fds_sales_assignedto,0)=@u 
OR ISNULL(fds_entry_assignedto,0)=@u 
OR ISNULL(fds_reconcile_assignedto,0)=@u
OR ISNULL(fds_compile_assignedto,0)=@u 
OR ISNULL(fds_review_assignedto,0)=@u 
OR ISNULL(fds_assembly_assignedto,0)=@u 
OR ISNULL(fds_delivery_assignedto,0)=@u  THEN ISNULL([fds_esttime],0) ELSE 0 END)AS[total_time]


,COUNT(DISTINCT CASE WHEN 
ISNULL(fds_obtaininfo_assignedto,0)=@u 
OR ISNULL(fds_sort_assignedto,0)=@u 
OR ISNULL(fds_checks_assignedto,0)=@u
OR ISNULL(fds_sales_assignedto,0)=@u 
OR ISNULL(fds_entry_assignedto,0)=@u 
OR ISNULL(fds_reconcile_assignedto,0)=@u
OR ISNULL(fds_compile_assignedto,0)=@u 
OR ISNULL(fds_review_assignedto,0)=@u 
OR ISNULL(fds_assembly_assignedto,0)=@u 
OR ISNULL(fds_delivery_assignedto,0)=@u THEN[fds_id]ELSE NULL END)AS[count_assigned]


,SUM(DISTINCT 
CASE WHEN ISNULL(fds_obtaininfo_assignedto,0)=@u THEN ISNULL([fds_obtaininfo_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_sort_assignedto,0)=@u  THEN ISNULL([fds_sort_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_checks_assignedto,0)=@u THEN ISNULL([fds_checks_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_sales_assignedto,0)=@u  THEN ISNULL([fds_sales_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_entry_assignedto,0)=@u  THEN ISNULL([fds_entry_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_reconcile_assignedto,0)=@u THEN ISNULL([fds_reconcile_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_compile_assignedto,0)=@u  THEN ISNULL([fds_compile_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_review_assignedto,0)=@u  THEN ISNULL([fds_review_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_assembly_assignedto,0)=@u  THEN ISNULL([fds_assembly_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fds_delivery_assignedto,0)=@u  THEN ISNULL([fds_delivery_esttime],0) ELSE 0 END
+ CASE WHEN ISNULL(fdss_assignedto,0)=@u  THEN ISNULL([fdss_esttime],0) ELSE 0 END
)AS[total_subtask_time]


,COUNT(DISTINCT CASE WHEN ISNULL(fds_obtaininfo_assignedto,0)=@u AND[fds_obtaininfo_datecompleted]IS NULL THEN fds_id ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN ISNULL(fds_sort_assignedto,0)=@u AND[fds_sort_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_checks_assignedto,0)=@u AND[fds_checks_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_sales_assignedto,0)=@u AND[fds_sales_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_entry_assignedto,0)=@u AND[fds_entry_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_reconcile_assignedto,0)=@u AND[fds_reconcile_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_compile_assignedto,0)=@u AND[fds_compile_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_review_assignedto,0)=@u AND[fds_review_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_assembly_assignedto,0)=@u AND[fds_assembly_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(fds_delivery_assignedto,0)=@u AND[fds_delivery_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT( CASE WHEN ISNULL(fdss_assignedto,0)=@u AND[fdss_completed]IS NULL THEN 1 ELSE NULL END)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(DISTINCT[fds_esttime]),0)AS[total_time]
,COUNT(DISTINCT[fds_id])AS[count_assigned]


,SUM(DISTINCT 
ISNULL([fds_obtaininfo_esttime],0) 
+ISNULL([fds_sort_esttime],0) 
+ISNULL([fds_checks_esttime],0)
+ISNULL([fds_sales_esttime],0)
+ISNULL([fds_entry_esttime],0) 
+ISNULL([fds_reconcile_esttime],0)
+ISNULL([fds_compile_esttime],0)
+ISNULL([fds_review_esttime],0) 
+ISNULL([fds_assembly_esttime],0)
+ISNULL([fds_delivery_esttime],0) 
+ISNULL([fdss_esttime],0)
)AS[total_subtask_time]



,COUNT(DISTINCT CASE WHEN [fds_obtaininfo_datecompleted]IS NULL THEN fds_id ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN [fds_sort_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_checks_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_sales_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_entry_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_reconcile_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_compile_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_review_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_assembly_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [fds_delivery_datecompleted]IS NULL THEN fds_id ELSE NULL END)
+COUNT( CASE WHEN[fdss_completed]IS NULL THEN 1 ELSE NULL END)AS[count_subtask_assigned]
</cfif>
,'F'AS[orderit]
FROM[v_financialdatastatus_subtask] 
WHERE([fds_status]NOT IN('2','3')OR([fds_status]IS NULL))AND([fdss_status]NOT IN('2','3')OR([fdss_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND[fds_delivery_datecompleted] IS NULL
AND([fds_obtaininfo_assignedto] = @u AND[fds_obtaininfo_datecompleted]IS NULL)
OR([fds_sort_assignedto] = @u AND[fds_obtaininfo_datecompleted]IS NOT NULL AND[fds_sort_datecompleted] IS NULL)
OR([fds_checks_assignedto] = @u  AND [fds_sort_datecompleted] IS NOT NULL AND [fds_checks_datecompleted] IS NULL)
OR([fds_sales_assignedto] = @u  AND [fds_checks_datecompleted] IS NOT NULL AND [fds_sales_datecompleted] IS NULL)
OR([fds_entry_assignedto] = @u  AND [fds_sales_datecompleted] IS NOT NULL AND [fds_entry_datecompleted] IS NULL)
OR([fds_reconcile_assignedto] = @u  AND [fds_entry_datecompleted] IS NOT NULL AND [fds_reconcile_datecompleted] IS NULL)
OR([fds_compile_assignedto]= @u  AND [fds_reconcile_datecompleted] IS NOT NULL AND [fds_compile_datecompleted] IS NULL)
OR([fds_review_assignedto] = @u  AND [fds_compile_datecompleted] IS NOT NULL AND [fds_review_datecompleted] IS NULL)
OR([fds_assembly_assignedto] = @u  AND [fds_review_datecompleted] IS NOT NULL AND [fds_assembly_datecompleted]  IS NULL)
OR([fds_delivery_assignedto] = @u  AND [fds_assembly_datecompleted] IS NOT NULL)
OR([fdss_assignedto]=@u)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Notices'AS[name]

 <cfif ARGUMENTS.userid neq "0">
,(0)AS[total_time]
,COUNT([nst_id])AS[count_assigned]
,SUM(DISTINCT CASE WHEN ISNULL( nst_assignedto ,0)=@u  THEN ISNULL([nst_esttime],0) ELSE NULL END)AS[total_subtask_time]
,COUNT(DISTINCT CASE WHEN ISNULL( nst_assignedto ,0)=@u  THEN [nst_id] ELSE NULL END)AS[count_subtask_assigned]
<cfelse>
,(0)AS[total_time]
,COUNT([nst_id])AS[count_assigned]
,ISNULL(SUM(ISNULL(nst_esttime,0)),0)AS[total_subtask_time]
,COUNT(DISTINCT[nst_id])AS[count_subtask_assigned]
</cfif>

,'G'AS[orderit]
FROM[v_notice_subtask]
WHERE([n_status]NOT IN('2','3')OR([n_status]IS NULL))
AND([nst_status]NOT IN('2','3')OR([nst_status]IS NULL)) 
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([nst_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Other Filings'AS[name]

<cfif ARGUMENTS.userid neq "0">
,ISNULL(SUM(ISNULL(of_esttime,0)),0)AS[total_time]
,COUNT([of_id])AS[count_assigned]
,SUM( CASE WHEN ISNULL(of_obtaininfo_assignedto,0)=@u AND[of_obtaininfo_datecompleted]IS NULL THEN ISNULL([of_obtaininfo_esttime],0)ELSE 0 END)
+SUM( CASE WHEN ISNULL(of_preparation_assignedto,0)=@u AND[of_preparation_datecompleted]IS NULL THEN ISNULL([of_preparation_esttime],0)ELSE 0 END)
+SUM( CASE WHEN ISNULL(of_review_assignedto,0)=@u AND[of_review_datecompleted]IS NULL THEN ISNULL([of_review_esttime],0)ELSE 0 END)
+SUM( CASE WHEN ISNULL(of_assembly_assignedto,0)=@u AND[of_assembly_datecompleted]IS NULL THEN ISNULL([of_assembly_esttime],0)ELSE 0 END)
+SUM( CASE WHEN ISNULL(of_delivery_assignedto,0)=@u AND[of_delivery_datecompleted]IS NULL THEN ISNULL([of_delivery_esttime],0)ELSE 0 END)
AS[total_subtask_time]

,COUNT(DISTINCT CASE WHEN ISNULL(of_obtaininfo_assignedto,0)=@u AND[of_obtaininfo_datecompleted]IS NULL THEN[of_id]ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN ISNULL(of_preparation_assignedto,0)=@u AND[of_preparation_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(of_review_assignedto,0)=@u AND[of_review_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(of_assembly_assignedto,0)=@u AND[of_assembly_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(of_delivery_assignedto,0)=@u AND[of_delivery_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(of_esttime,0)),0)AS[total_time]
,COUNT([of_id])AS[count_assigned]
,SUM( CASE WHEN[of_obtaininfo_datecompleted]IS NULL THEN ISNULL([of_obtaininfo_esttime],0)ELSE 0 END)
+SUM( CASE WHEN[of_preparation_datecompleted]IS NULL THEN ISNULL([of_preparation_esttime],0)ELSE 0 END)
+SUM( CASE WHEN[of_review_datecompleted]IS NULL THEN ISNULL([of_review_esttime],0)ELSE 0 END)
+SUM( CASE WHEN[of_assembly_datecompleted]IS NULL THEN ISNULL([of_assembly_esttime],0)ELSE 0 END)
+SUM( CASE WHEN[of_delivery_datecompleted]IS NULL THEN ISNULL([of_delivery_esttime],0)ELSE 0 END)
AS[total_subtask_time]

,COUNT(DISTINCT CASE WHEN[of_obtaininfo_datecompleted]IS NULL THEN[of_id]ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN[of_preparation_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN[of_review_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN[of_assembly_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN[of_delivery_datecompleted]IS NULL THEN[of_id]ELSE NULL END)
AS[count_subtask_assigned]
</cfif>
,'H'AS[orderit]
FROM[v_otherfilings]
WHERE([of_status]NOT IN('2','3')OR([of_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND([of_obtaininfo_assignedto]=@u AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=@u AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=@u  AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=@u AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=@u AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>


UNION
SELECT'Payroll Checks'AS[name]
<cfif ARGUMENTS.userid neq "0">
,ISNULL(SUM(ISNULL(pc_esttime,0)),0)AS[total_time]



,COUNT(DISTINCT[pc_id])AS[count_assigned]

,ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pc_delivery_assignedto,0)=@u AND [pc_delivery_datecompleted]IS NULL THEN[pc_delivery_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pc_obtaininfo_assignedto,0)=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN[pc_obtaininfo_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pc_preparation_assignedto,0)=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN[pc_preparation_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pc_review_assignedto,0)=@u AND[pc_review_datecompleted]IS NULL THEN[pc_review_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pc_assembly_assignedto,0)=@u AND[pc_assembly_datecompleted]IS NULL THEN[pc_assembly_esttime]ELSE NULL END),0)
AS[total_subtask_time]


,COUNT(DISTINCT CASE WHEN ISNULL(pc_delivery_assignedto,0)=@u AND[pc_delivery_datecompleted]IS NULL THEN[pc_id]ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN ISNULL(pc_obtaininfo_assignedto,0)=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pc_preparation_assignedto,0)=@u AND[pc_preparation_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pc_review_assignedto,0)=@u AND[pc_review_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pc_assembly_assignedto,0)=@u AND[pc_assembly_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)AS[count_subtask_assigned]

<cfelse>
,ISNULL(SUM(ISNULL(pc_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[pc_id])AS[count_assigned]

,ISNULL(SUM(DISTINCT CASE WHEN [pc_delivery_datecompleted]IS NULL THEN[pc_delivery_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN [pc_obtaininfo_datecompleted]IS NULL THEN[pc_obtaininfo_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN [pc_preparation_datecompleted]IS NULL THEN[pc_preparation_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN [pc_review_datecompleted]IS NULL THEN[pc_review_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN [pc_assembly_datecompleted]IS NULL THEN[pc_assembly_esttime]ELSE NULL END),0)
AS[total_subtask_time]

,COUNT(DISTINCT CASE WHEN [pc_delivery_datecompleted]IS NULL THEN[pc_id]ELSE NULL END) 
+COUNT(DISTINCT CASE WHEN [pc_obtaininfo_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [pc_preparation_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [pc_review_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN [pc_assembly_datecompleted]IS NULL THEN[pc_id]ELSE NULL END)AS[count_subtask_assigned]
</cfif>

,'I'AS[orderit]
FROM[v_payrollcheckstatus]
WHERE[pc_delivery_datecompleted]IS NULL 
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL OR[pc_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND
([pc_delivery_datecompleted]IS NULL AND([pc_obtaininfo_datecompleted]IS NULL AND[pc_obtaininfo_assignedto]=@u)
OR([pc_obtaininfo_datecompleted]IS NOT NULL AND[pc_preparation_datecompleted]IS NULL AND[pc_preparation_assignedto]=@u)
OR([pc_preparation_datecompleted]IS NOT NULL AND[pc_review_datecompleted]IS NULL AND[pc_review_assignedto]=@u)
OR([pc_review_datecompleted]IS NOT NULL AND[pc_assembly_datecompleted]IS NULL AND[pc_assembly_assignedto]=@u)
OR([pc_assembly_datecompleted]IS NOT NULL AND[pc_delivery_assignedto]=@u))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>


UNION
SELECT'Payroll Taxes'AS[name]

<cfif ARGUMENTS.userid neq "0">
,ISNULL(SUM(ISNULL(pt_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[pt_id])AS[count_assigned]
,ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_obtaininfo_assignedto,0)=@u AND [pt_obtaininfo_datecompleted]IS NULL THEN[pt_obtaininfo_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_entry_assignedto,0)=@u AND[pt_entry_datecompleted]IS NULL THEN[pt_entry_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_rec_assignedto,0)=@u AND[pt_rec_datecompleted]IS NULL THEN[pt_rec_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_review_assignedto,0)=@u AND[pt_review_datecompleted]IS NULL THEN[pt_review_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_assembly_assignedto,0)=@u AND[pt_assembly_datecompleted]IS NULL THEN[pt_assembly_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_delivery_assignedto,0)=@u AND[pt_delivery_datecompleted]IS NULL THEN[pt_delivery_esttime]ELSE NULL END),0)
AS[total_subtask_time]


,COUNT(DISTINCT CASE WHEN ISNULL(pt_obtaininfo_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pt_entry_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pt_rec_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pt_review_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pt_assembly_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
+COUNT(DISTINCT CASE WHEN ISNULL(pt_delivery_assignedto,0)=@u THEN[pt_id]ELSE NULL END)
AS[count_subtask_assigned]
<cfelse>


,ISNULL(SUM(ISNULL(pt_esttime,0)),0)AS[total_time]
,COUNT(DISTINCT[pt_id])AS[count_assigned]
,ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_obtaininfo_assignedto,0)=@u AND [pt_obtaininfo_datecompleted]IS NULL THEN[pt_obtaininfo_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_entry_assignedto,0)=@u AND[pt_entry_datecompleted]IS NULL THEN[pt_entry_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_rec_assignedto,0)=@u AND[pt_rec_datecompleted]IS NULL THEN[pt_rec_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_review_assignedto,0)=@u AND[pt_review_datecompleted]IS NULL THEN[pt_review_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_assembly_assignedto,0)=@u AND[pt_assembly_datecompleted]IS NULL THEN[pt_assembly_esttime]ELSE NULL END),0)
+ISNULL(SUM(DISTINCT CASE WHEN ISNULL(pt_delivery_assignedto,0)=@u AND[pt_delivery_datecompleted]IS NULL THEN[pt_delivery_esttime]ELSE NULL END),0)
AS[total_subtask_time]

,COUNT(pt_obtaininfo_assignedto)
+COUNT(pt_entry_assignedto)
+COUNT(pt_rec_assignedto)
+COUNT(pt_review_assignedto)
+COUNT(pt_assembly_assignedto)
+COUNT(pt_delivery_assignedto)
AS[count_subtask_assigned]


</cfif>
,'J'AS[orderit]
FROM[v_payrolltaxes] 
WHERE([pt_delivery_datecompleted]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL OR[pt_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND([pt_obtaininfo_assignedto]=@u  AND[pt_obtaininfo_datecompleted]IS NULL)
OR([pt_entry_assignedto]=@u  AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR([pt_rec_assignedto]=@u  AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR([pt_review_assignedto]=@u  AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR([pt_assembly_assignedto]=@u  AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR([pt_delivery_assignedto]=@u  AND[pt_assembly_datecompleted]IS NOT NULL)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>





UNION
SELECT'Personal Property Tax Returns'AS[name]
<cfif ARGUMENTS.userid neq "0">
,SUM(DISTINCT CASE WHEN ISNULL( tr_4_assignedto ,0)=@u  THEN ISNULL([tr_4_pptresttime],0) ELSE 0 END)AS[total_time]
,COUNT(DISTINCT CASE WHEN ISNULL(tr_4_assignedto,0)=@u THEN[tr_id]ELSE NULL END)AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
<cfelse>
,SUM(DISTINCT  ISNULL([tr_4_pptresttime],0) )AS[total_time]
,COUNT(DISTINCT[tr_id])AS[count_assigned]
,(0)AS[total_subtask_time]
,(0)AS[count_subtask_assigned]
</cfif>

,'K'AS[orderit]
FROM[v_taxreturns]
WHERE([tr_4_required]='TRUE'AND[tr_4_delivered]IS NULL)
OR(([tr_4_required]='TRUE'AND[tr_4_delivered]IS NULL)
AND [tr_3_delivered] IS NULL
AND([tr_taxyear]=Year(getdate())-1 OR Year([tr_2_informationreceived])=Year(getdate())))
<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL OR[tr_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_4_assignedto]IS NULL OR[tr_4_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION
SELECT'Tax Returns'AS[name]

<cfif ARGUMENTS.userid neq "0">
,ISNULL(SUM(ISNULL(tr_esttime,0)),0)AS[total_time]
,COUNT(tr_id)AS[count_assigned]
,(0)AS[total_subtask_time]

,COUNT(DISTINCT CASE WHEN ISNULL(tr_2_assignedto,0)=@u THEN[tr_id]ELSE 0 END)AS[count_subtask_assigned]
<cfelse>
,ISNULL(SUM(ISNULL(tr_esttime,0)),0)AS[total_time]
,COUNT(tr_id)AS[count_assigned]
,(0)AS[total_subtask_time]

,COUNT(tr_2_assignedto)AS[count_subtask_assigned]
</cfif>

,'L'AS[orderit]
FROM[v_taxreturns]
WHERE([tr_3_delivered]IS NULL )

<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL OR[tr_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_2_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>



<cfquery dbtype="query" name="fquery">
SELECT[name],[total_time],[count_assigned],[total_subtask_time],[count_subtask_assigned],[orderit]FROM[aquery]
UNION
SELECT'<b style=''font-weight: bold;''>Total</b>'AS[name]
,SUM(total_time)AS[total_time]
,SUM(count_assigned)AS[count_assigned]
,SUM(total_subtask_time)
,SUM(count_subtask_assigned)AS[count_subtask_assigned]
,'ZZZ'AS[orderit]
FROM[aquery]
ORDER BY[orderit]
</cfquery>


<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{
								"NAME":"'&NAME&'"
								,"TOTAL_TIME":"'&TOTAL_TIME&'"
								,"COUNT_ASSIGNED":"'&COUNT_ASSIGNED&'"
								,"TOTAL_SUBTASK_TIME":"'&TOTAL_SUBTASK_TIME&'"
								,"COUNT_SUBTASK_ASSIGNED":"'&COUNT_SUBTASK_ASSIGNED&'"
								,"ORDERIT":"'&ORDERIT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>

   <cfcatch >
        <cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#","QUERY":['&queryResult&']]}'> 
    </cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Accounting and Consulting Tasks --->
<cfcase value="group2">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT Distinct [mc_id]
,[client_id]
,[client_name]
,[mc_requestforservice]=FORMAT(mc_requestforservice,'d','#Session.localization.language#') 
,[mc_projectcompleted]=FORMAT(mc_projectcompleted,'d','#Session.localization.language#') 
,[mc_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,[mc_priority]
,[mc_assignedtoTEXT]
,[mc_duedate]=FORMAT(mc_duedate,'d','#Session.localization.language#') 
,[mc_esttime]
,[mc_category]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='2'OR[form_id]='0')AND([optionGroup]='2'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
FROM[v_managementconsulting_subtask]
WHERE([mc_status]NOT IN('2','3')OR([mc_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([mc_assignedto]=@u OR[mcs_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>

<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MC_ID":"'&MC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"MC_CATEGORYTEXT":"'&MC_CATEGORYTEXT&'"
								,"MC_DESCRIPTION":"'&MC_DESCRIPTION&'"
								,"MC_STATUSTEXT":"'&MC_STATUSTEXT&'"
								,"MC_DUEDATE":"'&MC_DUEDATE&'"
								,"MC_ASSIGNEDTOTEXT":"'&MC_ASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<cfcase value="group2_subtask">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT DISTINCT[mc_id]
,[mcs_id]
,[mcs_assignedtoTEXT]
,[mcs_duedate]
,[mcs_sequence]
,[mcs_completed]
,[mcs_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mcs_status]=[optionvalue_id])
,[mcs_subtaskTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_acctsubtasks'AND[mcs_subtask]=[optionvalue_id])
FROM[v_managementconsulting_subtask]
WHERE([mc_status]NOT IN('2','3')OR([mc_status]IS NULL))
AND[mc_id]=<cfqueryparam value="#ARGUMENTS.id#">
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([mc_assignedto]=@u OR[mcs_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>

<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"MCS_ID":"'&MCS_ID&'"
								,"MCS_SEQUENCE":"'&MCS_SEQUENCE&'"
								,"MCS_SUBTASKTEXT":"'&MCS_SUBTASKTEXT&'"
								,"MCS_DUEDATE":"'&MCS_DUEDATE&'"
 								,"MCS_STATUSTEXT":"'&MCS_STATUSTEXT&'"
								,"MCS_ASSIGNEDTOTEXT":"'&MCS_ASSIGNEDTOTEXT&'"
								,"MCS_COMPLETED":"'&MCS_COMPLETED&'"
 								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>



<!--- LOOKUP Administrative Tasks --->
<cfcase value="group3">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT [cas_id]
,[client_id]
,[client_name]
,[cas_duedate]=FORMAT(cas_duedate,'d','#Session.localization.language#') 
,[cas_assignedto]
,[cas_category]
,[cas_datereqested]=FORMAT(cas_datereqested,'d','#Session.localization.language#') 
,CASE WHEN LEN([cas_taskdesc]) >= 101 THEN SUBSTRING([cas_taskdesc],0,100) +  '...' ELSE [cas_taskdesc] END AS[cas_taskdesc]
,[cas_status]
,cas_assignedtoTEXT=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))FOR XML PATH('')),3,1000)
,cas_categoryTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[cas_category]=[optionvalue_id])
,cas_statusTEXT=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[cas_status]=[optionvalue_id])

FROM[v_clientadministrativetasks]
WHERE([cas_status]NOT IN('2','3')OR([cas_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([cas_duedate]IS NULL OR[cas_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](cas_assignedto)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CAS_ID":"'&CAS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CAS_CATEGORYTEXT":"'&CAS_CATEGORYTEXT&'"
								,"CAS_TASKDESC":"'&CAS_TASKDESC&'"
								,"CAS_DUEDATE":"'&CAS_DUEDATE&'"
								,"CAS_STATUSTEXT":"'&CAS_STATUSTEXT&'"
								,"CAS_ASSIGNEDTOTEXT":"'&CAS_ASSIGNEDTOTEXT&'"
								,"CAS_DATEREQESTED":"'&CAS_DATEREQESTED&'"	
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Business Formation --->
<cfcase value="group4">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT DISTINCT[bf_id]
,[client_id]
,[client_name]
,[bf_owners]
,[bf_status]
,[bf_duedate]=FORMAT(bf_duedate,'d','#Session.localization.language#') 
,[bf_businesstypeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[bf_businesstype]=[optionvalue_id])
,[bf_assignedtoTEXT]=(SELECT TOP (1)[si_initials]FROM[v_staffinitials]WHERE(bf_assignedto = user_id)) 
,[bf_activity]
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_missinginforeceived]=FORMAT(bf_missinginforeceived,'d','#Session.localization.language#') 
,[bf_missinginfo]
FROM[v_businessformation_subtask]
WHERE([bf_status]NOT IN('2','3')OR([bf_status]IS NULL))
<cfif ARGUMENTS.userid neq "0">AND([bf_assignedto]=@u OR[bfs_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BF_ID":"'&BF_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"BF_ACTIVITY":"'&BF_ACTIVITY&'"
								,"BF_OWNERS":"'&BF_OWNERS&'"
								,"BF_BUSINESSTYPETEXT":"'&BF_BUSINESSTYPETEXT&'"
								,"BF_DUEDATE":"'&BF_DUEDATE&'"								
								,"BF_STATUSTEXT":"'&BF_STATUSTEXT&'"
								,"BF_ASSIGNEDTOTEXT":"'&BF_ASSIGNEDTOTEXT&'"
								,"BF_MISSINGINFO":"'&BF_MISSINGINFO&'"
								,"BF_MISSINGINFORECEIVED":"'&BF_MISSINGINFORECEIVED&'"
			
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<cfcase value="group4_subtask">
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000), @id varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SET @id=<cfqueryparam value="#ARGUMENTS.id#">
SELECT[bfs_id]
,[bfs_taskname]
,[bfs_assignedtoTEXT]
,[bfs_dateinitiated]=FORMAT(bfs_dateinitiated,'d','#Session.localization.language#')
,[bfs_datecompleted]=FORMAT(bfs_datecompleted,'d','#Session.localization.language#')
,[bfs_estimatedtime]
FROM[v_businessformation_subtask]
WHERE([bf_status]NOT IN('2','3')OR([bf_status]IS NULL))
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND([bf_id]=@g)</cfif>
AND[BF_ID]=@id

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"BFS_ID":"'&BFS_ID&'"
								,"BFS_TASKNAME":"'&BFS_TASKNAME&'"
								,"BFS_ASSIGNEDTOTEXT":"'&BFS_ASSIGNEDTOTEXT&'"
								,"BFS_DATEINITIATED":"'&BFS_DATEINITIATED&'"
								,"BFS_DATECOMPLETED":"'&BFS_DATECOMPLETED&'"
								,"BFS_ESTIMATEDTIME":"'&BFS_ESTIMATEDTIME&'"
								}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>


<!--- LOOKUP Communications --->
<cfcase value="group5">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[co_id]
,[co_forTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](co_for)))FOR XML PATH('')),3,1000)
,CASE WHEN LEN([co_briefmessage]) >= 101 THEN SUBSTRING([co_briefmessage],0,100) +  '...' ELSE [co_briefmessage] END AS[co_briefmessage]
,[co_caller]
,[co_duedate]=FORMAT(co_duedate,'d','#Session.localization.language#')
,[co_date]=FORMAT(co_duedate,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[co_status]
,[co_responseneeded]
,[co_returncall]
,[client_name]
,[client_id]
,[co_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[co_status]=[optionvalue_id])

FROM[v_communications]
WHERE([co_status]NOT IN('2','3')OR([co_status]IS NULL))
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](co_for)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"CO_ID":"'&CO_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"CO_CALLER":"'&CO_CALLER&'"
								,"CO_DATE":"'&CO_DATE&'"
								,"CO_DUEDATE":"'&CO_DUEDATE&'"
								,"CO_STATUSTEXT":"'&CO_STATUSTEXT&'"
								,"CO_FORTEXT":"'&CO_FORTEXT&'"
								,"CO_RESPONSENEEDED":"'&CO_RESPONSENEEDED&'"
								,"CO_RETURNCALL":"'&CO_RETURNCALL&'"
								,"CO_BRIEFMESSAGE":"'&CO_BRIEFMESSAGE&'"								
								}'>                          
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP Financial &amp; Tax Planning --->
<cfcase value="group6">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[ftp_id]
,[ftp_status]
,[ftp_category]
,[ftp_assignedtoTEXT]
,[ftp_duedate]=FORMAT(ftp_duedate,'d','#Session.localization.language#')
,[ftp_requestservice]=FORMAT(ftp_requestservice,'d','#Session.localization.language#')
,[ftp_missinginfo]
,[client_name]
,[client_id]
,[ftp_description]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])AS[ftp_categoryTEXT]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])AS[ftp_statusTEXT]

FROM[v_financialtaxplanning]
WHERE([ftp_status]NOT IN('2','3')OR([ftp_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL OR[ftp_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([ftp_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>


</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FTP_ID":"'&FTP_ID&'"
 									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"FTP_CATEGORYTEXT":"'&FTP_CATEGORYTEXT&'"
									,"FTP_DESCRIPTION":"'&FTP_DESCRIPTION&'"
									,"FTP_DUEDATE":"'&FTP_DUEDATE&'"
									,"FTP_STATUSTEXT":"'&FTP_STATUSTEXT&'"
									,"FTP_ASSIGNEDTOTEXT":"'&FTP_ASSIGNEDTOTEXT&'"
 									,"FTP_REQUESTSERVICE":"'&FTP_REQUESTSERVICE&'"
 									,"FTP_MISSINGINFO":"'&FTP_MISSINGINFO&'"
									}'>
                                    
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Financial Statements --->
<cfcase value="group7">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT DISTINCT [fds_id]
,[client_id]
,[client_name]
,[fds_periodend]=FORMAT(fds_periodend,'d','#Session.localization.language#') 
,[fds_month]
,[fds_year]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
,[fds_duedate]=FORMAT(fds_duedate,'d','#Session.localization.language#') 
,[fds_status]
,[fds_missinginfo]
,[fds_compilemi]
,[fds_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id])
,[fds_obtaininfo_datecompleted]=ISNULL(FORMAT(fds_obtaininfo_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_obtaininfo_assignedtoTEXT]
,[fds_sort_datecompleted]=ISNULL(FORMAT(fds_sort_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_sort_assignedtoTEXT]
,[fds_checks_datecompleted]=ISNULL(FORMAT(fds_checks_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_checks_assignedtoTEXT]
,[fds_sales_datecompleted]=ISNULL(FORMAT(fds_sales_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_sales_assignedtoTEXT]
,[fds_entry_datecompleted]=ISNULL(FORMAT(fds_entry_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_entry_assignedtoTEXT]
,[fds_reconcile_datecompleted]=ISNULL(FORMAT(fds_reconcile_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_reconcile_assignedtoTEXT]
,[fds_compile_datecompleted]=ISNULL(FORMAT(fds_compile_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_compile_assignedtoTEXT]
,[fds_review_datecompleted]=ISNULL(FORMAT(fds_review_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_review_assignedtoTEXT]
,[fds_assembly_datecompleted]=ISNULL(FORMAT(fds_assembly_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_assembly_assignedtoTEXT]
,[fds_delivery_datecompleted]=ISNULL(FORMAT(fds_delivery_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_delivery_assignedtoTEXT]
,[fds_acctrpt_datecompleted]=ISNULL(FORMAT(fds_acctrpt_datecompleted,'d','#Session.localization.language#'),'N/A')
,[fds_acctrpt_assignedtoTEXT]
FROM[v_financialDataStatus_subtask]
WHERE([fds_status]NOT IN('2','3')OR([fds_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND[fds_delivery_datecompleted] IS NULL
AND([fds_obtaininfo_assignedto] = @u AND[fds_obtaininfo_datecompleted]IS NULL)
OR([fds_sort_assignedto] = @u AND[fds_obtaininfo_datecompleted]IS NOT NULL AND[fds_sort_datecompleted] IS NULL)
OR([fds_checks_assignedto] = @u  AND [fds_sort_datecompleted] IS NOT NULL AND [fds_checks_datecompleted] IS NULL)
OR([fds_sales_assignedto] = @u  AND [fds_checks_datecompleted] IS NOT NULL AND [fds_sales_datecompleted] IS NULL)
OR([fds_entry_assignedto] = @u  AND [fds_sales_datecompleted] IS NOT NULL AND [fds_entry_datecompleted] IS NULL)
OR([fds_reconcile_assignedto] = @u  AND [fds_entry_datecompleted] IS NOT NULL AND [fds_reconcile_datecompleted] IS NULL)
OR([fds_compile_assignedto]= @u  AND [fds_reconcile_datecompleted] IS NOT NULL AND [fds_compile_datecompleted] IS NULL)
OR([fds_review_assignedto] = @u  AND [fds_compile_datecompleted] IS NOT NULL AND [fds_review_datecompleted] IS NULL)
OR([fds_assembly_assignedto] = @u  AND [fds_review_datecompleted] IS NOT NULL AND [fds_assembly_datecompleted]  IS NULL)
OR([fds_delivery_assignedto] = @u  AND [fds_assembly_datecompleted] IS NOT NULL)
OR([fdss_assignedto]=@u)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDS_ID":"'&FDS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"FDS_MONTHTEXT":"'&FDS_MONTHTEXT&'"
								,"FDS_YEAR":"'&FDS_YEAR&'"
								,"FDS_PERIODEND":"'&FDS_PERIODEND&'"
								,"FDS_DUEDATE":"'&FDS_DUEDATE&'"
								,"FDS_STATUSTEXT":"'&FDS_STATUSTEXT&'"
								,"FDS_MISSINGINFO":"'&FDS_MISSINGINFO&'"
								,"FDS_OBTAININFO":"'&fds_obtaininfo_datecompleted&'<br/>'&fds_obtaininfo_assignedtoTEXT&'"
								,"FDS_SORT":"'&fds_sort_datecompleted&'<br/>'&fds_sort_assignedtoTEXT&'"
								,"FDS_CHECKS":"'&fds_checks_datecompleted&'<br/>'&fds_checks_assignedtoTEXT&'"
								,"FDS_SALES":"'&fds_sales_datecompleted&'<br/>'&fds_sales_assignedtoTEXT&'"
								,"FDS_ENTRY":"'&fds_entry_datecompleted&'<br/>'&fds_entry_assignedtoTEXT&'"
								,"FDS_RECONCILE":"'&fds_reconcile_datecompleted&'<br/>'&fds_reconcile_assignedtoTEXT&'"
								,"FDS_COMPILE":"'&fds_compile_datecompleted&'<br/>'&fds_compile_assignedtoTEXT&'"
								,"FDS_REVIEW":"'&fds_review_datecompleted&'<br/>'&fds_review_assignedtoTEXT&'"
								,"FDS_ASSEMBLY":"'&fds_assembly_datecompleted&'<br/>'&fds_assembly_assignedtoTEXT&'"
								,"FDS_DELIVERY":"'&fds_delivery_datecompleted&'<br/>'&fds_delivery_assignedtoTEXT&'"
								,"FDS_ACCTRPT":"'&fds_acctrpt_datecompleted&'<br/>'&fds_acctrpt_assignedtoTEXT&'"

								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<cfcase value="group7_subtask"><cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000), @id varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SET @id=<cfqueryparam value="#ARGUMENTS.id#">
SELECT[fdss_id]
,[fdss_subtaskTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialstatmentsubtask'AND[fdss_subtask]=[optionvalue_id])
,[fdss_assignedtoTEXT]
,[fdss_duedate]=FORMAT(fdss_duedate,'d','#Session.localization.language#')
,[fdss_sequence]
,[fdss_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fdss_status]=[optionvalue_id])
,[fdss_subtask]
,[fdss_completed]
FROM[v_financialDataStatus_Subtask]
WHERE([fds_status]NOT IN('2','3')OR([fds_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0"></cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
AND[fds_id]=@id



<cfif !ListFindNoCase('false,0',ARGUMENTS.orderBy) >ORDER BY[<cfqueryparam value="#ARGUMENTS.orderBy#"/>]<cfelse>ORDER BY[fdss_subtaskTEXT]</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"FDSS_ID":"'&FDSS_ID&'"
								,"FDSS_SEQUENCE":"'&FDSS_SEQUENCE&'"
								,"FDSS_SUBTASKTEXT":"'&FDSS_SUBTASKTEXT&'"
								,"FDSS_DUEDATE":"'&FDSS_DUEDATE&'"
								,"FDSS_STATUSTEXT":"'&FDSS_STATUSTEXT&'"
								,"FDSS_ASSIGNEDTOTEXT":"'&FDSS_ASSIGNEDTOTEXT&'"
								,"FDSS_COMPLETED":"'&FDSS_COMPLETED&'"
								}'>
<cfif queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
</cfcase>

<!--- Grid Notice  --->
<cfcase value="group8">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT DISTINCT[n_id]
,[n_name]
,[n_status]
,[client_name]
,[client_id]
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE([n_status]NOT IN('2','3')OR([n_status]IS NULL))
AND([nst_status]NOT IN('2','3')OR([nst_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([nst_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&n_NAME&'"
								,"N_STATUSTEXT":"'&n_STATUSTEXT&'"						
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- Grid Notice  --->
<cfcase value="group8_subtask">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000),@id int
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SET @id=<cfqueryparam value="#ARGUMENTS.id#">
SELECT[n_id],[nst_id]
,[nst_id]
,[client_name]
,[client_id]
,[n_name]
,[nst_assignedtoTEXT]
,[nst_status]
,[nst_1_noticenumberTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_noticenumber'AND[nst_1_noticenumber]=[optionvalue_id])
,[nst_1_taxform]
,[nst_1_taxyear]
,[nst_1_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[nst_1_taxform]=[optionvalue_id])
,[nst_1_resduedate]=FORMAT(nst_1_resduedate,'d','#Session.localization.language#')
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
,[nst_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[nst_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE([nst_status]NOT IN('2','3')OR([nst_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">--AND([nst_assignedto]=@u  OR[nst_assignedto]=0)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
AND[n_id]=@id

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"NST_ID":"'&NST_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&N_NAME&'"
								,"N_STATUSTEXT":"'&N_STATUSTEXT&'"
								,"NST_1_TAXYEAR":"'&NST_1_TAXYEAR&'"
								,"NST_1_TAXFORMTEXT":"'&NST_1_TAXFORMTEXT&'"
								,"NST_1_NOTICENUMBERTEXT":"'&NST_1_NOTICENUMBERTEXT&'"
								,"NST_1_RESDUEDATE":"'&NST_1_RESDUEDATE&'"
								,"NST_STATUSTEXT":"'&NST_STATUSTEXT&'"		
								,"NST_ASSIGNEDTOTEXT":"'&NST_ASSIGNEDTOTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"COLUMNS":["ERROR","ID","MESSAGE"],"DATA":["#cfcatch.message#","#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>




<!--- LOOKUP Other Filings --->
<cfcase value="group9">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[of_id]
,[of_taxyear]
,[of_period]
,[of_state]
,[of_type]
,[of_form]
,[of_periodTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[of_period]=[optionvalue_id])
,[of_obtaininfo_assignedto]
,[of_preparation_assignedto]
,[of_review_assignedto]
,[of_assembly_assignedto]
,[of_delivery_assignedto]
,[of_duedate]=FORMAT(of_duedate,'d','#Session.localization.language#') 
,[of_missinginfo]
,[of_missinginforeceived]=FORMAT(of_missinginforeceived,'d','#Session.localization.language#') 
,[of_filingdeadline]=FORMAT(of_filingdeadline,'d','#Session.localization.language#') 
,[client_name]
,[client_id]
,[of_obtaininfo_datecompleted]=ISNULL(FORMAT(of_obtaininfo_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_obtaininfo_assignedtoTEXT]
,[of_preparation_datecompleted]=ISNULL(FORMAT(of_preparation_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_preparation_assignedtoTEXT]
,[of_review_datecompleted]=ISNULL(FORMAT(of_review_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_review_assignedtoTEXT]
,[of_assembly_datecompleted]=ISNULL(FORMAT(of_assembly_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_assembly_assignedtoTEXT]
,[of_delivery_datecompleted]=ISNULL(FORMAT(of_delivery_datecompleted,'d','#Session.localization.language#'),'N/A')
,[of_delivery_assignedtoTEXT] 
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_type]=[optionvalue_id])
,[of_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_state]=[optionvalue_id])

FROM[v_otherfilings]
WHERE([of_status]NOT IN('2','3')OR([of_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND([of_obtaininfo_assignedto]=@u  AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=@u  AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=@u  AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=@u  AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=@u  AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"OF_ID":"'&OF_ID&'"
									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"OF_TAXYEAR":"'&OF_TAXYEAR&'"								
									,"OF_PERIODTEXT":"'&OF_PERIODTEXT&'"
									,"OF_STATETEXT":"'&OF_STATETEXT&'"
									,"OF_TYPETEXT":"'&OF_TYPETEXT&'"
 									,"OF_FORMTEXT":"'&OF_FORMTEXT&'"
									,"OF_DUEDATE":"'&OF_DUEDATE&'"						
									,"OF_FILINGDEADLINE":"'&OF_FILINGDEADLINE&'"
 									,"OF_STATUSTEXT":"'&OF_STATUSTEXT&'"
	 								,"OF_MISSINGINFO":"'&OF_MISSINGINFO&'"
	 								,"OF_MISSINGINFORECEIVED":"'&OF_MISSINGINFORECEIVED&'"								
									,"OF_OBTAININFO":"'&of_obtaininfo_datecompleted&'<br/>'&of_obtaininfo_assignedtoTEXT&'"
									,"OF_PREPARATION":"'&of_preparation_datecompleted&'<br/>'&of_preparation_assignedtoTEXT&'"
									,"OF_REVIEW":"'&of_review_datecompleted&'<br/>'&of_review_assignedtoTEXT&'"
									,"OF_ASSEMBLY":"'&of_assembly_datecompleted&'<br/>'&of_assembly_assignedtoTEXT&'"
									,"OF_DELIVERY":"'&of_delivery_datecompleted&'<br/>'&of_delivery_assignedtoTEXT&'"								
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Checks --->
<cfcase value="group10">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[pc_id]
	,[pc_year]
	,[pc_duedate]=FORMAT(pc_duedate,'d','#Session.localization.language#') 
	,[pc_missinginfo]
	,[pc_payenddate]=FORMAT(pc_payenddate,'d','#Session.localization.language#') 
	,[pc_paydate]=FORMAT(pc_paydate,'d','#Session.localization.language#') 
	,[pc_obtaininfo_datecompleted]=ISNULL(FORMAT(pc_obtaininfo_datecompleted,'d','#Session.localization.language#'),'N/A')
	,[pc_obtaininfo_assignedtoTEXT]
	,[pc_preparation_datecompleted]=ISNULL(FORMAT(pc_preparation_datecompleted,'d','#Session.localization.language#'),'N/A')
	,[pc_preparation_assignedtoTEXT]
	,[pc_review_datecompleted]=ISNULL(FORMAT(pc_review_datecompleted,'d','#Session.localization.language#'),'N/A')
	,[pc_review_assignedtoTEXT]
	,[pc_assembly_datecompleted]=ISNULL(FORMAT(pc_assembly_datecompleted,'d','#Session.localization.language#'),'N/A')
	,[pc_assembly_assignedtoTEXT]
	,[pc_delivery_datecompleted]=ISNULL(FORMAT(pc_delivery_datecompleted,'d','#Session.localization.language#'),'N/A')
	,[pc_delivery_assignedtoTEXT]
 	,[client_name]
 	,[client_id]

FROM[v_payrollcheckstatus]
WHERE[pc_delivery_datecompleted]IS NULL 
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL OR[pc_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND
([pc_delivery_datecompleted]IS NULL AND([pc_obtaininfo_datecompleted]IS NULL AND[pc_obtaininfo_assignedto]=@u)
OR([pc_obtaininfo_datecompleted]IS NOT NULL AND[pc_preparation_datecompleted]IS NULL AND[pc_preparation_assignedto]=@u)
OR([pc_preparation_datecompleted]IS NOT NULL AND[pc_review_datecompleted]IS NULL AND[pc_review_assignedto]=@u)
OR([pc_review_datecompleted]IS NOT NULL AND[pc_assembly_datecompleted]IS NULL AND[pc_assembly_assignedto]=@u)
OR([pc_assembly_datecompleted]IS NOT NULL AND[pc_delivery_assignedto]=@u))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PC_ID":"'&PC_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PC_YEAR":"'&PC_YEAR&'"
								,"PC_DUEDATE":"'&PC_DUEDATE&'"
								,"PC_PAYENDDATE":"'&PC_PAYENDDATE&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_MISSINGINFO":"'&PC_MISSINGINFO&'"
								,"PC_PAYDATE":"'&PC_PAYDATE&'"
								,"PC_OBTAININFO":"'&pc_obtaininfo_datecompleted&'<br/>'&pc_obtaininfo_assignedtoTEXT&'"
								,"PC_PREPARATION":"'&pc_preparation_datecompleted&'<br/>'&pc_preparation_assignedtoTEXT&'"
								,"PC_REVIEW":"'&pc_review_datecompleted&'<br/>'&pc_review_assignedtoTEXT&'"
								,"PC_ASSEMBLY":"'&pc_assembly_datecompleted&'<br/>'&pc_assembly_assignedtoTEXT&'"
								,"PC_DELIVERY":"'&pc_delivery_datecompleted&'<br/>'&pc_delivery_assignedtoTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP Payroll Taxes --->
<cfcase value="group11">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[pt_id]
		,[pt_year]
		,[pt_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[pt_state]=[optionvalue_id])
		,[pt_duedate]=FORMAT(pt_duedate,'d','#Session.localization.language#') 
		,[pt_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[pt_month]=[optionvalue_id])
		,[pt_lastpay]=FORMAT(pt_lastpay,'d','#Session.localization.language#') 
		,[pt_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_returntypes'AND[pt_type]=[optionvalue_id])
		,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'d','#Session.localization.language#') 
		,[pt_obtaininfo_datecompleted]=ISNULL(FORMAT(pt_obtaininfo_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_obtaininfo_assignedtoTEXT]
		,[pt_entry_datecompleted]=ISNULL(FORMAT(pt_entry_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_entry_assignedtoTEXT]
		,[pt_rec_datecompleted]=ISNULL(FORMAT(pt_rec_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_rec_assignedtoTEXT]
		,[pt_review_datecompleted]=ISNULL(FORMAT(pt_review_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_review_assignedtoTEXT]
		,[pt_assembly_datecompleted]=ISNULL(FORMAT(pt_assembly_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_assembly_assignedtoTEXT]
		,[pt_delivery_datecompleted]=ISNULL(FORMAT(pt_delivery_datecompleted,'d','#Session.localization.language#'),'N/A')
		,[pt_delivery_assignedtoTEXT]
		,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'d','#Session.localization.language#')
	 	,[pt_missinginfo]
		,[client_name]
	,[client_id]
FROM[v_payrolltaxes]
WHERE([pt_delivery_datecompleted]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL OR[pt_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND([pt_obtaininfo_assignedto]=@u  AND[pt_obtaininfo_datecompleted]IS NULL)
OR([pt_entry_assignedto]=@u  AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR([pt_rec_assignedto]=@u  AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR([pt_review_assignedto]=@u  AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR([pt_assembly_assignedto]=@u  AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR([pt_delivery_assignedto]=@u  AND[pt_assembly_datecompleted]IS NOT NULL)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"PT_ID":"'&PT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"PT_YEAR":"'&PT_YEAR&'"
								,"PT_MONTHTEXT":"'&PT_MONTHTEXT&'"
								,"PT_STATETEXT":"'&PT_STATETEXT&'"
								,"PT_TYPETEXT":"'&PT_TYPETEXT&'"
								,"PT_LASTPAY":"'&PT_LASTPAY&'"
								,"PT_DUEDATE":"'&PT_DUEDATE&'"
 								,"PT_MISSINGINFO":"'&PT_MISSINGINFO&'"
 								,"PT_MISSINGINFORECEIVED":"'&PT_MISSINGINFORECEIVED&'"
								,"PT_OBTAININFO":"'&pt_obtaininfo_datecompleted&'<br/>'&pt_obtaininfo_assignedtoTEXT&'"
								,"PT_ENTRY":"'&pt_entry_datecompleted&'<br/>'&pt_entry_assignedtoTEXT&'"
								,"PT_REC":"'&pt_rec_datecompleted&'<br/>'&pt_rec_assignedtoTEXT&'"
								,"PT_REVIEW":"'&pt_review_datecompleted&'<br/>'&pt_review_assignedtoTEXT&'"
								,"PT_ASSEMBLY":"'&pt_assembly_datecompleted&'<br/>'&pt_assembly_assignedtoTEXT&'"
								,"PT_DELIVERY":"'&pt_delivery_datecompleted&'<br/>'&pt_delivery_assignedtoTEXT&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>


<!--- LOOKUP TAX RETURNS --->
<cfcase value="group12">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[tr_id]
,[client_id]
,[client_name]
,[tr_4_extended]=FORMAT(tr_4_extended,'d','#Session.localization.language#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'d','#Session.localization.language#') 
,[tr_taxyear]
,[tr_taxform]
,[tr_priority]
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[tr_4_pptresttime]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'d','#Session.localization.language#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'d','#Session.localization.language#') 
FROM[v_taxreturns]
WHERE([tr_4_required]='TRUE'AND[tr_4_delivered]IS NULL)
OR(([tr_4_required]='TRUE'AND[tr_4_delivered]IS NULL)
AND [tr_3_delivered] IS NULL
AND([tr_taxyear]=Year(getdate())-1 OR Year([tr_2_informationreceived])=Year(getdate())))
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_4_assignedto]IS NULL OR[tr_4_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"TR_4_EXTENDED":"'&TR_4_EXTENDED&'"
								,"TR_4_COMPLETED":"'&TR_4_COMPLETED&'"
								,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
								,"TR_TAXFORM":"'&TR_TAXFORM&'"
								,"TR_PRIORITY":"'&TR_PRIORITY&'"
								,"TR_4_ASSIGNEDTOTEXT":"'&TR_4_ASSIGNEDTOTEXT&'"
								,"TR_4_PPTRESTTIME":"'&TR_4_PPTRESTTIME&'"
								,"TR_4_RFR":"'&TR_4_RFR&'"
								,"TR_4_DELIVERED":"'&TR_4_DELIVERED&'"
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

<!--- LOOKUP TAX RETURNS --->
<cfcase value="group13">
<cftry>
<cfquery datasource="#Session.organization.name#" name="fquery">
DECLARE @c varchar(8000),@u varchar(8000),@d date,@g varchar(8000)
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">
SET @g=<cfqueryparam value="#ARGUMENTS.group#">
SET @u=<cfqueryparam value="#ARGUMENTS.userid#">
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">
SELECT[tr_id]
 	,[tr_taxyear]
 	,[tr_taxform]
	,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
  	,[tr_duedate]=FORMAT(tr_duedate,'d','#Session.localization.language#') 
	,[tr_missinginfo]
	,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'d','#Session.localization.language#') 
	,[tr_2_assignedto]
  	,[tr_2_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_2_assignedto=user_id))
	,[client_name]
	,[client_id]
	,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'d','#Session.localization.language#') 
	,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'d','#Session.localization.language#') 
	,[tr_2_reviewassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_2_reviewassignedto=user_id))
	,[tr_2_reviewed]=FORMAT(tr_2_reviewed,'d','#Session.localization.language#') 
	,[tr_2_completed]=FORMAT(tr_2_completed,'d','#Session.localization.language#') 
	,[tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'d','#Session.localization.language#') 
	,[tr_3_delivered]=FORMAT(tr_3_delivered,'d','#Session.localization.language#') 
	,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'d','#Session.localization.language#') 

FROM[v_taxreturns]

WHERE([tr_3_delivered]IS NULL )

<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL OR[tr_duedate]>=@d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_2_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"TR_ID":"'&TR_ID&'"
 									,"CLIENT_ID":"'&CLIENT_ID&'"
 									,"CLIENT_NAME":"'&CLIENT_NAME&'"
									,"TR_TAXYEAR":"'&TR_TAXYEAR&'"
									,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
									,"TR_DUEDATE":"'&TR_DUEDATE&'"
									,"TR_2_ASSIGNEDTOTEXT":"'&TR_2_ASSIGNEDTOTEXT&'"
 									,"TR_2_INFORMATIONRECEIVED":"'&TR_2_INFORMATIONRECEIVED&'"
									,"TR_MISSINGINFO":"'&TR_MISSINGINFO&'"
									,"TR_MISSINGINFORECEIVED":"'&TR_MISSINGINFORECEIVED&'"
									,"TR_2_READYFORREVIEW":"'&TR_2_READYFORREVIEW&'"
									,"TR_2_REVIEWASSIGNEDTOTEXT":"'&TR_2_REVIEWASSIGNEDTOTEXT&'"
									,"TR_2_REVIEWED":"'&TR_2_REVIEWED&'"
									,"TR_2_REVIEWEDWITHNOTES":"'&TR_2_REVIEWEDWITHNOTES&'"
 									,"TR_2_COMPLETED":"'&TR_2_COMPLETED&'"
									,"TR_3_ASSEMBLERETURN":"'&TR_3_ASSEMBLERETURN&'"	
									,"TR_3_DELIVERED":"'&TR_3_DELIVERED&'"	
								}'>
<cfif  queryIndex lt fquery.recordcount><cfset queryResult=queryResult&","></cfif>
</cfloop>
<cfset myResult='{"Result":"OK","Records":['&queryResult&']}'>
<cfreturn myResult>
<cfcatch>
	<!--- CACHE ERRORS DEBUG CODE --->
<cfreturn '{"Result":"Error","Records":["ERROR":"#cfcatch.message#","id":"#arguments.loadType#","MESSAGE":"#cfcatch.detail#"]}'> 
</cfcatch>
</cftry>
</cfcase>

</cfswitch>
</cffunction>
</cfcomponent>