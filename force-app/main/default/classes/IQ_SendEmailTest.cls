@isTest
private class IQ_SendEmailTest {
    @isTest
    static void testIQ_SendEmail(){
        String quec = 'abc';
        Question_Evaluation_Criteria__c testQuestions = TestDataFactoryQuestionPicker.createQuestions();
        String testTrigger = IQ_EvaluationCriteriaController.runEvaluationCriteria(testQuestions);
        test.startTest();
         try{
             List<Question_Evaluation_Criteria__c> listQuestionCriteria = IQ_EvaluationCriteriaController.getQuestionEvaluationCriteria();   
        List<Interviewer__c> listInterviewer = IQ_EvaluationCriteriaController.getEmailsOfInterviwer();   
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
}