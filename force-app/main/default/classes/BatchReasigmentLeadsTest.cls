@IsTest(SeeAllData=true)
public class BatchReasigmentLeadsTest {
        
    static testMethod void testMethod1() {
        
        List<Id> usuarios = new List<Id>();
        Id usuariopropietario;
        string tiporeasignacion;
        
        list<lead>leadupdate= new list<lead>();

        Test.startTest();
        
        BatchReasigmentLeads obj = new BatchReasigmentLeads(usuarios,usuariopropietario,tiporeasignacion);
        DataBase.executeBatch(obj);
        
        obj.execute(null,leadupdate);
        
        Test.stopTest();
        
    }

}