trigger Trigger_EnvioAprobacionOportunidad on Cotizacion__c (before insert, before update) {
    for(Integer i=0;i<trigger.new.size();i++){ 
        if (Trigger.isUpdate){
           
            Cotizacion__c CotiNew = trigger.new[i];
            Cotizacion__c CotiOld = trigger.old[i];
            
            
            if((!CotiOld.Ingresa_Preferencial__c) && (CotiNew.Ingresa_Preferencial__c) ){
                Opportunity op = [select id, OwnerId from Opportunity where id=: CotiNew.Oportunidad__c limit 1];
                
                Correos_Notificaciones__c config = Correos_Notificaciones__c.getValues('Aprobador');
                User usuario = [select id from User where Email =: config.Direccion_Correo__c limit 1];
                
                op.ownerId = usuario.id;
                update op;

                String mensajeCorreo = '';
                String dire = config.Direccion_Correo__c;
                String[] dir = dire.split(',');
                    
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = dir;
                message.optOutPolicy = 'FILTER';
                message.subject = 'Nueva aprobación pendiente';
                
                mensajeCorreo = mensajeCorreo + '\nBuen día,\nSe tiene una oportunidad nueva pendiente de su aprobación.\n';
                message.plainTextBody=mensajeCorreo+'\n\nPS. Favor no responder a esta dirección de correo.';
                
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                    
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                                
            }
        }else{
            
            Cotizacion__c CotiNew = trigger.new[i];
            if(CotiNew.Ingresa_Preferencial__c ){
                Opportunity op = [select id, OwnerId from Opportunity where id=: CotiNew.Oportunidad__c limit 1];
                
                Correos_Notificaciones__c config = Correos_Notificaciones__c.getValues('Aprobador');
                User usuario = [select id from User where Email =: config.Direccion_Correo__c limit 1];
                
                op.ownerId = usuario.id;
                update op;

                String mensajeCorreo = '';
                String dire = config.Direccion_Correo__c;
                String[] dir = dire.split(',');
                    
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = dir;
                message.optOutPolicy = 'FILTER';
                message.subject = 'Nueva aprobación pendiente';
                
                mensajeCorreo = mensajeCorreo + '\nBuen día,\nSe tiene una oportunidad nueva pendiente de su aprobación.\n';
                message.plainTextBody=mensajeCorreo+'\n\nPS. Favor no responder a esta dirección de correo.';
                
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                    
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                                
            }
        }
    }

}