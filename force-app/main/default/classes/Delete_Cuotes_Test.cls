@IsTest(SeeAllData=true)
public class Delete_Cuotes_Test {
    @isTest static void TriggerDelete() {
        Cuota_Financiamiento__c cuot = new Cuota_Financiamiento__c();//creo la cuota a insertar
        cuot.Monto_Pago__c = 0;//Le asigno Monto igual a 0 ya que el trigger deberia eliminarla luego de ser ingresada
        insert cuot;//inserto la cuota con monto 0
    }
}