public class XMLParser {

    private String XMLString;
    public List<IdentificacionConsultada> listIdentificacionConsultada {get; set;}
    public List<PersonasInhabilitadas> listPersonasInhabilitadas {get; set;}
    public List<DeudareportadaporINFOCOM> listDeudareportadaporINFOCOM {get; set;}
    public List<Valordeudatotalenlos3segmentos> listValordeudatotalenlos3segmentos {get; set;}
    public List<CuotaestimadaMensual> listCuotaestimadaMensual {get; set;}
    public List<Entidadesquehanconsultado> listEntidadesquehanconsultado {get; set;}
    public List<Recursivodeudahistorica1> listRecursivodeudahistorica1 {get; set;}
    public List<Creditosotorgados12ultimosmeses> listCreditosotorgados12ultimosmeses {get; set;}
    public List<Tarjetasdecreditoanuladaspormalmanejo> listTarjetasdecreditoanuladaspormalmanejo {get; set;}
    public List<Ultimas10operacionescanceladas> listUltimas10operacionescanceladas {get; set;}
    public List<RecursivoGarantiaspersonalescodeudoresoperacionesvigentes> listRecursivoGarantiaspersonalescodeudoresoperacionesvigentes {get; set;}
    public List<Garantiaspersonalescodeudoresoperacionesnovigentes> listGarantiaspersonalescodeudoresoperacionesnovigentes {get; set;}
    public List<VinculacionesaInstitucionesFinancieras> listVinculacionesaInstitucionesFinancieras {get; set;}
    public List<Analisisdetalledelvencido> listAnalisisdetalledelvencido {get; set;}
    public List<Analisissaldosporvencersistemafinanciero> listAnalisissaldosporvencersistemafinanciero {get; set;}
    public List<WSOGraficarEvolucionDeuda> listWSOGraficarEvolucionDeuda {get; set;}
    public List<EvolucionHistoricayDistEndeudamientoSICOM> listEvolucionHistoricayDistEndeudamientoSICOM {get; set;}
    public List<ScoreGeneral> listScoreGeneral {get; set;}
    public List<Identificadorperfilriesgodirectodesde2005> listIdentificadorperfilriesgodirectodesde2005 {get; set;}
    public List<Identificadorperfilriesgodirecto6meses> listIdentificadorperfilriesgodirecto6meses {get; set;}
    public List<RecursivoDetalledistribucionendeudamiento> listRecursivoDetalledistribucionendeudamiento {get; set;}
    public List<RecursivoComposicionestructuradevencimiento> listRecursivoComposicionestructuradevencimiento {get; set;}
    public List<ResultadoSegmentacion> listResultadoSegmentacion {get; set;}
    public List<Sugerencia> listSugerencia {get; set;}
    public List<ResultadoSimulaciones> listResultadoSimulaciones {get; set;}
    public List<ResultadoPoliticas> listResultadoPoliticas {get; set;}

