trigger createTask_Lead on Lead (after insert) {    
    //Crear tarea cuando se crea una cuenta
    boolean flag = false;
    String leadId;
    Task tsk =new Task();
    String Name = UserInfo.getName(); System.debug(Name);
    for(Lead ld : Trigger.New) {
        if(Name != 'B2BMA Integration') { flag = true; leadId = ld.id;
        }
    }
    if(flag) { tsk.WhoId = leadId; tsk.Subject = 'Nuevo Prospecto creado por el Asesor'; tsk.Priority = 'Normal'; tsk.Status = 'Completed'; tsk.ActivityDate = System.Today(); insert tsk;
    }    
}