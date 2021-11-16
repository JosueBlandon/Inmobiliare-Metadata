@IsTest
public class processLeadOpportunityTest {
	@isTest static void execute2() {
        
        UserRole rManager = [SELECT Id FROM UserRole WHERE Name='Asesor Comercial Rioja'];
        
        User uM = new User();
        uM.Firstname = 'Ivan';
        uM.LastName = 'Hernández';
        uM.email = 'ihernan@outlook.com';
        uM.Alias = 'alias3';
        uM.CommunityNickname = 'commnick3';
        uM.EmailEncodingKey = 'UTF-8';
        uM.Username = 'ihernan123@outlook.com';
        uM.TimeZoneSidKey = 'America/Denver';
        uM.LocaleSidKey = 'en_US';
        uM.EmailEncodingKey = 'UTF-8';
        uM.LanguageLocaleKey = 'en_US';
        uM.isActive =true;
        uM.ProfileId = [SELECT id FROM profile where Name = 'Administrador del sistema'].Id;
        uM.UserRoleId = rManager.Id;
        insert uM;
      
    	UserRole r = [SELECT Id FROM UserRole WHERE Name='Asesor Comercial Rioja'];
        
        User u = new User();
        u.Firstname = 'B2BMA';
        u.LastName = 'Integration';
        u.email = 'b2bma@outlook.com';
        u.Alias = 'alias2';
        u.CommunityNickname = 'commnick2';
        u.EmailEncodingKey = 'UTF-8';
        u.Username = 'b2bma@outlook.com';
        u.TimeZoneSidKey = 'America/Denver';
        u.LocaleSidKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.isActive =true;
        u.ProfileId = [SELECT id FROM profile where Name = 'Administrador del sistema'].Id;
        u.UserRoleId = r.Id;
        insert u; 
                
        test.startTest();
        
        System.runAs ( u ) { 
            
            Asignacion_Web_to_Lead__c assign = new Asignacion_Web_to_Lead__c();
            assign.CI_Usuario__c = UM.Id;
            assign.CI_Cantidad_LA__c = 0;
            Insert assign;
            
            Proyecto__c pro = new Proyecto__c();
            pro.Name = 'LA RIOJA';
            pro.CI_Estado__c = 'Activo';
            pro.Codigo_Proyecto__c = '7001';
            insert pro;
            
            RecordType tipoRegistro=[select id,name from RecordType where Name =: 'Prospecto principal'];
            
       		Lead ld = new Lead();
            ld.RecordTypeId = tipoRegistro.Id;
            ld.FirstName = 'Test';
            ld.LastName = '001';
            ld.State = 'New';
            ld.CI_Tipo_Iden__c = '3';
            ld.CI_Personeria__c = '1';
            ld.CI_Identificacion__c = '0100194281090';
            ld.Email = 'test001@gmail.com';
            ld.CI_Proyecto__c = pro.Id;
            ld.CI_Medio_Contacto__c = 'EMAIL';
            ld.CI_Tipo_de_Cliente__c = 'Prospecto Potencial';
            ld.OwnerId = U.Id;
            Insert ld;
            
            Database.LeadConvert lc = new database.LeadConvert();  
            lc.setLeadId(ld.Id );  
            lc.setDoNotCreateOpportunity(true);  
            lc.setConvertedStatus('Qualified');  
              
            Database.LeadConvertResult lcr = Database.convertLead(lc, false);  
            
            System.debug('lcr: '+lcr.getAccountId());
                    
            List<String> LeadIds = new List<String>();
            LeadIds.add(ld.Id);
            
            List<String> IdentityLead = new List<String>();
            IdentityLead.add(ld.CI_Identificacion__c);
            
            processLeadOpportunity.deleteLead(LeadIds);
            
            processLeadOpportunity.createOpportunity(IdentityLead, U.Id);
            
            Account cuenta=[select Id,Owner.Id from Account where Id =: lcr.getAccountId()];
            cuenta.Owner.Id = U.Id;
            Update cuenta;
        }
    }
}