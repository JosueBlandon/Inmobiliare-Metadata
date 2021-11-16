@IsTest
public class testaAcountDuplicatePreventer {
    
    public testmethod static void AcountDuplicatePreventer() {
        Account acc = new Account();
        acc.LastName = 'TestApe';
        acc.CI_Identificacion__c = '1234';
        insert acc;
        
        acc= new Account();
        acc.LastName = 'TestApe';
        acc.CI_Identificacion__c = '1234';
        insert acc;   
    }

}