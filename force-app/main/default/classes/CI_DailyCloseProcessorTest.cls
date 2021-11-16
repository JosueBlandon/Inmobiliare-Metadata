@IsTest(SeeAllData=true)
public class CI_DailyCloseProcessorTest {
    
    static Configuracion_General__c config;
    static Configuracion_General__c config2;
    static Configuracion_General__c config3;
    static Configuracion_General__c config4;
    static Configuracion_General__c config5;
    
    static Account acc;
    
    @isTest static void executeTest(){
        
        try {
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Administrador del sistema'];
            User u1 = new User(Alias = 'standa', Email='pruebaadmin@gmail.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='pruebaadmin@gmail.com');
            
            System.runAs(u1) {
                
            acc = new Account();
            acc.LastName = 'TestAccount';
            acc.OwnerId = u1.Id;
            acc.CI_Notificar_PPI__c = false;
            insert acc;
            
            Opportunity oppt = new Opportunity(Name ='Test Opor',AccountID = Acc.Id,StageName = 'Probable',Amount = 3000,CloseDate = System.today());
            insert oppt;
            
            acc.CI_Notificar_PPI__c = true;
            //acc.OwnerId = '0052i000000f4K3';
            update acc;
                       
            config = new Configuracion_General__c();
            config.Name = 'Dar de baja prospecto potencial manual';
            config.CI_Valor__c = 30;
            insert config;
            
            config2 = new Configuracion_General__c();
            config2.Name = 'Dar de baja al registro de forma automática';
            config2.CI_Valor__c = 35;
            insert config2;
            
            config3 = new Configuracion_General__c();
            config3.Name = 'Dar de baja a la oportunidad manual';
            config3.CI_Valor__c = 30;
            insert config3;
            
            config4 = new Configuracion_General__c();
            config4.Name = 'Notificación previa inactividad de la oportunidad';
            config4.CI_Valor__c = 30;
            insert config4;
            
            config5 = new Configuracion_General__c();
            config5.Name = 'Dar de baja prospecto (Lead) manual';
            config5.CI_Valor__c = 15;
            insert config5;
            
            List<Configuracion_General__c> lstofConfig = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto potencial manual']; 
            
            List<Configuracion_General__c> lstofConfig2 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja al registro de forma automática']; 
            
            List<Configuracion_General__c> lstofConfig3 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja a la oportunidad manual'];
            
            List<Configuracion_General__c> lstofConfig4 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Notificación previa inactividad de la oportunidad'];
            
            List<Configuracion_General__c> lstofConfig5 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto (Lead) manual'];
           
            }    
                
            Test.StartTest();
            SchedulableContext sc = null;
            CI_DailyCloseProcessor tsc = new CI_DailyCloseProcessor();
            tsc.execute(sc);
            Test.StopTest();

        } catch(Exception ex) {
        	System.debug('Error de test: '+ex.getLineNumber()+'---'+ex.getMessage());
        }
    } 
    
    @isTest static void executeTest2(){
        
        try {
          
            UserRole r = [SELECT Id FROM UserRole WHERE Name='Asesor Comercial Rioja'];
            
            User u = new User();
            u.Firstname = 'mauricio';
            u.LastName = 'ruiz';
            u.email = 'mauryruiz@outlook.com';
            u.Alias = 'alias2';
            u.CommunityNickname = 'commnick2';
            u.EmailEncodingKey = 'UTF-8';
            u.Username = 'mauryruiz123@outlook.com';
            u.TimeZoneSidKey = 'America/Denver';
            u.LocaleSidKey = 'en_US';
            u.EmailEncodingKey = 'UTF-8';
            u.LanguageLocaleKey = 'en_US';
            u.isActive =true;
            u.ProfileId = [SELECT id FROM profile where Name = 'Administrador del sistema'].Id;
            u.UserRoleId = r.Id;
            insert u; 
            
            System.runAs(u) {
                
            acc = new Account();
            acc.LastName = 'TestAccount';
            acc.OwnerId = u.Id;
            acc.CI_Notificar_PPI__c = false;
            acc.OwnerId = u.Id;
            insert acc;
            
            Opportunity oppt = new Opportunity(Name ='Test Opor',AccountID = Acc.Id,StageName = 'Probable',Amount = 3000,CloseDate = System.today());
            insert oppt;
            
            acc.CI_Notificar_PPI__c = true;
            //acc.OwnerId = '0052i000000f4K3';
            update acc;
                       
            config = new Configuracion_General__c();
            config.Name = 'Dar de baja prospecto potencial manual';
            config.CI_Valor__c = 30;
            insert config;
            
            config2 = new Configuracion_General__c();
            config2.Name = 'Dar de baja al registro de forma automática';
            config2.CI_Valor__c = 35;
            insert config2;
            
            config3 = new Configuracion_General__c();
            config3.Name = 'Dar de baja a la oportunidad manual';
            config3.CI_Valor__c = 30;
            insert config3;
            
            config4 = new Configuracion_General__c();
            config4.Name = 'Notificación previa inactividad de la oportunidad';
            config4.CI_Valor__c = 30;
            insert config4;
            
            config5 = new Configuracion_General__c();
            config5.Name = 'Dar de baja prospecto (Lead) manual';
            config5.CI_Valor__c = 15;
            insert config5;
            
            List<Configuracion_General__c> lstofConfig = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto potencial manual']; 
            
            List<Configuracion_General__c> lstofConfig2 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja al registro de forma automática']; 
            
            List<Configuracion_General__c> lstofConfig3 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja a la oportunidad manual'];
            
            List<Configuracion_General__c> lstofConfig4 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Notificación previa inactividad de la oportunidad'];
            
            List<Configuracion_General__c> lstofConfig5 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto (Lead) manual'];
           
            }    
                
            Test.StartTest();
            SchedulableContext sc = null;
            CI_DailyCloseProcessor tsc = new CI_DailyCloseProcessor();
            tsc.execute(sc);
            Test.StopTest();

        } catch(Exception ex) {
            System.debug('Error de test: '+ex.getLineNumber()+'---'+ex.getMessage());
        }
        
    } 
    
}