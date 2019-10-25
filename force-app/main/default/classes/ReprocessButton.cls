/**
  * @author Stepan Ruzicka
  * @date 06.06.2017
  *
  * @description
  */

public with sharing class ReprocessButton {
    // Constructor - this only really matters if the autoRun function doesn't work right
    private final Log__c log;

    public ReprocessButton() {
        
    }

    public PageReference reprocessRecord(){
        String logId = ApexPages.currentPage().getParameters().get('id');
System.debug('log id je: ' + logId);
        if (logId == null) {
            // Display the Visualforce page's content if no Id is passed over
            return null;
        }

        PageReference pageRef = new PageReference('/' + logId);
        pageRef.setRedirect(true);
        return pageRef;
    }
}