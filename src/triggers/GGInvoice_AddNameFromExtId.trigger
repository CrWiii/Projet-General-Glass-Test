trigger GGInvoice_AddNameFromExtId on Invoice_Credit__c (before insert, before update) {
for (Invoice_Credit__c gginv : Trigger.new){

    gginv.Name = gginv.Invoice_Ext_ID__c; 
	}
}