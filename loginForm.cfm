<cfoutput>
    <div> #loginmessage#
        <form action="#cgi.script_name#?p=login" method="post" >
            
            <div class="form-floating mb-3">
                <input type="email" id="loginemail" name="loginemail" class="form-control" placeholder="Please Enter your login email" />
                <label for="loginemail">Login Email</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please Enter your login password" required />
                <label for="loginpass">Login Password</label>
            </div>

            <div>
                <input type="submit" class="btn btn-warning" value="Submit" />
            </div>
        </form>
    </div>
</cfoutput>