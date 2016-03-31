Public class Budget_Actual_Controller{
    
    List<Account> Accounts {get;set;}
    List<Budget__c> Budgets;
	List<Actual__c> Actuals;
    /*public List<AggregateResult> LstAct = new list<AggregateResult>();    
    public Budget_Actual_Controller(){
        LstAct = [select Account_Name__c AccountID, SUM(Actual__c) Actual, CALENDAR_MONTH(Booking_Date__c) BDate from Actual__c group by CALENDAR_MONTH(Booking_Date__c), Account_Name__c];
    }
    public list<oppClass> getResults(){
        list<oppClass> lstResult = new list<oppClass>();
        for (AggregateResult ar : listAct){
            oppClass objOppClass = new oppClass(ar);
            listResult.add(objOppClass);
        }
        return lstResult;
    }
    public oppClass {
        public Integer Actual {get;set;}
        public String BDate {get:set;}
        public String AccountID {get;set;}
        
        public oppClass(AggregateResult ar) {
            Actual = (Integer)ar.get('Actual');
            BDate = (String)ar.get('BDate');
            AccountID = (String)ar.get('AccountID');
        }
    }*/
    
    @RemoteAction
    public static List<Account> getClassInstances(){
        List<Account> classes = [SELECT id,A_W_Account_Number__c,name FROM Account];
         return classes;
    }
    public String getAccount(){
        Accounts = [SELECT id,A_W_Account_Number__c,name FROM Account];
        String accountsJSON = JSON.serializePretty(Accounts);
        return accountsJSON;
    }
    public String getBudget(){
        Budgets = [SELECT Account_Name__c, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c,Budget_Date__c ];
    	String BudgetJSON = JSON.serializePretty(Budgets);
        return BudgetJSON;

    }
    public String getActual(){
        Actuals = [SELECT Account_Name__c, Actual__c, Booking_Date__c from Actual__c order by Account_Name__c, Booking_Date__c];
        String ActualJSON = JSON.serializePretty(Actuals);
        return ActualJSON;
    }
    
    /*public String gActual(){
        Act = [select Account_Name__c, SUM(Actual__c), CALENDAR_MONTH(Booking_Date__c) from Actual__c group by CALENDAR_MONTH(Booking_Date__c), Account_Name__c];
        String ActualJSON = JSON.serializePretty(Act);
        return ActualJSON;
    }*/
        /*public String getActual(){
        Actuals = [SELECT Account_Name__r.A_W_Account_Number__c, Account_Name__r.name, Actual__c, Booking_Date__c from Actual__c order by Account_Name__c, Booking_Date__c];
        return system.JSON.serilizePretty(Actuals);
    }*/
    /*List<Budget__c> budgets = [SELECT Account_Name__c, Account_Name__r.name, Account_Name__r.A_W_Account_Number__c, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c,Budget_Date__c ];
    String budgetsJSON = JSON.serializePretty(budgets);*/
    
    /*public List<Budget__c> getBudget(){
        Budget = [select Account_Name__c, Account_Name__r.name, Account_Name__r.A_W_Account_Number__c, Budget_Amt__c, Budget_Date__c from Budget__c order by Account_Name__c,Budget_Date__c ];
        return Budget;
    }*/
    //List<Actual__c> actuals = [select Account_Name__c, SUM(Actual__c), CALENDAR_MONTH(Booking_Date__c) from Actual__c group by CALENDAR_MONTH(Booking_Date__c), Account_Name__c];
    
    
    /*List<Actual__c> actuals = [select Account_Name__r.A_W_Account_Number__c, Account_Name__r.name, Actual__c, Booking_Date__c from Actual__c order by Account_Name__c, Booking_Date__c];
    String actualsJSON = JSON.serializePretty(actuals);*/
    
    /*
    List<Contact> contacts = [SELECT Id,Name FROM Contact LIMIT 10];
    JSONGeneratir generator = JSON.createGenerator(true);
    generator.writeStartObject();
    generator.writeNumberField('count', contacts.size());
    generator.writeEndObject();
    String jsonString = generator.getAsString();
    */
    
    /*Public Account acc {get; private set;}
    public Budget_Actual_Controller(){
        acc =[
            SELECT id,name,owner.name,billingcity,billingstate,annualrevenue
            FROM Account
            WHERE name =
            	:ApexPages.currentPage().getParameters().get('context')
            limit 1];
        system.debug(acc);   
    }*/
    
    
}