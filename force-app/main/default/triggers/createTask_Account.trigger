trigger createTask_Account on Account (after insert) {    
    //Crear tarea cuando se crea una cuenta
    boolean flag = false;
    String accountId;
    Task tsk =new Task();
    for(Account acc : Trigger.New) {
        if(acc.CI_Tipo_de_Cliente__c == 'Prospecto Potencial') { flag = true; accountId = acc.id;
        }
    }
    if(flag) { tsk.WhatId = accountId; tsk.Subject = 'Nueva Cuenta Creada'; tsk.Priority = 'High'; tsk.Status = 'Completed'; tsk.ActivityDate = System.Today(); insert tsk;
    }   
    
    //Poner el campo Convertido desde Lead = No
    for(Account acc : Trigger.new) {
        if(acc.CI_Convertido_Lead__c == 'Si') { ValidateEditionInAccountClass.validacionesCuenta2(acc.Id); 
        }
    }
}