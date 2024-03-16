component {
    function obtainSearchResults(){
        var qs = new query( datasource = application.dsource );
        qs.setSql( "select * from books inner join Publishers on books.publisherId=Publishers.id where title like '%#trim(form.searchme)#%' or isbn13 like '%#trim(searchme)#%'");

        return qs.execute().getResult();
    }

    function noResults(){
        return "There were no results to be found.";
    }

    function oneResult(){
        return "There was one result, here are the details:";
    }

    function manyResults(){
        return "There were more than one result, here is a list:";
    }

}