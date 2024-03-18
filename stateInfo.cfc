
component {

    function obtainUser(
        isLoggedIn = false,
        firstname="",
        lastname="",
        email="",
        acctNumber="",
        isAdmin=0
        ) {
        return {
            isLoggedIn=arguments.isLoggedIn,
            firstname:arguments.firstname,
            lastname:arguments.lastname,
            email:arguments.email,
            acctNumber:arguments.acctNumber,
            isAdmin:arguments.isAdmin
        };
    }
       

        function processNewAccount(formdata){
            var retme = {
                success:false, message:""
            }

            if (emailUnique(formdata.email)) {
                var newId = createuuid();
                if ( addPassword(newId, formdata.password) ){
                    addAccount(newId, formdata.title, formdata.firstname, formdata.lastname, formdata.email);
                    retme.success=true;
                    retme.message = "Account Made.  Go login!";
                } else {
                    retme.message = "We had a problem.  Please resubmit";
                }
            } else {
                retme.message = "That email is already in our database.  Please login instead.";
            }
            writeDump(retme)
            return retme;
        }

        function emailUnique(required string email){
            var qs = new query(datasource  = application.dsource);
            qs.setSql('select * from people where email=:email'); 
            qs.addParam(name = 'email', value=arguments.email);
            return qs.execute().getResult().recordcount == 0;
        }

        function addPassword(id, password){
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into passwords (personid, password)
                values (:personid, :password) ");
                qs.addParam(name = "personid", value = arguments.id);
                qs.addParam(
                    name = "password",
                    value = hash( arguments.password, "SHA-512" )
                    );
                qs.execute();
                return true;
            } catch(ary err){
                writeDump(err); abort;
                return false;
            }
        }

        function addAccount(id, title, firstname, lastname, email, isAdmin = 0) {
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into people (personid, title, firstname, lastname, email, isAdmin)
                values (:personid, :title, :firstname, :lastname, :email, :isAdmin) ");
                qs.addParam(name = "personid", value = arguments.id);
                qs.addParam(name = "title", value = arguments.title);
                qs.addParam(name = "firstname", value = arguments.firstname);
                qs.addParam(name = "lastname", value = arguments.lastname);
                qs.addParam(name = "email", value = arguments.email);
                qs.addParam(name = "isAdmin", value = arguments.isAdmin);

                qs.execute();
                return true;
            } catch (ary err) {
                writeDump(err); abort;
                return false;
            }
        }   
        
        function logMeIn(username, password){
            var qs = new query(datasource=application.dsource);
            qs.setSql("
                SELECT * FROM people
                INNER JOIN passwords ON people.personid = passwords.personid
                WHERE email = :email AND password = :password");
            qs.addParam(name="email", value=arguments.username);
            qs.addParam(name="password", value=hash(form.loginpass,"SHA-512"));
            writeDump(qs.getParams());
            return qs.execute().getResult();
        }
           
           
}