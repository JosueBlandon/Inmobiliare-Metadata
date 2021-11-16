trigger identificactionLead on Lead (before insert, before update) {
            
    new CI_LeadTriggerHandler().run(); 

}