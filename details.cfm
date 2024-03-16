<cfdump var="#form#">

<cfset bookInfo = bookstoreFunctions.obtainSearchResults( form.searchme ) />
<cfset noResults = bookstoreFunctions.noResults() />
<cfset oneResult = bookstoreFunctions.oneResult() />
<cfset manyResults = bookstoreFunctions.manyResults() />


<cfif bookinfo.recordcount == 0>
    <cfoutput> #noResults# </cfoutput>

    <cfelseif bookinfo.recordcount == 1>

        <cfoutput> 
            #oneResult# 
            <img src="images/#bookinfo.IMAGE[1]#" style="float:left; width:250px; height:250px"/>
            <span>Title: #bookinfo.title[1]#</span>
            <span>Publisher: #bookinfo.name[1]#</span>
        </cfoutput>

    <cfelse>
        <cfoutput>#manyResults#</cfoutput>

        <cfoutput query="bookinfo"> 
            <ol class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">
                    #trim(title)#
                    </a>
                </li>
            </ol>
        </cfoutput>
</cfif>
