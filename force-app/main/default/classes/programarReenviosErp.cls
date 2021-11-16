global class programarReenviosErp implements Schedulable{
 
    global void execute(SchedulableContext ctx) {
        batchReenvios clase = new batchReenvios(); 
        ID batchprocessid = Database.executeBatch(clase, 1);
    }

}