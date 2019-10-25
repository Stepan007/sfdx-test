/**
 * @author Stepan Ruzicka
 * @date 12.04.2017
 *
 * @description This class generates, and optionally persists, Log__c records. Extension of Gene Koopman's solution. The solution was extended for integration logging ability.
 */
public with sharing class LogServices{

	/*******************************************************************************************************
    * @description Using the supplied message and class name, a Log__c record is generated and persisted.
    * @param message the message, presumably describing/identifying the error being logged, to use in the generated Log__c record
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @return the generated Log__c record
    */
	public static Log__c logError(String message, String className){
		return logError(message, className, null, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	public static Log__c logError(String message, String className, String methodName){
		return logError(message, className, methodName, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	/*******************************************************************************************************
    * @description Using the supplied message and class name, a Log__c record is generated and, if directed, persisted.
    * @param message the message, presumably describing/identifying the error being logged, to use in the generated Log__c record
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @param persisLog boolean indicating if the generated Log__c record should be persisted
    * @return the generated Log__c record
    */
	public static Log__c logError(String message, String className, String methodName, boolean persistLog){
		Log__c 	log = null;

		try
		{
			//build the log
			log = LogServicesCommon.buildBaseLog(message, className, methodName);

			if(log != null){
				//persist if indicated
				if(persistLog)
					insert log;

				//add log to the collection
				LogServicesCommon.generatedLogs.add(log);
			}
		}catch(Exception e){
			//nothing really to do here...where would we log the logging failure?
			System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
			System.debug('The error logging failed. Here\'s the error the method was attempting to log: ' + message);
			if(log != null)
				System.debug(LogServicesCommon.GENERATED_LOG + log);
		}

		return log;
	}

	/*******************************************************************************************************
    * @description Using the supplied exception and class name, a Log__c record is generated and persisted.
    * @param exp the exception describing the error encountered, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @return the generated Log__c record
    */
	public static Log__c logError(Exception exp, String className){
		return logError(exp, className, null, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	public static Log__c logError(Exception exp, String className, String methodName){
		return logError(exp, className, methodName, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	/*******************************************************************************************************
    * @description Using the supplied exception and class name, a Log__c record is generated and optionally persisted.
    * @param exp the exception describing the error encountered, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @param persisLog boolean indicating if the generated Log__c record should be persisted
    * @return the generated Log__c record
    */
	public static Log__c logError(Exception exp, String className, String methodName, boolean persistLog){
		Log__c 	log = null;
		try{
			//build the log
			log =  LogServicesCommon.buildBaseLogFromException(exp, className, methodName);

			if(log != null){
				//persist if indicated
				if(persistLog)
					insert log;

				//add log to the collection
				LogServicesCommon.generatedLogs.add(log);
			}
		}catch(Exception e){
			//nothing really to do here...where would we log the logging failure?
			System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
			System.debug(LogServicesCommon.RESULT_MESSAGE_LOGGING_FAILED + exp);
			if(log != null)
				System.debug(LogServicesCommon.GENERATED_LOG + log);
		}

		return log;
	}

	/*******************************************************************************************************
    * @description Using the supplied exception, class name, and Object instance a Log__c record is generated persisted.
    * @param exp the exception describing the error encountered, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @param obj the Object record which should be serialized and documented in the generated Log__c record
    * @return the generated Log__c record
    */
	public static Log__c logError(Exception exp, String className, Object obj){
		return logError(exp, className, null, obj, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	/*******************************************************************************************************
    * @description Using the supplied exception, class name, and Object instance a Log__c record is generated and optionally persisted.
    * @param exp the exception describing the error encountered, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @param obj the Object record which should be serialized and documented in the generated Log__c record
    * @param persisLog boolean indicating if the generated Log__c record should be persisted
    * @return the generated Log__c record
    */
	public static Log__c logError(Exception exp, String className, String methodName, Object obj, boolean persistLog){
		Log__c 	log = null;

		try{
			//build the base log
			log 				= LogServicesCommon.buildBaseLogFromException(exp, className, methodName);

			if(log != null){
				//add the JSON serialized object
				log.Log_Details__c 	+= (obj != null) ? JSON.serializePretty(obj) : LogServicesCommon.ERRMSG_EMPTY_MODEL;

				//persist if indicated
				if(persistLog)
					insert log;

				//add log to the collection
				LogServicesCommon.generatedLogs.add(log);
			}

		}catch(Exception e){
			//nothing really to do here...where would we log the logging failure?
			System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
			System.debug(LogServicesCommon.RESULT_MESSAGE_LOGGING_FAILED + exp);

			if(log != null)
				System.debug(LogServicesCommon.GENERATED_LOG + log);
		}

		return log;
	}

	/*******************************************************************************************************
    * @description Using the supplied collection of Database.SaveResult values and class name a Log__c record is generated and persisted.
    * @param srList the collection of Database.SaveResult values, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @return the generated Log__c record
    */
	public static Log__c logError(List<Database.SaveResult> srList, String className, String methodName){
		return logError(srList, className, methodName, LogServicesCommon.DEFAULT_PERSIST_LOG);
	}

	public static Log__c logError(List<Database.SaveResult> srList, String className){
		return logError(srList, className, null);
	}

	/*******************************************************************************************************
    * @description Using the supplied collection of Database.SaveResult values and class name a Log__c record is generated and optionally persisted.
    * @param srList the collection of Database.SaveResult values, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @param persisLog boolean indicating if the generated Log__c record should be persisted
    * @return the generated Log__c record
    */
	public static Log__c logError(List<Database.SaveResult> srList, String className, String methodName, boolean persistLog){
		Log__c 	log = null;
		try{
			//build the log
			for(Database.SaveResult sr : srList){
				if(!sr.isSuccess()){
					if(log == null){
						log = LogServicesCommon.buildBaseLog(LogServicesCommon.SAVE_RESULT_LOGGING, className, methodName);
					}

					if(log != null){
						LogServicesCommon.logSaveResultError(sr, log);
					}
				}
			}

			//if log generated
			if(log != null){
				//persist if indicateds
				if(persistLog)
					insert log;

				//add log to the collection
				LogServicesCommon.generatedLogs.add(log);
			}
		}
		catch(Exception e){
			//nothing really to do here...where would we log the logging failure?
			System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
			if(log != null)
				System.debug(LogServicesCommon.GENERATED_LOG + log);
		}

		return log;
	}
}