global with sharing class BAReportController {
        
    global static String getAccounts() {
        return JSON.serialize([select id,A_W_Account_Number__c,name from account where A_W_Account_Number__c != null]);
    }
     
    global static String getBudgets() {
        //return JSON.serialize([SELECT Account_Name__c Account, SUM(Budget_Amt__c) Budget_Amt, CALENDAR_MONTH(Budget_Date__c) Moth  from Budget__c group by CALENDAR_MONTH(Budget_Date__c),Account_Name__c order by Account_Name__c]);
        return JSON.serialize([SELECT Account_Name__c,Account_Name__r.A_W_Account_Number__c,Account_Name__r.name,Account_Name__r.Id, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c]);
    }

    global static String getActuals(){
        return JSON.serialize([select Account_Name__c Account, SUM(Actual__c) Actual_Amt, CALENDAR_MONTH(Booking_Date__c) Moth from Actual__c group by CALENDAR_MONTH(Booking_Date__c), Account_Name__c]);
    }
    
    global static String getAccBuds() {
        return JSON.serialize([SELECT Account_Name__c,Account_Name__r.A_W_Account_Number__c,Account_Name__r.name, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c]);
    }
    
    global static String getResponse(){
        String json = '{"Owners":[{"OwnerId":"100","OnwerName":"SertPro360","Customers":[{"CustId":"200","CustNumber":"456","CustName":"CristhianSevilla","Month":{"January":{"Budget_Amt":1500,"Actual_Amt":9500},"February":{"Budget_Amt":1500,"Actual_Amt":6700},"March":{"Budget_Amt":20000,"Actual_Amt":9800},"April":{"Budget_Amt":5000,"Actual_Amt":4500},"May":{"Budget_Amt":15000,"Actual_Amt":15000},"June":{"Budget_Amt":15000,"Actual_Amt":12500},"July":{"Budget_Amt":1600,"Actual_Amt":1200},"August":{"Budget_Amt":6000,"Actual_Amt":2000},"September":{"Budget_Amt":20000,"Actual_Amt":9800},"October":{"Budget_Amt":6500,"Actual_Amt":9500},"November":{"Budget_Amt":7900,"Actual_Amt":1500},"December":{"Budget_Amt":12000,"Actual_Amt":5000},"Totals":{"Budget_Tot":125000,"Actual_Tot":115000,"PorAtt":"60%"}}},{"CustId":"201","CustNumber":"457","CustName":"AngelloCamacho","Month":{"January":{"Budget_Amt":1500,"Actual_Amt":9500},"February":{"Budget_Amt":1500,"Actual_Amt":6700},"March":{"Budget_Amt":20000,"Actual_Amt":9800},"April":{"Budget_Amt":5000,"Actual_Amt":4500},"May":{"Budget_Amt":15000,"Actual_Amt":15000},"June":{"Budget_Amt":15000,"Actual_Amt":12500},"July":{"Budget_Amt":1600,"Actual_Amt":1200},"August":{"Budget_Amt":6000,"Actual_Amt":2000},"September":{"Budget_Amt":20000,"Actual_Amt":9800},"October":{"Budget_Amt":6500,"Actual_Amt":9500},"November":{"Budget_Amt":7900,"Actual_Amt":1500},"December":{"Budget_Amt":12000,"Actual_Amt":5000},"Totals":{"Budget_Tot":125000,"Actual_Tot":115000,"PorAtt":"60%"}}}]},{"OwnerId":"101","OnwerName":"AsisTP","Customers":[{"CustId":"202","CustNumber":"458","CustName":"RonaldPaico","Month":{"January":{"Budget_Amt":1500,"Actual_Amt":9500},"February":{"Budget_Amt":1500,"Actual_Amt":6700},"March":{"Budget_Amt":20000,"Actual_Amt":9800},"April":{"Budget_Amt":5000,"Actual_Amt":4500},"May":{"Budget_Amt":15000,"Actual_Amt":15000},"June":{"Budget_Amt":15000,"Actual_Amt":12500},"July":{"Budget_Amt":1600,"Actual_Amt":1200},"August":{"Budget_Amt":6000,"Actual_Amt":2000},"September":{"Budget_Amt":20000,"Actual_Amt":9800},"October":{"Budget_Amt":6500,"Actual_Amt":9500},"November":{"Budget_Amt":7900,"Actual_Amt":1500},"December":{"Budget_Amt":12000,"Actual_Amt":5000},"Totals":{"Budget_Tot":125000,"Actual_Tot":115000,"PorAtt":"60%"}}},{"CustId":"203","CustNumber":"459","CustName":"LouisUriarte","Month":{"January":{"Budget_Amt":1500,"Actual_Amt":9500},"February":{"Budget_Amt":1500,"Actual_Amt":6700},"March":{"Budget_Amt":20000,"Actual_Amt":9800},"April":{"Budget_Amt":5000,"Actual_Amt":4500},"May":{"Budget_Amt":15000,"Actual_Amt":15000},"June":{"Budget_Amt":15000,"Actual_Amt":12500},"July":{"Budget_Amt":1600,"Actual_Amt":1200},"August":{"Budget_Amt":6000,"Actual_Amt":2000},"September":{"Budget_Amt":20000,"Actual_Amt":9800},"October":{"Budget_Amt":6500,"Actual_Amt":9500},"November":{"Budget_Amt":7900,"Actual_Amt":1500},"December":{"Budget_Amt":12000,"Actual_Amt":5000},"Totals":{"Budget_Tot":125000,"Actual_Tot":115000,"PorAtt":"60%"}}}]}]}';
        return json; 
    }
    
    public String getResults(){
        List<Account> Acc = [SELECT Id,A_W_Account_Number__c,name from account];
        List<Budget__c> Bud = [SELECT Id,Account_Name__c, Budget_Amt__c, Budget_Date__c from Budget__c];
        List<Actual__c> Act =  [SELECT Id,Account_Name__c,Actual__c,Booking_Date__c from Actual__c];
        /*List<Id> Ids = new List<Id>();
                for (Actual__c a : Act){
                        Ids.add(a.Id);
                }
        List<Actual__c> Act = [SELECT Id, SUM(Actual__c) Actual_Amt, CALENDAR_MONTH(Booking_Date__c) Moth from Actual__c group by CALENDAR_MONTH(Booking_Date__c), Account_Name__c];
        */
        BAReport BAR;
        List<BAReport> BARep = new List<BAReport>();
        
        for (Account a : Acc){
                for(Budget__c b : Bud){
                        for(Actual__c c : Act){                                 
                                if(a.Id==b.Account_Name__c){
                                        if(b.Account_Name__c==c.Account_Name__c){
                                                //if(){
                                                        BAR = new BAReport(a.Id,
                                                        a.A_W_Account_Number__c,
                                                        a.Name,
                                                        b.Budget_Amt__c,
                                                        c.Actual__c,
                                                        b.Budget_Date__c.month(),
                                                        c.Booking_Date__c.month());
                                                        BARep.add(BAR);
                                                //}
                                        }
                                }
                        }
                }
        }
        return JSON.serialize(BARep);
    }
    public class BAReport{
        Id CustomerID;
        String CustomerNumber;
        String CustomerName;
        decimal Budget;
        decimal Actual;
        Integer BMoth;
        Integer AMoth;
        
        public BAReport(Id CustomerID,String CustomerNumber,String CustomerName,decimal Budget,decimal Actual,Integer BMoth,Integer AMoth){
                this.CustomerID = CustomerID;
                this.CustomerNumber = CustomerNumber;
                this.CustomerName = CustomerName;
                this.Budget = Budget;
                this.Actual = Actual;
                this.BMoth = BMoth;
                this.AMoth = AMoth;
        }
        
        
    }
    
    
    
    
    /*    global static String getBudgets() {
        //return JSON.serialize([SELECT Account_Name__c Id, SUM(Budget_Amt__c) Budget_Amt, CALENDAR_MONTH(Budget_Date__c) Moth  from Budget__c group by CALENDAR_MONTH(Budget_Date__c),Account_Name__c order by Account_Name__c]);
        List<Budget__c> bg = [SELECT Account_Name__c, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c];
        String ltbg = JSON.serialize(bg);
        for (Budget__c b : bg){
                  ltbg=ltbg.replace('type','');
                  ltbg=ltbg.replace('url','');
        }
        return ltbg;
    }*/
}