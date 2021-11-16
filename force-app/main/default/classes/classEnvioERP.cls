global class classEnvioERP {
	@future(callout=true)
    public static void envioDatosERP(Id Cotizacion, Id Oportunidad){
        HttpRequest reqObj=new HttpRequest();
        HttpResponse resObj=new HttpResponse();
        Http httpRootObj = new Http();
        
        URL_Servicios_Web__mdt servicio = 
    		[SELECT MasterLabel, Endpoint__c FROM URL_Servicios_Web__mdt WHERE QualifiedApiName='Serivicio_Envio_Cotizacion_ERP'];
        
        reqObj.setEndpoint(servicio.Endpoint__c+'?strParamIDSalesForce='+Cotizacion);
        
        reqObj.setMethod('GET');
        
        reqObj.setTimeout(120000);
        if(!test.isRunningTest()){
            resObj= httpRootObj.send(reqObj);
        }        
        
        Opportunity actualizar = new Opportunity(Id=Oportunidad,Estado_de_Aprobacion__c = 'Aprobado');
        
        try{
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
        }catch(Exception e){
            actualizar.Estado_de_Aprobacion__c = 'Fallido';
        }
        
        //Opportunity actualizar = new Opportunity(Id=Oportunidad,Estado_de_Aprobacion__c = 'Aprobado');
        
        update actualizar;
        
    }
}