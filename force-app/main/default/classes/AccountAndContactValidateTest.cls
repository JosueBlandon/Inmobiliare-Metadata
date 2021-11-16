@IsTest(SeeAllData=true)
public class AccountAndContactValidateTest {
    
    static Lead prosp;
    static Account acc;
    static Contact cont;
    
	@isTest static void ejecuciones1() {
        
        prosp = new Lead();
        prosp.LastName = 'TestLead';
        prosp.Email = 'test0123456789@gmail.com';
        prosp.CI_Personeria__c = '1';
        prosp.CI_Tipo_Iden__c = '2';
        prosp.CI_Identificacion__c = '1308095064';
        prosp.CI_Medio_Contacto__c = 'TELÉFONO';
        prosp.CI_Identificacion_C__c = '1303633158';
        insert prosp;
        
        prosp.LastName = 'TestLead2';
        prosp.Email = 'test111111111@gmail.com';
        prosp.CI_Personeria__c = '1';
        prosp.CI_Tipo_Iden__c = '2';
        prosp.CI_Identificacion__c = '1309736559';
        prosp.CI_Medio_Contacto__c = 'CELULAR';
        prosp.CI_Identificacion_C__c = '1303633158';
        prosp.CI_Movil__c = '123123123';
        update prosp;
        
        acc = new Account();
        acc.LastName = 'TestApe';
        insert acc;
    	
        acc.LastName = 'TestApe2';
        update acc;
        
        cont = new Contact();
        cont.LastName = 'TestApe';
        insert cont;
    	
        cont.LastName = 'TestApe2';
        update cont;
        
        Opportunity opp = new Opportunity(Name='test opp', StageName='stage', Probability = 95, CloseDate=system.today());
        insert opp;
        opp.Amount = 1000;
        opp.StageName = 'Closed/Won';
        update opp;
        
        //-----MARCO-----//
        ////METODO OPCIONAL PARA PROBAR LA PRIMERA CONDICION DEL TRIGGER "envioERPTrigger"
        Opportunity opp1 = new Opportunity(Name='test opportunidad 001', StageName='Probable', Probability = 10, CloseDate=system.today());
        insert opp1;
        
        Task tarea = new Task();
        tarea.WhatId = opp1.Id;
        tarea.ActivityDate = System.today();
        tarea.Priority = 'Normal';
        tarea.Subject = 'Nueva Oportunidad Creada';
        tarea.Status = 'Completed';
        insert tarea;
               
        Cotizacion__c cot = new Cotizacion__c();
        cot.Oportunidad__c = opp1.Id;
        cot.CI_Oportunidad_PD__c = opp1.Id;
        cot.Precio_Venta__c = 80000;
        Insert cot;
        
        Cuota_Financiamiento__c cuota = new Cuota_Financiamiento__c();
        cuota.Cotizacion__c = cot.Id;
        cuota.Monto_Pago__c = 2500;
        insert cuota;
        
        opp1.Amount = 1000;
        opp1.Cotizacion__c = Cot.Id;
        opp1.StageName = 'No negociada'; 
        opp1.Estado_de_Aprobacion__c = 'Enviado'; //cambio el estado de la Aprobacion a True para que cumpla la primera condicion
        update opp1;
        
        //METODO OPCIONAL PARA PROBAR LA SEGUNDA CONDICION DEL TRIGGER "envioERPTrigger" (descartado)
        //Opportunity opp2 = new Opportunity(Name='test opp', StageName='stage', Probability = 95, CloseDate=system.today());
        //Cotizacion__c cot = new Cotizacion__c(Ingresa_Preferencial__c = True, CI_Aprobar_cotizacion_pref__c = True);
        //insert cot;
        //insert opp2;
        //opp2.Amount = 1000;
        //opp2.StageName = 'Closed/Won';
        //opp2.Estado_de_Aprobacion__c = 'Enviado'; 
        //opp2.Cotizacion__r.Ingresa_Preferencial__c = True;
        //opp2.Cotizacion__r.CI_Aprobar_cotizacion_pref__c = True;
        //update cot;
        //update opp2;
		//-----MARCO-----//                

        ValidateEditionInAccountClass.validacionesCuenta(opp.id, opp.AccountId, opp.CI_Proyecto__c, Opp.StageName);
        ValidateEditionInAccountClass.validacionesCuenta2(opp.AccountId);
        
    }
}