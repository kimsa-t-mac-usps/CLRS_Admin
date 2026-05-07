component {

    public void function doMfaInit(relayPage, queryString) {
        //writeLog(text="saml.cfc: relayPage: #arguments.relayPage# | querystring: #arguments.queryString#", type="information",file="ContLiab_samlcfc");
        if(len(arguments.queryString) > 0) {
            returnPage = "#arguments.relayPage#?#arguments.queryString#";
        } else {
            returnPage = "#arguments.relayPage#";
        }
        samlConfig = {
            idp = {name="ContLiabAdmin_idp"},
            sp = {name="ContLiabAdmin_sp"},
            relayState = "#returnPage#"
        };
        initSamlAuthRequest(samlConfig);
    }
}