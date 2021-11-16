trigger envioERPTrigger on Opportunity (after update) {
    if(Trigger.new[0].Estado_de_Aprobacion__c == 'Enviado' && Trigger.new[0].Cotizacion__r.Ingresa_Preferencial__c == false){
    	classEnvioERP.envioDatosERP(Trigger.new[0].Cotizacion__c, Trigger.new[0].Id);
    }  else if(Trigger.new[0].Estado_de_Aprobacion__c == 'Enviado' && Trigger.new[0].Cotizacion__r.Ingresa_Preferencial__c == True && Trigger.new[0].Cotizacion__r.CI_Aprobar_cotizacion_pref__c == True) {
    	classEnvioERP.envioDatosERP(Trigger.new[0].Cotizacion__c, Trigger.new[0].Id);    
    }    
}