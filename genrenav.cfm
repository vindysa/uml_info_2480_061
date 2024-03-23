<h3>Search By Genre</h3>
<ul class="nav flex-column">
    <cfset genres = bookstoreFunctions.obtainDistinctGenres()>
    <cfoutput>
        <cfloop query="genres">
            <li class="nav-item">
                <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=details&genre=#genreid#">#genrename#</a>
            </li>
        </cfloop>
    </cfoutput>
</ul>