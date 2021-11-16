@isTest
global class mocksoapws implements WebServiceMock{
	global void doInvoke(
    	Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {  
            
        CI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResponse_element response_x = new CI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResponse_element();   
        CI_Equifax_wsdl.Identificadorperfilriesgodirecto6meses_element response2 = new CI_Equifax_wsdl.Identificadorperfilriesgodirecto6meses_element();
        CI_Equifax_wsdl.ResultadoPoliticas_element response3 = new CI_Equifax_wsdl.ResultadoPoliticas_element();
        CI_Equifax_wsdl.Valordeudatotalenlos3segmentos_element response4 = new CI_Equifax_wsdl.Valordeudatotalenlos3segmentos_element();
        CI_Equifax_wsdl.CuotaestimadaMensual_element response5 = new CI_Equifax_wsdl.CuotaestimadaMensual_element();    
        CI_Equifax_wsdl.Analisisdetalledelvencido_element response6 = new CI_Equifax_wsdl.Analisisdetalledelvencido_element();
        CI_Equifax_wsdl.PersonasInhabilitadas_element response7 = new CI_Equifax_wsdl.PersonasInhabilitadas_element();
        CI_Equifax_wsdl.Recursivodeudahistorica1_element response8 = new CI_Equifax_wsdl.Recursivodeudahistorica1_element();
        CI_Equifax_wsdl.RecursivoComposicionestructuradevencimiento_element response9 = new CI_Equifax_wsdl.RecursivoComposicionestructuradevencimiento_element();
        CI_Equifax_wsdl.VinculacionesaInstitucionesFinancieras_element response10 = new CI_Equifax_wsdl.VinculacionesaInstitucionesFinancieras_element();
        CI_Equifax_wsdl.Analisissaldosporvencersistemafinanciero_element response11 = new CI_Equifax_wsdl.Analisissaldosporvencersistemafinanciero_element();
        CI_Equifax_wsdl.Ultimas10operacionescanceladas_element response12 = new CI_Equifax_wsdl.Ultimas10operacionescanceladas_element();
        CI_Equifax_wsdl.ScoreGeneral_element response13 = new CI_Equifax_wsdl.ScoreGeneral_element();
        CI_Equifax_wsdl.RecursivoGarantiaspersonalescodeudoresoperacionesvigentes_element response14 = new CI_Equifax_wsdl.RecursivoGarantiaspersonalescodeudoresoperacionesvigentes_element();
        CI_Equifax_wsdl.Garantiaspersonalescodeudoresoperacionesnovigentes_element response15 = new CI_Equifax_wsdl.Garantiaspersonalescodeudoresoperacionesnovigentes_element();
        CI_Equifax_wsdl.ResultadoSegmentacion_element response16 = new CI_Equifax_wsdl.ResultadoSegmentacion_element();
        CI_Equifax_wsdl.IdentificacionConsultada_element response17 = new CI_Equifax_wsdl.IdentificacionConsultada_element();
        CI_Equifax_wsdl.CabeceraCR response18 = new CI_Equifax_wsdl.CabeceraCR();
        CI_Equifax_wsdl.WSOGraficarEvolucionDeuda_element response19 = new CI_Equifax_wsdl.WSOGraficarEvolucionDeuda_element();
        CI_Equifax_wsdl.Creditosotorgados12ultimosmeses_element response20 = new CI_Equifax_wsdl.Creditosotorgados12ultimosmeses_element();
        CI_Equifax_wsdl.ResultadoSimulaciones_element response21 = new CI_Equifax_wsdl.ResultadoSimulaciones_element();
        CI_Equifax_wsdl.Tarjetasdecreditoanuladaspormalmanejo_element response22 = new CI_Equifax_wsdl.Tarjetasdecreditoanuladaspormalmanejo_element();
        CI_Equifax_wsdl.RecursivoDetalledistribucionendeudamiento_element response23 = new CI_Equifax_wsdl.RecursivoDetalledistribucionendeudamiento_element();
        CI_Equifax_wsdl.Sugerencia_element response24 = new CI_Equifax_wsdl.Sugerencia_element();          
        CI_Equifax_wsdl.Identificadorperfilriesgodirectodesde2005_element response25 = new CI_Equifax_wsdl.Identificadorperfilriesgodirectodesde2005_element();     
        CI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResult_element response26 = new CI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResult_element();  
            
        response.put('response_x', response_x);
            
        System.Continuation continuation;
        String tipoDocumento;
        String numeroDocumento;
        String valorBien;
        String valorEntrada;
        String ingresoUnidadFamiliar;
        String gastoHogarUnidadFamiliar;
        String restaGastoFinanciero;
        String plazo;
        String tipoCredito;
        String tipoProyecto;
            
        AsyncCI_Equifax_wsdl async = new AsyncCI_Equifax_wsdl(); 
        AsyncCI_Equifax_wsdl.AsyncWSExpertoCorporacionInmobiliareSoap val = new AsyncCI_Equifax_wsdl.AsyncWSExpertoCorporacionInmobiliareSoap();
        AsyncCI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResponse_elementFuture val2 = new AsyncCI_Equifax_wsdl.ObtenerResultadoExpertoCorporacionInmobiliareResponse_elementFuture();
        val2.getValue();
             
    } 
}