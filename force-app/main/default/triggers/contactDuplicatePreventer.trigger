trigger contactDuplicatePreventer on Contact (before insert, before update) {
    // Validando el campo identificación
    new CI_ContactTriggerHandler().run();
}