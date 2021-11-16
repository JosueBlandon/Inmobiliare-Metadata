@isTest(SeeAllData=true)
public class mockrestws implements HttpCalloutMock {
	private HttpResponse resp;
    
    public mockrestws(String testBody) {
        resp = new HttpResponse();
        resp.setBody(testBody);
        resp.setStatusCode(200);
    }
    
    public HTTPResponse respond(HTTPRequest req) {
        return resp;
    }
 
    public testmethod static void testWS() {
        String testBody = 'This is a test :-)';
        
        HttpCalloutMock mock = new mockrestws(testBody);
        Test.setMock(HttpCalloutMock.class, mock);
           
        ApexPages.StandardController controller;
        CI_apex_equifax callout = new CI_apex_equifax(controller);
    }
}