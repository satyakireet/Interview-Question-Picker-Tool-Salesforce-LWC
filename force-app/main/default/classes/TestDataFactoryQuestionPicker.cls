public class TestDataFactoryQuestionPicker {
	 public static Interviewer__c createInterviewer(){
        Interviewer__c testInterviewer = new Interviewer__c();
        testInterviewer.Name = 'Test Interviewer';
        testInterviewer.Competency__c = 'Salesforce';
        testInterviewer.Email__c = 'testemail@gmail.com';
        insert testInterviewer;
        return testInterviewer;
    }
    public static Question_Evaluation_Criteria__c createQuestions(){
        Question_Evaluation_Criteria__c testQuestions = new Question_Evaluation_Criteria__c();
        testQuestions.Competency__c = 'Salesforce';
        testQuestions.Date__c = System.today();
        testQuestions.Email__c = 'mahimag.507@gmail.com';
        testQuestions.No_of_Easy_Q__c = 2;
        testQuestions.No_of_Hard_Q__c = 2;
        testQuestions.No_of_Medium_Q__c = 2;
        testQuestions.Multiple_Topics__c = 'LWC';
        insert testQuestions;
        return testQuestions;
    }
    public static Question_Bank__c createQuestionBank(){
        Question_Bank__c testQuestionBank = new Question_Bank__c();
        testQuestionBank.Competency__c = 'Salesforce';
        testQuestionBank.Answer__c = 'Test Answer';
        testQuestionBank.Level_of_Questions__c = 'Easy';
        testQuestionBank.Question__c = 'Test Question';
        testQuestionBank.Request_Counter__c = 1;
        testQuestionBank.Topics__c = 'LWC';
        testQuestionBank.Status__c = 'Pending';
        insert testQuestionBank;
        return testQuestionBank;
    }

}