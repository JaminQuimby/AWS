<cfcomponent output="true">
	<cffunction name="myFun" access="remote"  returntype="string" returnformat="plain">
		<cfargument name="myArgument" type="string" required="no">
        	<cfargument name="loadType" type="string" required="no">
        <cfif ARGUMENTS.loadType eq true>
        
		<cfset myResult='{
 "Result":"OK",
 "Records":[
  {"PersonId":1,"Name":"Benjamin Button","Age":17,"RecordDate":"\/Date(1320259705710)\/"},
  {"PersonId":2,"Name":"Douglas Adams","Age":42,"RecordDate":"\/Date(1320259705710)\/"},
  {"PersonId":3,"Name":"Isaac Asimov","Age":26,"RecordDate":"\/Date(1320259705710)\/"},
  {"PersonId":4,"Name":"Thomas More","Age":65,"RecordDate":"\/Date(1320259705710)\/"}
 ]
}'>
		<cfreturn myResult>
	</cfif>
    </cffunction>
</cfcomponent>