public without sharing class CI_AccountTriggerHandler extends TriggerHandler{

    public override void BeforeInsert(){
        ValidacedularucAccount();
        ValidacedulaAccountConyuge();
    }
        
    public override void BeforeUpdate(){
        ValidacedularucAccount();
        ValidacedulaAccountConyuge();
    }
    
    public void ValidacedularucAccount() {
        Map<Id,Schema.RecordTypeInfo> rtMap = Account.sobjectType.getDescribe().getRecordTypeInfosById(); 
        for(Account a:(List<Account>) trigger.new){    
            //system.debug(rtMap.get(a.RecordTypeId).getDeveloperName());   
            boolean resultado = CI_Validaciones.infotributariaecuador(a.CI_Tipo_Persona__c,a.CI_Identificacion__c,a.CI_Tipo_Identi__c,a.RecordType.Name);   
            if(resultado==false){
                //a.CI_Identificacion__c.adderror('Error en validación de '+a.CI_Tipo_Iden__c);
                a.CI_Identificacion__c.adderror('No es una identificación válida');
            }
        }
    }  
    
    public void ValidacedulaAccountConyuge() {
        Map<Id,Schema.RecordTypeInfo> rtMap = Account.sobjectType.getDescribe().getRecordTypeInfosById(); 
        for(Account a:(List<Account>) trigger.new){    
            //system.debug(rtMap.get(a.RecordTypeId).getDeveloperName());   
            boolean resultado = CI_Validaciones.infotributariaecuadorconyuge(a.CI_Tipo_Ident_C__c,a.CI_Identificacion_C__c);   
            if(resultado==false){
                //a.CI_Identificacion__c.adderror('Error en validación de '+a.CI_Tipo_Iden__c);
                a.CI_Identificacion_C__c.adderror('No es una identificación válida');
            }
        }
    }               

}