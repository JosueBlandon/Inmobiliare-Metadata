trigger trigger_UpdCuotasFinanciamiento on Opportunity (after update) {
    /*Conf_Validaciones_SLA__c config = Conf_Validaciones_SLA__c.getValues('RG-8');
    
    if(config.Activa__c){
        for(Integer i=0;i<trigger.new.size();i++){       
            Opportunity OppNew = trigger.new[i];
            Opportunity OppOld = trigger.old[i];
            
            if(OppNew.Fecha_de_Reserva__c <> null && OppOld.Fecha_de_Reserva__c == null){
                Cotizacion__c CotNueva = [select id from Cotizacion__c where Oportunidad__c =: OppNew.Id order by CreatedDate desc limit 1 ];
                
                List<Cuota_Financiamiento__c> CuoFin = [select id, Name, Fecha__c from Cuota_Financiamiento__c where Cotizacion__c =: CotNueva.Id order by id];
                
                Date nuevoInicio = OppNew.Fecha_de_Reserva__c.addDays(Integer.valueOf(config.Valor_de_N__c));
                Boolean primero = true;
                
                for(Cuota_Financiamiento__c cuota:CuoFin){
                    if(primero){
                        primero = false;
                        cuota.fecha__c = nuevoInicio;
                    }else{
                        nuevoInicio= nuevoInicio.addMonths(1);
                        cuota.fecha__c = nuevoInicio;
                    }
                }                
                
                update CuoFin;
            }
        }
    }*/
}