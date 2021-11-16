@IsTest(SeeAllData=true)
public class BatchReasigmentOppTest {
    
	static testMethod void testMethod1() {
        
        Id userorigenbatch;
        Id userdestinobatch;
        string tiporeasignacion; 
        
        list<Opportunity>opor= new list<Opportunity>();
        
        //tiporeasignacion = 'reasignación';
                
        Test.startTest();
        
        BatchReasigmentOpp obj = new BatchReasigmentOpp(userorigenbatch,userdestinobatch,tiporeasignacion);
        DataBase.executeBatch(obj);
        
        obj.execute(null,opor);
        
        Test.stopTest();
        
    }
}