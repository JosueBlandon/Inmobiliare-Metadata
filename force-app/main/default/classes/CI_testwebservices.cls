@isTest
public class CI_testwebservices {
	
    @isTest static void testCallout() {              
        Test.setMock(WebServiceMock.class, new mocksoapws());
        CI_Equifax_wsdl_Locator cewl = new CI_Equifax_wsdl_Locator();
        cewl.values('C','0907837199','10000','15','2500','400','0','12','VIVIENDA','VITT');
    }
    
}