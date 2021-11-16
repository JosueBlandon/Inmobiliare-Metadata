@isTest(seealldata=true)
public class CI_AutoConvertLeads_Test {
	static void DataFactory() {
        List<Id> leadIds = new List<Id>();   
        for(Lead l : [SELECT Id,Status,Owner.IsActive FROM Lead Where Status='New' and Owner.IsActive = true limit 1]) { 
        	leadIds.add(l.Id);
        }       
        CI_AutoConvertLeads.LeadAssign(leadIds);    
    }  
    public static testMethod void procesar() {       
        Test.startTest();       
        DataFactory();      
        Test.stopTest();       
    } 
}