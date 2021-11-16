public without sharing class CI_LeadTriggerHandler extends TriggerHandler{

    public override void BeforeInsert(){
        Validarcedularuc(); 
    }
        
    public override void BeforeUpdate(){
        Validarcedularuc();
    }
       
    public void Validarcedularuc() {
        Map<Id,Schema.RecordTypeInfo> rtMap = Lead.sobjectType.getDescribe().getRecordTypeInfosById(); 
        for(Lead a:(List<Lead>) trigger.new){    
            //system.debug(rtMap.get(a.RecordTypeId).getDeveloperName());   
            boolean resultado = CI_Validaciones.infotributariaecuador(a.CI_Personeria__c,a.CI_Identificacion__c,a.CI_Tipo_Iden__c,a.RecordType.Name);   
            if(resultado==false){
                //a.CI_Identificacion__c.adderror('Error en validación de '+a.CI_Tipo_Iden__c);
                a.CI_Identificacion__c.adderror('No es una identificación válida');
            }
        }
    }           

}