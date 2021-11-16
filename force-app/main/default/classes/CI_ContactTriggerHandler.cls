public without sharing class CI_ContactTriggerHandler extends TriggerHandler{

    public override void BeforeInsert(){
        ValidacedulaContact();
    }
        
    public override void BeforeUpdate(){
        ValidacedulaContact();
    }
    
    public void ValidacedulaContact() {
        Map<Id,Schema.RecordTypeInfo> rtMap = Contact.sobjectType.getDescribe().getRecordTypeInfosById(); 
        for(Contact a:(List<Contact>) trigger.new){     
            boolean resultado = CI_Validaciones.infotributariaecuadorconyuge(a.CI_Tipo_Identi__c,a.CI_Identificacion__c);   
            if(resultado==false){
                a.CI_Identificacion__c.adderror('No es una identificación válida');
            }
        }
    }                

}