trigger GGOrder_AddNameFromExtId on Order__c (before insert, before update) {
// before orders are inserted

for (Order__c ggo : Trigger.new){

    ggo.Name = ggo.Order_Number_Ext_ID__c; 
	}
}