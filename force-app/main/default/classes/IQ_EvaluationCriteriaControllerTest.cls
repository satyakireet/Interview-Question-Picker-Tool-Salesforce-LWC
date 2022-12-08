@isTest
public class IQ_EvaluationCriteriaControllerTest {
	@isTest
    static void testgetEmailsOfInterviwer(){
        Interviewer__c testInterviewer = TestDataFactoryQuestionPicker.createInterviewer();
        test.startTest();
         try{
        List<Interviewer__c> listInterviewer = IQ_EvaluationCriteriaController.getEmailsOfInterviwer();   
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
    @isTest
    static void testgetQuestionEvaluationCriteria(){
        Question_Evaluation_Criteria__c testQuestions = TestDataFactoryQuestionPicker.createQuestions();
        test.startTest();
        List<Question_Bank__c> listQuestions = IQ_EvaluationCriteriaController.getAllQuestions('Salesforce','LWC','Easy');
        List<Question_Evaluation_Criteria__c> listQuestionCriteria = IQ_EvaluationCriteriaController.getQuestionEvaluationCriteria();   
        String sendemailTest2 = EmailUtility.send_email(new List<String>{'abc@gmail.com', 'xyz@gmail.com'}, 'Subject', null);
        String prepareEmailTest = EmailUtility.prepairEmailBody(listQuestions, testQuestions);
        test.stopTest();
    }
    /*@isTest
    static void testgetAllQuestions(){
        Question_Bank__c testAllQuestions = TestDataFactoryQuestionPicker.createQuestionBank();
        test.startTest();
         try{
             Question_Bank__c listQuestions = IQ_EvaluationCriteriaController.updateCounter(testAllQuestions);   
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }*/
    @isTest
    static void testupdateCounter(){
        Question_Bank__c testAllQuestions = TestDataFactoryQuestionPicker.createQuestionBank();
        test.startTest();
         try{
        List<Question_Bank__c> listQuestions = IQ_EvaluationCriteriaController.getAllQuestions('Salesforce','LWC','Easy');   
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
}