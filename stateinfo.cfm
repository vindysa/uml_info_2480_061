<cfset stateFunctions = createObject("stateInfo") />
<cfset session.clear() />

<cfif !session.keyExists("user")>
    <cfset session["user"] = stateFunctions.obtainUser() />
</cfif>

<cfif form.keyExists("loginPass")>
    <cfset userData = stateFunctions.logMeIn(form.loginemail,form.loginpass) />
    <cfdump var="#userData#">
    <cfif userData.recordCount == 1>
        <cfset session.user=stateFunctions.obtainUser(
            isLoggedIn=true,
            firstname=userData.firstname,
            lastname=userData.lastname,
            email=userData.email,
            isAdmin=userData.isAdmin
        ) />

        <cfdump var="#session.user#" label="User Information after login">


        <cfset p="carousel">
    <cfelse>
        <cfset loginMessage="That login did not work." />
    </cfif>
</cfif>


<cfif form.keyExists("firstname")>
    <cfset newAccountResult = stateFunctions.processNewAccount(form) />
    <cfset accountMessage = newAccountResult.message />
</cfif>

<cfif url.keyExists("p") && url.p =='logoff'>
    <cfset session.user = stateFunctions.obtainUser() />
    <cfset p="carousel"/>
</cfif>