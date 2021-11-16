global class CI_DailyCloseProcessor implements Schedulable {
    global void execute(SchedulableContext sc) { 
        
       //---Dar de baja al Prospecto Potencial (Account)---
         //Dar de baja al Prospecto Potencial de forma Manual
       List<Configuracion_General__c> lstofConfig = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto potencial manual']; 
       Decimal Valor = lstofConfig[0].CI_Valor__c;
       List<Account> lstofAccount = [Select id, CI_Tipo_de_Cliente__c, CreatedDate, LastModifiedDate, CI_Dias_sin_gestionar__c, CI_Notificar_PPI__c, CI_Estado_cuenta__c from Account where CI_Tipo_de_Cliente__c='Prospecto Potencial' and CI_Estado_cuenta__c != 'Dado de Baja' and CI_Dias_sin_gestionar__c =: Valor];      
       List<Account> lstofUdateAccount = new List<Account>();
       if(!lstofAccount.isEmpty()) { 
           for(Account acc : lstofAccount) { acc.CI_Notificar_PPI__c = true; lstofUdateAccount.add(acc); } update lstofUdateAccount;
       }
         //Dar de baja al Prospecto Potencial de forma automática 
       List<Configuracion_General__c> lstofConfig2 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja al registro de forma automática']; 
       Decimal Valor2 = lstofConfig2[0].CI_Valor__c;
       Decimal Valor3 =  Valor + Valor2;
       List<Account> lstofAccount2 = [Select id, CI_Tipo_de_Cliente__c, CreatedDate, LastModifiedDate, CI_Dias_sin_gestionar__c, CI_Notificar_PPI__c, CI_Estado_cuenta__c from Account where CI_Tipo_de_Cliente__c='Prospecto Potencial' and CI_Estado_cuenta__c != 'Dado de Baja' and CI_Dias_sin_gestionar__c =: Valor3]; 
       List<Account> lstofUdateAccount2 = new List<Account>();
       if(!lstofAccount2.isEmpty()) { for(Account acc2 : lstofAccount2) { acc2.CI_Motivo_Baja__c = 'PROCESO AUTOMÁTICO'; acc2.CI_Estado_cuenta__c = 'Dado de Baja'; lstofUdateAccount2.add(acc2); } update lstofUdateAccount2;
       }
        //poner el check de envío de email en false 
       List<Account> lstofUdateAccount3 = new List<Account>();  
       if(!lstofAccount.isEmpty() || !lstofAccount2.isEmpty()) { 
           for(Account acc3 : lstofAccount) { acc3.CI_Notificar_PPI__c = false; lstofUdateAccount3.add(acc3); } update lstofUdateAccount3;
       }
       //---Fin Dar de baja al Prospecto Potencial (Account)---
       
       //---Dar de baja a la Oportunidad---
         //Notificación previa al propietario de la oportunida y a su jefe inmediato
       List<Configuracion_General__c> lstofConfig3 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja a la oportunidad manual']; 
       Decimal Valor4 = lstofConfig3[0].CI_Valor__c;
       
       List<Configuracion_General__c> lstofConfig4 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Notificación previa inactividad de la oportunidad']; 
       Decimal Valor5 = lstofConfig4[0].CI_Valor__c; 
        
       Decimal Valor6 =  Valor4 - Valor5;
        
       List<Opportunity> lstofOpportunity = [Select id,name,CI_Fecha_prox_act__c,CI_Dias_sin_gestionar__c,CI_Motivo_Baja__c,CI_Notificar_OpIn__c from Opportunity where CI_Dias_sin_gestionar__c =: Valor6 and (StageName != 'Vendida' or StageName != 'No negociada')]; 
       List<Opportunity> lstofUdateOpportunity = new List<Opportunity>();
       if(!lstofOpportunity.isEmpty()) { for(Opportunity opp : lstofOpportunity) { opp.CI_Notificar_OpIn__c = true; /*opp.CI_Motivo_Baja__c = 'PROCESO AUTOMÁTICO';*/ lstofUdateOpportunity.add(opp); } update lstofUdateOpportunity;
       }
         //poner el check de envío de email en false   
       List<Opportunity> lstofUdateOpportunity2 = new List<Opportunity>();
       if(!lstofOpportunity.isEmpty()) { for(Opportunity opp2 : lstofOpportunity) { opp2.CI_Notificar_OpIn__c = false; lstofUdateOpportunity2.add(opp2); } update lstofUdateOpportunity2;
       }
         //Notificar vencimiento al propietario de la oportunida y a su jefe inmediato / creación de evento
       List<Opportunity> lstofOpportunity2 = [Select id,name,accountId,CI_Fecha_prox_act__c,CI_Dias_sin_gestionar__c,CI_Motivo_Baja__c,CI_Notificar_OpIn__c,OwnerId from Opportunity where CI_Dias_sin_gestionar__c =: Valor4 and (StageName != 'Vendida' or StageName != 'No negociada')]; 
       List<Opportunity> lstofUdateOpportunity3 = new List<Opportunity>();
       /*if(!lstofOpportunity2.isEmpty()) { System.debug('Notificar Oportunidad Dada de baja Manual');
           for(Opportunity opp3 : lstofOpportunity2) { List<Event> evtList = new List<Event>();
                Event evt = new Event(); evt.Subject = 'Reunión'; evt.Description = 'Reunión para definir el seguimiento de la oportunidad';
				evt.StartDateTime = Date.today()+1; evt.EndDateTime	 = Date.today()+1; evt.WhatId = lstofOpportunity2[0].Id;
                evt.OwnerId = lstofOpportunity2[0].OwnerId; evt.CI_Evento_flag__c = true; evtList.add(evt);
                if(evtList!=null && evtList.size()>0) { insert evtList; System.debug('Evento Creado: '+evtList); }    
           }
           update lstofUdateOpportunity3;
       }*/
       if(!lstofOpportunity2.isEmpty()) { 
           for(Opportunity opp3 : lstofOpportunity2) { opp3.CI_Notificar_DDBM__c = true; lstofUdateOpportunity3.add(opp3); } update lstofUdateOpportunity3;
       }
         //poner el check de envío 2 de email en false   
       List<Opportunity> lstofUdateOpportunity5 = new List<Opportunity>();
       if(!lstofOpportunity2.isEmpty()) { 
           for(Opportunity opp4 : lstofOpportunity2) { opp4.CI_Notificar_DDBM__c = false; lstofUdateOpportunity5.add(opp4); } update lstofUdateOpportunity5;
       } 
        
         //Dar de baja a la oportunidad de forma automática  
       /*List<Configuracion_General__c> lstofConfig5 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto potencial manual']; 
       Decimal Valor7 = lstofConfig5[0].CI_Valor__c;*/
        
       List<Configuracion_General__c> lstofConfig6 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja al registro de forma automática']; 
       Decimal Valor8 = lstofConfig6[0].CI_Valor__c;
        
       Decimal Valor9 =  Valor4 + Valor8; 
        
       List<Opportunity> lstofOpportunity3 = [Select id,name,accountId,CI_Fecha_prox_act__c,CI_Dias_sin_gestionar__c,CI_Motivo_Baja__c,CI_Notificar_OpIn__c,Baja_automatica_flag__c,Cotizacion__r.Codigo_Venta__c from Opportunity where CI_Dias_sin_gestionar__c =: Valor9 and (StageName != 'Vendida' or StageName != 'No negociada') and Baja_automatica_flag__c =: false and Cotizacion__r.Codigo_Venta__c =: null];
       List<Opportunity> lstofUdateOpportunity4 = new List<Opportunity>();
       if(!lstofOpportunity3.isEmpty()) { for(Opportunity opp4 : lstofOpportunity3) { opp4.CI_Motivo_Baja__c = 'PROCESO AUTOMÁTICO'; opp4.StageName = 'No negociada'; opp4.Baja_automatica_flag__c = true; lstofUdateOpportunity4.add(opp4); } update lstofUdateOpportunity4;
       }
       //---Fin Dar de baja a la Oportunidad---
       
       //---Dar de baja al Prospecto (Lead)---
       List<Configuracion_General__c> lstofConfig7 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Dar de baja prospecto (Lead) manual']; 
       Decimal Valor10 = lstofConfig7[0].CI_Valor__c;
        
       /*List<Lead> lstofLead = [Select id, CreatedDate, LastModifiedDate, CI_Dias_sin_gestionar__c, CI_Notificar_PI__c, Status from Lead where Status != 'Dado de Baja' and Status != 'Qualified' and CI_Dias_sin_gestionar__c =: Valor10];
       List<Lead> lstofUpdateLead = new List<Lead>(); 
       if(!lstofLead.isEmpty()) { for(Lead l : lstofLead) { l.CI_Notificar_PI__c = true; lstofUpdateLead.add(l); } update lstofUpdateLead;
       }*/ 
         //Dar de baja al Prospecto (Lead) de forma automática  
       /*Decimal Valor11 =  Valor10 + Valor2;
       
       List<Lead> lstofLead2 = [Select id, CreatedDate, LastModifiedDate, CI_Dias_sin_gestionar__c, CI_Notificar_PI__c, Status from Lead where Status != 'Dado de Baja' and Status != 'Qualified' and CI_Dias_sin_gestionar__c =: Valor11];
       List<Lead> lstofUpdateLead2 = new List<Lead>(); 
       if(!lstofLead2.isEmpty()) { for(Lead l2 : lstofLead2) { l2.CI_Motivo_Baja__c = 'PROCESO AUTOMÁTICO'; l2.Status = 'Dado de Baja'; lstofUpdateLead2.add(l2); } update lstofUpdateLead2;
       }*/ 
         //poner el check de envío de email en false 
       /*List<Lead> lstofUpdateLead3 = new List<Lead>();  
       if(!lstofLead.isEmpty()) { for(Lead l3 : lstofLead) { l3.CI_Notificar_PI__c = false; lstofUpdateLead3.add(l3); } update lstofUpdateLead3;
       }*/ 
       //---Fin Dar de baja al Prospecto (Lead)--- 
       
       //---Reasignar Cuenta a Jefe por venta no generada de la Oportunidad. 
       List<Configuracion_General__c> lstofConfig8 = [Select id, Name, CI_Valor__c from Configuracion_General__c where Name = 'Reasignar cuenta a jefe por falta de gestión en oportunidad']; 
       Integer Valor12 = Integer.valueOf(lstofConfig7[0].CI_Valor__c);
       //Integer dias = 90; 
       List<Opportunity> lstofOppor = [Select Id, Name, AccountId, Account.CI_Identificacion__c, Cotizacion__r.Codigo_Venta__c, Account.CI_Dias_creacion__c, Account.OwnerId, Account.CI_Id_Gestor__c, StageName From Opportunity Where (StageName != 'Vendida' or StageName != 'No negociada') and Cotizacion__r.Codigo_Venta__c = null and Account.CI_Dias_creacion__c =: Valor12];      
       List<Opportunity> lstofUpdateOppor = new List<Opportunity>(); 
        
       Set<Id> opor = new Set<Id>();  
       if(!lstofOppor.isEmpty()) { for(Opportunity opp : lstofOppor) { opor.add(opp.AccountId); opp.CI_Cambia_prop_cuenta__c = true; opp.CI_Motivo_Baja__c = 'PROCESO AUTOMÁTICO'; opp.StageName = 'No negociada'; lstofUpdateOppor.add(opp); } update lstofUpdateOppor;
       }
         //poner el check de envío de email en false  
       List<Opportunity> lstofUpdateOppor2 = new List<Opportunity>();  
       if(!lstofOppor.isEmpty()) { for(Opportunity opp : lstofOppor) { opp.CI_Cambia_prop_cuenta__c = false; lstofUpdateOppor2.add(opp); } update lstofUpdateOppor2;
       } 
         //Actualizar el propietario de la cuenta 
       List<Account> lstofAcc = [SELECT Id,OwnerId,Owner.Name,CI_Id_Gestor__c FROM Account Where Id IN : opor];  
       List<Account> lstofUdateAcc = new List<Account>();
        
       if(!lstofAcc.isEmpty()) {  for(Account acc : lstofAcc) { acc.OwnerId = acc.CI_Id_Gestor__c; lstofUdateAcc.add(acc); } update lstofUdateAcc;
       }  
       //---Fin Reasignar Cuenta a Jefe por venta no generada de la Oportunidad. 
       
    }
}