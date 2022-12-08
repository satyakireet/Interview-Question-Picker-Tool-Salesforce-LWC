@isTest
public class RandomUtilityTest {
    @isTest
	static void testGenerateRandomFromRange(){
        test.startTest();
         try{
        Integer generateRandomNumberTest = RandomUtility.generateRandomFromRange(1,2);
        Integer generateRandomNumberTest1 = RandomUtility.generateRandomFromRange(1,3);
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
    @isTest
	static void testGenerateRandomNumber(){
        test.startTest();
         try{
        Integer testGenerateRandomNumber = RandomUtility.generateRandomNumber(5);
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
    @isTest
	static void testGenerateRandomBoolean(){
        test.startTest();
         try{
        Boolean testGenerateRandomBoolean = RandomUtility.generateRandomBoolean();
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
     @isTest
	static void testfindRandomStringFromList(){
        test.startTest();
         try{
        String testfindRandomStringFromList = RandomUtility.findRandomStringFromList(new List<String>{'abc', 'xyz'});
         }catch(Exception e){
             system.debug('Error'+e.getMessage());
         }
        test.stopTest();
    }
    
}