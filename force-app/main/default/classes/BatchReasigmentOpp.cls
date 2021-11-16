global without sharing class BatchReasigmentOpp implements Database.Batchable<sObject>{
    
    global Id userorigenbatch;
    global Id userdestinobatch;
    global string tiporeasignacion;
    global BatchReasigmentOpp(string userorigen,string userdestino,string tipo) {
        this.userorigenbatch = userorigen;
        this.userdestinobatch = userdestino;
        this.tiporeasignacion = tipo;
    }
  global Database.QueryLocator start(Database.BatchableContext BC) {
        if(tiporeasignacion=='Todo'){
          return Database.getQueryLocator([select id,ownerid,CI_Reasigment__c,Name from Opportunity where isclosed=false and ownerid=:userorigenbatch and Account.CI_Tipo_de_Cliente__c='Prospecto Potencial' limit 50000]);    
        }
        else{
          return Database.getQueryLocator([select id,ownerid,CI_Reasigment__c,Name from Opportunity where isclosed=false and ownerid=:userorigenbatch and CI_Reasigment__c=true and Account.CI_Tipo_de_Cliente__c='Prospecto Potencial' limit 50000]);           
        }       
     }
    global void execute(Database.BatchableContext BC, List<Opportunity>scope) {
      list<user>usuario = [select id,Prospectos_Reasignados__c from user where id=:userdestinobatch limit 1];
      list<Opportunity>oppupdate= new list<Opportunity>();
      List<ConnectApi.BatchInput> batchInputs = new List<ConnectApi.BatchInput>();   
      for (Opportunity o : scope) { o.OwnerId =usuario[0].id; o.CI_Reasigment__c=false; oppupdate.add(o); usuario[0].Prospectos_Reasignados__c++; 
        //post chatter
             ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput(); ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput(); ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput(); ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
             
             messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
             //Mention user here
             mentionSegmentInput.id = usuario[0].id; messageBodyInput.messageSegments.add(mentionSegmentInput);
             
             textSegmentInput.text = ' Se le ha asignado/reasignado el prospecto potencial'+o.Name; messageBodyInput.messageSegments.add(textSegmentInput);
             
             feedItemInput.body = messageBodyInput; feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem; feedItemInput.subjectId = o.id;
             
             ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(feedItemInput); batchInputs.add(batchInput);  
       }
       update oppupdate;
       update usuario; 
       ConnectApi.ChatterFeeds.postFeedElementBatch(Network.getNetworkId(), batchinputs); 
     }
     global void finish(Database.BatchableContext BC) {
       AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        string estado = a.Status;
        if (estado == 'Completed') {
            estado = 'Completado';
        }
        list<user>usuario = [select id,firstname,lastname,Prospectos_Reasignados__c,email,Codigo_Usuario__c from user where id=:userdestinobatch order by Prospectos_Reasignados__c asc];   
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Reasignación de prospectos ' + estado);
         String body = 'Estimado Usuario el proceso ha finalizado con el siguiente resumen, '+ '<br/>';
          body +='<table style="border:1px solid black;border-collapse:collapse;">';
          body +='<th style="border:1px solid black;">Ejecutivo</th><th style="border:1px solid black;">Identificación</th><th style="border:1px solid black;">Correo</th><th style="border:1px solid black;">Total Asignado</th>';
          body +='<tbody>';
        for (user u : usuario) {
            Decimal ClienteTotal = u.Prospectos_Reasignados__c; String outputClienteTotal = String.valueOf(ClienteTotal.format());
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