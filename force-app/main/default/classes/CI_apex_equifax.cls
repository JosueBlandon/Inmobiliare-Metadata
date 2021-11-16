public class CI_apex_equifax {

    private String username;
    private String password;
    private String link;
    
    public String tipoDocumento {get; set;}
    public String numeroDocumento {get; set;}
    public String valorBien {get; set;}
    public String valorEntrada {get; set;}
    public String ingresoUnidadFamiliar {get; set;}
    public String gastoHogarUnidadFamiliar {get; set;}
    public String restaGastoFinanciero {get; set;}
    public String plazo {get; set;}
    public String tipoCredito {get; set;}
    public String tipoProyecto {get; set;}
    
    public String name {get; set;}
    
    public CI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResult_element resultados {get; set;}
    
    //Parámetros de url
    public String Documento {get; set;}
    public String Proyecto {get; set;}
    public String valorBienUrl {get; set;}
    public String valorEntradaUrl {get; set;}
    public String ingresoUF {get; set;}
    public String gastoUF {get; set;}
    public String plazoUrl {get; set;}
    public String score {get; set;}
    
    public String Segmentacion {get; set;}
    public String NivelInP {get; set;}
    public String ValorEntA {get; set;}
    public String PlazoRes {get; set;}
    public String CoutaMen {get; set;}
    public String CapPago {get; set;}
    
    public String SugVEM {get; set;}
    public String SugP1 {get; set;}
    public String SugC1 {get; set;}
    public String SugPM {get; set;}
    public String SugP2 {get; set;}
    public String SugC2 {get; set;}
    
    public String P0 {get; set;}
    public String C0 {get; set;}
    public String P1 {get; set;}
    public String C1 {get; set;}
    public String P2 {get; set;}
    public String C2 {get; set;}
    public String P3 {get; set;}
    public String C3 {get; set;}
    public String P4 {get; set;}
    public String C4 {get; set;}
    
    public String Pol0 {get; set;}
    public String Valor0 {get; set;}
    public String Result0 {get; set;}   
    public String Pol1 {get; set;}
    public String Valor1 {get; set;}
    public String Result1 {get; set;}    
    public String Pol2 {get; set;}
    public String Valor2 {get; set;}
    public String Result2 {get; set;}   
    public String Pol3 {get; set;}
    public String Valor3 {get; set;}
    public String Result3 {get; set;}    
    
    public String FechaCor00 {get; set;}
    public String Insti00 {get; set;}
    public String TipoCre00 {get; set;}
    public String SaldoDeu00 {get; set;}
    public String DemanJud00 {get; set;}
    public String CarteraCast00 {get; set;}
    public String Titular00 {get; set;}
    public String Garante00 {get; set;}
    public String Coddeu00 {get; set;}
    public String TarCre00 {get; set;}
    public String AcConc00 {get; set;}   
    public String FechaCor01 {get; set;}
    public String Insti01 {get; set;}
    public String TipoCre01 {get; set;}
    public String SaldoDeu01 {get; set;}
    public String DemanJud01 {get; set;}
    public String CarteraCast01 {get; set;}
    public String Titular01 {get; set;}
    public String Garante01 {get; set;}
    public String Coddeu01 {get; set;}
    public String TarCre01 {get; set;}
    public String AcConc01 {get; set;}    
    public String FechaCor02 {get; set;}
    public String Insti02 {get; set;}
    public String TipoCre02 {get; set;}
    public String SaldoDeu02 {get; set;}
    public String DemanJud02 {get; set;}
    public String CarteraCast02 {get; set;}
    public String Titular02 {get; set;}
    public String Garante02 {get; set;}
    public String Coddeu02 {get; set;}
    public String TarCre02 {get; set;}
    public String AcConc02 {get; set;}   
    public String FechaCor03 {get; set;}
    public String Insti03 {get; set;}
    public String TipoCre03 {get; set;}
    public String SaldoDeu03 {get; set;}
    public String DemanJud03 {get; set;}
    public String CarteraCast03 {get; set;}
    public String Titular03 {get; set;}
    public String Garante03 {get; set;}
    public String Coddeu03 {get; set;}
    public String TarCre03 {get; set;}
    public String AcConc03 {get; set;}    
    public String FechaCor04 {get; set;}
    public String Insti04 {get; set;}
    public String TipoCre04 {get; set;}
    public String SaldoDeu04 {get; set;}
    public String DemanJud04 {get; set;}
    public String CarteraCast04 {get; set;}
    public String Titular04 {get; set;}
    public String Garante04 {get; set;}
    public String Coddeu04 {get; set;}
    public String TarCre04 {get; set;}
    public String AcConc04 {get; set;}
    
    public String Acreedor0 {get; set;}
    public String PVencer0 {get; set;}
    public String NDevegaInt0 {get; set;}
    public String Vencido0 {get; set;}
    public String SalDeud0 {get; set;}
    public String DemanJudi0 {get; set;}
    public String CarteraCasti0 {get; set;}
    public String Acreedor1 {get; set;}
    public String PVencer1 {get; set;}
    public String NDevegaInt1 {get; set;}
    public String Vencido1 {get; set;}
    public String SalDeud1 {get; set;}
    public String DemanJudi1 {get; set;}
    public String CarteraCasti1 {get; set;}
    public String PVencer2 {get; set;}
    public String NDevegaInt2 {get; set;}
    public String Vencido2 {get; set;}
    public String SalDeud2 {get; set;}
    public String DemanJudi2 {get; set;}
    public String CarteraCasti2 {get; set;}
    //Fin Parámetros de url
    
    public List<Datos_Equifax__c> Records {get; set;}

    public CI_apex_equifax(ApexPages.StandardController controller) {
    
        Records = [Select id,name,CI_Fecha_corte__c,CI_Institucion__c,CI_Tipo_deudor__c,CI_Total_vencer__c,CI_Total_vencido__c,CI_No_devenga_interes__c,CI_Demanda_judicial__c,CI_Cartera_castigada__c,CI_Dias_vencidos__c from Datos_Equifax__c];

        this.restaGastoFinanciero = '0';
        this.tipoCredito = 'VIVIENDA';
        
        this.resultados = null;

        consultarEquifax();
        
        //Parámetros de url
        Documento = apexpages.currentpage().getparameters().get('Documento');
        Proyecto = apexpages.currentpage().getparameters().get('Proyecto');
        valorBienUrl = apexpages.currentpage().getparameters().get('valorBien');
        valorEntradaUrl = apexpages.currentpage().getparameters().get('valorEntrada');
        ingresoUF = apexpages.currentpage().getparameters().get('ingresoUF');
        gastoUF = apexpages.currentpage().getparameters().get('gastoUF');
        plazoUrl = apexpages.currentpage().getparameters().get('plazo');
        score = apexpages.currentpage().getparameters().get('score');
        
        Segmentacion = apexpages.currentpage().getparameters().get('Segmentacion');
        NivelInP = apexpages.currentpage().getparameters().get('NivelInP');
        ValorEntA = apexpages.currentpage().getparameters().get('ValorEntA');
        PlazoRes = apexpages.currentpage().getparameters().get('PlazoRes');
        CoutaMen = apexpages.currentpage().getparameters().get('CoutaMen');
        CapPago = apexpages.currentpage().getparameters().get('CapPago');
        
        SugVEM = apexpages.currentpage().getparameters().get('SugVEM');
        SugP1 = apexpages.currentpage().getparameters().get('SugP1');
        SugC1 = apexpages.currentpage().getparameters().get('SugC1');
        SugPM = apexpages.currentpage().getparameters().get('SugPM');
        SugP2 = apexpages.currentpage().getparameters().get('SugP2');
        SugC2 = apexpages.currentpage().getparameters().get('SugC2');
        
        P0 = apexpages.currentpage().getparameters().get('P0');
        C0 = apexpages.currentpage().getparameters().get('C0');
        P1 = apexpages.currentpage().getparameters().get('P1');
        C1 = apexpages.currentpage().getparameters().get('C1');
        P2 = apexpages.currentpage().getparameters().get('P2');
        C2 = apexpages.currentpage().getparameters().get('C2');
        P3 = apexpages.currentpage().getparameters().get('P3');
        C3 = apexpages.currentpage().getparameters().get('C3');
        P4 = apexpages.currentpage().getparameters().get('P4');
        C4 = apexpages.currentpage().getparameters().get('C4');
        
        Pol0 = apexpages.currentpage().getparameters().get('Pol0');
        Valor0 = apexpages.currentpage().getparameters().get('Valor0');
        Result0 = apexpages.currentpage().getparameters().get('Result0');       
        Pol1 = apexpages.currentpage().getparameters().get('Pol1');
        Valor1 = apexpages.currentpage().getparameters().get('Valor1');
        Result1 = apexpages.currentpage().getparameters().get('Result1');        
        Pol2 = apexpages.currentpage().getparameters().get('Pol2');
        Valor2 = apexpages.currentpage().getparameters().get('Valor2');
        Result2 = apexpages.currentpage().getparameters().get('Result2');        
        Pol3 = apexpages.currentpage().getparameters().get('Pol3');
        Valor3 = apexpages.currentpage().getparameters().get('Valor3');
        Result3 = apexpages.currentpage().getparameters().get('Result3');
        
        FechaCor00 = apexpages.currentpage().getparameters().get('FechaCor00');
        Insti00 = apexpages.currentpage().getparameters().get('Insti00');
        TipoCre00 = apexpages.currentpage().getparameters().get('TipoCre00');
        SaldoDeu00 = apexpages.currentpage().getparameters().get('SaldoDeu00');
        DemanJud00 = apexpages.currentpage().getparameters().get('DemanJud00');
        CarteraCast00 = apexpages.currentpage().getparameters().get('CarteraCast00');
        Titular00 = apexpages.currentpage().getparameters().get('Titular00');
        Garante00 = apexpages.currentpage().getparameters().get('Garante00');
        Coddeu00 = apexpages.currentpage().getparameters().get('Coddeu00');
        TarCre00 = apexpages.currentpage().getparameters().get('TarCre00');
        AcConc00 = apexpages.currentpage().getparameters().get('AcConc00');       
        FechaCor01 = apexpages.currentpage().getparameters().get('FechaCor01');
        Insti01 = apexpages.currentpage().getparameters().get('Insti01');
        TipoCre01 = apexpages.currentpage().getparameters().get('TipoCre01');
        SaldoDeu01 = apexpages.currentpage().getparameters().get('SaldoDeu01');
        DemanJud01 = apexpages.currentpage().getparameters().get('DemanJud01');
        CarteraCast01 = apexpages.currentpage().getparameters().get('CarteraCast01');
        Titular01 = apexpages.currentpage().getparameters().get('Titular01');
        Garante01 = apexpages.currentpage().getparameters().get('Garante01');
        Coddeu01 = apexpages.currentpage().getparameters().get('Coddeu01');
        TarCre01 = apexpages.currentpage().getparameters().get('TarCre01');
        AcConc01 = apexpages.currentpage().getparameters().get('AcConc01');        
        if (FechaCor02!=null) { FechaCor02 = apexpages.currentpage().getparameters().get('FechaCor02'); }
        Insti02 = apexpages.currentpage().getparameters().get('Insti02');
        TipoCre02 = apexpages.currentpage().getparameters().get('TipoCre02');
        SaldoDeu02 = apexpages.currentpage().getparameters().get('SaldoDeu02');
        DemanJud02 = apexpages.currentpage().getparameters().get('DemanJud02');
        CarteraCast02 = apexpages.currentpage().getparameters().get('CarteraCast02');
        Titular02 = apexpages.currentpage().getparameters().get('Titular02');
        Garante02 = apexpages.currentpage().getparameters().get('Garante02');
        Coddeu02 = apexpages.currentpage().getparameters().get('Coddeu02');
        TarCre02 = apexpages.currentpage().getparameters().get('TarCre02');
        AcConc02 = apexpages.currentpage().getparameters().get('AcConc02');        
        FechaCor03 = apexpages.currentpage().getparameters().get('FechaCor03');
        Insti03 = apexpages.currentpage().getparameters().get('Insti03');
        TipoCre03 = apexpages.currentpage().getparameters().get('TipoCre03');
        SaldoDeu03 = apexpages.currentpage().getparameters().get('SaldoDeu03');
        DemanJud03 = apexpages.currentpage().getparameters().get('DemanJud03');
        CarteraCast03 = apexpages.currentpage().getparameters().get('CarteraCast03');
        Titular03 = apexpages.currentpage().getparameters().get('Titular03');
        Garante03 = apexpages.currentpage().getparameters().get('Garante03');
        Coddeu03 = apexpages.currentpage().getparameters().get('Coddeu03');
        TarCre03 = apexpages.currentpage().getparameters().get('TarCre03');
        AcConc03 = apexpages.currentpage().getparameters().get('AcConc03');       
        FechaCor04 = apexpages.currentpage().getparameters().get('FechaCor04');
        Insti04 = apexpages.currentpage().getparameters().get('Insti04');
        TipoCre04 = apexpages.currentpage().getparameters().get('TipoCre04');
        SaldoDeu04 = apexpages.currentpage().getparameters().get('SaldoDeu04');
        DemanJud04 = apexpages.currentpage().getparameters().get('DemanJud04');
        CarteraCast04 = apexpages.currentpage().getparameters().get('CarteraCast04');
        Titular04 = apexpages.currentpage().getparameters().get('Titular04');
        Garante04 = apexpages.currentpage().getparameters().get('Garante04');
        Coddeu04 = apexpages.currentpage().getparameters().get('Coddeu04');
        TarCre04 = apexpages.currentpage().getparameters().get('TarCre04');
        AcConc04 = apexpages.currentpage().getparameters().get('AcConc04');
        
        Acreedor0 = apexpages.currentpage().getparameters().get('Acreedor0');
        PVencer0 = apexpages.currentpage().getparameters().get('PVencer0');
        NDevegaInt0 = apexpages.currentpage().getparameters().get('NDevegaInt0');
        Vencido0 = apexpages.currentpage().getparameters().get('Vencido0');
        SalDeud0 = apexpages.currentpage().getparameters().get('SalDeud0');
        DemanJudi0 = apexpages.currentpage().getparameters().get('DemanJudi0');
        CarteraCasti0 = apexpages.currentpage().getparameters().get('CarteraCasti0');       
        Acreedor1 = apexpages.currentpage().getparameters().get('Acreedor1');
        PVencer1 = apexpages.currentpage().getparameters().get('PVencer1');
        NDevegaInt1 = apexpages.currentpage().getparameters().get('NDevegaInt1');
        Vencido1 = apexpages.currentpage().getparameters().get('Vencido1');
        SalDeud1 = apexpages.currentpage().getparameters().get('SalDeud1');
        DemanJudi1 = apexpages.currentpage().getparameters().get('DemanJudi1');
        CarteraCasti1 = apexpages.currentpage().getparameters().get('CarteraCasti1');
        PVencer2 = apexpages.currentpage().getparameters().get('PVencer2');
        NDevegaInt2 = apexpages.currentpage().getparameters().get('NDevegaInt2');
        Vencido2 = apexpages.currentpage().getparameters().get('Vencido2');
        SalDeud2 = apexpages.currentpage().getparameters().get('SalDeud2');
        DemanJudi2 = apexpages.currentpage().getparameters().get('DemanJudi2');
        CarteraCasti2 = apexpages.currentpage().getparameters().get('CarteraCasti2');
        //Fin Parámetros de url
    }    
    
    public string valores {get;set;}
    public string valores2 {get;set;}
    public string valores3 {get;set;}
    public string valores4 {get;set;}
    public string valores5 {get;set;}
    public string valores6 {get;set;}
    public string valores7 {get;set;}
    public string mensaje {get;set;}
    
    public static Configuracion_General__c conexion(string servicio){
        Configuracion_General__c con= [select id,Name,CI_LinkServicio__c,CI_Usuario__c,CI_Password__c from Configuracion_General__c where Name=:servicio limit 1]; 
        return con;
    }
    
    public void consultarEquifax() {
        try{            
            string tipoDocumento = apexpages.currentpage().getparameters().get('tipoDocumento');
            
            //Traer datos de conexión a equifax  
            Configuracion_General__c conn = CI_apex_equifax.conexion('Equifax');
            link = conn.CI_LinkServicio__c;
            username = conn.CI_Usuario__c;
            password = conn.CI_Password__c;

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(link);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'text/xml; charset=character encoding');
            request.setTimeout(120000);
            
            if(ingresoUnidadFamiliar == null) { ingresoUnidadFamiliar = '0'; }
            if(gastoHogarUnidadFamiliar == null) { gastoHogarUnidadFamiliar = '0'; }

            String SOAPXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">\n';
            SOAPXML += '<soapenv:Header>\n';
            SOAPXML += '<tem:CabeceraCR>\n';
            SOAPXML += '<tem:Usuario>'+ username +'</tem:Usuario>\n';
            SOAPXML += '<tem:Clave>' + password + '</tem:Clave>\n';
            SOAPXML += '</tem:CabeceraCR>\n';
            SOAPXML += '</soapenv:Header>\n';
            SOAPXML += '<soapenv:Body>\n';
            SOAPXML += '<tem:ObtenerResultadoExpertoCorporacionInmobiliare>\n';
            SOAPXML += '<tem:tipoDocumento>' + tipoDocumento + '</tem:tipoDocumento>\n';
            SOAPXML += '<tem:numeroDocumento>' + numeroDocumento + '</tem:numeroDocumento>\n';
            SOAPXML += '<tem:valorBien>' + valorBien + '</tem:valorBien>\n';
            SOAPXML += '<tem:valorEntrada>' + valorEntrada + '</tem:valorEntrada>\n';
            SOAPXML += '<tem:ingresoUnidadFamiliar>' + ingresoUnidadFamiliar + '</tem:ingresoUnidadFamiliar>\n';
            SOAPXML += '<tem:gastoHogarUnidadFamiliar>' + gastoHogarUnidadFamiliar + '</tem:gastoHogarUnidadFamiliar>\n';
            SOAPXML += '<tem:restaGastoFinanciero>' + this.restaGastoFinanciero + '</tem:restaGastoFinanciero>\n';
            SOAPXML += '<tem:plazo>' + plazo + '</tem:plazo>\n';
            SOAPXML += '<tem:tipoCredito>' + this.tipoCredito + '</tem:tipoCredito>\n';
            SOAPXML += '<tem:tipoProyecto>' + tipoProyecto + '</tem:tipoProyecto>\n';
            SOAPXML += '</tem:ObtenerResultadoExpertoCorporacionInmobiliare>\n';
            SOAPXML += '</soapenv:Body>\n';
            SOAPXML += '</soapenv:Envelope>';

            System.debug(SOAPXML);

            request.setBody(SOAPXML);
            HttpResponse response = http.send(request);
            
            System.debug(response);
            System.debug(response.getBody());
            XMLParser xmlParsed = new XMLParser(response.getBody()); 
            
            valores = Json.Serialize(xmlParsed.listResultadoSegmentacion);
            
            valores2 = Json.Serialize(xmlParsed.listSugerencia);
            
            valores3 = Json.Serialize(xmlParsed.listResultadoSimulaciones);
            
            valores4 = Json.Serialize(xmlParsed.listResultadoPoliticas);
            
            valores5 = Json.Serialize(xmlParsed.listEvolucionHistoricayDistEndeudamientoSICOM);
            
            valores6 = Json.Serialize(xmlParsed.listRecursivoDetalledistribucionendeudamiento);
            
            valores7 = Json.Serialize(xmlParsed.listValordeudatotalenlos3segmentos);
                         
        } catch (NullPointerException ex) {
            System.debug('Exception :'+ex); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Se alcanzó el límte de espera en la consulta al servicio de Equifax, favor intente nuevamente.'));
        }
      
    }
    
}