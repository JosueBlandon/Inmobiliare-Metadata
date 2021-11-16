@IsTest
public class CI_Validaciones_Test {
    
    static RecordType tipoRegistro;
    
    static void DataFactory() {
        
        CI_Validaciones val = new CI_Validaciones();
        
        tipoRegistro=[select id,name from RecordType where Name =: 'Prospecto principal'];
        
    }
    
    public static testMethod void procesar() {
        
        Test.startTest();
        
        DataFactory();
        
        //apexpages.currentpage().getparameters().put('id',testCot.id);
        
        CI_Validaciones.infotributariaecuador(null,null,null,null);
        CI_Validaciones.infotributariaecuador('Natural','1103393912','Cédula',tipoRegistro.id);
        CI_Validaciones.infotributariaecuadorconyuge('Natural','1103393912');
        CI_Validaciones.validateCedula('1103393912');
        CI_Validaciones.validateRUC('1790550176001');
        CI_Validaciones.validateRUC('1760550176001');
        
        integer sumatoria = 0;
                   
        CI_Validaciones.validateRUC('1234567890');
        CI_Validaciones.validateRUC('1234567890123');
        
        Test.stopTest();
        
    } 

}