public class CI_Equifax_wsdl_Locator {
    public void values(String tipoDocumento,String numeroDocumento,String valorBien,String valorEntrada,String ingresoUnidadFamiliar,String gastoHogarUnidadFamiliar,String restaGastoFinanciero,String plazo,String tipoCredito,String tipoProyecto) {
        CI_Equifax_wsdl.WSExpertoCorporacionInmobiliareSoap obj = new CI_Equifax_wsdl.WSExpertoCorporacionInmobiliareSoap();
        obj.ObtenerResultadoExpertoCorporacionInmobiliare(tipoDocumento,numeroDocumento,valorBien,valorEntrada,ingresoUnidadFamiliar,gastoHogarUnidadFamiliar,restaGastoFinanciero,plazo,tipoCredito,tipoProyecto);
    }
}