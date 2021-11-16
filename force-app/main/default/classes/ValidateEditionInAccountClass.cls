public class ValidateEditionInAccountClass {                                                         
    
    @future(callout=true)
    public static void validacionesCuenta(Id Opor, Id Acc, String Proyect, String Estado) { //System.debug(lstAccount);
        
        Boolean b = System.isFuture();
            
        List<Permiso_a_Cuenta__c> myList = new List<Permiso_a_Cuenta__c>(); 
        myList = [SELECT Id, Name, CI_Permite_Edicion__c From Permiso_a_Cuenta__c Where CI_Oportunidad__c =: Opor LIMIT 1];

        for(Permiso_a_Cuenta__c obj : myList ) { 
            if(Estado == 'Probable' || Estado == 'Negociando') { 
                obj.CI_Permite_Edicion__c = true; 
        } else if(Estado == 'Vendida' || Estado == 'No negociada') { 
            obj.CI_Permite_Edicion__c = false; 
        }     
        } if(myList.size() > 0) { update myList; }
        
    }
    
    //Poner el campo Convertido desde Lead = No
    @future(callout=true)
    public static void validacionesCuenta2(Id accId) {           
        
        List<Account> myList = new List<Account>(); 
        myList = [SELECT Id, CI_Convertido_Lead__c From Account Where Id =: accId LIMIT 1];

        for(Account obj : myList) { obj.CI_Convertido_Lead__c = 'No';                 
        }
        
        if(myList.size() > 0) { update myList; }
        
    }
    
}