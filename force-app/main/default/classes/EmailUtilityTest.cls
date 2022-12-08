@isTest
public class EmailUtilityTest {
    @isTest
    static void testsend_email(){
        Question_Bank__c testAllQuestions = TestDataFactoryQuestionPicker.createQuestionBank();
        Interviewer__c testInterviewer = TestDataFactoryQuestionPicker.createInterviewer();
        Question_Evaluation_Criteria__c testQuestions = TestDataFactoryQuestionPicker.createQuestions();
        test.startTest();
        try{
            List<Question_Evaluation_Criteria__c> listQuestionCriteria = IQ_EvaluationCriteriaController.getQuestionEvaluationCriteria();  
            List<Interviewer__c> listInterviewer = IQ_EvaluationCriteriaController.getEmailsOfInterviwer();   
            List<Question_Bank__c> listQuestions = IQ_EvaluationCriteriaController.getAllQuestions('Salesforce','LWC','Easy'); 
            String sendemailTest = EmailUtility.send_email(new List<String>{'abc@gmail.com', 'xyz@gmail.com'}, 'Subject', 'This is an email');
            String sendemailTest2 = EmailUtility.send_email(new List<String>{'abc@gmail.com', 'xyz@gmail.com'}, 'Subject', null);
            String prepareEmailTest = EmailUtility.prepairEmailBody(listQuestions, testQuestions);
            String prepareEmailTest2 = EmailUtility.prepairEmailBody(listQuestions, null);
        }catch(Exception e){
            system.debug('Error'+e.getMessage());
        }
        test.stopTest();
        
    }
}