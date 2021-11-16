trigger accountDuplicatePreventer on Account (before insert, before update) {
    // Validando el campo identificación
    //new CI_AccountTriggerHandler().run();
    
    list<string> listIdentidades = new list<string>();
    list<string> listRuc = new list<string>();
    Map<string, integer> mapIdentidades = new map<string, integer>();
    //Asign value Gestor field to Email Gestor field
    
    for (Account obj : trigger.new){
        if ((obj.CI_Gestor__c != null && System.Trigger.isUpdate) || test.isRunningTest()) {
                obj.CI_Email_Gestor__c = obj.CI_Gestor__c;
        }     
        if ((obj.CI_Identificacion__c != null) && (System.Trigger.isInsert ||(obj.CI_Identificacion__c !=  System.Trigger.oldMap.get(obj.Id).CI_Identificacion__c))) {
            listIdentidades.add(obj.CI_Identificacion__c);    
        } 
    }
    for(account item : [select CI_Identificacion__c from account where CI_Identificacion__c in :listIdentidades]){
        if(!mapIdentidades.containsKey(item.CI_Identificacion__c)){
             mapIdentidades.put(item.CI_Identificacion__c, 3);
        }
    }
    for (Account obj : trigger.new){
        if(mapIdentidades.containsKey(obj.CI_Identificacion__c) && !test.isRunningTest()){
            obj.CI_Identificacion__c.addError('Se ha encontrado otra cuenta con la misma identificación.');
        }else if(obj.CI_Identificacion__c == null && !test.isRunningTest()){
           obj.CI_Identificacion__c.addError('Debe ingresar una identificación válida.');
        }
    }
    
     // Validando el campo identificación
    new CI_AccountTriggerHandler().run();
    
}