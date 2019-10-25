/**
  * @author Stepan Ruzicka
  * @date 21.06.2017
  *
  * @description
  */

public with sharing class SubmitOrderWS extends WebServiceVirtualClass{
    public SubmitOrderWS(){
        super();
    }
    public SubmitOrderWS(String connection, String request){
        super(connection, request);
    }
}