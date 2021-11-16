public class processLeadOpportunity {
	@future
    public static void deleteLead(List<String> LeadIds) {
        List<Lead> listLead = [Select Id,Createddate From Lead Where CI_Identificacion__c In: LeadIds order by Createddate desc Limit 1];
        if(!listLead.isEmpty()) {
            delete listLead;
        }
    }
    
    @future
    public static void createOpportunity(List<String> IdentityLead, String newUser) {
        //Buscando la Cuenta
        List<Lead> candidato = [Select Id,Status,ConvertedAccountId From Lead Where CI_Identificacion__c IN: IdentityLead]; 
        System.debug('candidato: '+candidato);
        if(!candidato.IsEmpty() && candidato[0].Status == 'Qualified') {
            List<Account> cuenta = [Select Id,Name From Account Where Id =: candidato[0].ConvertedAccountId];
            System.debug('cuenta: '+cuenta);
            Opportunity opor = new Opportunity();
            opor.AccountId = cuenta[0].Id;
            opor.StageName = 'Probable';
            opor.Name = cuenta[0].NAme+'--';
            opor.CloseDate = System.today() + 30;
            opor.OwnerId = newUser;
            Insert opor;
            System.debug('Nueva oportunidad: '+opor);
            
            List<Asignacion_Web_to_Lead__c> assign = new List<Asignacion_Web_to_Lead__c>();
            assign = [Select Id,CI_Usuario__c,CI_Usuario_Activo__c,CI_Proyecto__c,CI_Cantidad_LA__c 
                                  From Asignacion_Web_to_Lead__c where CI_Usuario__c =: newUser Limit 1];
            if(!assign.isEmpty()) {
            	assign[0].CI_Cantidad_LA__c = assign[0].CI_Cantidad_LA__c + 1;
                update assign;
            }
        }
    } 
}