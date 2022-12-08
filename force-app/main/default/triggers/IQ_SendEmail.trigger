/**
 * This IQ_SendEmail trigger sends the list of questions in email
*/
trigger IQ_SendEmail on Question_Evaluation_Criteria__c (after insert) {
    for (Question_Evaluation_Criteria__c quec: Trigger.new) {
        if (Trigger.isAfter && Trigger.isInsert) {
        	IQ_EvaluationCriteriaController.runEvaluationCriteria(quec);
        }
    }
}