    public XMLparser(String XMLString){
        
        this.XMLString = XMLString;
        DOM.Document doc=new DOM.Document();
        listIdentificacionConsultada = new List<IdentificacionConsultada>();
        listPersonasInhabilitadas = new List<PersonasInhabilitadas>();
        listDeudareportadaporINFOCOM = new List<DeudareportadaporINFOCOM>();
        listValordeudatotalenlos3segmentos = new List<Valordeudatotalenlos3segmentos>();
        listCuotaestimadaMensual = new List<CuotaestimadaMensual>();
        listEntidadesquehanconsultado = new List<Entidadesquehanconsultado>();
        listRecursivodeudahistorica1 = new List<Recursivodeudahistorica1>();
        listCreditosotorgados12ultimosmeses = new List<Creditosotorgados12ultimosmeses>();
        listTarjetasdecreditoanuladaspormalmanejo = new List<Tarjetasdecreditoanuladaspormalmanejo>();
        listUltimas10operacionescanceladas = new List<Ultimas10operacionescanceladas>();
        listRecursivoGarantiaspersonalescodeudoresoperacionesvigentes = new List<RecursivoGarantiaspersonalescodeudoresoperacionesvigentes>();
        listGarantiaspersonalescodeudoresoperacionesnovigentes = new List<Garantiaspersonalescodeudoresoperacionesnovigentes>();
        listVinculacionesaInstitucionesFinancieras = new List<VinculacionesaInstitucionesFinancieras>();
        listAnalisisdetalledelvencido = new List<Analisisdetalledelvencido>();
        listAnalisissaldosporvencersistemafinanciero = new List<Analisissaldosporvencersistemafinanciero>();
        listWSOGraficarEvolucionDeuda = new List<WSOGraficarEvolucionDeuda>();
        listEvolucionHistoricayDistEndeudamientoSICOM = new List<EvolucionHistoricayDistEndeudamientoSICOM>();
        listScoreGeneral = new List<ScoreGeneral>();
        listIdentificadorperfilriesgodirectodesde2005 = new List<Identificadorperfilriesgodirectodesde2005>();
        listIdentificadorperfilriesgodirecto6meses = new List<Identificadorperfilriesgodirecto6meses>();
        listRecursivoDetalledistribucionendeudamiento = new List<RecursivoDetalledistribucionendeudamiento>();
        listRecursivoComposicionestructuradevencimiento = new List<RecursivoComposicionestructuradevencimiento>();
        listResultadoSegmentacion = new List<ResultadoSegmentacion>();
        listSugerencia = new List<Sugerencia>();
        listResultadoSimulaciones = new List<ResultadoSimulaciones>();
        listResultadoPoliticas = new List<ResultadoPoliticas>();

        try{
            doc.load(XMLString);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
    
    private void parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            List<Dom.XMLNode> listChildNodes = node.getChildElements();
            if(node.getName()=='IdentificacionConsultada'){
                if(listChildNodes.size()>0) listIdentificacionConsultada.add(new IdentificacionConsultada(node));
            }
            else if(node.getName()=='PersonasInhabilitadas'){
                if(listChildNodes.size()>0) listPersonasInhabilitadas.add(new PersonasInhabilitadas(node));
            }
            else if(node.getName()=='DeudareportadaporINFOCOM'){
                if(listChildNodes.size()>0) listDeudareportadaporINFOCOM.add(new DeudareportadaporINFOCOM(node));
            }
            else if(node.getName()=='Valordeudatotalenlos3segmentos'){
                if(listChildNodes.size()>0) listValordeudatotalenlos3segmentos.add(new Valordeudatotalenlos3segmentos(node));
            }
            else if(node.getName()=='CuotaestimadaMensual'){
                if(listChildNodes.size()>0) listCuotaestimadaMensual.add(new CuotaestimadaMensual(node));
            }
            else if(node.getName()=='Entidadesquehanconsultado'){
                if(listChildNodes.size()>0) listEntidadesquehanconsultado.add(new Entidadesquehanconsultado(node));
            }
            else if(node.getName()=='Recursivodeudahistorica1'){
                if(listChildNodes.size()>0) listRecursivodeudahistorica1.add(new Recursivodeudahistorica1(node));
            }
            else if(node.getName()=='Creditosotorgados12ultimosmeses'){
                if(listChildNodes.size()>0) listCreditosotorgados12ultimosmeses.add(new Creditosotorgados12ultimosmeses(node));
            }
            else if(node.getName()=='Tarjetasdecreditoanuladaspormalmanejo'){
                if(listChildNodes.size()>0) listTarjetasdecreditoanuladaspormalmanejo.add(new Tarjetasdecreditoanuladaspormalmanejo(node));
            }
            else if(node.getName()=='Ultimas10operacionescanceladas'){
                if(listChildNodes.size()>0) listUltimas10operacionescanceladas.add(new Ultimas10operacionescanceladas(node));
            }
            else if(node.getName()=='RecursivoGarantiaspersonalescodeudoresoperacionesvigentes'){
                if(listChildNodes.size()>0) listRecursivoGarantiaspersonalescodeudoresoperacionesvigentes.add(new RecursivoGarantiaspersonalescodeudoresoperacionesvigentes(node));
            }
            else if(node.getName()=='Garantiaspersonalescodeudoresoperacionesnovigentes'){
                if(listChildNodes.size()>0) listGarantiaspersonalescodeudoresoperacionesnovigentes.add(new Garantiaspersonalescodeudoresoperacionesnovigentes(node));
            }
            else if(node.getName()=='VinculacionesaInstitucionesFinancieras'){
                if(listChildNodes.size()>0) listVinculacionesaInstitucionesFinancieras.add(new VinculacionesaInstitucionesFinancieras(node));
            }
            else if(node.getName()=='Analisisdetalledelvencido'){
                if(listChildNodes.size()>0) listAnalisisdetalledelvencido.add(new Analisisdetalledelvencido(node));
            }
            else if(node.getName()=='Analisissaldosporvencersistemafinanciero'){
                if(listChildNodes.size()>0) listAnalisissaldosporvencersistemafinanciero.add(new Analisissaldosporvencersistemafinanciero(node));
            }
            else if(node.getName()=='WSOGraficarEvolucionDeuda'){
                if(listChildNodes.size()>0) listWSOGraficarEvolucionDeuda.add(new WSOGraficarEvolucionDeuda(node));
            }
            else if(node.getName()=='EvolucionHistoricayDistEndeudamientoSICOM'){
                if(listChildNodes.size()>0) listEvolucionHistoricayDistEndeudamientoSICOM.add(new EvolucionHistoricayDistEndeudamientoSICOM(node));
            }
            else if(node.getName()=='ScoreGeneral'){
                if(listChildNodes.size()>0) listScoreGeneral.add(new ScoreGeneral(node));
            }
            else if(node.getName()=='Identificadorperfilriesgodirectodesde2005'){
                if(listChildNodes.size()>0) listIdentificadorperfilriesgodirectodesde2005.add(new Identificadorperfilriesgodirectodesde2005(node));
            }
            else if(node.getName()=='Identificadorperfilriesgodirecto6meses'){
                if(listChildNodes.size()>0) listIdentificadorperfilriesgodirecto6meses.add(new Identificadorperfilriesgodirecto6meses(node));
            }
            else if(node.getName()=='RecursivoDetalledistribucionendeudamiento'){
                if(listChildNodes.size()>0) listRecursivoDetalledistribucionendeudamiento.add(new RecursivoDetalledistribucionendeudamiento(node));
            }
            else if(node.getName()=='RecursivoComposicionestructuradevencimiento'){
                if(listChildNodes.size()>0) listRecursivoComposicionestructuradevencimiento.add(new RecursivoComposicionestructuradevencimiento(node));
            }
            else if(node.getName()=='ResultadoSegmentacion'){
                if(listChildNodes.size()>0) listResultadoSegmentacion.add(new ResultadoSegmentacion(node));
            }
            else if(node.getName()=='Sugerencia'){
                if(listChildNodes.size()>0) listSugerencia.add(new Sugerencia(node));
            }
            else if(node.getName()=='ResultadoSimulaciones'){
                if(listChildNodes.size()>0) listResultadoSimulaciones.add(new ResultadoSimulaciones(node));
            }
            else if(node.getName()=='ResultadoPoliticas'){
                if(listChildNodes.size()>0) listResultadoPoliticas.add(new ResultadoPoliticas(node));
            }
        }
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
    }

