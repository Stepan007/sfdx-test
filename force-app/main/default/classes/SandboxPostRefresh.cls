global with sharing class SandboxPostRefresh implements SandboxPostCopy {
    global void runApexClass(SandboxContext context) {
     
        System.debug(context.organizationId());
        System.debug(context.sandboxId());
        System.debug(context.sandboxName());

        Database.executeBatch(new BAT_ModifySandboxContactData());
        Database.executeBatch(new BAT_ModifySandboxLeadData());
    }
}