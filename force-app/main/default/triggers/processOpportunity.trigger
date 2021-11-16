trigger processOpportunity on Opportunity (before insert, before update) {
    
    //Asign value Gestor field to Email Gestor field
    for (Opportunity obj : trigger.new){
        if (obj.CI_Gestor__c != null && System.Trigger.isUpdate) {
            obj.CI_Email_Gestor__c = obj.CI_Gestor__c;
        }    
    }
    //End Asign value Gestor field to Email Gestor field
    
    //Insertando registros en Permiso a Cuenta 
    Boolean b = System.isFuture();   
    if(b == False) {
    for(Opportunity opor2 : Trigger.new) {
        if((opor2.StageName == 'Probable' || opor2.StageName == 'Negociando') && opor2.Estado_de_Venta__c != 'Vendido') {
            ValidateEditionInAccountClass.validacionesCuenta(opor2.Id,opor2.AccountId,opor2.CI_Proyecto__c,opor2.StageName); 
        } else if((opor2.StageName == 'Vendida' && opor2.Estado_de_Venta__c == 'Vendido') || opor2.StageName == 'No negociada') {
            ValidateEditionInAccountClass.validacionesCuenta(opor2.Id,opor2.AccountId,opor2.CI_Proyecto__c,opor2.StageName); 
        }
    }
    }
    
    Map<String, Opportunity> oppMap = new Map<String, Opportunity>(); //Proyecto
    
    for (Opportunity opp : System.Trigger.new) {           
        if ((opp.CI_Proyecto__c != null) && (System.Trigger.isInsert || (opp.CI_Proyecto__c != System.Trigger.oldMap.get(opp.Id).CI_Proyecto__c))) {                        
            if (oppMap.containsKey(opp.CI_Proyecto__c)) {
                opp.CI_Proyecto__c.addError('Ya existen oportunidades con este proyecto.');
            } else {
                oppMap.put(opp.CI_Proyecto__c, opp);
            }
        }
    }
    
    //String Name = UserInfo.getName(); System.debug(Name);
    
    //Proyecto del Usuario
    String UserId = UserInfo.getUserId();
    List<User> usuario = [SELECT Id, Name, CI_Nombre_Funcion__c FROM User WHERE Id =: UserId LIMIT 1];
    String UserProyecto = usuario[0].CI_Nombre_Funcion__c; //system.debug('UserProyecto ' + UserProyecto);    
    
    //Cuenta de la Oportunidad
    String accid;
    for (Opportunity opoId : Trigger.new) {
        List<Account> account = [SELECT Id FROM Account WHERE Id =: opoId.AccountId];
        if(account != null && account.size()>0) {
            accid = account[0].Id;  
        } 
    }
    
    //List<Opportunity> oport = [SELECT Id,Name,StageName,CI_Proyecto__c,Owner.Name,AccountId FROM Opportunity
                      //WHERE CI_Proyecto__c IN :oppMap.KeySet() and AccountId =: accid];
    List<Opportunity> oport = [SELECT Id,Name,StageName,CI_Proyecto__c,Owner.Name,AccountId FROM Opportunity
                      WHERE CI_Proyecto__c =: UserProyecto and AccountId =: accid and (StageName != 'Vendida' and StageName != 'No negociada')]; System.debug('Total Opor: ' + oport.size());
    
    String IdUser = UserInfo.getUserId(); System.debug(IdUser);   
    
    //Perfil del Usuario
    String ProfileId = UserInfo.getProfileId();
    List<Profile> Profile = [SELECT Id, Name FROM Profile WHERE Id =: ProfileId LIMIT 1];
    String ProfileName = Profile[0].Name; //system.debug('ProfileName ' + ProfileName);
    
    for (Opportunity opp : oport) {
        Opportunity newOpp = oppMap.get(opp.CI_Proyecto__c); //System.debug('Oportunidades existentes: ' + oport.size());
        if(opp.OwnerId != IdUser && ProfileName == 'Asesor de Ventas') {  
            newOpp.addError('Existen oportunidades abiertas para este proyecto por lo cual en este momento no puede crear una nueva.');
        }     
    }
      
}