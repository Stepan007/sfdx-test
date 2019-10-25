/**
 * Created by stepan on 28/04/17.
 */

global class CreateAttachmentBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {

    public static final String CUSTOM_METADATA_CST_PREFIX = 'CST';
    private static Map<String, String> crmCaseType; // Key - CST_DATA_ID (1882), Value - Internal Salesforce Developer Name of Case RecordType

    private static final String query = 'select Id, Name from User';

    global Database.QueryLocator start(Database.BatchableContext BC){
        Database.QueryLocator ql = Database.getQueryLocator(query);
        return ql;
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        List<User> concreteScope = (List<User>) scope;
        Attachment theAttachment = new Attachment();
        String csvContent = '';

        csvContent += 'header';
        for(User theUser : concreteScope){
            csvContent += '\n' + theUser.Name;
        }
        theAttachment.Body = Blob.valueOf(csvContent);
        theAttachment.Name = BC.getJobId();
        theAttachment.ParentId = '00158000003ci3S';
        theAttachment.ContentType = 'text/csv';

        insert theAttachment;
    }

    global void finish(Database.BatchableContext BC){
        String queryPartialAttachments = 'select Id, Name, Body from Attachment where name like \''+ BC.getJobId() + '%\'';
        System.debug(BC.getJobId());
        List<Attachment> attachmentList = Database.query(queryPartialAttachments);
        String header = '';
        String body = '';

        if(attachmentList.size() > 0){
            header += attachmentList.get(0).Body.toString().substring(0, attachmentList.get(0).Body.toString().indexOf('\n'));

            // combine all the generated attachments
            for(Attachment attach: attachmentList){
                body += attach.Body.toString().substring(attach.Body.toString().indexOf('\n') + 1);
            }

            Attachment resultAttachment = new Attachment();
            resultAttachment.Body = Blob.valueOf(header + '\n' + body);
            resultAttachment.Name = 'R14T' + String.valueOf(DateTime.now().format('yyyyMMdd')) + '.csv';
            resultAttachment.ParentId = '00158000003ci3S';
            resultAttachment.ContentType = 'text/csv';
            insert resultAttachment;
            //delete attachmentList;
        }

    }
}