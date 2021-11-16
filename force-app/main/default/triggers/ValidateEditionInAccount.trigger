trigger ValidateEditionInAccount on Account (before update) {  
    
    try {
    
    //Get Id of Account
    Set<String> cliente = new Set<String>();
    for (Account acc : Trigger.new) {
        cliente.add(acc.Id);
    }
    //End Get Id of Account
    //Perfil del Usuario
    String ProfileId = UserInfo.getProfileId();
    List<Profile> Profile = [SELECT Id, Name FROM Profile WHERE Id =: ProfileId LIMIT 1];
    String ProfileName = Profile[0].Name; system.debug('ProfileName ' + ProfileName);
    
    //Proyecto del Usuario
    String UserId = UserInfo.getUserId();
    List<User> usuario = [SELECT Id, Name, CI_Nombre_Funcion__c FROM User WHERE Id =: UserId LIMIT 1];
    String UserProyecto = usuario[0].CI_Nombre_Funcion__c; system.debug('UserProyecto ' + UserProyecto);
    
    //Id del Proyecto
    List<Proyecto__c> proyect = [SELECT Id, Name FROM Proyecto__c WHERE Name =: UserProyecto LIMIT 1];
    String UserProyectoId = proyect[0].Id; system.debug('UserProyectoId ' + UserProyectoId);
       
    List<Permiso_a_Cuenta__c> permiso = [Select Id,Name,CI_Proyecto__c,CI_Oportunidad__c,CI_Propietario__c,CI_Permite_Edicion__c from Permiso_a_Cuenta__c where CI_Propietario__c =: UserId and CI_Cuenta__c IN: cliente and CI_Permite_Edicion__c =: True];
    System.debug('permiso ' + permiso);
    
    //Permisos por Jefes
    List<Permiso_a_Cuenta__c> permiso2 = [Select Id,Name,CI_Proyecto__c,CI_Cuenta__c,CI_Oportunidad__c,CI_Propietario__c,CI_Permite_Edicion__c from Permiso_a_Cuenta__c where CI_Proyecto__c =: UserProyecto and CI_Cuenta__c IN: cliente and CI_Permite_Edicion__c = True];
    System.debug('Permisos Jefe ' + permiso2.size());
    
    for (Account acc : Trigger.new) {     
        if(Acc.Id != null && permiso.size() == 0 && ProfileName == 'Asesor de Ventas' && acc.CI_Convertido_Lead__c == 'No') {   
            acc.addError('No puede modificar la cuenta porque no tiene oportunidades activas para este registro.');    
        }
        if((ProfileName == 'Jefe de Ventas' || ProfileName == 'Coordinador de Ventas') && acc.CI_Proyecto__c != UserProyectoId && permiso2.size() == 0) {   
            acc.addError('No puede modificar la cuenta porque no pertenece a este proyecto.');    
        }
    }
        
    } catch(Exception ex) {
        System.debug('Error en ValidateEditionInAccout class: '+ex.getLineNumber()+'---'+ex.getMessage());
    }
}