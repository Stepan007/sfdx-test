/**
 * Created by kolint on 23.11.2015.
 */

global class CommonIntegrationTypes {

    global class Header{
        webService String SessionID;
        webservice integer SessionSequenceNumber;
        webService BusinessProcessOriginator BusinessProcessOriginator;
        webService String BusinessUniqueID;
        webService String BuidSequence;
        webService integer ReleaseVersion;
        webService Data Data;
        webService OriginalSource OriginalSource;
        webService UltimateTarget UltimateTarget;
        //QoS vynecháno, zbytečné
        webService Retry Retry;
        //extension vynecháno, nezajímá nás
    }

    global class BusinessProcessOriginator{
        webService DateTime TimeStamp;
        webService String User;
        webService String BPO_System;
        webService integer Company;
        webService String Function;
        webService String UseCaseId;
    }

    global class Data {
        webService String Type;
        webService Decimal Version;
    }

    global class OriginalSource{
        webService DateTime TimeStamp;
        webService String User;
        webService String OS_System;
        webService integer Company;
        webService String Function;
        webService String UseCaseId;
    }

    global class UltimateTarget{
        webService String UT_System;
        webService integer Company;
        webService String Function;
        webService String UseCaseId;
    }

    global class Retry{
        webService integer Counter;
        webService integer MaxAttempts;
    }

    //////////////////////// Party ////////////////////////

    global class Party{
        webService String CUID;
        webService ClientInstances ClientInstances;
    }

    global class ClientInstances{
        webService List<ClientInstance> ClientInstance;
    }

    global class ClientInstance{
        webService String ClientNumber;
        webService String BankSystem; 
    }

    //////////////////////// Party ////////////////////////

    global class ResultType{
        webservice integer resultCode;
        webservice String resultDescription;
    }

}