/**
  * @author Stepan Ruzicka
  * @date 06.06.2017
  *
  * @description Controller to support custom button ("Reprocess") functionality
  */

public with sharing class LogController{

    public LogController(){

    }

    /**
     * @description Get set of IDs passed in as URL parameters and call reprocess method then redirect to the list of logs or detail page of a record (if one ID only)
     */
    public PageReference reprocessSelectedRecords(){
        List<String> logIdList = ApexPages.currentPage().getParameters().get('recs').split(',');
        Set<String> logIdSet = new Set<String>();
        if(logIdList != null){
            logIdSet.addAll(logIdList);
        }
        System.debug(logIdSet);

        if(!logIdSet.isEmpty()){
            IntegrationFrameworkUtils.reprocess(logIdSet);

            if(logIdList.size() > 1){
                PageReference pg = new PageReference('/' + getIdSubstr(logIdList));
                pg.setRedirect(true);
                return pg;
            }else{
                PageReference pg = new PageReference('/' + logIdList.get(0));
                pg.setRedirect(true);
                return pg;
            }

        }else{
            return null;
        }
    }

    /**
     * @description Get first three letters of an ID to be able to redirect to a list of records
     */
    private String getIdSubstr(List<String> logIdList){
        if(logIdList != null && !logIdList.isEmpty()){
            return logIdList.get(0).substring(0, 3);
        }else{
            return null;
        }
    }
}