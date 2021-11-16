public class CI_CambiarPropietarioLead {
	@AuraEnabled
    public static Lead changeOwnerMethod(Id leadId) {
        if(leadId != null) {
            Lead l = [SELECT Id,OwnerId,CI_Id_Gestor__c FROM Lead WHERE Id = :leadId];
            l.OwnerId = l.CI_Id_Gestor__c;
            update l;
            return l;
        }
        return null;
    }
}