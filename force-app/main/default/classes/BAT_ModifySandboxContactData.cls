/**
* @author Neeru Nagpal
* @date 10/01/2019
*
* @group GFK
*
* @description  BAT_ModifySandboxContactData class : purpose of this class is to obfuscate contact records after sandbox refresh.
*/
public with sharing class BAT_ModifySandboxContactData implements Database.Batchable<sObject>{
    
    /**
    * @description       This is the start method of batch class to query data from the org
    * @param             
    * @return            list of contact records
    */
    public Database.QueryLocator start(Database.BatchableContext BC){
        //exclude all contacts 
        String query = 'select Id, FirstName, LastName, Email, MobilePhone, Phone from Contact where Email != null AND FirstName != null AND LastName != null AND MobilePhone != null AND Phone != null';
        //return results to process only if the current instance is a sandbox or a test is running
        Boolean isSandbox;
        Organization orgObj = [Select isSandbox from Organization limit 1];
            isSandbox = orgObj.isSandbox;
        
        if(isSandbox == TRUE){
            return Database.getQueryLocator(query);
        } else if (Test.isRunningTest()){
            return Database.getQueryLocator(query + ' limit 1');        
        } else {
            return Database.getQueryLocator(query + ' limit 0');
        }
    }
    
    /**
    * @description       This is the execute method of batch class to execute the logic, and expecting List of contacts to be obfuscated
    * @param             
    * @return            list of contact records with the updated values
    */
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Contact> listContact = (List<Contact>)scope;
        List<Contact> listToUpdate = new List<Contact>();
        if(scope!=null){
            for(Contact contactRecord :listContact){
                contactRecord.Email = crypto.getRandomInteger()+ '@gfk.customer.com';
                String emailId = contactRecord.Email;
                contactRecord.FirstName = 'Customer';
                contactRecord.LastName = emailId.subStringBefore('@');
                contactRecord.MobilePhone = '07123456789';
                contactRecord.Phone = '01234567891';
                listToUpdate.add(contactRecord);                    
            }
        }
        if(listToUpdate.size()>0){
            //Update all Contacts that can be updated
            Database.update(listToUpdate,false);
        }
    }
    
    /**
    * @description       This is the finish method of batch class
    * @param             
    * @return            
    */
    public void finish(Database.BatchableContext BC){
        System.debug('***** BatchModifySandboxContactData is complete.');    
    }
}