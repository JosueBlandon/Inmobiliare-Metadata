@IsTest(SeeAllData=true)
public class Test_CI_CambiarPropietarioLead {
    static Lead prosp;
	static void DataFactory() {
        CI_CambiarPropietarioLead cp = new CI_CambiarPropietarioLead();
        
        User u0 = [Select Id, Name, ProfileID, ManagerId from User Where Profile.Name = 'Asesor de Ventas' and ManagerId != null Limit 1];
        
        prosp = new Lead();
        prosp.LastName = 'TestLead';
        prosp.Email = 'test0123456789@gmail.com';
        prosp.CI_Personeria__c = '1';
        prosp.CI_Tipo_Iden__c = '2';
        prosp.CI_Identificacion__c = '1308095064';
        prosp.CI_Medio_Contacto__c = 'TELÉFONO';
        prosp.CI_Identificacion_C__c = '1303633158';
        prosp.OwnerId = u0.Id;
        insert prosp;
      
    }
    public static testMethod void ventasctas() {
       
        Test.startTest();
        
        DataFactory();
        
        CI_CambiarPropietarioLead.changeOwnerMethod(prosp.Id);
        
        Test.stopTest();
        
    }    
}