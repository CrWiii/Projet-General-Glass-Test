@isTest
private class TestOrderInvoiceTriggers {

 static testMethod void TestOrderInvoiceTriggers() {
        //create Account
    	Account acct = new  Account(Name='MyTestAccount');
    	insert acct;
        //System.Debug('After INSERT Account');
    	acct.Name = 'ModifiedTestAccount';
    	update acct;
        //System.Debug('After UPDATE Account');
        
        //create Order
    	Order__c ord = new  Order__c(Name='MyTestOrder', Account__c = acct.id);
    	insert ord;
        //System.Debug('After INSERT Order');
    	ord.Name = 'ModifiedTestOrder';
    	update ord;
        //System.Debug('After UPDATE Order');
        
        //Create Invoice 
        Invoice_Credit__c inv = new Invoice_Credit__c(Name='MyTestInvoice', Account__c = acct.id);	
        insert inv;
        inv.Name = 'ModifiedTestInvoice';
    	update inv;
        //System.Debug('After UPDATE Invoice');
    }
}