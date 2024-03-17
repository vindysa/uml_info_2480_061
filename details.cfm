

<cfdump var="#form#">

<cfoutput>
        <cfset bookinfo = bookstoreFunctions.obtainSearchResults( searchme ) />

    <cfif bookinfo.recordcount == 0>
        There were no results.  Please search again.
    <cfelseif bookinfo.recordcount == 1>
        <cfset oneResult()/>
    <cfelse>
        <cfset manyResults() />

    </cfif>

    <cfdump var="#bookinfo#" />
</cfoutput>

<cffunction name="oneResult">
    <cfoutput>
        <div class="row">
            <div class="col-6>"
                <img src="images/#bookinfo.image[1]#" style="float:left; width:250px; height:250px"/>
            </div>
            <div class="col-6">
                <span> Title: #bookinfo.title[1]#</span></br>
                <span> Year: #bookinfo.year[1]#</span></br>
                <span> Pages: #bookinfo.pages[1]#</span></br>
                <span> Description: #bookinfo.description[1]#</span></br>
                <span> Publisher: #bookinfo.name[1]#</span>
            </div>
        </div>
    </cfoutput>
</cffunction>

<cffunction name="manyResults">
    <cfoutput query="bookinfo"> 
        <ol class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">
                #trim(title)#
                </a>
            </li>
        </ol>
    </cfoutput>
</cffunction>
