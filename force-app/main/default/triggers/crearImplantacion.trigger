trigger crearImplantacion on Lote__c (after insert) {

    List<Implantacion__c> lista = new List<Implantacion__c>();
    for(Lote__c item: trigger.new){
        lista.add(new Implantacion__c(Lote__c = item.Id, Modelo__c = item.CI_Modelo_Casa__c, Precio_Lista__c=item.CI_Precio_Actual__c, activo__c=true));
    }
    
    insert lista;
}