global class EmailAutoProcess implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope){
        // Create an InboundEmailResult object for returning the result of the 
    	// Apex Email Service
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        // Add the email plain text into the local variable 
        String plainTextBody = email.plainTextBody;
        system.debug(plainTextBody);
        // New QuestionEvaluationCriteria object to be created
        Question_Evaluation_Criteria__c qec= new Question_Evaluation_Criteria__c();
        qec.Competency__c = plainTextBody.substringBetween('Competency:', '.');
        qec.Multiple_Topics__c = plainTextBody.substringBetween('Multipletopics:', '.');
        qec.No_of_Easy_Q__c = integer.valueOf(plainTextBody.substringBetween('NumofEasy:', '.'));
      	qec.No_of_Medium_Q__c = integer.valueOf(plainTextBody.substringBetween('NumofMedium:', '.'));
        qec.No_of_Hard_Q__c = integer.valueOf(plainTextBody.substringBetween('NumofHard:', '.'));
        qec.Email__c = plainTextBody.substringBetween('Email:', '!');
        qec.Date__c = system.today();
        // Insert the new  QuestionEvaluationCriteria
        Database.SaveResult insertQuestionEvaluationCriteria = Database.insert(qec);
        // Return the result for the Apex Email Service
        return result;
    }

}