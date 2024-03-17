<cfset stateFunctions = createObject("stateInfo") />
<cfset session.clear() />

<cfif !session.keyExists("user")>
    <cfset session["user"] = stateFunctions.obtainUser() />
</cfif>

<cfif form.keyExists("firstname")>
    <cfset newAccountResult = stateFunctions.processNewAccount(form) />
    <cfif newAccountResult.success>
        <cfset accountMessage = newAccountResult.message />
</cfif>