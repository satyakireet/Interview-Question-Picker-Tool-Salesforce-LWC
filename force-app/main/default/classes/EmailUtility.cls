/**
 * Class Name: EmailUtility
 * Test class name: EmailUtilityTest
 * Purpose: EmailUtility is used to send emails based on the topics selected
 */ 
public class EmailUtility {
    /**
     * send_email contains three parameters list of emails, subject of email and email body
     * send_email method is used to send email to the requester containing a list of questions as an attachment
	*/
    public static String send_email(List<String> senderEmails,String subject,String emailBody,String questionCsvString){
        try{
 			String attName = 'Questionnairs.csv'; 
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName(attName);
            attachment.setBody(Blob.valueOf(questionCsvString));
			attachment.setContentType('text/csv');
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            email.setSubject(subject);
            email.setPlainTextBody(emailBody);
            email.setHtmlBody(emailBody);
            email.setToAddresses(senderEmails);
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            return 'Success';    
        } catch(Exception e){
            System.debug('Failed in send_email method'+e.getMessage());  
            return 'Failed';
        }
    }
    /**
     * prepairEmailBody methods the email body that contains the list of questions from multiple topics
     */ 
    public static String prepairEmailBody(LIST<Question_Bank__c> allQuestions,Question_Evaluation_Criteria__c quec){
        String finalEmailBody='';
        try{
            finalEmailBody+='<html xmlns="http://www.w3.org/1999/xhtml" lang="en-GB"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><title></title><meta name="viewport" content="width=device-width, initial-scale=1.0"/>';
            finalEmailBody+='<style type="text/css">a[x-apple-data-detectors]{color:inherit!important}@media all and (max-width:599px){.smarttable{border:0}.smarttable thead{display:none;border:none;height:0;margin:0;overflow:hidden;padding:0;max-width:0;max-height:0}.smarttable tr{display:block;width:90%;margin:20px auto}.smarttable td{border-bottom:1px solid #ddd;display:block;font-size:15px;text-align:center}}.smarttable tbody tr:nth-child(2n){background-color:#f2f2f2}.smarttable thead{text-align:left}.smarttable th{background-color:#4caf50;color:#fff}</style></head>';
            finalEmailBody+='<body style="margin: 0; padding: 0;">';
            finalEmailBody+='<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%">';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td style="padding: 20px 0 30px 0;">';
            finalEmailBody+='<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse: collapse; border: 1px solid #cccccc;min-width:600px;">';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td align="right" bgcolor="#050a0d" style="">';
            finalEmailBody+='<img src="https://sfdcmedia.s3.ap-south-1.amazonaws.com/yash-logo.PNG" alt="Yash Technologies." width="100" height="62" style="display: block;" />';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td align="center" bgcolor="#bb4c2b" style="">';
            finalEmailBody+='<img src="https://sfdcmedia.s3.ap-south-1.amazonaws.com/Interview-bckg.png" alt="Yash Technologies." width="300" height="230" style="display: block;" />';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td bgcolor="#ffffff" style="padding: 30px 30px 30px 30px;">';
            finalEmailBody+='<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td style="color: #153643; font-family: Arial, sans-serif;">';
            finalEmailBody+='<h1 style="font-size: 24px; margin: 0;">Hello Team,</h1>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td style="color: #153643; font-family: Arial, sans-serif; font-size: 16px; line-height: 24px; padding: 15px 0 20px 0;">';
            finalEmailBody+='<p style="margin: 0;">As per your request, Interview scheduled on '+quec.Date__c+' related to '+quec.Multiple_Topics__c+' of '+quec.Competency__c+' Competency Questions (E-'+quec.No_of_Easy_Q__c+', M-'+quec.No_of_Medium_Q__c+', H-'+quec.No_of_Hard_Q__c+'). </p>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td>';
            finalEmailBody+='<table class="smarttable" width="100%" cellpadding="0" cellspacing="0" style="min-width:100%;border: 1px solid #e6e6e6;">';
            finalEmailBody+='<thead>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<th scope="col" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;line-height:30px">SN</th>';
            finalEmailBody+='<th scope="col" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;line-height:30px">Question</th>';
            finalEmailBody+='<th scope="col" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;line-height:30px">Topic</th>';
            finalEmailBody+='<th scope="col" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;line-height:30px">Level</th>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</thead>';
            finalEmailBody+='<tbody>';
            for(Integer i=0;i<allQuestions.size();i++){
                Question_Bank__c question=allQuestions.get(i);
                if(math.mod(i, 2) == 0){
                    finalEmailBody+='<tr>';
                }else{
                    finalEmailBody+='<tr style="background-color:#f2f2f2">';  
                }
                finalEmailBody+='<td valign="top" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;">'+(i+1)+'</td>';
                    finalEmailBody+='<td valign="top" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;">'+String.valueOf((question.Question__c).trim())+'</td>';
                finalEmailBody+='<td valign="top" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;">'+String.valueOf(question.Topics__c)+'</td>';
                finalEmailBody+='<td valign="top" style="padding:5px; font-family: Arial,sans-serif; font-size: 16px; line-height:20px;">'+String.valueOf(question.Level_of_Questions__c)+'</td>';
                finalEmailBody+='</tr>';
            }
            finalEmailBody+='</tbody>';
            finalEmailBody+='</table>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td style="color: #153643; font-family: Arial, sans-serif; padding: 30px 0 5px 0;">';
            finalEmailBody+='<p style="margin: 0;font-size: 16px;"><b>Thanks & Regards,</b></p>';
            finalEmailBody+='<p style="margin: 0;font-size: 14px;padding-left:3px;"><b>'+quec.Competency__c+' Team</b></p>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</table>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td bgcolor="#ee4c50" style="padding: 30px 30px;">';
            finalEmailBody+='<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td style="color: #ffffff; font-family: Arial, sans-serif; font-size: 14px;">';
            finalEmailBody+='<p style="margin: 0;">&#174; Copyright &copy; 2021. <a href="https://www.yash.com/" style="color: #ffffff;">YASH Technologies</a>.<br/>';
            finalEmailBody+='All Rights Reserved.';
            finalEmailBody+='</p>';
            finalEmailBody+='</td>';
            finalEmailBody+='<td align="right">';
            finalEmailBody+='<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">';
            finalEmailBody+='<tr>';
            finalEmailBody+='<td>';
            finalEmailBody+='<a href="https://twitter.com/YASH_Tech">';
            finalEmailBody+='<img src="https://assets.codepen.io/210284/tw.gif" alt="Twitter." width="38" height="38" style="display: block;" border="0" />';
            finalEmailBody+='</a>';
            finalEmailBody+='</td>';
            finalEmailBody+='<td style="font-size: 0; line-height: 0;" width="20">&nbsp;</td>';
            finalEmailBody+='<td>';
            finalEmailBody+='<a href="https://www.facebook.com/YASHCorporate">';
            finalEmailBody+='<img src="https://assets.codepen.io/210284/fb.gif" alt="Facebook." width="38" height="38" style="display: block;" border="0" />';
            finalEmailBody+='</a>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</table>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</table>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</table>';
            finalEmailBody+='</td>';
            finalEmailBody+='</tr>';
            finalEmailBody+='</table>';
            finalEmailBody+='</body></html>';
        } catch(Exception e){
            System.debug('Failed in send_email method'+e.getMessage());  
            finalEmailBody='';
        }
        return finalEmailBody;
    }
}