    public class IdentificacionConsultada{
        public String NombreSujeto {get; set;}
        public String TipoDocumentoDobleInfo {get; set;}
        public String NumeroDocumentoDobleInfo {get; set;}

        public IdentificacionConsultada(Dom.XMLNode xmlRecord){
            NombreSujeto = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreSujeto', null));
            TipoDocumentoDobleInfo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoDocumentoDobleInfo', null));
            NumeroDocumentoDobleInfo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroDocumentoDobleInfo', null));
        }
    }

    public class PersonasInhabilitadas{
        public String NumeroDocumentoInv {get; set;}
        public String NombreSujetoInv {get; set;}
        public Datetime FechaInhabilitacion {get; set;}
        public Integer TiempoInhabilitacion {get; set;}
        public String Accion {get; set;}
        public String MotivoInv {get; set;}
        public String CodigoInhabilitado {get; set;}
        public Integer NumeroProtestos {get; set;}

        public PersonasInhabilitadas(Dom.XMLNode xmlRecord){
            NumeroDocumentoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroDocumentoInv', null));
            NombreSujetoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreSujetoInv', null));
            FechaInhabilitacion = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaInhabilitacion', null));
            TiempoInhabilitacion = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('TiempoInhabilitacion', null));
            Accion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Accion', null));
            MotivoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('MotivoInv', null));
            CodigoInhabilitado = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoInhabilitado', null));
            NumeroProtestos = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('NumeroProtestos', null));
        }
    }
    
    public class DeudareportadaporINFOCOM{
        public String Institucion {get; set;}
        public String FechaCorte {get; set;}
        public String TipoDeudor {get; set;}
        public String Total {get; set;}
        public String PorVencer {get; set;}
        public String NoDevengaInt {get; set;}
        public String Vencido {get; set;}
        public String DemandaJudicial {get; set;}
        public String CarteraCastigada {get; set;}
        public String DiasVencido {get; set;}
        public String CodigoInstitucionInv {get; set;}
        public String CodTipoDeudorInv {get; set;}
        public String NumeroDocumentoInv {get; set;}
        public String NombreSujetoInv {get; set;}

        public DeudareportadaporINFOCOM(Dom.XMLNode xmlRecord){
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            FechaCorte = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            TipoDeudor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoDeudor', null));
            Total = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Total', null));           
            PorVencer = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('PorVencer', null));
            NoDevengaInt = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NoDevengaInt', null));
            Vencido = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Vencido', null));
            DemandaJudicial = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('DemandaJudicial', null));
            CarteraCastigada = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CarteraCastigada', null));            
            DiasVencido = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('DiasVencido', null));
            CodigoInstitucionInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            CodTipoDeudorInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodTipoDeudorInv', null));
            NumeroDocumentoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroDocumentoInv', null));
            NombreSujetoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreSujetoInv', null));        
        }
    }

    public class Valordeudatotalenlos3segmentos{
        public String Titulo {get; set;}
        public String TituloWSInv {get; set;}
        public String PorVencer {get; set;}
        public String NoDevengaInt {get; set;}
        public String Vencido {get; set;}
        public String Total {get; set;}
        public String DemandaJudicial {get; set;}
        public String CarteraCastigada {get; set;}

        public Valordeudatotalenlos3segmentos(Dom.XMLNode xmlRecord){
            Titulo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Titulo', null));
            TituloWSInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TituloWSInv', null));
            PorVencer = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('PorVencer', null));
            NoDevengaInt = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NoDevengaInt', null));
            Vencido = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Vencido', null));
            Total = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Total', null));
            DemandaJudicial = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('DemandaJudicial', null));
            CarteraCastigada = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CarteraCastigada', null));
        }
    }

    class CuotaestimadaMensual{
        public Decimal Pago {get; set;}
        public Integer NumeroCreditosComercial {get; set;}
        public Decimal TotalVencido {get; set;}
        public Decimal TotalDemanda {get; set;}
        public Decimal TotalCartera {get; set;}
        public Integer NumeroCreditosIece {get; set;}

        public CuotaestimadaMensual(Dom.XMLNode xmlRecord){
            Pago = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Pago', null));
            NumeroCreditosComercial = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('NumeroCreditosComercial', null));
            TotalVencido = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('TotalVencido', null));
            TotalDemanda = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('TotalDemanda', null));
            TotalCartera = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('TotalCartera', null));
            NumeroCreditosIece = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('NumeroCreditosIece', null));
        }
    }

    public class Entidadesquehanconsultado{
        public String NombreCliente {get; set;}
        public String Mes1 {get; set;}
        public String Mes2 {get; set;}
        public String Mes3 {get; set;}
        public String Mes4 {get; set;}
        public String Mes5 {get; set;}
        public String Mes6 {get; set;}
        public String Mes7 {get; set;}
        public String Mes8 {get; set;}
        public String Mes9 {get; set;}
        public String Mes10 {get; set;}
        public String Mes11 {get; set;}
        public String Mes12 {get; set;}
        public String ResaltadaInv {get; set;}

        public Entidadesquehanconsultado(Dom.XMLNode xmlRecord){
            NombreCliente = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreCliente', null));
            Mes1 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes1', null));
            Mes2 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes2', null));
            Mes3 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes3', null));
            Mes4 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes4', null));
            Mes5 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes5', null));
            Mes6 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes6', null));
            Mes7 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes7', null));
            Mes8 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes8', null));
            Mes9 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes9', null));
            Mes10 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes10', null));
            Mes11 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes11', null));
            Mes12 = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mes12', null));
            ResaltadaInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('ResaltadaInv', null));
        }
    }

    public class Recursivodeudahistorica1{
        public Datetime FechaCorte {get; set;}
        public Datetime FechaCorteParam {get; set;}
        public Decimal PorVencer {get; set;}
        public Decimal NoDevengaInt {get; set;}
        public Decimal Vencido0a1 {get; set;}
        public Decimal Vencido1a2 {get; set;}
        public Decimal Vencido2a3 {get; set;}
        public Decimal Vencido3a6 {get; set;}
        public Decimal Vencido6a9 {get; set;}
        public Decimal Vencido9a12 {get; set;}
        public Decimal Vencido12a24 {get; set;}
        public Decimal Vencido24 {get; set;}
        public Decimal Vencido36 {get; set;}
        public Decimal DemandaJudicial {get; set;}
        public Decimal CarteraCastigada {get; set;}
        public Decimal SaldoDeuda {get; set;}
        public String tipoDeudaParam {get; set;}

        public Recursivodeudahistorica1(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            FechaCorteParam = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorteParam', null));
            PorVencer = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer', null));
            NoDevengaInt = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('NoDevengaInt', null));
            Vencido0a1 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido0a1', null));
            Vencido1a2 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido1a2', null));
            Vencido2a3 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido2a3', null));
            Vencido3a6 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido3a6', null));
            Vencido6a9 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido6a9', null));
            Vencido9a12 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido9a12', null));
            Vencido12a24 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido12a24', null));
            Vencido24 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido24', null));
            Vencido36 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido36', null));
            DemandaJudicial = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('DemandaJudicial', null));
            CarteraCastigada = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CarteraCastigada', null));
            SaldoDeuda = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('SaldoDeuda', null));
            tipoDeudaParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('tipoDeudaParam', null));
        }
    }

    public class Creditosotorgados12ultimosmeses{
        public String CodigoInstitucionInv {get; set;}
        public String Institucion {get; set;}
        public String EstadoOperacion {get; set;}
        public String TipoCredito {get; set;}
        public Decimal ValorOperacion {get; set;}
        public Decimal Titular {get; set;}
        public Decimal Codeudor {get; set;}
        public Decimal Garante {get; set;}
        public Datetime FechaConcesion {get; set;}
        public Datetime FechaVencimiento {get; set;}
        public String CodEstadoOpInv {get; set;}
        public String CodTipoCreditoInv {get; set;}
        public String CodTipoDeudorInv {get; set;}
        public String CodCalificacionInv {get; set;}

        public Creditosotorgados12ultimosmeses(Dom.XMLNode xmlRecord){
            CodigoInstitucionInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            EstadoOperacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('EstadoOperacion', null));
            TipoCredito = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoCredito', null));
            ValorOperacion = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('ValorOperacion', null));
            Titular = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Titular', null));
            Codeudor = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Codeudor', null));
            Garante = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Garante', null));
            FechaConcesion = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaConcesion', null));
            FechaVencimiento = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaVencimiento', null));
            CodEstadoOpInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodEstadoOpInv', null));
            CodTipoCreditoInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodTipoCreditoInv', null));
            CodTipoDeudorInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodTipoDeudorInv', null));
            CodCalificacionInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodCalificacionInv', null));
        }
    }

    public class Tarjetasdecreditoanuladaspormalmanejo{
        public String Institucion {get; set;}
        public Datetime FechaCorte {get; set;}

        public Tarjetasdecreditoanuladaspormalmanejo(Dom.XMLNode xmlRecord){
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            FechaCorte = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
        }
    }

    public class Ultimas10operacionescanceladas{
        public Decimal CodigoInstitucionInv {get; set;}
        public String Institucion {get; set;}
        public String NumeroOperaciones {get; set;}
        public Decimal ValorOriginal {get; set;}
        public String CodFormaCancelacionInv {get; set;}
        public String FormaCancelacion {get; set;}
        public Datetime FechaCancelacion {get; set;}

        public Ultimas10operacionescanceladas(Dom.XMLNode xmlRecord){
            CodigoInstitucionInv = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            NumeroOperaciones = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroOperaciones', null));
            ValorOriginal = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('ValorOriginal', null));
            CodFormaCancelacionInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodFormaCancelacionInv', null));
            FormaCancelacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('FormaCancelacion', null));
            FechaCancelacion = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCancelacion', null));
        }
    }

    public class RecursivoGarantiaspersonalescodeudoresoperacionesvigentes{
        public String TipoDeudor {get; set;}
        public String NombreTitular {get; set;}
        public String IdentificacionTitular {get; set;}
        public String NumeroOperacion {get; set;}
        public String Institucion {get; set;}
        public Decimal DeudaTotal {get; set;}
        public Decimal CodigoInstitucionParam {get; set;}
        public String OperacionParam {get; set;}
        public String CodigoTipoDeudorParam {get; set;}
        public String TipoDocumentoTitularParam {get; set;}
        public String NumeroDocumentoTitularParam {get; set;}
        public Datetime FechaCorteParam {get; set;}

        public RecursivoGarantiaspersonalescodeudoresoperacionesvigentes(Dom.XMLNode xmlRecord){
            TipoDeudor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoDeudor', null));
            NombreTitular = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreTitular', null));
            IdentificacionTitular = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('IdentificacionTitular', null));
            NumeroOperacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroOperacion', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            DeudaTotal = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('DeudaTotal', null));
            CodigoInstitucionParam = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CodigoInstitucionParam', null));
            OperacionParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('OperacionParam', null));
            CodigoTipoDeudorParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoTipoDeudorParam', null));
            TipoDocumentoTitularParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoDocumentoTitularParam', null));
            NumeroDocumentoTitularParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroDocumentoTitularParam', null));
            FechaCorteParam = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorteParam', null));
        }
    }

    public class Garantiaspersonalescodeudoresoperacionesnovigentes{
        public String TipoDeudor {get; set;}
        public Datetime FechaConcesion {get; set;}
        public Datetime FechaEliminacin {get; set;}
        public String NumeroDocumento {get; set;}
        public String NombreSujeto {get; set;}
        public String Institucion {get; set;}
        public String NumeroOperacion {get; set;}
        public Decimal ValorOperacion {get; set;}
        public Datetime FechaCancelacin {get; set;}
        public Datetime FechaCorteInv {get; set;}

        public Garantiaspersonalescodeudoresoperacionesnovigentes(Dom.XMLNode xmlRecord){
            TipoDeudor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoDeudor', null));
            FechaConcesion = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaConcesion', null));
            FechaEliminacin = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaEliminacin', null));
            NumeroDocumento = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroDocumento', null));
            NombreSujeto = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NombreSujeto', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            NumeroOperacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NumeroOperacion', null));
            ValorOperacion = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('ValorOperacion', null));
            FechaCancelacin = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCancelacin', null));
            FechaCorteInv = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorteInv', null));
        }
    }

    public class VinculacionesaInstitucionesFinancieras{
        public Decimal CodigoInstitucionInv {get; set;}
        public String Institucion {get; set;}
        public String Vinculacion {get; set;}
        public String Causal {get; set;}

        public VinculacionesaInstitucionesFinancieras(Dom.XMLNode xmlRecord){
            CodigoInstitucionInv = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            Vinculacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Vinculacion', null));
            Causal = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Causal', null));
        }
    }

    public class Analisisdetalledelvencido{
        public Datetime FechaCorte {get; set;}
        public String CodigoInstitucionInv {get; set;}
        public String Institucion {get; set;}
        public Decimal Vencido0a1 {get; set;}
        public Decimal Vencido1a2 {get; set;}
        public Decimal Vencido2a3 {get; set;}
        public Decimal Vencido3a6 {get; set;}
        public Decimal Vencido6a9 {get; set;}
        public Decimal Vencido9a12 {get; set;}
        public Decimal Vencido12a24 {get; set;}
        public Decimal Vencido24a36 {get; set;}
        public Decimal Vencido36 {get; set;}
        public Decimal DemandaJudicial {get; set;}
        public Decimal CarteraCastigada {get; set;}
        public Decimal NoDevengaInteresesInv {get; set;}
        public Decimal TotalVencidoInv {get; set;}
        public String AcuerdoConcordato {get; set;}

        public Analisisdetalledelvencido(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            CodigoInstitucionInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            Vencido0a1 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido0a1', null));
            Vencido1a2 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido1a2', null));
            Vencido2a3 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido2a3', null));
            Vencido3a6 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido3a6', null));
            Vencido6a9 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido6a9', null));
            Vencido9a12 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido9a12', null));
            Vencido12a24 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido12a24', null));
            Vencido24a36 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido24a36', null));
            Vencido36 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencido36', null));
            DemandaJudicial = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('DemandaJudicial', null));
            CarteraCastigada = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CarteraCastigada', null));
            NoDevengaInteresesInv = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('NoDevengaInteresesInv', null));
            TotalVencidoInv = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('TotalVencidoInv', null));
            AcuerdoConcordato = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('AcuerdoConcordato', null));
        }
    }

    public class Analisissaldosporvencersistemafinanciero{
        public Datetime FechaCorte {get; set;}
        public String Institucion {get; set;}
        public Decimal CodigoInstitucionInv {get; set;}
        public Decimal TotalPorVencer {get; set;}
        public Decimal PorVencer0a1 {get; set;}
        public Decimal PorVencer1a3 {get; set;}
        public Decimal PorVencer3a6 {get; set;}
        public Decimal PorVencer6a12 {get; set;}
        public Decimal PorVencer12 {get; set;}

        public Analisissaldosporvencersistemafinanciero(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            CodigoInstitucionInv = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('CodigoInstitucionInv', null));
            TotalPorVencer = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('TotalPorVencer', null));
            PorVencer0a1 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer0a1', null));
            PorVencer1a3 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer1a3', null));
            PorVencer3a6 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer3a6', null));
            PorVencer6a12 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer6a12', null));
            PorVencer12 = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('PorVencer12', null));
        }
    }

    public class WSOGraficarEvolucionDeuda{
        public Datetime FechaCorte {get; set;}
        public Decimal Total {get; set;}
        public Decimal Vencidos {get; set;}

        public WSOGraficarEvolucionDeuda(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getDatetimeValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            Total = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Total', null));
            Vencidos = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Vencidos', null));
        }
    }
    
    public class EvolucionHistoricayDistEndeudamientoSICOM {
        public String FechaCorte {get; set;}
        public String NOM_INSTITUCION {get; set;}
        public String TIPO_DEUDOR {get; set;}
        public String VAL_X_VENCER {get; set;}
        public String VAL_VENCIDO {get; set;}
        public String VAL_NDI {get; set;}
        public String VAL_DEM_JUDICIAL {get; set;}
        public String VAL_CART_CASTIGADA {get; set;}
        public String NUM_DIAS_VENCIDO_ACTUALIZADO {get; set;}
        
        public EvolucionHistoricayDistEndeudamientoSICOM(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            NOM_INSTITUCION = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NOM_INSTITUCION', null));
            TIPO_DEUDOR = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TIPO_DEUDOR', null));
            VAL_X_VENCER = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('VAL_X_VENCER', null));
            VAL_VENCIDO = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('VAL_VENCIDO', null));
            VAL_NDI = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('VAL_NDI', null));
            VAL_DEM_JUDICIAL = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('VAL_DEM_JUDICIAL', null));
            VAL_CART_CASTIGADA = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('VAL_CART_CASTIGADA', null));
            NUM_DIAS_VENCIDO_ACTUALIZADO = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('NUM_DIAS_VENCIDO_ACTUALIZADO', null));
        }
    }

    class ScoreGeneral{
        public Integer Score {get; set;}
        public Decimal Porcentaje {get; set;}
        public Integer Riesgo_x0020_Inv {get; set;}

        public ScoreGeneral(Dom.XMLNode xmlRecord){
            Score = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('Score', null));
            Porcentaje = utilsXMLParse.getDecimalValueFromXML(xmlRecord.getChildElement('Porcentaje', null));
            Riesgo_x0020_Inv = utilsXMLParse.getIntegerValueFromXML(xmlRecord.getChildElement('Riesgo_x0020_Inv', null));
        }
    }

    class Identificadorperfilriesgodirectodesde2005{
        public String Mensaje {get; set;}

        public Identificadorperfilriesgodirectodesde2005(Dom.XMLNode xmlRecord){
            Mensaje = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mensaje', null));
        }
    }

    class Identificadorperfilriesgodirecto6meses{
        public String Mensaje {get; set;}

        public Identificadorperfilriesgodirecto6meses(Dom.XMLNode xmlRecord){
            Mensaje = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mensaje', null));
        }
    }

    class RecursivoDetalledistribucionendeudamiento{
        public String FechaCorte {get; set;}
        public String FechaCorteParam {get; set;}
        public String CodigoInstitucionParam {get; set;}
        public String Institucion {get; set;}
        public String TipoCreditoParam {get; set;}
        public String TipoCredito {get; set;}
        public String SaldoDeuda {get; set;}
        public String DemandaJudicial {get; set;}
        public String CarteraCastigada {get; set;}
        public String Titular {get; set;}
        public String Garante {get; set;}
        public String Codeudor {get; set;}
        public String TarjetaCredito {get; set;}        
        public String AcuerdoConcordatorio {get; set;}
        public String Detalle {get; set;}
        public String ResaltadaInv {get; set;}

        public RecursivoDetalledistribucionendeudamiento(Dom.XMLNode xmlRecord){
            FechaCorte = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('FechaCorte', null));
            FechaCorteParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('FechaCorteParam', null));
            CodigoInstitucionParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CodigoInstitucionParam', null));
            Institucion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Institucion', null));
            TipoCreditoParam = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoCreditoParam', null));
            TipoCredito = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TipoCredito', null));           
            SaldoDeuda = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('SaldoDeuda', null));
            DemandaJudicial = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('DemandaJudicial', null));
            CarteraCastigada = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CarteraCastigada', null));
            Titular = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Titular', null));
            Garante = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Garante', null));
            Codeudor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Codeudor', null));
            TarjetaCredito = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('TarjetaCredito', null));
            AcuerdoConcordatorio = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('AcuerdoConcordatorio', null));
            Detalle = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Detalle', null));
            ResaltadaInv = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('ResaltadaInv', null));
        }
    }

    class RecursivoComposicionestructuradevencimiento{
        public String Mensaje {get; set;}

        public RecursivoComposicionestructuradevencimiento(Dom.XMLNode xmlRecord){
            Mensaje = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Mensaje', null));
        }
    }

    class ResultadoSegmentacion{
        public String ResultadoEvaluacion {get; set;}
        public String SegmentacionCliente {get; set;}
        public String ScoreDeudor {get; set;}
        public String RiesgoAcumulado {get; set;}
        public String RangosIngresos {get; set;}
        public String ValorEntradaAprobado {get; set;}
        public String Plazo {get; set;}
        public String CuotaMensual {get; set;}
        public String CapacidadPago {get; set;}
        public String IngresoValidado {get; set;}

        public ResultadoSegmentacion(Dom.XMLNode xmlRecord){
            ResultadoEvaluacion = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('ResultadoEvaluacion', null));
            SegmentacionCliente = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('SegmentacionCliente', null));
            ScoreDeudor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('ScoreDeudor', null));
            RiesgoAcumulado = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('RiesgoAcumulado', null));
            RangosIngresos = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('RangosIngresos', null));
            ValorEntradaAprobado = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('ValorEntradaAprobado', null));
            Plazo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Plazo', null));
            CuotaMensual = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CuotaMensual', null));
            CapacidadPago = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('CapacidadPago', null));
            IngresoValidado = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('IngresoValidado', null));
        }
    }

    class Sugerencia{
        public String Detalle {get; set;}
        public String Entrada {get; set;}
        public String Plazo {get; set;}
        public String Cuota {get; set;}

        public Sugerencia(Dom.XMLNode xmlRecord){
            Detalle = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Detalle', null));
            Entrada = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('V._x0020_Entrada_x0028_Usd_x0029_', null));
            Plazo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Plazo', null));
            Cuota = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Cuota_x0028_Usd_x0029_', null));
        }
    }

    class ResultadoSimulaciones{
        public String Plazo {get; set;}
        public String Cuota {get; set;}

        public ResultadoSimulaciones(Dom.XMLNode xmlRecord){
            Plazo = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Plazo', null));
            Cuota = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Cuota', null));
        }
    }

    class ResultadoPoliticas{
        public String Politica {get; set;}
        public String Valor {get; set;}
        public String Resultado {get; set;}

        public ResultadoPoliticas(Dom.XMLNode xmlRecord){
            Politica = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Politica', null));
            Valor = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Valor', null));
            Resultado = utilsXMLParse.getStringValueFromXML(xmlRecord.getChildElement('Resultado', null));
        }
    }
}