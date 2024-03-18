
component {

    function obtainUser(){
        return {
        "isLoggedIn":"",
        "firstname":"",
        "lastname":"",
        "email":"",
        "acctNumber":""
        }
    }

        function processNewAccount(formData){
            var retme = {
                success:false, message:""
            }

            if(emailUnique(formdata.email)){
                var newId = createuuid();
                writeDump(formData);
                if ( addPassword(newId, formData.password) ){
                    addAccount(newid, formdata.title, formdata.firstname, formdata.lastname, formdata.email);
                    retme.success=true;
                    retme.message = "Account Made.  Go login!"
                } else {
                    retme.message = "We had a problem.  Please resubmit";
                }
            } else {
                retme.message = "That email is already in our database.  Please login instead."
            }
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

        function addAccount(id, title, firstname, lastname, email) {
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into people (personid, title, firstname, lastname, email)
                values (:personid, :title, :firstname, :lastname, :email) ");
                qs.addParam(name = "personid", value = arguments.id);
                qs.addParam(name = "title", value = arguments.title);
                qs.addParam(name = "firstname", value = arguments.firstname);
                qs.addParam(name = "lastname", value = arguments.lastname);
                qs.addParam(name = "email", value = arguments.email);

                qs.execute();
                return true;
            } catch (ary err) {
                writeDump(err); abort;
                return false;
            }
        }          
           
}