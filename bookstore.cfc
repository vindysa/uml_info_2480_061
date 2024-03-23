component {
    function obtainSearchResults(searchme, genre){
        if(searchme.len() != 0) {
            var qs = new query( datasource = application.dsource );
            qs.setSql( "select * from books inner join Publishers on books.publisherId=Publishers.id where title like '%#trim(form.searchme)#%' or isbn13 like '%#trim(searchme)#%'");

            return qs.execute().getResult(); 
        } else if( genre.len() != 0){
            var qs = new query(datasource = application.dsource);
            qs.setSql("SELECT * from books INNER JOIN genreToBook ON books.isbn13 = genreToBook.isbn13 INNER JOIN Publishers ON books.publisherId=Publishers.id WHERE genreid=:genre ");
            qs.addParam(name = "genre", value = trim(arguments.genre));
            
            return qs.execute().getResult();
        }
    }

    function obtainDistinctGenres() {
        var qs = new query(datasource = application.dsource);
        qs.setSql("SELECT DISTINCT genres.genreid, genreName FROM genresToBooks INNER JOIN genres ON genres.genreid = genresToBooks.genreid ORDER BY genrename");

        return qs.execute().getResult();
    }

    function resultsHeader(searchme, genre) {
        if (searchme.len() > 0) {
            return 'Keyword: #searchme#';
        } else if (genre.len() > 0) {
            return 'Genre: #genreName(arguments.genre)#';
        }

    function genreName(genreid) {
        var qs = new query(datasource = application.dsource);
        qs.setSql( 'select genrename from genres where genreid=:genreid' );
        qs.addParam(name = 'genreid', value = arguments.genreid);
        
        return qs.execute().getResult().genrename;
    }

}