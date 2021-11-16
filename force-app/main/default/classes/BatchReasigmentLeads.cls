global without sharing class  BatchReasigmentLeads implements Database.Batchable<sObject>{
    global List<Id> usuarios = new List<Id>();
    global Id usuariopropietario;
    global string tiporeasignacion;
    global BatchReasigmentLeads(List < Id > idsuser,string iduser,string tipo) {
        this.usuarios = idsuser;
        this.usuariopropietario = iduser;
        this.tiporeasignacion = tipo;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        list<lead>prosp = new list<lead>();
        if(tiporeasignacion=='Todo'){
          return Database.getQueryLocator([select id,ownerid,firstname,lastname,CI_Reasigment__c from lead where isconverted=false and ownerid=:usuariopropietario limit 50000]);    
        }
        else{
          return Database.getQueryLocator([select id,ownerid,firstname,lastname,CI_Reasigment__c from lead where isconverted=false and ownerid=:usuariopropietario and CI_Reasigment__c=true limit 50000]);           
        }       
     }
     global void execute(Database.BatchableContext BC, List<Lead>scope) {
      list<user>usuario = [select id,Prospectos_Reasignados__c from user where id IN:usuarios order by Prospectos_Reasignados__c asc];
      list<lead>leadupdate= new list<lead>();
      List<ConnectApi.BatchInput> batchInputs = new List<ConnectApi.BatchInput>();   
      for (Lead l : scope) { l.OwnerId =usuario[0].id; l.CI_Reasigment__c=false; leadupdate.add(l); usuario[0].Prospectos_Reasignados__c++; 
         //post chatter
             ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput(); ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput(); ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput(); ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
             
             messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
             //Mention user here
             mentionSegmentInput.id = usuario[0].id; messageBodyInput.messageSegments.add(mentionSegmentInput);
             
             textSegmentInput.text = ' Se le ha asignado/reasignado el prospecto '+l.firstname+' '+l.lastname; messageBodyInput.messageSegments.add(textSegmentInput);
             
             feedItemInput.body = messageBodyInput; feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem; feedItemInput.subjectId = l.id;
             
             ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(feedItemInput); batchInputs.add(batchInput);
       }
       update leadupdate;
       update usuario;
       ConnectApi.ChatterFeeds.postFeedElementBatch(Network.getNetworkId(), batchinputs);  
     }
     global void finish(Database.BatchableContext BC) {
      AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        string estado = a.Status;
        if (estado == 'Completed') {
            estado = 'Completado';
        }
         list<user>usuario = [select id,firstname,lastname,Prospectos_Reasignados__c,email,Codigo_Usuario__c from user where id IN:usuarios order by Prospectos_Reasignados__c asc];   
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Reasignación de prospectos ' + estado);
         String body = 'Estimado Usuario el proceso ha finalizado con el siguiente resumen, '+ '<br/>';
          body +='<table style="border:1px solid black;border-collapse:collapse;">';
          body +='<th style="border:1px solid black;">Ejecutivo</th><th style="border:1px solid black;">Identificación</th><th style="border:1px solid black;">Correo</th><th style="border:1px solid black;">Total Asignado</th>';
          body +='<tbody>';
        for (user u : usuario) {
            Decimal ClienteTotal = u.Prospectos_Reasignados__c;
            String outputClienteTotal = String.valueOf(ClienteTotal.format());
            body +='<tr>';
            body += '<td style="border:1px solid black;">' + u.firstname + ' ' + u.lastname + '</td>'+'<td style="border:1px solid black;">'+ u.Codigo_Usuario__c + '</td>'+'<td style="border:1px solid black;">'+ u.email + '</td>'+'<td style="border:1px solid black;">'+ outputClienteTotal + '</td>';
            body +='</tr>';
        }
        body +='</tbody>';
        body +='</table>';  
        mail.setHtmlBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     }   
}