@IsTest(SeeAllData=true)
public class CI_Apex_Test {
    
    static Account acc;
    static Opportunity opp;
    static Cotizacion__c testCot;
    
    static CI_apex instance;
    
    static Lead pros;
    static Promocion__c Prom;
    static Detalle_Promocion__c detProm;
    
    static Financiamiento__c finan;
    static Cuota_Financiamiento__c cuota;
    
    static Lote__c lote;
    static Document document;
    static ContentVersion cv;
    static ContentDocumentLink cdl;
    
    static void DataFactory() {
       
        acc = new Account();
        acc.LastName = 'TestAcc';
        insert acc;
        
        opp = new Opportunity();
        opp.Name = 'TestOpp';
        opp.StageName = 'Abierta'; 
        opp.CloseDate = System.today();
        insert opp;
        
        testCot = new Cotizacion__c();
        
        testCot.Estado__c='Nueva';
        testCot.CI_Cuenta__c=acc.Id;
        testCot.Oportunidad__c=opp.Id;
        testCot.CI_Oportunidad_PD__c=opp.Id;
        insert testCot;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(testCot);
        instance = new CI_apex(sc);
        
        //select id, name, CI_Correo_Validado__c from Lead where id = :id and CI_Correo_Validado__c = false
        pros = new Lead();
        pros.LastName = 'TestLead';
        pros.CI_Correo_Validado__c = true;
        insert pros;
        
        instance.updateValue();
        
        instance.updateCotizacion();
        
        Prom = new Promocion__c();
        Prom.Name = 'Promo';
        insert Prom;
        
        detProm = new Detalle_Promocion__c();
        detProm.Cotizacion__c = testCot.Id;
        detProm.Promocion__c = Prom.Id;
        detProm.CI_Fecha_Promo_Agre__c = System.today();
        detProm.Valor_Promocion__c = 0;
        insert detProm;
        
        instance.getPromosCotiza();
        instance.getPromos();
        instance.getAdic();
        
        finan = new Financiamiento__c();
        finan.name = 'testFinan';
        finan.Cotizacion__c = testCot.Id;
        insert finan;
        
        cuota = new Cuota_Financiamiento__c();
        cuota.Cotizacion__c = testCot.Id;
        cuota.Tipo__c = '1';
        cuota.Orden__c = 1;
        cuota.Es_Personalizado__c = true;
        cuota.Es_Personalizado_Nueva_Cuota__c = true;
        cuota.Es_Personalizado_Cuota_Original__c = true;
        cuota.Valor_Saldo__c = 1200;
        cuota.Valor_dividendo__c = 500;
        cuota.Valor_Presente__c = 100;
        cuota.Financiamiento__c = finan.Id;
        cuota.Fecha_de_Vencimiento__c = System.today();
        cuota.Monto_sin_Descuento__c = 600;
        insert cuota;
        
        instance.getFinanciamiento();
        instance.getFinanciamiento3();
        instance.getFinanciamiento4();
        instance.getFinanciamiento2();
        
        lote = new Lote__c();
        lote.Name = 'Casa 01';
        Insert lote;
        
        System.debug(lote);
        
        ContentVersion content=new ContentVersion(); 
        content.Title='Inmueble'; 
        content.PathOnClient='/' + content.Title + '.png'; 
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        content.VersionData=bodyBlob; 
        content.origin = 'H';
        insert content;
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=lote.id;
        contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
        contentlink.ShareType = 'V';
        contentlink.Visibility = 'AllUsers'; 
        
        insert contentlink;
        
        System.debug(contentLink);
        
        //instance.getimagenInmueble();
        
    }
       
    public static testMethod void procesar() {
        
        Test.startTest();
        
        DataFactory();
        
        apexpages.currentpage().getparameters().put('id',testCot.id);
        
        CI_apex.camposCotizacion(testCot.id);
        
        Test.stopTest();
        
    } 

}