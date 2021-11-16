trigger Delete_Cuotes on Cuota_Financiamiento__c (after insert, after update) {
    delete [Select Id From Cuota_Financiamiento__c Where Monto_Pago__c = 0 ];
}