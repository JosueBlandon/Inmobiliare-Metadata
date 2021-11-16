trigger createTask_Opportunity on Opportunity (after insert) { 
    //Crear tarea cuando se crea una Oportunidad
    boolean flag = false;
    String oppId;
    Task tsk =new Task();
    for(Opportunity opor : Trigger.New) {
        if(opor.StageName == 'Probable') { flag = true; oppId = opor.id;
        }
    }
    if(flag) { tsk.WhatId = oppId; tsk.Subject = 'Nueva Oportunidad Creada'; tsk.Priority = 'Normal'; tsk.Status = 'Completed'; tsk.ActivityDate = System.Today(); insert tsk;
    }

    //Insertando registros en Permiso a Cuenta
    List<Permiso_a_Cuenta__c> lista = new List<Permiso_a_Cuenta__c>();
    for(Opportunity opor2 : Trigger.New) {
    	lista.add(new Permiso_a_Cuenta__c(CI_Cuenta__c = opor2.AccountId, CI_Proyecto__c = opor2.CI_Proyecto__c, CI_Oportunidad__c = opor2.Id, CI_Propietario__c = opor2.OwnerId, CI_Permite_Edicion__c = true));    
    }
    if(!lista.isEmpty()) {
    	insert lista;
    }
    
}