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
SET @c=<cfqueryparam value="#ARGUMENTS.clientid#">;
SET @g=<cfqueryparam value="#ARGUMENTS.group#">;
SET @u=<cfqueryparam value="#ARGUMENTS.userid#" >;
SET @d=<cfqueryparam value="#ARGUMENTS.duedate#">;

WITH cte_accountingandconsulting AS(
SELECT[t].mc_id,mcs_id,c.client_id,mc_assignedto,mcs_assignedto,mc_duedate,client_group,count_mc_id=ROW_NUMBER()OVER(PARTITION BY t.mc_id ORDER BY t.mc_id),mc_esttime,mcs_esttime
FROM[client_listing]AS[c]
INNER JOIN [managementconsulting]as[t]ON t.client_id = c.client_id and t.deleted is null and(mc_status not in ('2','3') or mc_status is null)
LEFT JOIN [managementconsulting_subtask]as[s]ON t.mc_id = s.mc_id and s.deleted is null and (mcs_status not in ('2','3') or mcs_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_administrativetasks AS(
SELECT[t].as_id,c.client_id,as_assignedto,as_duedate,client_group,count_as_id=ROW_NUMBER()OVER(PARTITION BY t.as_id ORDER BY t.as_id),as_esttime
FROM[client_listing]AS[c]
INNER JOIN [administrativetasks]as[t]ON t.client_id = c.client_id and t.deleted is null and(as_status not in ('2','3') or as_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_businessformation AS(
SELECT[t].bf_id,bfs_id,c.client_id,bf_assignedto,bfs_assignedto,bf_duedate,client_group,count_bf_id=ROW_NUMBER()OVER(PARTITION BY t.bf_id ORDER BY t.bf_id),bf_esttime,bfs_estimatedtime
FROM[client_listing]AS[c]
INNER JOIN [businessformation]as[t]ON t.client_id = c.client_id and t.deleted is null and(bf_status not in ('2','3') or bf_status is null)
LEFT JOIN [businessformation_subtask]as[s]ON t.bf_id = s.bf_id and s.deleted is null and(bfs_status not in ('2','3') or bfs_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_communication AS(
SELECT[t].co_id,c.client_id,co_for,co_duedate,client_group,count_co_id=ROW_NUMBER()OVER(PARTITION BY t.co_id ORDER BY t.co_id)
FROM[client_listing]AS[c]
INNER JOIN [communications]as[t]ON t.client_id = c.client_id and t.deleted is null and(co_status not in ('2','3') or co_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_financialtaxplanning AS(
SELECT[t].ftp_id,c.client_id,ftp_assignedto,ftp_duedate,client_group,count_ftp_id=ROW_NUMBER()OVER(PARTITION BY t.ftp_id ORDER BY t.ftp_id),ftp_esttime
FROM[client_listing]AS[c]
INNER JOIN [financialtaxplanning]as[t]ON t.client_id = c.client_id and t.deleted is null and([ftp_status]not in('2','3')or[ftp_status]is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_financialstatements AS(
SELECT[t].fds_id,fdss_id,c.client_id,fds_assignedto,fdss_assignedto,fds_duedate,client_group,count_fds_id=ROW_NUMBER()OVER(PARTITION BY t.fds_id ORDER BY t.fds_id),fds_esttime,fdss_esttime
,fds_obtaininfo_assignedto,fds_sort_assignedto,fds_checks_assignedto,fds_sales_assignedto,fds_entry_assignedto,fds_reconcile_assignedto,fds_compile_assignedto,fds_review_assignedto,fds_assembly_assignedto,fds_delivery_assignedto,fds_acctrpt_assignedto
,fds_obtaininfo_esttime,fds_sort_esttime,fds_checks_esttime,fds_sales_esttime,fds_entry_esttime,fds_reconcile_esttime,fds_compile_esttime,fds_review_esttime,fds_assembly_esttime,fds_delivery_esttime,fds_acctrpt_esttime
,fds_obtaininfo_datecompleted,fds_sort_datecompleted,fds_checks_datecompleted,fds_sales_datecompleted,fds_entry_datecompleted,fds_reconcile_datecompleted,fds_compile_datecompleted,fds_review_datecompleted,fds_assembly_datecompleted,fds_delivery_datecompleted,fds_acctrpt_datecompleted,fdss_completed
FROM[client_listing]AS[c]
INNER JOIN [financialdatastatus]as[t]ON t.client_id = c.client_id and t.deleted is null and(fds_status not in ('2','3') or fds_status is null)
and([fds_delivery_datecompleted]IS NULL)
LEFT JOIN [financialdatastatus_subtask]as[s]ON t.fds_id = s.fds_id and s.deleted is null and(fdss_status not in ('2','3') or fdss_status is null)
WHERE([client_active]='1'and[c].[deleted]is null))


,cte_notices AS(
SELECT[t].n_id,nst_id,c.client_id,nst_assignedto,client_group,count_n_id=ROW_NUMBER()OVER(PARTITION BY t.n_id ORDER BY t.n_id),nst_esttime,nst_1_resduedate
,count_t_id=ROW_NUMBER()OVER(PARTITION BY s.nst_assignedto,t.n_id ORDER BY t.n_id)
FROM[client_listing]AS[c]
INNER JOIN [notice]as[t]ON t.client_id = c.client_id and t.deleted is null and(n_status not in ('2','3') or n_status is null) 
LEFT JOIN [notice_subtask]as[s]ON t.n_id = s.n_id and s.deleted is null and(nst_status not in ('2','3') or nst_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))



,cte_otherfilings AS(
SELECT[t].of_id,c.client_id,of_assignedto,of_duedate,client_group,count_of_id=ROW_NUMBER()OVER(PARTITION BY t.of_id ORDER BY t.of_id),of_esttime
,of_obtaininfo_assignedto,of_preparation_assignedto,of_review_assignedto,of_assembly_assignedto,of_delivery_assignedto
,of_obtaininfo_datecompleted,of_preparation_datecompleted,of_review_datecompleted,of_assembly_datecompleted,of_delivery_datecompleted
,of_obtaininfo_esttime,of_preparation_esttime,of_review_esttime,of_assembly_esttime,of_delivery_esttime
FROM[client_listing]AS[c]
INNER JOIN [otherfilings]as[t]ON t.client_id = c.client_id and t.deleted is null and(of_status not in ('2','3') or of_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))



,cte_payrollcheckstatus AS(
SELECT[t].pc_id,c.client_id,pc_assignedto,pc_duedate,client_group,count_pc_id=ROW_NUMBER()OVER(PARTITION BY t.pc_id ORDER BY t.pc_id),pc_esttime
,pc_delivery_assignedto,pc_obtaininfo_assignedto,pc_preparation_assignedto,pc_review_assignedto,pc_assembly_assignedto
,pc_delivery_datecompleted,pc_obtaininfo_datecompleted,pc_review_datecompleted,pc_assembly_datecompleted,pc_preparation_datecompleted
,pc_delivery_esttime,pc_obtaininfo_esttime,pc_preparation_esttime,pc_review_esttime,pc_assembly_esttime
FROM[client_listing]AS[c]
INNER JOIN [payrollcheckstatus]as[t]ON t.client_id = c.client_id and t.deleted is null and(pc_status not in ('2','3') or pc_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_payrolltaxes AS(
SELECT[t].pt_id,c.client_id,pt_assignedto,pt_duedate,client_group,count_pt_id=ROW_NUMBER()OVER(PARTITION BY t.pt_id ORDER BY t.pt_id),pt_esttime
,pt_obtaininfo_assignedto,pt_entry_assignedto,pt_rec_assignedto,pt_review_assignedto,pt_assembly_assignedto,pt_delivery_assignedto
,pt_obtaininfo_datecompleted,pt_entry_datecompleted,pt_rec_datecompleted,pt_review_datecompleted,pt_assembly_datecompleted,pt_delivery_datecompleted
,pt_obtaininfo_esttime,pt_entry_esttime,pt_rec_esttime,pt_review_esttime,pt_assembly_esttime,pt_delivery_esttime
,pt_review_completedby
FROM[client_listing]AS[c]
INNER JOIN [payrolltaxes]as[t]ON t.client_id = c.client_id and t.deleted is null and(pt_status not in ('2','3') or pt_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

,cte_taxreturns_personalproperty AS(
SELECT[t].tr_id,c.client_id,tr_4_assignedto,tr_3_delivered,tr_duedate,client_group,count_tr_id=ROW_NUMBER()OVER(PARTITION BY t.tr_id ORDER BY t.tr_id),tr_4_pptresttime
FROM[client_listing]AS[c]
INNER JOIN [taxreturns]as[t]ON t.client_id = c.client_id and t.deleted is null and(tr_4_required='TRUE') and (tr_4_status not in ('2','3') or tr_4_status is null)
WHERE([client_active]='1'and[c].[deleted]is null ))

, cte_taxreturns AS(
SELECT[t].tr_id,c.client_id,tr_notrequired,tr_2_reviewassignedto,tr_3_delivered,tr_2_readyforreview,tr_2_reviewedwithnotes,tr_2_assignedto,tr_duedate,client_group,count_tr_id=ROW_NUMBER()OVER(PARTITION BY t.tr_id ORDER BY t.tr_id),tr_esttime
FROM[client_listing]AS[c]
INNER JOIN [taxreturns]as[t]ON t.client_id = c.client_id and t.deleted is null and(tr_status not in ('2','3') or tr_status is null)and([tr_notrequired]!=(1))
WHERE([client_active]='1'and[c].[deleted]is null ))




SELECT 'Accounting and Consulting'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN mc_assignedto = @u and count_mc_id = 1 THEN ISNULL(mc_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN mc_assignedto = @u and count_mc_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum (CASE WHEN mcs_assignedto = @u THEN ISNULL(mcs_esttime,0) ELSE 0 END)
,count_subtask_assigned = count( CASE WHEN mcs_assignedto = @u THEN 1 ELSE NULL END)
<cfelse>
,total_time = sum (CASE WHEN  count_mc_id = 1 THEN ISNULL(mc_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_mc_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum ( ISNULL(mcs_esttime,0) )
,count_subtask_assigned = count( mcs_id  )
</cfif>
,'A'AS[orderit]
 FROM cte_accountingandconsulting
 WHERE (1)=(1)
<cfif ARGUMENTS.userid neq "0">AND((mc_assignedto = @u ) or ( mcs_assignedto = @u or (mc_assignedto = @u and mcs_assignedto is null)))</cfif>
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Administrative Tasks'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN as_assignedto LIKE '%'+ @u +'%'  and count_as_id = 1 THEN ISNULL(as_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN as_assignedto LIKE '%'+ @u +'%'  and count_as_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
<cfelse>
,total_time = sum (CASE WHEN  count_as_id = 1 THEN ISNULL(as_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_as_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
</cfif>
,'B'AS[orderit]
 FROM cte_administrativetasks
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([as_duedate]IS NULL OR[as_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](as_assignedto)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION

SELECT 'Business Formation'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN bf_assignedto = @u and count_bf_id = 1 THEN ISNULL(bf_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN bf_assignedto = @u and count_bf_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum (CASE WHEN bfs_assignedto = @u THEN ISNULL(bfs_estimatedtime,0) ELSE 0 END)
,count_subtask_assigned = count( CASE WHEN bfs_assignedto = @u THEN 1 ELSE NULL END)
<cfelse>
,total_time = sum (CASE WHEN  count_bf_id = 1 THEN ISNULL(bf_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_bf_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum (ISNULL(bfs_estimatedtime,0))
,count_subtask_assigned = count( bfs_id  )
</cfif>
,'C'AS[orderit]
 FROM cte_businessformation
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([bf_duedate]IS NULL OR[bf_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([bf_assignedto]=@u OR([bfs_assignedto]=@u OR[bfs_assignedto]IS NULL))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Communication'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time =0
,count_assigned = count( CASE WHEN co_for LIKE '%'+ @u +'%' and count_co_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
<cfelse>
,total_time = 0
,count_assigned = count( CASE WHEN  count_co_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
</cfif>
,'D'AS[orderit]
 FROM cte_communication
 WHERE (1)=(1)
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](co_for)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION

SELECT 'Financial & Tax Planning'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN ftp_assignedto = @u and count_ftp_id = 1 THEN ISNULL(ftp_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN ftp_assignedto = @u and count_ftp_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
<cfelse>
,total_time = sum (CASE WHEN  count_ftp_id = 1 THEN ISNULL(ftp_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_ftp_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
</cfif>
,'E'AS[orderit]
 FROM cte_financialtaxplanning
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL OR[ftp_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([ftp_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Financial Statements'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN fds_assignedto = @u and count_fds_id = 1 THEN fds_esttime ELSE 0 END)
,count_assigned = count( CASE WHEN fds_assignedto = @u and count_fds_id = 1 THEN 1 ELSE NULL END) 

,total_subtask_time = sum(CASE WHEN fdss_assignedto = @u  and fdss_id is not null  THEN ISNULL(fdss_esttime,0) ELSE 0 END
+ CASE WHEN fds_obtaininfo_assignedto=@u and count_fds_id = 1 AND[fds_obtaininfo_datecompleted]IS NULL THEN ISNULL(fds_obtaininfo_esttime,0)ELSE 0 END
+ CASE WHEN fds_sort_assignedto=@u and count_fds_id = 1 AND[fds_sort_datecompleted]IS NULL THEN ISNULL(fds_sort_esttime,0)ELSE 0 END
+ CASE WHEN fds_checks_assignedto=@u and count_fds_id = 1 AND[fds_checks_datecompleted]IS NULL THEN ISNULL(fds_checks_esttime,0)ELSE 0 END
+ CASE WHEN fds_sales_assignedto=@u and count_fds_id = 1 AND[fds_sales_datecompleted]IS NULL THEN ISNULL(fds_sales_esttime,0)ELSE 0 END
+ CASE WHEN fds_entry_assignedto=@u and count_fds_id = 1 AND[fds_entry_datecompleted]IS NULL THEN ISNULL(fds_entry_esttime,0)ELSE 0 END
+ CASE WHEN fds_reconcile_assignedto=@u and count_fds_id = 1 AND[fds_reconcile_datecompleted]IS NULL THEN ISNULL(fds_reconcile_esttime,0)ELSE 0 END
+ CASE WHEN fds_compile_assignedto=@u and count_fds_id = 1 AND[fds_compile_datecompleted]IS NULL THEN ISNULL(fds_compile_esttime,0)ELSE 0 END
+ CASE WHEN fds_review_assignedto=@u and count_fds_id = 1 AND[fds_review_datecompleted]IS NULL THEN ISNULL(fds_review_esttime,0)ELSE 0 END
+ CASE WHEN fds_assembly_assignedto=@u and count_fds_id = 1 AND[fds_assembly_datecompleted]IS NULL THEN ISNULL(fds_assembly_esttime,0)ELSE 0 END
+ CASE WHEN fds_delivery_assignedto=@u and count_fds_id = 1 AND[fds_delivery_datecompleted]IS NULL THEN ISNULL(fds_delivery_esttime,0)ELSE 0 END
+ CASE WHEN fds_acctrpt_assignedto=@u and count_fds_id = 1 AND[fds_acctrpt_datecompleted]IS NULL THEN ISNULL(fds_acctrpt_esttime,0)ELSE 0 END
)
,count_subtask_assigned = 
sum(CASE WHEN fdss_assignedto = @u  and fdss_id is not null  THEN 1 ELSE 0 END
+ CASE WHEN fds_obtaininfo_assignedto=@u and count_fds_id = 1 AND[fds_obtaininfo_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_sort_assignedto=@u and count_fds_id = 1 AND[fds_sort_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_checks_assignedto=@u and count_fds_id = 1 AND[fds_checks_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_sales_assignedto=@u and count_fds_id = 1 AND[fds_sales_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_entry_assignedto=@u and count_fds_id = 1 AND[fds_entry_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_reconcile_assignedto=@u and count_fds_id = 1 AND[fds_reconcile_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_compile_assignedto=@u and count_fds_id = 1 AND[fds_compile_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_review_assignedto=@u and count_fds_id = 1 AND[fds_review_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_assembly_assignedto=@u and count_fds_id = 1 AND[fds_assembly_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_delivery_assignedto=@u and count_fds_id = 1 AND[fds_delivery_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN fds_acctrpt_assignedto=@u and count_fds_id = 1 AND[fds_acctrpt_datecompleted]IS NULL THEN 1 ELSE 0 END
)



<cfelse>
,total_time = sum (CASE WHEN  count_fds_id = 1 THEN fds_esttime ELSE 0 END)
,count_assigned = count( CASE WHEN count_fds_id = 1 THEN 1 ELSE NULL END) 

,total_subtask_time = sum(CASE WHEN fdss_id is not null  THEN ISNULL(fdss_esttime,0) ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_obtaininfo_datecompleted]IS NULL THEN ISNULL(fds_obtaininfo_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_sort_datecompleted]IS NULL THEN ISNULL(fds_sort_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_checks_datecompleted]IS NULL THEN ISNULL(fds_checks_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_sales_datecompleted]IS NULL THEN ISNULL(fds_sales_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_entry_datecompleted]IS NULL THEN ISNULL(fds_entry_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_reconcile_datecompleted]IS NULL THEN ISNULL(fds_reconcile_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_compile_datecompleted]IS NULL THEN ISNULL(fds_compile_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_review_datecompleted]IS NULL THEN ISNULL(fds_review_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_assembly_datecompleted]IS NULL THEN ISNULL(fds_assembly_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_delivery_datecompleted]IS NULL THEN ISNULL(fds_delivery_esttime,0)ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_acctrpt_datecompleted]IS NULL THEN ISNULL(fds_acctrpt_esttime,0)ELSE 0 END
)
,count_subtask_assigned = 
sum(CASE WHEN fdss_id is not null THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_obtaininfo_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_sort_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_checks_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_sales_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_entry_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_reconcile_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_compile_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_review_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_assembly_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_delivery_datecompleted]IS NULL THEN 1 ELSE 0 END
+ CASE WHEN count_fds_id = 1 AND[fds_acctrpt_datecompleted]IS NULL THEN 1 ELSE 0 END
)
</cfif>
,'F'AS[orderit]
 FROM cte_financialstatements
 WHERE (1)=(1)AND[fds_delivery_datecompleted] IS NULL
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">

AND([fds_assignedto]=@u 
OR[fds_obtaininfo_assignedto] = @u 
OR[fds_sort_assignedto] = @u 
OR[fds_checks_assignedto] = @u  
OR[fds_sales_assignedto] = @u 
OR[fds_entry_assignedto] = @u 
OR[fds_reconcile_assignedto] = @u  
OR[fds_compile_assignedto]= @u 
OR[fds_review_assignedto] = @u 
OR[fds_assembly_assignedto] = @u 
OR[fds_delivery_assignedto] = @u 
OR[fdss_assignedto]=@u)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION

SELECT 'Notices'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = 0
,count_assigned = count( CASE WHEN nst_assignedto = @u and count_t_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum(CASE WHEN nst_assignedto = @u THEN ISNULL(nst_esttime,0) ELSE 0 END)
,count_subtask_assigned = count( CASE WHEN nst_assignedto = @u THEN 1 ELSE NULL END)
<cfelse>
,total_time = 0
,count_assigned = count( CASE WHEN  count_n_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = sum (ISNULL(nst_esttime,0)) 
,count_subtask_assigned = count( nst_id  )
</cfif>
,'G'AS[orderit]
 FROM cte_notices
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([nst_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Other Filings'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN of_assignedto = @u and count_of_id = 1 THEN of_esttime ELSE 0 END)
,count_assigned = count( CASE WHEN of_assignedto = @u and count_of_id = 1 THEN 1 ELSE NULL END)
,total_subtask_time = 
SUM( CASE WHEN ISNULL(of_obtaininfo_assignedto,0)=@u AND[of_obtaininfo_datecompleted]IS NULL THEN ISNULL([of_obtaininfo_esttime],0)ELSE 0 END
+CASE WHEN ISNULL(of_preparation_assignedto,0)=@u AND[of_preparation_datecompleted]IS NULL THEN ISNULL([of_preparation_esttime],0)ELSE 0 END
+CASE WHEN ISNULL(of_review_assignedto,0)=@u AND[of_review_datecompleted]IS NULL THEN ISNULL([of_review_esttime],0)ELSE 0 END
+CASE WHEN ISNULL(of_assembly_assignedto,0)=@u AND[of_assembly_datecompleted]IS NULL THEN ISNULL([of_assembly_esttime],0)ELSE 0 END
+CASE WHEN ISNULL(of_delivery_assignedto,0)=@u AND[of_delivery_datecompleted]IS NULL THEN ISNULL([of_delivery_esttime],0)ELSE 0 END)
,count_subtask_assigned = 
COUNT( CASE WHEN ISNULL(of_obtaininfo_assignedto,0)=@u AND[of_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN ISNULL(of_preparation_assignedto,0)=@u AND[of_preparation_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN ISNULL(of_review_assignedto,0)=@u AND[of_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN ISNULL(of_assembly_assignedto,0)=@u AND[of_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN ISNULL(of_delivery_assignedto,0)=@u AND[of_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END)
<cfelse>
,total_time = sum (CASE WHEN  count_of_id = 1 THEN of_esttime ELSE NULL END)
,count_assigned = count( CASE WHEN  count_of_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = SUM( CASE WHEN[of_obtaininfo_datecompleted]IS NULL THEN ISNULL([of_obtaininfo_esttime],0)ELSE 0 END
+CASE WHEN[of_preparation_datecompleted]IS NULL THEN ISNULL([of_preparation_esttime],0)ELSE 0 END
+CASE WHEN[of_review_datecompleted]IS NULL THEN ISNULL([of_review_esttime],0)ELSE 0 END
+CASE WHEN[of_assembly_datecompleted]IS NULL THEN ISNULL([of_assembly_esttime],0)ELSE 0 END
+CASE WHEN[of_delivery_datecompleted]IS NULL THEN ISNULL([of_delivery_esttime],0)ELSE 0 END)
,count_subtask_assigned = 
COUNT(CASE WHEN[of_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN[of_preparation_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN[of_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN[of_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN[of_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END)
</cfif>
,'H'AS[orderit]
 FROM cte_otherfilings
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND((of_assignedto=@u)
OR([of_obtaininfo_assignedto]=@u AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=@u AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=@u AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=@u AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=@u AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Payroll Checks'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN pc_assignedto = @u and count_pc_id = 1 THEN isnull(pc_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN pc_assignedto = @u and count_pc_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = SUM(CASE WHEN pc_delivery_assignedto=@u AND [pc_delivery_datecompleted]IS NULL THEN ISNULL(pc_delivery_esttime,0)ELSE 0 END
+CASE WHEN pc_obtaininfo_assignedto=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN ISNULL(pc_obtaininfo_esttime,0)ELSE 0 END
+CASE WHEN pc_preparation_assignedto=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN ISNULL(pc_preparation_esttime,0)ELSE 0 END
+CASE WHEN pc_review_assignedto=@u AND[pc_review_datecompleted]IS NULL THEN ISNULL(pc_review_esttime,0)ELSE 0 END
+CASE WHEN pc_assembly_assignedto=@u AND[pc_assembly_datecompleted]IS NULL THEN ISNULL(pc_assembly_esttime,0)ELSE 0 END)

,count_subtask_assigned = COUNT(CASE WHEN pc_delivery_assignedto=@u AND[pc_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END) 
+COUNT(CASE WHEN pc_obtaininfo_assignedto=@u AND[pc_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pc_preparation_assignedto=@u AND[pc_preparation_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pc_review_assignedto=@u AND[pc_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pc_assembly_assignedto=@u AND[pc_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
<cfelse>
,total_time = sum (CASE WHEN  count_pc_id = 1 THEN isnull(pc_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_pc_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = SUM(CASE WHEN [pc_delivery_datecompleted]IS NULL THEN ISNULL(pc_delivery_esttime,0)ELSE 0 END
+CASE WHEN [pc_obtaininfo_datecompleted]IS NULL THEN ISNULL(pc_obtaininfo_esttime,0) ELSE 0 END
+CASE WHEN [pc_preparation_datecompleted]IS NULL THEN ISNULL(pc_preparation_esttime,0)ELSE 0 END
+CASE WHEN [pc_review_datecompleted]IS NULL THEN ISNULL(pc_review_esttime,0)ELSE 0 END
+CASE WHEN [pc_assembly_datecompleted]IS NULL THEN ISNULL(pc_assembly_esttime,0)ELSE 0 END)

,count_subtask_assigned = COUNT( CASE WHEN [pc_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END) 
+COUNT( CASE WHEN [pc_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT( CASE WHEN [pc_preparation_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT( CASE WHEN [pc_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT( CASE WHEN [pc_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
</cfif>
,'I'AS[orderit]
 FROM cte_payrollcheckstatus
 WHERE (1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL OR[pc_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
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

SELECT 'Payroll Taxes'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN pt_assignedto = @u and count_pt_id = 1 THEN isnull(pt_esttime,0) ELSE NULL END)
,count_assigned = count( CASE WHEN pt_assignedto = @u and count_pt_id = 1 THEN 1 ELSE NULL END)
,total_subtask_time =
SUM(CASE WHEN ISNULL(pt_obtaininfo_assignedto,0)=@u AND [pt_obtaininfo_datecompleted]IS NULL THEN ISNULL(pt_obtaininfo_esttime,0)ELSE 0 END
+CASE WHEN ISNULL(pt_entry_assignedto,0)=@u AND[pt_entry_datecompleted]IS NULL THEN ISNULL(pt_entry_esttime,0)ELSE 0 END
+CASE WHEN ISNULL(pt_rec_assignedto,0)=@u AND[pt_rec_datecompleted]IS NULL THEN ISNULL(pt_rec_esttime,0)ELSE 0 END
+CASE WHEN ISNULL(pt_review_assignedto,0)=@u AND[pt_review_datecompleted]IS NULL THEN ISNULL(pt_review_esttime,0)ELSE 0 END
+CASE WHEN ISNULL(pt_assembly_assignedto,0)=@u AND[pt_assembly_datecompleted]IS NULL THEN ISNULL(pt_assembly_esttime,0)ELSE 0 END
+CASE WHEN ISNULL(pt_delivery_assignedto,0)=@u AND[pt_delivery_datecompleted]IS NULL THEN ISNULL(pt_delivery_esttime,0)ELSE 0 END)
,count_subtask_assigned =
COUNT(CASE WHEN pt_obtaininfo_assignedto=@u AND[pt_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END) 
+COUNT(CASE WHEN pt_entry_assignedto=@u AND[pt_entry_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pt_rec_assignedto=@u AND[pt_rec_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pt_review_assignedto=@u AND[pt_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pt_assembly_assignedto=@u AND[pt_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN pt_delivery_assignedto=@u AND[pt_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END)
<cfelse>
,total_time = sum (CASE WHEN  count_pt_id = 1 THEN isnull(pt_esttime,0) ELSE NULL END)
,count_assigned = count( CASE WHEN  count_pt_id = 1 THEN 1 ELSE NULL END)
,total_subtask_time =
SUM(CASE WHEN [pt_obtaininfo_datecompleted]IS NULL THEN ISNULL(pt_obtaininfo_esttime,0)ELSE 0 END
+CASE WHEN [pt_entry_datecompleted]IS NULL THEN  ISNULL(pt_entry_esttime,0)ELSE 0 END
+CASE WHEN [pt_rec_datecompleted]IS NULL THEN  ISNULL(pt_rec_esttime,0)ELSE 0 END
+CASE WHEN [pt_review_datecompleted]IS NULL THEN  ISNULL(pt_review_esttime,0)ELSE 0 END
+CASE WHEN [pt_assembly_datecompleted]IS NULL THEN  ISNULL(pt_assembly_esttime,0)ELSE 0 END
+CASE WHEN [pt_delivery_datecompleted]IS NULL THEN  ISNULL(pt_delivery_esttime,0)ELSE 0 END)
,count_subtask_assigned = 
COUNT(CASE WHEN [pt_obtaininfo_datecompleted]IS NULL THEN 1 ELSE NULL END) 
+COUNT(CASE WHEN [pt_entry_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN [pt_rec_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN [pt_review_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN [pt_assembly_datecompleted]IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN [pt_delivery_datecompleted]IS NULL THEN 1 ELSE NULL END)
</cfif>
,'J'AS[orderit]
 FROM cte_payrolltaxes
 WHERE(1)=(1)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL OR[pt_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND((pt_assignedto=@u)
OR(pt_obtaininfo_assignedto=@u AND[pt_obtaininfo_datecompleted]IS NULL)
OR(pt_entry_assignedto=@u AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR(pt_rec_assignedto=@u AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR(pt_review_assignedto=@u AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR(pt_assembly_assignedto=@u AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR(pt_delivery_assignedto=@u AND[pt_assembly_datecompleted]IS NOT NULL))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Personal Property Tax Returns'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN tr_4_assignedto  = @u and count_tr_id = 1 THEN ISNULL(tr_4_pptresttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN tr_4_assignedto  = @u and count_tr_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
<cfelse>
,total_time = sum (CASE WHEN  count_tr_id = 1 THEN ISNULL(tr_4_pptresttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_tr_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
</cfif>
,'K'AS[orderit]
 FROM cte_taxreturns_personalproperty
 WHERE (1)=(1)
<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_4_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

UNION 

SELECT 'Tax Returns'AS[name]
<cfif ARGUMENTS.userid neq "0">
,total_time = sum (CASE WHEN tr_2_assignedto = @u and count_tr_id = 1 THEN ISNULL(tr_esttime,0) ELSE 0 END)

,count_assigned = 
COUNT(CASE WHEN count_tr_id = 1  AND tr_2_assignedto=@u AND [tr_2_readyforreview] IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN count_tr_id = 1 AND tr_2_reviewassignedto=@u AND [tr_2_reviewedwithnotes] IS NULL THEN 1 ELSE NULL END)
+COUNT(CASE WHEN count_tr_id = 1 AND tr_2_assignedto=@u AND [tr_2_reviewedwithnotes] IS NOT NULL THEN 1 ELSE NULL END)

,total_subtask_time = 0
,count_subtask_assigned = 0
<cfelse>


,total_time = sum (CASE WHEN  count_tr_id = 1 THEN ISNULL(tr_esttime,0) ELSE 0 END)
,count_assigned = count( CASE WHEN  count_tr_id = 1 THEN 1 ELSE NULL END) 
,total_subtask_time = 0
,count_subtask_assigned = 0
</cfif>

,'L'AS[orderit]
 FROM cte_taxreturns
 WHERE (1)=(1)
AND([tr_notrequired]!=(1))
<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL OR[tr_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(ISNULL(tr_2_assignedto,0)=@u OR ISNULL(tr_2_reviewassignedto,0)=@u)</cfif>
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

   <cfcatch>
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
,[mc_requestforservice]=FORMAT(mc_requestforservice,'#Session.localization.formatdate#') 
,[mc_projectcompleted]=FORMAT(mc_projectcompleted,'#Session.localization.formatdate#') 
,[mc_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mc_status]=[optionvalue_id])
,[mc_priority]
,[mc_assignedtoTEXT]
,[mc_duedateORDERBY]=convert(datetime, mc_duedate, 101)
,[mc_duedate]=FORMAT(mc_duedate,'#Session.localization.formatdate#') 
,[mc_esttime]
,[mc_category]
,[mc_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='2'OR[form_id]='0')AND([optionGroup]='2'OR[optionGroup]='0')AND[selectName]='global_consultingcategory'AND[mc_category]=[optionvalue_id])
,CASE WHEN LEN([mc_description]) >= 101 THEN SUBSTRING([mc_description],0,100) +  '...' ELSE [mc_description] END AS[mc_description]
FROM[v_managementconsulting_subtask]
WHERE[deleted] IS NULL AND[client_active]=(1) AND([mc_status]NOT IN('2','3')OR[mc_status]IS NULL)AND([mcs_status]NOT IN('2','3')OR[mcs_status]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([mc_assignedto]=@u OR[mcs_assignedto]=@u  )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

ORDER BY([mc_duedateORDERBY])ASC
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
,[mcs_duedate]=FORMAT(mc_duedate,'#Session.localization.formatdate#') 
,[mcs_sequence]
,[mcs_completed]
,[mcs_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[mcs_status]=[optionvalue_id])
,[mcs_subtaskTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_acctsubtasks'AND[mcs_subtask]=[optionvalue_id])
FROM[v_managementconsulting_subtask]
WHERE
([client_active]=(1)
AND [deleted] IS NULL
AND[mc_id]=<cfqueryparam value="#ARGUMENTS.id#">
AND([mcs_status]NOT IN('2','3')OR([mcs_status]IS NULL))
AND[mcs_id]is not null)
<cfif ARGUMENTS.duedate neq "">AND([mc_duedate]IS NULL OR[mc_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([mc_assignedto]=@u OR[mcs_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([mcs_sequence])ASC
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
SELECT [as_id]
,[client_id]
,[client_name]
,[as_duedateORDERBY]=convert(datetime, as_duedate, 101)
,[as_duedate]=FORMAT(as_duedate,'#Session.localization.formatdate#') 
,[as_assignedto]
,[as_category]
,[as_datereqested]=FORMAT(as_datereqested,'#Session.localization.formatdate#') 
,CASE WHEN LEN([as_taskdesc]) >= 101 THEN SUBSTRING([as_taskdesc],0,100) +  '...' ELSE [as_taskdesc] END AS[as_taskdesc]
,[as_status]
,[as_assignedtoTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](as_assignedto)))FOR XML PATH('')),3,1000)
,[as_categoryTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_admintaskcategory'AND[as_category]=[optionvalue_id])
,[as_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[as_status]=[optionvalue_id])
FROM[v_administrativetasks]
WHERE [client_active]=(1)
AND [deleted] IS NULL
AND ([as_status]NOT IN('2','3')OR([as_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([as_duedate]IS NULL OR[as_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](as_assignedto)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([as_duedateORDERBY])ASC
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"AS_ID":"'&AS_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"AS_CATEGORYTEXT":"'&AS_CATEGORYTEXT&'"
								,"AS_TASKDESC":"'&AS_TASKDESC&'"
								,"AS_DUEDATE":"'&AS_DUEDATE&'"
								,"AS_STATUSTEXT":"'&AS_STATUSTEXT&'"
								,"AS_ASSIGNEDTOTEXT":"'&AS_ASSIGNEDTOTEXT&'"
								,"AS_DATEREQESTED":"'&AS_DATEREQESTED&'"	
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
,[bf_duedateORDERBY]=convert(datetime, bf_duedate, 101)
,[bf_duedate]=FORMAT(bf_duedate,'#Session.localization.formatdate#') 
,[bf_businesstypeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_businesstype'AND[bf_businesstype]=[optionvalue_id])
,[bf_assignedtoTEXT]=(SELECT TOP (1)[si_initials]FROM[v_staffinitials]WHERE(bf_assignedto = user_id)) 
,[bf_activity]
,[bf_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[bf_status]=[optionvalue_id])
,[bf_missinginforeceived]=FORMAT(bf_missinginforeceived,'#Session.localization.formatdate#') 
,[bf_missinginfo]
FROM[v_businessformation_subtask]
WHERE[client_active]=(1)AND(([bf_status]NOT IN('2','3')OR([bf_status]IS NULL))AND([bfs_status]NOT IN('2','3')OR([bfs_status]IS NULL)))
<cfif ARGUMENTS.duedate neq "">AND([bf_duedate]IS NULL OR[bf_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([bf_assignedto]=@u OR[bfs_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([bf_duedateORDERBY])ASC
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
,[bfs_assignedtoTEXT]=SUBSTRING((SELECT', '+[si_initials]FROM[v_staffinitials]WHERE(CAST([user_id]AS nvarchar(10))IN(SELECT[id]FROM[CSVToTable](bfs_assignedto)))FOR XML PATH('')),3,1000)
,[bfs_dateinitiated]=FORMAT(bfs_dateinitiated,'#Session.localization.formatdate#')
,[bfs_datecompleted]=FORMAT(bfs_datecompleted,'#Session.localization.formatdate#')
,[bfs_estimatedtime]
FROM[v_businessformation_subtask]
WHERE[client_active]=(1)
AND [deleted] IS NULL
AND([bf_status]NOT IN('2','3')OR([bf_status]IS NULL))
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
,[co_duedateORDERBY]=convert(datetime, co_duedate, 101)
,[co_duedate]=FORMAT(co_duedate,'#Session.localization.formatdate#')
,[co_date]=FORMAT(co_date,'#Session.localization.formatdatetime#','#Session.localization.language#')
,[co_status]
,[co_responseneeded]
,[co_returncall]
,[client_name]
,[client_id]
,[co_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[co_status]=[optionvalue_id])
FROM[v_communications]
WHERE [client_active]=(1)
AND [deleted] IS NULL
AND ([co_status]NOT IN('2','3')OR([co_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([co_duedate]IS NULL OR[co_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND(@u IN(SELECT[id]FROM[CSVToTable](co_for)))</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([co_duedateORDERBY])ASC
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
,[ftp_duedateORDERBY]=convert(datetime, ftp_duedate, 101)
,[ftp_duedate]=FORMAT(ftp_duedate,'#Session.localization.formatdate#')
,[ftp_requestservice]=FORMAT(ftp_requestservice,'#Session.localization.formatdate#')
,[ftp_missinginfo]
,[client_name]
,[client_id]
,[ftp_description]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_financialcategory'AND[ftp_category]=[optionvalue_id])AS[ftp_categoryTEXT]
,(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[ftp_status]=[optionvalue_id])AS[ftp_statusTEXT]
FROM[v_financialtaxplanning]
WHERE [client_active]=(1)
AND [deleted] IS NULL
AND ([ftp_status]NOT IN('2','3')OR([ftp_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([ftp_duedate]IS NULL OR[ftp_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([ftp_assignedto]=@u )</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

ORDER BY([ftp_duedateORDERBY])ASC
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
,[fds_periodend]=FORMAT(fds_periodend,'#Session.localization.formatdate#') 
,[fds_month]
,[fds_year]
,[fds_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[fds_month]=[optionvalue_id])
,[fds_duedateORDERBY]=convert(datetime, fds_duedate, 101)
,[fds_duedate]=FORMAT(fds_duedate,'#Session.localization.formatdate#') 
,[fds_status]
,[fds_missinginfo]
,[fds_compilemi]
,[fds_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fds_status]=[optionvalue_id])
,[fds_obtaininfo_datecompleted]=ISNULL(FORMAT(fds_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_obtaininfo_assignedtoTEXT]
,[fds_sort_datecompleted]=ISNULL(FORMAT(fds_sort_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_sort_assignedtoTEXT]
,[fds_checks_datecompleted]=ISNULL(FORMAT(fds_checks_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_checks_assignedtoTEXT]
,[fds_sales_datecompleted]=ISNULL(FORMAT(fds_sales_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_sales_assignedtoTEXT]
,[fds_entry_datecompleted]=ISNULL(FORMAT(fds_entry_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_entry_assignedtoTEXT]
,[fds_reconcile_datecompleted]=ISNULL(FORMAT(fds_reconcile_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_reconcile_assignedtoTEXT]
,[fds_compile_datecompleted]=ISNULL(FORMAT(fds_compile_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_compile_assignedtoTEXT]
,[fds_review_datecompleted]=ISNULL(FORMAT(fds_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_review_assignedtoTEXT]
,[fds_assembly_datecompleted]=ISNULL(FORMAT(fds_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_assembly_assignedtoTEXT]
,[fds_delivery_datecompleted]=ISNULL(FORMAT(fds_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_delivery_assignedtoTEXT]
,[fds_acctrpt_datecompleted]=ISNULL(FORMAT(fds_acctrpt_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[fds_acctrpt_assignedtoTEXT]
FROM[v_financialDataStatus_subtask]


 WHERE 
 [client_active]=(1)
 AND[fds_delivery_datecompleted] IS NULL 
 AND [deleted] IS NULL
 AND ([fds_status]NOT IN('2','3')OR([fds_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">

AND(
	[fds_assignedto]=@u 
OR[fds_obtaininfo_assignedto] = @u 
OR[fds_sort_assignedto] = @u 
OR[fds_checks_assignedto] = @u  
OR[fds_sales_assignedto] = @u 
OR[fds_entry_assignedto] = @u 
OR[fds_reconcile_assignedto] = @u  
OR[fds_compile_assignedto]= @u 
OR[fds_review_assignedto] = @u 
OR[fds_assembly_assignedto] = @u 
OR[fds_delivery_assignedto] = @u 
OR[fdss_assignedto]=@u
)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>



ORDER BY([fds_duedateORDERBY]) ASC
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
								,"FDS_COMPILEMI":"'&FDS_COMPILEMI&'"
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
,[fdss_duedate]=FORMAT(fdss_duedate,'#Session.localization.formatdate#')
,[fdss_sequence]
,[fdss_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[fdss_status]=[optionvalue_id])
,[fdss_subtask]
,[fdss_completed]=FORMAT(fdss_completed,'#Session.localization.formatdate#') 
FROM[v_financialDataStatus_Subtask]
WHERE[client_active]=(1)
AND [deleted] IS NULL
AND([fds_status]NOT IN('2','3')OR([fds_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([fds_duedate]IS NULL OR[fds_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0"></cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
AND[fds_id]=@id
ORDER BY([fdss_sequence]) ASC
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
,[nst_1_resduedateORDERBY]=convert(datetime, nst_1_resduedate, 101)
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE [client_active]=(1)
AND [deleted] IS NULL
AND ([n_status]NOT IN('2','3')OR([n_status]IS NULL))
AND([nst_status]NOT IN('2','3')OR([nst_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([nst_assignedto]=@u)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([nst_1_resduedateORDERBY])ASC
</cfquery>
<cfset myResult="">
<cfset queryResult="">
<cfset queryIndex=0>
<cfloop query="fquery">
<cfset queryIndex=queryIndex+1>
<cfset queryResult=queryResult&'{"N_ID":"'&N_ID&'"
								,"CLIENT_ID":"'&CLIENT_ID&'"
								,"CLIENT_NAME":"'&CLIENT_NAME&'"
								,"N_NAME":"'&N_NAME&'"
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
SELECT[n_id]
,[nst_id]
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
,[nst_1_resduedateORDERBY]=convert(datetime, nst_1_resduedate, 101)
,[nst_1_resduedate]=FORMAT(nst_1_resduedate,'#Session.localization.formatdate#')
,[n_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[n_status]=[optionvalue_id])
,[nst_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[nst_status]=[optionvalue_id])
FROM[v_notice_subtask]
WHERE[client_active]=(1)
AND [deleted] IS NULL
AND ([nst_status]NOT IN('2','3')OR([nst_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([nst_1_resduedate]IS NULL OR[nst_1_resduedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">AND([nst_assignedto]=@u  OR[nst_assignedto]=0)</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
AND[n_id]=@id
ORDER BY([nst_1_resduedateORDERBY])ASC
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
,[of_duedateORDERBY]=convert(datetime, of_duedate, 101)
,[of_duedate]=FORMAT(of_duedate,'#Session.localization.formatdate#') 
,[of_missinginfo]
,[of_missinginforeceived]=FORMAT(of_missinginforeceived,'#Session.localization.formatdate#') 
,[of_filingdeadline]=FORMAT(of_filingdeadline,'#Session.localization.formatdate#') 
,[client_name]
,[client_id]
,[of_obtaininfo_datecompleted]=ISNULL(FORMAT(of_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_obtaininfo_assignedtoTEXT]
,[of_preparation_datecompleted]=ISNULL(FORMAT(of_preparation_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_preparation_assignedtoTEXT]
,[of_review_datecompleted]=ISNULL(FORMAT(of_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_review_assignedtoTEXT]
,[of_assembly_datecompleted]=ISNULL(FORMAT(of_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_assembly_assignedtoTEXT]
,[of_delivery_datecompleted]=ISNULL(FORMAT(of_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[of_delivery_assignedtoTEXT] 
,[of_statusTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_status'AND[of_status]=[optionvalue_id])
,[of_formTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[of_form]=[optionvalue_id])
,[of_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_otherfilingtype'AND[of_type]=[optionvalue_id])
,[of_stateTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_state'AND[of_state]=[optionvalue_id])
FROM[v_otherfilings]
WHERE [client_active]=(1)
AND [deleted] IS NULL
AND ([of_status]NOT IN('2','3')OR([of_status]IS NULL))
<cfif ARGUMENTS.duedate neq "">AND([of_duedate]IS NULL OR[of_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">

AND[of_assignedto]=@u
OR([of_obtaininfo_assignedto]=@u  AND[of_obtaininfo_datecompleted]IS NULL)
OR([of_preparation_assignedto]=@u  AND[of_obtaininfo_datecompleted]IS NOT NULL AND[of_preparation_datecompleted]IS NULL)
OR([of_review_assignedto]=@u  AND[of_preparation_datecompleted]IS NOT NULL AND[of_review_datecompleted]IS NULL)
OR([of_assembly_assignedto]=@u  AND[of_review_datecompleted]IS NOT NULL AND[of_assembly_datecompleted]IS NULL)
OR([of_delivery_assignedto]=@u  AND[of_assembly_datecompleted]IS NOT NULL AND[of_delivery_datecompleted]IS NULL)
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([of_duedateORDERBY])ASC
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
,[pc_duedateORDERBY]=convert(datetime, pc_duedate, 101)
,[pc_duedate]=FORMAT(pc_duedate,'#Session.localization.formatdate#') 
,[pc_missinginfo]
,[pc_payenddate]=FORMAT(pc_payenddate,'#Session.localization.formatdate#') 
,[pc_paydate]=FORMAT(pc_paydate,'#Session.localization.formatdate#') 
,[pc_obtaininfo_datecompleted]=ISNULL(FORMAT(pc_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_obtaininfo_assignedtoTEXT]
,[pc_preparation_datecompleted]=ISNULL(FORMAT(pc_preparation_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_preparation_assignedtoTEXT]
,[pc_review_datecompleted]=ISNULL(FORMAT(pc_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_review_assignedtoTEXT]
,[pc_assembly_datecompleted]=ISNULL(FORMAT(pc_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_assembly_assignedtoTEXT]
,[pc_delivery_datecompleted]=ISNULL(FORMAT(pc_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pc_delivery_assignedtoTEXT]
,[client_name]
,[client_id]
FROM[v_payrollcheckstatus]

 WHERE [client_active]='1' AND (pc_status not in ('2','3') or pc_status is null)
<cfif ARGUMENTS.duedate neq "">AND([pc_duedate]IS NULL OR[pc_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND
([pc_delivery_datecompleted]IS NULL AND[pc_assignedto]=@u
OR([pc_obtaininfo_datecompleted]IS NULL AND[pc_obtaininfo_assignedto]=@u)
OR([pc_obtaininfo_datecompleted]IS NOT NULL AND[pc_preparation_datecompleted]IS NULL AND[pc_preparation_assignedto]=@u)
OR([pc_preparation_datecompleted]IS NOT NULL AND[pc_review_datecompleted]IS NULL AND[pc_review_assignedto]=@u)
OR([pc_review_datecompleted]IS NOT NULL AND[pc_assembly_datecompleted]IS NULL AND[pc_assembly_assignedto]=@u)
OR([pc_assembly_datecompleted]IS NOT NULL AND[pc_delivery_assignedto]=@u))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

ORDER BY([pc_duedateORDERBY])ASC
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
,[pt_duedateORDERBY]=convert(datetime, pt_duedate, 101)
,[pt_duedate]=FORMAT(pt_duedate,'#Session.localization.formatdate#') 
,[pt_monthTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_month'AND[pt_month]=[optionvalue_id])
,[pt_lastpay]=FORMAT(pt_lastpay,'#Session.localization.formatdate#') 
,[pt_typeTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_returntypes'AND[pt_type]=[optionvalue_id])
,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#') 
,[pt_obtaininfo_datecompleted]=ISNULL(FORMAT(pt_obtaininfo_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_obtaininfo_assignedtoTEXT]
,[pt_entry_datecompleted]=ISNULL(FORMAT(pt_entry_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_entry_assignedtoTEXT]
,[pt_rec_datecompleted]=ISNULL(FORMAT(pt_rec_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_rec_assignedtoTEXT]
,[pt_review_datecompleted]=ISNULL(FORMAT(pt_review_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_review_assignedtoTEXT]
,[pt_assembly_datecompleted]=ISNULL(FORMAT(pt_assembly_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_assembly_assignedtoTEXT]
,[pt_delivery_datecompleted]=ISNULL(FORMAT(pt_delivery_datecompleted,'#Session.localization.formatdate#'),'N/A')
,[pt_delivery_assignedtoTEXT]
,[pt_missinginforeceived]=FORMAT(pt_missinginforeceived,'#Session.localization.formatdate#')
,[pt_missinginfo]
,[client_name]
,[client_id]
FROM[v_payrolltaxes]
WHERE [client_active]=(1) and  (pt_status not in ('2','3') or pt_status is null)
AND [deleted] IS NULL
AND ([pt_delivery_datecompleted]IS NULL)
<cfif ARGUMENTS.duedate neq "">AND([pt_duedate]IS NULL OR[pt_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">

AND((pt_assignedto=@u)
OR(pt_obtaininfo_assignedto=@u AND[pt_obtaininfo_datecompleted]IS NULL)
OR(pt_entry_assignedto=@u AND[pt_obtaininfo_datecompleted]IS NOT NULL AND[pt_entry_datecompleted]IS NULL)
OR(pt_rec_assignedto=@u AND[pt_entry_datecompleted]IS NOT NULL AND[pt_rec_datecompleted]IS NULL)
OR(pt_review_assignedto=@u AND[pt_rec_datecompleted]IS NOT NULL AND[pt_review_completedby]IS NULL)
OR(pt_assembly_assignedto=@u AND[pt_review_completedby]IS NOT NULL AND[pt_assembly_datecompleted]IS NULL)
OR(pt_delivery_assignedto=@u AND[pt_assembly_datecompleted]IS NOT NULL))

</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c )</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>
ORDER BY([pt_duedateORDERBY])ASC
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


<!--- LOOKUP Personal Property TAX RETURNS --->
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
,[tr_4_extended]=FORMAT(tr_4_extended,'#Session.localization.formatdate#') 
,[tr_4_completed]=FORMAT(tr_4_completed,'#Session.localization.formatdate#') 
,[tr_taxyear]
,[tr_taxformTEXT]=(SELECT TOP(1)[optionname]FROM[v_selectOptions]WHERE([form_id]='#ARGUMENTS.formid#'OR[form_id]='0')AND([optionGroup]='#ARGUMENTS.formid#'OR[optionGroup]='0')AND[selectName]='global_taxservices'AND[tr_taxform]=[optionvalue_id])
,[tr_priority]
,[tr_4_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_4_assignedto=user_id))
,[tr_4_pptresttime]
,[tr_4_rfr]=FORMAT(tr_4_rfr,'#Session.localization.formatdate#') 
,[tr_4_delivered]=FORMAT(tr_4_delivered,'#Session.localization.formatdate#') 
,[tr_duedateORDERBY]=convert(datetime, tr_duedate, 101)
FROM[v_taxreturns]
WHERE
  (tr_4_status not in ('2','3') or tr_4_status is null) and [client_active]=(1) AND[tr_4_required]='TRUE' AND [deleted] IS NULL

<cfif ARGUMENTS.search neq "">AND[client_name]LIKE <cfqueryparam value="#ARGUMENTS.search#%"/></cfif>
<cfif ARGUMENTS.userid neq "0">AND[tr_4_assignedto]=@u</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

ORDER BY([tr_duedateORDERBY])ASC
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
								,"TR_TAXFORMTEXT":"'&TR_TAXFORMTEXT&'"
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
,[tr_duedateORDERBY]=convert(datetime, tr_duedate, 101)
,[tr_duedate]=FORMAT(tr_duedate,'#Session.localization.formatdate#') 
,[tr_missinginfo]
,[tr_2_informationreceived]=FORMAT(tr_2_informationreceived,'#Session.localization.formatdate#') 
,[tr_2_assignedto]
,[tr_2_assignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_2_assignedto=user_id))
,[client_name]
,[client_id]
,[tr_missinginforeceived]=FORMAT(tr_missinginforeceived,'#Session.localization.formatdate#') 
,[tr_2_readyforreview]=FORMAT(tr_2_readyforreview,'#Session.localization.formatdate#') 
,[tr_2_reviewassignedtoTEXT]=(SELECT TOP(1)[si_initials]FROM[v_staffinitials]WHERE(tr_2_reviewassignedto=user_id))
,[tr_2_reviewed]=FORMAT(tr_2_reviewed,'#Session.localization.formatdate#') 
,[tr_2_completed]=FORMAT(tr_2_completed,'#Session.localization.formatdate#') 
,[tr_3_assemblereturn]=FORMAT(tr_3_assemblereturn,'#Session.localization.formatdate#') 
,[tr_3_delivered]=FORMAT(tr_3_delivered,'#Session.localization.formatdate#') 
,[tr_2_reviewedwithnotes]=FORMAT(tr_2_reviewedwithnotes,'#Session.localization.formatdate#') 
FROM[v_taxreturns]
WHERE[client_active]=(1)
AND[tr_notrequired]!=(1)
AND [deleted] IS NULL
AND ([tr_status]NOT IN('2','3')OR([tr_status]IS NULL))

<cfif ARGUMENTS.duedate neq "">AND([tr_duedate]IS NULL OR[tr_duedate]BETWEEN '1/1/1900' AND @d)</cfif>
<cfif ARGUMENTS.userid neq "0">
AND((ISNULL(tr_2_assignedto,0)=@u AND[tr_2_readyforreview]IS NULL)
OR(ISNULL(tr_2_reviewassignedto,0)=@u AND[tr_2_reviewedwithnotes]IS NULL)
OR(ISNULL(tr_2_assignedto,0)=@u AND[tr_2_reviewedwithnotes]IS NOT NULL ))
</cfif>
<cfif ARGUMENTS.clientid neq "0">AND([client_id]=@c)</cfif>
<cfif ARGUMENTS.group neq "0">AND(@g IN([client_group]))</cfif>

ORDER BY([tr_duedateORDERBY])ASC
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