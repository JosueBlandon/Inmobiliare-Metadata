@IsTest
public class ProspectManagerTest {
    
    static Lead candidato;  
    static Account acc;
    static Opportunity opor;
    
    static integer offset;
        
    @isTest static void ejecuciones1() {
        
        //----------//
        Profile pf= [Select Id from profile limit 1]; 
        
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        User uu=new User(firstname = 'ABC', 
                         lastName = 'XYZ', 
                         email = uniqueName + '@test' + orgId + '.org', 
                         Username = uniqueName + '@test' + orgId + '.org', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         ProfileId = pf.Id
                        ); 
        insert uu;
        
        list<User> usuarios;
        usuarios = [select id,firstname,lastname,name from user where isactive=true];
        
        //-----------//
        
        boolean next = false;
        boolean prev = true;
        decimal off = Decimal.valueOf(10);
        decimal recordsshow = Decimal.valueOf(5);
        string iduser = usuarios[0].id;
        string searchKey = 'searchKey';
        
        offset = (integer) off;
        
        //----------//
        candidato = new Lead();
        candidato.LastName = 'TestLead';
        insert candidato;
        
        String idlead = candidato.id;
        Boolean asignacion = true;
        
        //----------//
        List<String> strList = new List<String>();
        strList.add('id1');
        strList.add('id2');
        
        //----------//
        List<String> strList2 = new List<String>();
        strList2.add(usuarios[0].id);
        string idusuario = usuarios[0].id; 
        
        //----------//
        
        //----------//
        acc = new Account();
        acc.LastName = 'TestAcc';
        insert acc;
        
        opor = new Opportunity();
        opor.name = 'TestOpor';
        opor.AccountId = acc.Id;
        opor.StageName = 'Closed Won';
        opor.CloseDate = date.today();
        opor.Type = 'New Customers';
        opor.CI_Reasigment__c = true;
        insert opor;
        string idopp = opor.Id;
        
        //----------//
        List<String> idopps = new List<String>();
        idopps.add(opor.id);
        
        //----------//
        string userorigen = usuarios[0].id;
        string userdestino = usuarios[0].id;
        
        Test.startTest();
        
        ProspectManager.Getusers();
        
        ProspectManager.getleadsuser(next, prev, off, recordsshow, iduser, searchKey);
        
        ProspectManager.UpdateAsignacion(idlead, asignacion); 
        
        ProspectManager.UpdateAsignacionMass(strList, asignacion);
        
        ProspectManager.Changeowner(strList2, idusuario);
        
        ProspectManager.ChangeownerMass(strList2, idusuario);
        
        ProspectManager.getopportunitiesbysuser(next, prev, off, recordsshow, iduser);
        
        ProspectManager.UpdateAsignacionOpp(idopp, asignacion);
        
        ProspectManager.UpdateAsignacionMassOpp(idopps, asignacion);
        
        ProspectManager.ChangeownerOpp(userorigen, userdestino);
        
        ProspectManager.ChangeownerMassOpp(userorigen, userdestino);
        
        Test.stopTest(); 
        
    }
    
}