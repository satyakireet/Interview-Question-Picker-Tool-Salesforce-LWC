/**
* Class Name:  IQ_EvaluationCriteriaController
* Test Class Name: IQ_EvaluationCriteriaControllerTest
* Purpose: IQ_EvaluationCriteriaController is a controller that controls all the methods related to question picker tool
*/
public class IQ_EvaluationCriteriaController {
    private static final Integer NAME_LENGTH=5;
    private static final Integer STARTING_FROM=0;
    private static final String EASY='Easy';
    private static final String MEDIUM='Medium';
    private static final String HARD='Hard';
    private static final String APPROVED='Approved';  
    
    /**
* getEmailsOfInterviwer gets all the emails of the interviews
*/
    @AuraEnabled(cacheable=true)
    public static List<Interviewer__c> getEmailsOfInterviwer(){
        return [Select Id,Name,Competency__c,Email__c From Interviewer__c];
    }
    /**
*  getQuestionEvaluationCriteria gets all the selected topics questions from Question_Evaluation_Criteria__c custom object
*/
    @AuraEnabled(cacheable=true)
    public static List<Question_Evaluation_Criteria__c> getQuestionEvaluationCriteria(){
        return [Select Id,Name,Competency__c,Date__c,Email__c,No_of_Easy_Q__c,No_of_Hard_Q__c,No_of_Medium_Q__c,Multiple_Topics__c From Question_Evaluation_Criteria__c Order by createdDate desc];
    }
    /**
* getAllQuestions method contains three paramters compentency, topic and levelOfQuestions
* The methods returns the list of questions based on the parameters selected
*/
    @AuraEnabled(cacheable=true)
    public static List<Question_Bank__c> getAllQuestions(String competency,String topic,String levelOfQuestion){
        return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Request_Counter__c,Topics__c,Status__c From Question_Bank__c where Competency__c=:competency and Topics__c =:topic and Level_of_Questions__c=:levelOfQuestion and Status__c=:APPROVED];
    }
    /**
* runEvaluationCriteria selects the questions based on topics and returns the random list of questions from the question bank
*/
    @AuraEnabled(cacheable=true)
    public static String runEvaluationCriteria(Question_Evaluation_Criteria__c quec){
        if(quec !=null){
            
            LIST<Question_Bank__c> allQuestions=new LIST<Question_Bank__c>();
            //Easy
            
            List<String> topics = quec.Multiple_Topics__c.split(';');
            system.debug('TOPICS'+topics);
            system.debug('QUEC'+quec);
            for(String topic: topics){
                //	quec.Totemp;
                if(quec.No_of_Easy_Q__c !=null && quec.No_of_Easy_Q__c !=0){
                    LIST<Question_Bank__c> tempQBList=new LIST<Question_Bank__c>();
                    List<Question_Bank__c> tempAllEasyQBList=getAllQuestions(quec.Competency__c, topic,EASY);
                    if(tempAllEasyQBList.size()>1){
                        for(Integer i=1;i<=quec.No_of_Easy_Q__c;i++){
                            Integer randomeNumber= RandomUtility.generateRandomFromRange(STARTING_FROM, (tempAllEasyQBList.size()-1));
                            tempQBList.add(tempAllEasyQBList.get(randomeNumber));
                        }
                    }else if(tempAllEasyQBList.size()==1){
                        tempQBList.add(tempAllEasyQBList.get(STARTING_FROM));
                    }
                    
                    System.debug('No_of_Easy_Q__c Names>>'+tempQBList);
                    if(tempQBList.size()>0){
                        allQuestions.addAll(tempQBList);   
                    }
                }
                //MEDIUM
                if(quec.No_of_Medium_Q__c !=null && quec.No_of_Medium_Q__c !=0){
                    LIST<Question_Bank__c> tempQBList=new LIST<Question_Bank__c>();
                    List<Question_Bank__c> tempAllMEDIUMQBList=getAllQuestions(quec.Competency__c, topic,MEDIUM);
                    if(tempAllMEDIUMQBList.size()>1){
                        for(Integer i=1;i<=quec.No_of_Medium_Q__c;i++){
                            Integer randomeNumber= RandomUtility.generateRandomFromRange(STARTING_FROM, (tempAllMEDIUMQBList.size()-1));
                            tempQBList.add(tempAllMEDIUMQBList.get(randomeNumber));
                        }
                    }else if(tempAllMEDIUMQBList.size()==1){
                        tempQBList.add(tempAllMEDIUMQBList.get(STARTING_FROM));
                    }
                    System.debug('No_of_MEDIUM_Q__c Names>>'+tempQBList);
                    if(tempQBList.size()>0){
                        allQuestions.addAll(tempQBList);   
                    }
                }
                //HARD
                if(quec.No_of_Hard_Q__c !=null && quec.No_of_Hard_Q__c !=0){
                    LIST<Question_Bank__c> tempQBList=new LIST<Question_Bank__c>();
                    List<Question_Bank__c> tempAllHardQBList=getAllQuestions(quec.Competency__c, topic,HARD);
                    
                    if(tempAllHardQBList.size()>1){
                        for(Integer i=1;i<=quec.No_of_Hard_Q__c;i++){
                            Integer randomeNumber= RandomUtility.generateRandomFromRange(STARTING_FROM, (tempAllHardQBList.size()-1));
                            tempQBList.add(tempAllHardQBList.get(randomeNumber));
                        }
                    }else if(tempAllHardQBList.size()==1){
                        tempQBList.add(tempAllHardQBList.get(STARTING_FROM));
                    }
                    System.debug('No_of_HARD_Q__c Names>>'+tempQBList);
                    if(tempQBList.size()>0){
                        allQuestions.addAll(tempQBList);
                    }
                }
            }
            System.debug('All questions >>'+allQuestions);
            if(allQuestions.size() >0){
                System.debug('QUEC>>>>>>>>>>>>>'+quec.Email__c);
                List<String> senderEmails =new List<String>();
                senderEmails.addAll(quec.Email__c.split(';'));
                String subject='Salesforce Interview Questions';
                String emailBody=EmailUtility.prepairEmailBody(allQuestions,quec);
                String questionCsvString = prepareCsvString(allQuestions);
                String status=EmailUtility.send_email(senderEmails, subject, emailBody,questionCsvString);
                updateCounter(allQuestions);
                System.debug('Final Staus>>>>>>>>>>>>>'+status);
            }
        }
        return 'Success';
    }
    public static String prepareCsvString(LIST<Question_Bank__c> allRequestedQuestions){
        String questionCSVString = '';
        for ( Question_Bank__c qb: allRequestedQuestions) {
            questionCSVString += qb.Question__c + ',' + qb.Topics__c + ',' + qb.Level_of_Questions__c + '\n';
        }
        String finalstr = 'Questions, Topic, Level \n'+questionCSVString;
        return finalstr;
    }
    public static void updateCounter(LIST<Question_Bank__c> allQuestions){
        Set<Question_Bank__c> tempAllQuestions=new Set<Question_Bank__c>();
        tempAllQuestions.addAll(allQuestions);
        allQuestions.clear();
        allQuestions.addAll(tempAllQuestions);
        for(Question_Bank__c qb:allQuestions){
            qb.Request_Counter__c=(qb.Request_Counter__c+1);
        }
        update allQuestions;
    }
    
    /* 
@AuraEnabled(cacheable=true)
public static Question_Bank__c getMaxQuestion(String competency,String topic,String levelOfQuestion){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Request_Counter__c,Topics__c From Question_Bank__c Where Competency__c=:competency and Topics__c=:topic and Level_of_Questions__c=:levelOfQuestion order by Name desc limit 1];
}
public static Question_Bank__c getMinQuestion(String competency,String topic,String levelOfQuestion){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Request_Counter__c,Topics__c From Question_Bank__c Where Competency__c=:competency and Topics__c=:topic and Level_of_Questions__c=:levelOfQuestion order by Name asc limit 1];
}
/*@AuraEnabled(cacheable=true)
public static List<Question_Bank__c> getAllQuestions(){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Topics__c From Question_Bank__c];
}
@AuraEnabled(cacheable=true)
public static List<Question_Bank__c> getEasyQuestions(List<String> qBNames,Integer noOfRecord,String competency,String topic){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Topics__c From Question_Bank__c where Name IN :qBNames and Level_of_Questions__c='Easy' LIMIT :noOfRecord];
}
@AuraEnabled(cacheable=true)
public static List<Question_Bank__c> getMediumQuestions(List<String> qBNames,Integer noOfRecord){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Topics__c From Question_Bank__c where Name IN :qBNames and Level_of_Questions__c='Medium' LIMIT :noOfRecord];
}
@AuraEnabled(cacheable=true)
public static List<Question_Bank__c> getHardQuestions(List<String> qBNames,Integer noOfRecord){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Topics__c From Question_Bank__c where Name IN :qBNames and Level_of_Questions__c='Hard' LIMIT :noOfRecord];
}
@AuraEnabled(cacheable=true)
public static List<Question_Bank__c> getAllQuestions(List<String> qBNames,String levelOfQuestion,String competency,String topic,Integer noOfRecord){
return [Select Id,Name,Answer__c,Competency__c,Level_of_Questions__c,Question__c,Request_Counter__c,Topics__c From Question_Bank__c where Competency__c=:competency and Topics__c=:topic and Name IN :qBNames and Level_of_Questions__c=:levelOfQuestion LIMIT :noOfRecord];
}
public static Integer getSplitedFormatedName(String name){
return Integer.valueOf(name.split('-')[1]);
}
public static String getAppendedFormatedName(Integer randomeNumber){
return 'QB-'+String.valueOf(randomeNumber).leftPad(NAME_LENGTH, '0');
}
public static String addValuesInGlobalList(){
//system.debug('interviewer data'+interviewer);
String fieldDef = '{"Metadata":{"customValue":[{"color":null,"default":false,"description":null,"isActive":true,"label":"test@gmail.com","urls":null,"valueName":"test@gmail.com"}],"description":null,"masterLabel":"Interviewer Emails","sorted":false,"urls":null},"FullName":"Interviewer_Emails"}';
HttpRequest req = new HttpRequest();
req.setBody(fieldDef);
req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
req.setHeader('Content-Type', 'application/json');      
req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v50.0/tooling/sobjects/GlobalValueSet/0Nt2w000000YZBs?_HttpMethod=PATCH'); //replace id with your GlobalPicklist Id**
req.setMethod('PATCH');
//req.setHeader('X-HTTP-Method-Override','PATCH');
Http httpreq = new Http();
HttpResponse res  = httpreq.send(req);
system.debug('Res Body'+res.getBody());
return res.getBody();
}*/
    
}