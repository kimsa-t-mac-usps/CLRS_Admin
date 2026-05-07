component {
    dsn = "Contliab";

  function createAppLogRecord(authName, authSessionId, templatePath,appName) {
    try {
        sqlString = "Insert into LDIS_APPS_LOG (AUTH_NAME_ID,AUTH_SESSION_INDEX,TEMPLATE_PATH,APPS_LOG_TIMESTAMP,APP_NAME) values(:name,:session,:template,sysdate,:appName)";
        //writeLog(text="sqlString: #sqlString#",type="information",file="webStaffDuh");
        qry = new query();
        qry.setname("insertLogRecord");
        qry.setDatasource("#dsn#");
        qry.addParam(name="name",value="#arguments.authName#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="session",value="#arguments.authSessionId#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="template",value="#arguments.templatePath#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="appName",value="#arguments.appName#",cfsqltype="cf_sql_varchar");
        result = qry.execute(sql=sqlString).getPrefix();
       return result;
    } catch (any e) {
        writeDump(var="#e#",abort="true");
    }
    }
}