trigger leadDuplicatePreventer on Lead (before insert, before update) {

    Map<String, Lead> leadMap = new Map<String, Lead>(); //Email
    
    Map<String, Lead> leadMap2 = new Map<String, Lead>(); //Cédula

    Map<String, Lead> leadMap3 = new Map<String, Lead>(); //Cédula cónyuge
    
    Map<String, Lead> leadMap4 = new Map<String, Lead>(); //Cédula prospecto vrs Cédula cónyuge
      
    //Asign value Gestor field to Email Gestor field
    for (Lead obj : trigger.new) {
        if (obj.CI_Gestor__c != null && System.Trigger.isUpdate) { obj.Email_Gestor__c = obj.CI_Gestor__c;
        }    
    }
    //End Asign value Gestor field to Email Gestor field
    
    //Asign proyect to proyect
    for (Lead obj2 : trigger.new) {
        if (obj2.CI_Proyecto__c != null && obj2.CI_Cod_Proyecto__c == null) { obj2.CI_Cod_Proyecto__c = obj2.CI_Proyecto_User__c;
        }    
    }
    //End Asign proyect to proyect
    
    for (Lead lead : System.Trigger.new) {
        
        // Asegurando no tratar una dirección de correo electrónico que
        // no está cambiando durante una actualización como un duplicado. 
             
        if ((lead.Email != null) &&
                (System.Trigger.isInsert ||
                (lead.Email != 
                    System.Trigger.oldMap.get(lead.Id).Email))) {
        
            // Asegúrese de que otro nuevo cliente potencial no sea también un duplicado 
    
            if (leadMap.containsKey(lead.Email)) { lead.Email.addError('Otro prospecto tiene la misma dirección de correo electrónico.');
            } else {
                leadMap.put(lead.Email, lead);
            }
        }
    
        if ((lead.CI_Identificacion__c != null) &&
                (System.Trigger.isInsert ||
                (lead.CI_Identificacion__c != 
                    System.Trigger.oldMap.get(lead.Id).CI_Identificacion__c))) {
        
            // Asegúrese de que otro nuevo cliente potencial no sea también un duplicado 
    
            if (leadMap2.containsKey(lead.CI_Identificacion__c)) {
                lead.CI_Identificacion__c.addError('Otro prospecto tiene la misma identificación.');
            } else {
                leadMap2.put(lead.CI_Identificacion__c, lead);
            }
        } else if(lead.CI_Identificacion__c == null) {
        	lead.CI_Identificacion__c.addError('Debe ingresar una identificación válida.');   
        }

        if ((lead.CI_Identificacion_C__c != null) &&
                (System.Trigger.isInsert ||
                (lead.CI_Identificacion_C__c != 
                    System.Trigger.oldMap.get(lead.Id).CI_Identificacion_C__c))) {
        
            // Asegúrese de que otro nuevo cliente potencial no sea también un duplicado 
    
            if (leadMap3.containsKey(lead.CI_Identificacion_C__c)) {
                lead.CI_Identificacion_C__c.addError('Un prospecto ya existe con la misma identificación.');
            } else {
                leadMap3.put(lead.CI_Identificacion_C__c, lead);
            }
        }
        
        if ((lead.CI_Identificacion__c != null) &&
                (System.Trigger.isInsert ||
                (lead.CI_Identificacion__c!= 
                    System.Trigger.oldMap.get(lead.Id).CI_Identificacion__c))) {
        
            // Asegúrese de que otro nuevo cliente potencial no sea también un duplicado 
    
            if (leadMap4.containsKey(lead.CI_Identificacion__c)) {
                lead.CI_Identificacion__c.addError('Un cónyuge ya existe con la misma identificación.');
            } else {
                leadMap4.put(lead.CI_Identificacion__c, lead);
            }
        }

    }
    
    // Usando una sola consulta de base de datos, encuentre todos los leads en
    
    // la base de datos que tiene la misma dirección de correo electrónico que cualquier otra  
    
    // de los leads que se insertan o actualizan.  
    
    String Name = UserInfo.getName(); System.debug(Name);
    
    for (Lead lead : [SELECT Email,Owner.Name,CI_Web_to_Lead__c FROM Lead
                      WHERE Email IN :leadMap.KeySet()]) {
        //if(Lead.Owner.Name != Name) { 
        if(Name != 'B2BMA Integration') { Lead newLead = leadMap.get(lead.Email); newLead.Email.addError('Un prospecto con esta dirección de correo electrónico ya existe y es propiedad de: '+lead.Owner.Name);
        }    
    }   
    
    for (Lead lead2 : [SELECT Id,CI_Identificacion__c,Owner.Name FROM Lead
                      WHERE CI_Identificacion__c IN :leadMap2.KeySet()]) { 
        /*if(Name != 'B2BMA Integration') { Lead newLead = leadMap2.get(lead2.CI_Identificacion__c); newLead.CI_Identificacion__c.addError('Un prospecto con esta identificación ya existe y es propiedad de: '+lead2.Owner.Name);  
        } */     
        Lead newLead = leadMap2.get(lead2.CI_Identificacion__c); newLead.CI_Identificacion__c.addError('Un prospecto con esta identificación ya existe o ya ha sido convertido a Cuenta y es propiedad de: '+lead2.Owner.Name);                                        
    } 
    
    for (Lead lead3 : [SELECT CI_Identificacion__c,CI_Identificacion_C__c,Owner.Name FROM Lead
                      WHERE CI_Identificacion__c IN :leadMap3.KeySet()]) { 
        if(Name != 'B2BMA Integration') { Lead newLead = leadMap3.get(lead3.CI_Identificacion__c); newLead.CI_Identificacion_C__c.addError('La identificación de este cónyuge ya existe como prospecto con id: ' +lead3.CI_Identificacion__c+' y es propiedad de: '+lead3.Owner.Name); 
        }    
    }
    
    for (Lead lead4 : [SELECT CI_Identificacion__c,CI_Identificacion_C__c,Owner.Name FROM Lead
                      WHERE CI_Identificacion_C__c IN :leadMap4.KeySet()]) {
        if(Name != 'B2BMA Integration') { Lead newLead = leadMap4.get(lead4.CI_Identificacion_C__c); newLead.CI_Identificacion__c.addError('Un cónyuge con esta identificación ya existe bajo el id: ' +lead4.CI_Identificacion__c+' y es propiedad de: '+lead4.Owner.Name);
        }    
    }
      
    for(Lead lead5:trigger.new) {
        if((lead5.CI_Cod_Proyecto__c == '' || lead5.CI_Cod_Proyecto__c == null) && Name == 'B2BMA Integration') {
            lead5.CI_Cod_Proyecto__c.addError('El proyecto es requerido.');
        }
    }
    
    // Validando el campo identificación
    new CI_LeadTriggerHandler().run();
    
}