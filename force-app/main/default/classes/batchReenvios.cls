global class batchReenvios implements Database.Batchable<sObject>, Database.AllowsCallouts{
	global batchReenvios(){
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id, Cotizacion__c, Estado_de_Aprobacion__c FROM Opportunity WHERE Estado_de_Aprobacion__c = \'Fallido\'';
        if(test.isRunningTest()){
            query+=' LIMIT 1';
        }
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        for(Sobject s : scope){
            Opportunity actualizar = (Opportunity)s;
            actualizar.Estado_de_Aprobacion__c = 'Aprobado';
            HttpRequest reqObj=new HttpRequest();
            HttpResponse resObj=new HttpResponse();
            Http httpRootObj = new Http();
            
            URL_Servicios_Web__mdt servicio = 
                [SELECT MasterLabel, Endpoint__c FROM URL_Servicios_Web__mdt WHERE QualifiedApiName='Serivicio_Envio_Cotizacion_ERP'];
            
            reqObj.setEndpoint(servicio.Endpoint__c+'?strParamIDSalesForce='+actualizar.Cotizacion__c);
            
            reqObj.setMethod('GET');
        
            reqObj.setTimeout(120000);
            if(!test.isRunningTest()){
                resObj= httpRootObj.send(reqObj);
            }
        
            if (resObj.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                             resObj.getStatusCode() + ' ' + resObj.getStatus());
                actualizar.Estado_de_Aprobacion__c = 'Fallido';
            } else {
                System.debug(resObj.getBody());
                if(resObj.getBody().contains('false')){
                    actualizar.Estado_de_Aprobacion__c = 'Fallido';
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}