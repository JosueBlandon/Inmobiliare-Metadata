public class CI_apex {

    String id = ApexPages.currentPage().getParameters().get('id');

    public String idInmueble{get;set;}
    
    public Decimal sumAdicionales{get;set;}
    
    public Decimal TotalVenta{get;set;}

    public CI_apex(ApexPages.StandardController controller) { 
    
      List<Cotizacion__c> cotiza = [Select id, name, Precio_Venta__c, Implantaci_n_Principal__r.Lote__c, Implantaci_n_Principal__r.Modelo__c from Cotizacion__c where id =: id Limit 1]; 
      Id idlote = null;
      if(cotiza.size()>0) {
        idlote = cotiza[0].Implantaci_n_Principal__r.Modelo__c;  
      } 
            
      AggregateResult[] groupedResults = [Select Sum(Valor_Promocion__c) sum From Detalle_Promocion__c Where Cotizacion__c =: id and Valor_Promocion__c>0];
      sumAdicionales = 0;
      if((decimal)groupedResults[0].get('sum')>0) {
        sumAdicionales = (decimal)groupedResults[0].get('sum');
      }
      
      TotalVenta = null; 
      if(cotiza.size()>0) {
        TotalVenta = cotiza[0].Precio_Venta__c + sumAdicionales;
      }  
    
      List<Modelo__c> lote = [Select id, name from Modelo__c where id =: idlote];   
      idInmueble = null;
      if(lote.size()>0) {
        idInmueble = lote[0].id; System.debug(idInmueble);
      }       
    
    }
    
    public PageReference updateValue() {
           
        List<Lead> leads = [select id, name, CI_Correo_Validado__c from Lead where id = :id and CI_Correo_Validado__c = false];   
        if(leads.size() > 0) {
            leads[0].CI_Correo_Validado__c = true;
            update leads;
        }
        return null;
    
    }
    
    public PageReference updateCotizacion() {
           
        List<Cotizacion__c> cotiza = [select id, name, CI_Aprobar_cotizacion_pref__c from Cotizacion__c where id = :id and CI_Aprobar_cotizacion_pref__c = false];   
        if(cotiza.size() > 0) {
            cotiza[0].CI_Aprobar_cotizacion_pref__c = true;
            update cotiza;
        }
        return null;
    
    }
    
    @AuraEnabled
    public static string camposCotizacion(Id recordId) {
        list<Cotizacion__c> ListaCotizacion = [Select id,name,Ingresa_Preferencial__c,CI_Aprobar_cotizacion_pref__c FROM Cotizacion__c WHERE id=:recordId];        
        string campos = JSON.serialize(new Map<String,Object> {
            'Preferencial' => ListaCotizacion[0].Ingresa_Preferencial__c,
            'Aprobada' => ListaCotizacion[0].CI_Aprobar_cotizacion_pref__c 
        });
        return campos;
    }
    
    public List<Detalle_Promocion__c> getPromosCotiza() {     
      List<Detalle_Promocion__c> promosCotiza = Database.query('Select id, name, Cotizacion__c, Promocion__c, Promocion__r.Name, Promocion__r.CI_Valor__c, CI_Fecha_Promo_Agre__c, Valor_Promocion__c From Detalle_Promocion__c Where Cotizacion__c =: id order by Promocion__r.CI_Valor__c Desc');
      return promosCotiza;
    }
    
    public List<Detalle_Promocion__c> getPromos() {     
      List<Detalle_Promocion__c> promos = Database.query('Select id, name, Cotizacion__c, Promocion__c, Promocion__r.Name, Promocion__r.CI_Valor__c, CI_Fecha_Promo_Agre__c From Detalle_Promocion__c Where Cotizacion__c =: id and (Valor_Promocion__c=0 or Valor_Promocion__c=null)');
      return promos;
    }
        
    public List<Detalle_Promocion__c> getAdic() {     
      List<Detalle_Promocion__c> adic = Database.query('Select id, name, Cotizacion__c, Promocion__c, Promocion__r.Name, Promocion__r.CI_Valor__c, CI_Fecha_Promo_Agre__c, Valor_Promocion__c From Detalle_Promocion__c Where Cotizacion__c =: id and Valor_Promocion__c>0');
      return adic;
    }
    
    /*public AggregateResult[] resultsAdic {
        get {
            return [Select Sum(Valor_Promocion__c) sum From Detalle_Promocion__c Where Cotizacion__c =: id and Valor_Promocion__c>0];
        }
    }*/
    
    //Mostrar las cuotas de entradas
      //Mostrar las primeras 0 - 37 cuotas de entradas
    public List<Cuota_Financiamiento__c> getFinanciamiento() {   
      String Tipo = '5'; 
      List<Cuota_Financiamiento__c> financiamiento = Database.query('Select id, name, Cotizacion__c, Tipo__c, Orden__c, Es_Personalizado__c, Es_Personalizado_Nueva_Cuota__c, Es_Personalizado_Cuota_Original__c, Valor_Saldo__c, Valor_dividendo__c, Valor_Presente__c, Financiamiento__c, Fecha_de_Vencimiento__c, Monto_sin_Descuento__c From Cuota_Financiamiento__c Where Cotizacion__c =: id and toLabel(Tipo__c)!=:Tipo and Orden__c!=-1 order by Orden__c Asc Limit 38');
      return financiamiento;
    }
      //Fin Mostrar las primeras 0 - 37 cuotas de entradas
      //Mostrar desde la cuota 39 en adelante
    public List<Cuota_Financiamiento__c> getFinanciamiento3() {   
      String Tipo = '5';  
      List<Cuota_Financiamiento__c> financiamiento3 = Database.query('Select id, name, Cotizacion__c, Tipo__c, Orden__c, Es_Personalizado__c, Es_Personalizado_Nueva_Cuota__c, Es_Personalizado_Cuota_Original__c, Valor_Saldo__c, Valor_dividendo__c, Valor_Presente__c, Financiamiento__c, Fecha_de_Vencimiento__c, Monto_sin_Descuento__c From Cuota_Financiamiento__c Where Cotizacion__c =: id and toLabel(Tipo__c)!=:Tipo and Orden__c>=38 order by Orden__c Asc');
      return financiamiento3;
    }
      //Fin Mostrar desde la cuota 39 en adelante
      
      //Mostrar desde la cuota 0 - 32 del plan de pago
    public List<Cuota_Financiamiento__c> getFinanciamiento4() {   
      String Tipo = '5';  
      List<Cuota_Financiamiento__c> financiamiento4 = Database.query('Select id, name, Cotizacion__c, Tipo__c, Orden__c, Es_Personalizado__c, Es_Personalizado_Nueva_Cuota__c, Es_Personalizado_Cuota_Original__c, Valor_Saldo__c, Valor_dividendo__c, Valor_Presente__c, Financiamiento__c, Fecha_de_Vencimiento__c, Monto_sin_Descuento__c From Cuota_Financiamiento__c Where Cotizacion__c =: id and toLabel(Tipo__c)!=:Tipo and Orden__c!=-1 order by Orden__c Asc Limit 33');
      return financiamiento4;
    }
      //Fin Mostrar desde la cuota 0 - 32 del plan de pago
      
      //Mostrar desde la cuota 32 en adelante del plan de pago  
    public List<Cuota_Financiamiento__c> getFinanciamiento2() {   
      String Tipo = '5';  
      List<Cuota_Financiamiento__c> financiamiento2 = Database.query('Select id, name, Cotizacion__c, Tipo__c, Orden__c, Es_Personalizado__c, Es_Personalizado_Nueva_Cuota__c, Es_Personalizado_Cuota_Original__c, Valor_Saldo__c, Valor_dividendo__c, Valor_Presente__c, Financiamiento__c, Fecha_de_Vencimiento__c, Monto_sin_Descuento__c From Cuota_Financiamiento__c Where Cotizacion__c =: id and toLabel(Tipo__c)!=:Tipo and Orden__c>=33 order by Orden__c Asc');
      return financiamiento2;
    }  
      //Fin Mostrar desde la cuota 32 en adelante del plan de pago
    //Fin Mostrar las cuotas de entradas
    
    //Mostrar las Salidas
    /*public List<Cuota_Financiamiento__c> getFinanciamiento2() {   
      String Tipo = '5';  
      List<Cuota_Financiamiento__c> financiamiento2 = Database.query('Select id, name, Cotizacion__c, Tipo__c, Orden__c, Es_Personalizado__c, Es_Personalizado_Nueva_Cuota__c, Es_Personalizado_Cuota_Original__c, Valor_Saldo__c, Valor_dividendo__c, Valor_Presente__c, Financiamiento__c, Fecha_de_Vencimiento__c, Monto_sin_Descuento__c From Cuota_Financiamiento__c Where Cotizacion__c =: id and toLabel(Tipo__c)=:Tipo and Orden__c!=-1 order by Orden__c Asc');
      return financiamiento2;
    }*/
    //Fin Mostrar las Salidas
    
    //Mostrar las imagenes de la cotización
    public List<ContentDocumentLink> getimagenInmueble() {   
      String Inmueble = 'Inmueble'; List<ContentDocumentLink> imagenInmueble = Database.query('Select id,ContentDocument.LatestPublishedVersionID,ContentDocument.title from ContentDocumentLink where LinkedEntityId=:idInmueble and ContentDocument.title=:Inmueble Limit 1'); return imagenInmueble;
    }
    public List<ContentDocumentLink> getimagenPlano1() {   
      String Inmueble = 'Plano1'; List<ContentDocumentLink> imagenPlano1 = Database.query('Select id,ContentDocument.LatestPublishedVersionID,ContentDocument.title from ContentDocumentLink where LinkedEntityId=:idInmueble and ContentDocument.title=:Inmueble Limit 1'); return imagenPlano1;
    }
    public List<ContentDocumentLink> getimagenPlano2() {   
      String Inmueble = 'Plano2'; List<ContentDocumentLink> imagenPlano2 = Database.query('Select id,ContentDocument.LatestPublishedVersionID,ContentDocument.title from ContentDocumentLink where LinkedEntityId=:idInmueble and ContentDocument.title=:Inmueble Limit 1'); return imagenPlano2;
    }   
  
}