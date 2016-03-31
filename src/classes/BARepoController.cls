public class BARepoController {
    
    public Map<Integer, List<String>> myMapHeader {get;set;}
    public Map<Id, List<String>> myMapBody {get;set;}
    public Set<String> myMonthList {get;set;}
    public String tempOwner {get; set;}
    public String ownerName {get;set;}
    public String date1 {get; set;}
    public String date2 {get; set;}
    public List<String> itemDataHeader2 {get; set;}
    public String date3 {get; set;}
    public String date4 {get; set;}
    
    public BARepoController() {
        date1=System.currentPageReference().getParameters().get('date1');
        date2=System.currentPageReference().getParameters().get('date2');
        date3=System.currentPageReference().getParameters().get('date3');
        date4=System.currentPageReference().getParameters().get('date4');
        tempOwner=System.currentPageReference().getParameters().get('tempOwner');
        ownerName=System.currentPageReference().getParameters().get('ownerName');
        
        System.debug('&&&&&&&&&&&&&& date1: '+date1);
        
    	myMonthList = new Set<String>();
                MyMonthList.add('January');
                MyMonthList.add('February');
                MyMonthList.add('March');
                MyMonthList.add('April');
                MyMonthList.add('May');
                MyMonthList.add('June');
                MyMonthList.add('July');
                MyMonthList.add('August');
                MyMonthList.add('September');
                MyMonthList.add('October');
                MyMonthList.add('November');
                MyMonthList.add('December');
        
        Map<Integer, AggregateResult> allitems2 = new Map<Integer, AggregateResult>();
        Integer cont=0;
        Integer yearActual = System.now().year();
        for(AggregateResult ar : [select Account_Name__c, sum(Budget_Amt__c)budget, CALENDAR_year(Budget_Date__c)year, 
                                  CALENDAR_month(Budget_Date__c)month from Budget__c where CALENDAR_year(Budget_Date__c) = :yearActual 
                                  group by Account_Name__c, CALENDAR_year(Budget_Date__c), 
                                  CALENDAR_month(Budget_Date__c)]) {
        	allitems2.put(cont, ar);
            cont++;
        }
        
        Map<Integer, AggregateResult> allitems1 = new Map<Integer, AggregateResult>();
        cont=0;
        for(AggregateResult ar : [select Account_Name__c, sum(Actual__c)actual, CALENDAR_year(Booking_Date__c)year, 
                                  CALENDAR_month(Booking_Date__c)month from actual__c where CALENDAR_year(Booking_Date__c) = :yearActual 
                                  group by Account_Name__c, CALENDAR_year(Booking_Date__c), 
                                  CALENDAR_month(Booking_Date__c)]) {
        	allitems1.put(cont, ar);
            cont++;
        }
        
        Map<Id, List<String>> allitems = new Map<Id, List<String>>();
        cont=0;
        List<Account> allAccounts = [SELECT id, Name, OwnerId, A_W_Account_Number__c from Account];
        
        	itemDataHeader2 = new List<String>();
            itemDataHeader2.add('#');
            itemDataHeader2.add('Name');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('%Att');

        for(Account acc : allAccounts) {
            List<String> itemData = new List<String>();
            String actual1='';
            String actual2='';
            String actual3='';
            String actual4='';
            String actual5='';
            String actual6='';
            String actual7='';
            String actual8='';
            String actual9='';
            String actual10='';
            String actual11='';
            String actual12='';
            String budget1='';
            String budget2='';
            String budget3='';
            String budget4='';
            String budget5='';
            String budget6='';
            String budget7='';
            String budget8='';
            String budget9='';
            String budget10='';
            String budget11='';
            String budget12='';
            String totalActual='';
            String totalBudget='';
            String att='';
            
            for ( Integer item : allitems1.keySet() ){
                if(acc.Id == allitems1.get(item).get('Account_Name__c')) {
                    if(Integer.valueOf(allitems1.get(item).get('year'))== System.Today().year()) {
                        if(Integer.valueOf(allitems1.get(item).get('month'))==1) {
                            actual1=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==2) {
                            actual2=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==3) {
                            actual3=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==4) {
                            actual4=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==5) {
                            actual5=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==6) {
                            actual6=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==7) {
                            actual7=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==8) {
                            actual8=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==9) {
                            actual9=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==10) {
                            actual10=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==11) {
                            actual11=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                        if(Integer.valueOf(allitems1.get(item).get('month'))==12) {
                            actual12=String.valueOf(allitems1.get(item).get('actual'));
                            //break;
                        }
                    }
                }
            }
            for ( Integer item : allitems2.keySet() ){
                if(acc.Id == allitems2.get(item).get('Account_Name__c')) {
                    if(Integer.valueOf(allitems2.get(item).get('year'))== System.Today().year()) {
                        if(Integer.valueOf(allitems2.get(item).get('month'))==1) {
                            budget1=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==2) {
                            budget2=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==3) {
                            budget3=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==4) {
                            budget4=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==5) {
                            budget5=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==6) {
                            budget6=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==7) {
                            budget7=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==8) {
                            budget8=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==9) {
                            budget9=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==10) {
                            budget10=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==11) {
                            budget11=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                        if(Integer.valueOf(allitems2.get(item).get('month'))==12) {
                            budget12=String.valueOf(allitems2.get(item).get('budget'));
                            //break;
                        }
                    }
                }
            }
            if(acc.A_W_Account_Number__c!=null) itemData.add(acc.A_W_Account_Number__c);
            else itemData.add('');
            itemData.add(acc.Name);
            itemData.add(budget1);
            itemData.add(actual1);
            itemData.add(budget2);
            itemData.add(actual2);
            itemData.add(budget3);
            itemData.add(actual3);
            itemData.add(budget4);
            itemData.add(actual4);
            itemData.add(budget5);
            itemData.add(actual5);
            itemData.add(budget6);
            itemData.add(actual6);
            itemData.add(budget7);
            itemData.add(actual7);
            itemData.add(budget8);
            itemData.add(actual8);
            itemData.add(budget9);
            itemData.add(actual9);
            itemData.add(budget10);
            itemData.add(actual10);
            itemData.add(budget11);
            itemData.add(actual11);
            itemData.add(budget12);
            itemData.add(actual12);
            if(budget1=='') budget1='0';
            if(budget2=='') budget2='0';
            if(budget3=='') budget3='0';
            if(budget4=='') budget4='0';
            if(budget5=='') budget5='0';
            if(budget6=='') budget6='0';
            if(budget7=='') budget7='0';
            if(budget8=='') budget8='0';
            if(budget9=='') budget9='0';
            if(budget10=='') budget10='0';
            if(budget11=='') budget11='0';
            if(budget12=='') budget12='0';
            totalBudget=String.valueOf(Double.valueof(budget1)+Double.valueof(budget2)+Double.valueof(budget3)
                                                   +Double.valueof(budget4)+Double.valueof(budget5)+Double.valueof(budget6)
                                                   +Double.valueof(budget7)+Double.valueof(budget8)+Double.valueof(budget9)
                                                   +Double.valueof(budget10)+Double.valueof(budget11)+Double.valueof(budget12));
            if(Double.ValueOf(totalBudget)==0) totalBudget='';
            itemData.add(totalBudget);
            
            if(actual1=='') actual1='0';
            if(actual2=='') actual2='0';
            if(actual3=='') actual3='0';
            if(actual4=='') actual4='0';
            if(actual5=='') actual5='0';
            if(actual6=='') actual6='0';
            if(actual7=='') actual7='0';
            if(actual8=='') actual8='0';
            if(actual9=='') actual9='0';
            if(actual10=='') actual10='0';
            if(actual11=='') actual11='0';
            if(actual12=='') actual12='0';
            totalActual=String.valueOf(Double.valueof(actual1)+Double.valueof(actual2)+Double.valueof(actual3)
                                                   +Double.valueof(actual4)+Double.valueof(actual5)+Double.valueof(actual6)
                                                   +Double.valueof(actual7)+Double.valueof(actual8)+Double.valueof(actual9)
                                                   +Double.valueof(actual10)+Double.valueof(actual11)+Double.valueof(actual12));
            if(Double.ValueOf(totalActual)==0) totalActual='';
            itemData.add(totalActual);
            if(totalActual=='' || totalBudget=='')
            	att='';
            else
                att=String.valueOf((Decimal.valueof(totalActual)/Decimal.valueof(totalBudget)).setScale(2));
            itemData.add(att);
            //itemData.add(acc.OwnerId);
            allitems.put(acc.Id, itemData);
            cont++;
        }
        myMapBody=allitems;
    }
    
    public List<SelectOption> getItemsOwner() {
        List<selectOption> options = new List<selectOption>();
        for (AggregateResult accountOwner : [SELECT OwnerId, Owner.Name FROM Account GROUP BY OwnerId, Owner.Name]) {
            options.add(new selectOption(String.valueOf(accountOwner.get('OwnerId')), String.valueOf(accountOwner.get('Name'))));
        }
        return options;
    }
    
    public pageReference filter() {
        Integer yearActual = System.now().year();
        List<String> headers = new List<String>();
        Map<Integer, AggregateResult> allitems2 = new Map<Integer, AggregateResult>();
        Map<Integer, AggregateResult> allitems1 = new Map<Integer, AggregateResult>();
        Map<Id, List<String>> allitems = new Map<Id, List<String>>();
        allitems2.clear();
        allitems1.clear();
        Integer cont1=0;
        Integer cont2=0;
        
        if(date1!='' && date1!=null && date2!='' && date2!=null && (Date.valueOf(date1)<=Date.valueOf(date2))) {
                Integer yearStart = Integer.valueOf(date1.substring(0,4));
                Integer monthStart = Integer.valueOf(date1.substring(5,7));
                Integer yearEnd = Integer.valueOf(date2.substring(0,4));
                Integer monthEnd = Integer.valueOf(date2.substring(5,7));
                
                while(yearStart<=yearEnd) {
                    System.debug('ingresooooooooooooooooooooo');
                    String auxMonth='';
                    if(monthStart==1) auxMonth='Jan';
                    if(monthStart==2) auxMonth='Feb';
                    if(monthStart==3) auxMonth='Mar';
                    if(monthStart==4) auxMonth='Apr';
                    if(monthStart==5) auxMonth='May';
                    if(monthStart==6) auxMonth='Jun';
                    if(monthStart==7) auxMonth='Jul';
                    if(monthStart==8) auxMonth='Aug';
                    if(monthStart==9) auxMonth='Sep';
                    if(monthStart==10) auxMonth='Oct';
                    if(monthStart==11) auxMonth='Nov';
                    if(monthStart==12) auxMonth='Dec';
                    headers.add(String.valueOf(yearStart)+auxMonth);
                    System.debug('################## aux:' + auxMonth);
                    if(yearStart==yearEnd && monthStart==monthEnd) {
                        break;
                    }
                    monthStart++;
                    if(monthStart==13) {
                        yearStart++;
                        monthStart=1;
                    }                   
                }
            myMonthList = new Set<String>();
            myMonthList.clear();
            
            itemDataHeader2 = new List<String>();
            itemDataHeader2.clear();
            itemDataHeader2.add('#');
            itemDataHeader2.add('Name');
            
            for(integer j=0; j<headers.size(); j++) {
                    if(headers.get(j).subString(4,7)=='Jan') MyMonthList.add('January');
                    if(headers.get(j).subString(4,7)=='Feb') MyMonthList.add('February');
                    if(headers.get(j).subString(4,7)=='Mar') MyMonthList.add('March');
                    if(headers.get(j).subString(4,7)=='Apr') MyMonthList.add('April');
                    if(headers.get(j).subString(4,7)=='May') MyMonthList.add('May');
                    if(headers.get(j).subString(4,7)=='Jun') MyMonthList.add('June');
                    if(headers.get(j).subString(4,7)=='Jul') MyMonthList.add('July');
                    if(headers.get(j).subString(4,7)=='Aug') MyMonthList.add('August');
                    if(headers.get(j).subString(4,7)=='Sep') MyMonthList.add('September');
                    if(headers.get(j).subString(4,7)=='Oct') MyMonthList.add('October');
                    if(headers.get(j).subString(4,7)=='Nov') MyMonthList.add('November');
                	if(headers.get(j).subString(4,7)=='Dec') MyMonthList.add('December');
                itemDataHeader2.add('Budget');
            	itemDataHeader2.add('Actual');
            }
            
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('%Att');
            
                System.debug('################################### headers: '+headers);
                
                for(AggregateResult ar : [select Account_Name__c, sum(Budget_Amt__c)budget, CALENDAR_year(Budget_Date__c)year, 
                                          CALENDAR_month(Budget_Date__c)month from Budget__c where Budget_Date__c >= 
                                          :Date.valueOf(date1) and Budget_Date__c <= :Date.valueOf(date2) 
                                          group by Account_Name__c, CALENDAR_year(Budget_Date__c), CALENDAR_month(Budget_Date__c)] ) {
                    allitems2.put(cont1, ar);
                    cont1++;
                }
                
                for(AggregateResult ar : [select Account_Name__c, sum(Actual__c)actual, CALENDAR_year(Booking_Date__c)year, 
                                          CALENDAR_month(Booking_Date__c)month from actual__c  where Booking_Date__c >= 
                                          :Date.valueOf(date1) and Booking_Date__c <= :Date.valueOf(date2) 
                                          group by Account_Name__c, CALENDAR_year(Booking_Date__c), 
                                          CALENDAR_month(Booking_Date__c)]) {
                    allitems1.put(cont2, ar);
                    cont2++;
                }
                
            List<Account> allAccounts = [SELECT id, Name, OwnerId, A_W_Account_Number__c from Account];
            
            for(Account acc : allAccounts) {
                List<String> itemData = new List<String>();
                
                if(acc.A_W_Account_Number__c!=null) itemData.add(acc.A_W_Account_Number__c);
                else itemData.add('');
                itemData.add(acc.Name);
                Double actualTotal=0;
                Double budgetTotal=0;
                Double attr=0;
                for(integer j=0; j<headers.size(); j++) {
                    Integer numMonth = 0;
                    String budget='';
                    String Actual='';
                    if(headers.get(j).subString(4,7)=='Jan') numMonth=1;
                    if(headers.get(j).subString(4,7)=='Feb') numMonth=2;
                    if(headers.get(j).subString(4,7)=='Mar') numMonth=3;
                    if(headers.get(j).subString(4,7)=='Apr') numMonth=4;
                    if(headers.get(j).subString(4,7)=='May') numMonth=5;
                    if(headers.get(j).subString(4,7)=='Jun') numMonth=6;
                    if(headers.get(j).subString(4,7)=='Jul') numMonth=7;
                    if(headers.get(j).subString(4,7)=='Aug') numMonth=8;
                    if(headers.get(j).subString(4,7)=='Sep') numMonth=9;
                    if(headers.get(j).subString(4,7)=='Oct') numMonth=10;
                    if(headers.get(j).subString(4,7)=='Nov') numMonth=11;
                    if(headers.get(j).subString(4,7)=='Dec') numMonth=12;
                            System.Debug('&&&&&&&&&&&&&&& mes: '+numMonth);
                            System.Debug('&&&&&&&&&&&&&&& anio: '+headers.get(j).subString(0,4));
                            
                    for ( Integer item : allitems2.keySet() ){
                        if(acc.Id == allitems2.get(item).get('Account_Name__c') && Integer.valueOf(allitems2.get(item).get('year'))==Integer.valueOf(headers.get(j).subString(0,4)) && Integer.valueOf(allitems2.get(item).get('month'))==numMonth) {
                            budget=String.valueOf(allitems2.get(item).get('budget'));
                        }
                    }
                    
                    for ( Integer item : allitems1.keySet() ){
                        if(acc.Id == allitems1.get(item).get('Account_Name__c') && Integer.valueOf(allitems1.get(item).get('year'))==Integer.valueOf(headers.get(j).subString(0,4)) && Integer.valueOf(allitems1.get(item).get('month'))==numMonth) {
                            actual=String.valueOf(allitems1.get(item).get('actual'));
                        }
                    }
                    if(budget!='') budgetTotal=budgetTotal+Double.valueOf(budget);
                    if(actual!='') actualTotal=actualTotal+Double.valueOf(actual);
                    itemData.add(budget);
                    itemData.add(actual);
                }
                if(budgetTotal!=0) itemData.add(String.valueOf(budgetTotal));
                else itemData.add(String.valueOf(''));
                if(actualTotal!=0) itemData.add(String.valueOf(actualTotal));
                else itemData.add(String.valueOf(''));
                if(budgetTotal!=0) itemData.add(String.valueOf((Decimal.valueof(actualTotal)/Decimal.valueof(budgetTotal)).setScale(2)));
                else itemData.add(String.valueOf(''));
                itemData.add(acc.OwnerId);
                allitems.put(acc.Id, itemData);
            }
        }
        else {
            for(AggregateResult ar : [select Account_Name__c, sum(Budget_Amt__c)budget, CALENDAR_year(Budget_Date__c)year, 
                                      CALENDAR_month(Budget_Date__c)month from Budget__c where CALENDAR_year(Budget_Date__c) = :yearActual 
                                      group by Account_Name__c, CALENDAR_year(Budget_Date__c), 
                                      CALENDAR_month(Budget_Date__c)]) {
                allitems2.put(cont1, ar);
                cont1++;
            }
            
            for(AggregateResult ar : [select Account_Name__c, sum(Actual__c)actual, CALENDAR_year(Booking_Date__c)year, 
                                      CALENDAR_month(Booking_Date__c)month from actual__c where CALENDAR_year(Booking_Date__c) = :yearActual 
                                      group by Account_Name__c, CALENDAR_year(Booking_Date__c), 
                                      CALENDAR_month(Booking_Date__c)]) {
                allitems1.put(cont2, ar);
                cont2++;
            }
            
            myMonthList = new Set<String>();
                MyMonthList.add('January');
                MyMonthList.add('February');
                MyMonthList.add('March');
                MyMonthList.add('April');
                MyMonthList.add('May');
                MyMonthList.add('June');
                MyMonthList.add('July');
                MyMonthList.add('August');
                MyMonthList.add('September');
                MyMonthList.add('October');
                MyMonthList.add('November');
                MyMonthList.add('December');
        
            allitems.clear();
            Integer cont=0;
            List<Account> allAccounts = [SELECT id, Name, OwnerId, A_W_Account_Number__c from Account];
            
        	itemDataHeader2 = new List<String>();
            itemDataHeader2.add('#');
            itemDataHeader2.add('Name');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('Budget');
            itemDataHeader2.add('Actual');
            itemDataHeader2.add('%Att');

            for(Account acc : allAccounts) {
                List<String> itemData = new List<String>();
                String actual1='';
                String actual2='';
                String actual3='';
                String actual4='';
                String actual5='';
                String actual6='';
                String actual7='';
                String actual8='';
                String actual9='';
                String actual10='';
                String actual11='';
                String actual12='';
                String budget1='';
                String budget2='';
                String budget3='';
                String budget4='';
                String budget5='';
                String budget6='';
                String budget7='';
                String budget8='';
                String budget9='';
                String budget10='';
                String budget11='';
                String budget12='';
                String totalActual='';
                String totalBudget='';
                String att='';
                
                for ( Integer item : allitems1.keySet() ){
                    if(acc.Id == allitems1.get(item).get('Account_Name__c')) {
                        if(Integer.valueOf(allitems1.get(item).get('year'))== System.Today().year()) {
                            if(Integer.valueOf(allitems1.get(item).get('month'))==1) {
                                actual1=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==2) {
                                actual2=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==3) {
                                actual3=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==4) {
                                actual4=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==5) {
                                actual5=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==6) {
                                actual6=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==7) {
                                actual7=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==8) {
                                actual8=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==9) {
                                actual9=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==10) {
                                actual10=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==11) {
                                actual11=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                            if(Integer.valueOf(allitems1.get(item).get('month'))==12) {
                                actual12=String.valueOf(allitems1.get(item).get('actual'));
                                //break;
                            }
                        }
                    }
                }
                for ( Integer item : allitems2.keySet() ){
                    if(acc.Id == allitems2.get(item).get('Account_Name__c')) {
                        if(Integer.valueOf(allitems2.get(item).get('year'))== System.Today().year()) {
                            if(Integer.valueOf(allitems2.get(item).get('month'))==1) {
                                budget1=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==2) {
                                budget2=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==3) {
                                budget3=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==4) {
                                budget4=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==5) {
                                budget5=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==6) {
                                budget6=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==7) {
                                budget7=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==8) {
                                budget8=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==9) {
                                budget9=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==10) {
                                budget10=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==11) {
                                budget11=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                            if(Integer.valueOf(allitems2.get(item).get('month'))==12) {
                                budget12=String.valueOf(allitems2.get(item).get('budget'));
                                //break;
                            }
                        }
                    }
                }
                if(acc.A_W_Account_Number__c!=null) itemData.add(acc.A_W_Account_Number__c);
                else itemData.add('');
                itemData.add(acc.Name);
                itemData.add(budget1);
                itemData.add(actual1);
                itemData.add(budget2);
                itemData.add(actual2);
                itemData.add(budget3);
                itemData.add(actual3);
                itemData.add(budget4);
                itemData.add(actual4);
                itemData.add(budget5);
                itemData.add(actual5);
                itemData.add(budget6);
                itemData.add(actual6);
                itemData.add(budget7);
                itemData.add(actual7);
                itemData.add(budget8);
                itemData.add(actual8);
                itemData.add(budget9);
                itemData.add(actual9);
                itemData.add(budget10);
                itemData.add(actual10);
                itemData.add(budget11);
                itemData.add(actual11);
                itemData.add(budget12);
                itemData.add(actual12);
                if(budget1=='') budget1='0';
                if(budget2=='') budget2='0';
                if(budget3=='') budget3='0';
                if(budget4=='') budget4='0';
                if(budget5=='') budget5='0';
                if(budget6=='') budget6='0';
                if(budget7=='') budget7='0';
                if(budget8=='') budget8='0';
                if(budget9=='') budget9='0';
                if(budget10=='') budget10='0';
                if(budget11=='') budget11='0';
                if(budget12=='') budget12='0';
                totalBudget=String.valueOf(Double.valueof(budget1)+Double.valueof(budget2)+Double.valueof(budget3)
                                                       +Double.valueof(budget4)+Double.valueof(budget5)+Double.valueof(budget6)
                                                       +Double.valueof(budget7)+Double.valueof(budget8)+Double.valueof(budget9)
                                                       +Double.valueof(budget10)+Double.valueof(budget11)+Double.valueof(budget12));
                if(Double.ValueOf(totalBudget)==0) totalBudget='';
                itemData.add(totalBudget);
                
                if(actual1=='') actual1='0';
                if(actual2=='') actual2='0';
                if(actual3=='') actual3='0';
                if(actual4=='') actual4='0';
                if(actual5=='') actual5='0';
                if(actual6=='') actual6='0';
                if(actual7=='') actual7='0';
                if(actual8=='') actual8='0';
                if(actual9=='') actual9='0';
                if(actual10=='') actual10='0';
                if(actual11=='') actual11='0';
                if(actual12=='') actual12='0';
                totalActual=String.valueOf(Double.valueof(actual1)+Double.valueof(actual2)+Double.valueof(actual3)
                                                       +Double.valueof(actual4)+Double.valueof(actual5)+Double.valueof(actual6)
                                                       +Double.valueof(actual7)+Double.valueof(actual8)+Double.valueof(actual9)
                                                       +Double.valueof(actual10)+Double.valueof(actual11)+Double.valueof(actual12));
                if(Double.ValueOf(totalActual)==0) totalActual='';
                itemData.add(totalActual);
                if(totalActual=='' || totalBudget=='')
                    att='';
                else
                    att=String.valueOf((Decimal.valueof(totalActual)/Decimal.valueof(totalBudget)).setScale(2));
                itemData.add(att);
                itemData.add(acc.OwnerId);
                allitems.put(acc.Id, itemData);
                cont++;
            }
        
        }
        
        System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ list: '+ tempOwner);
        System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ allitems: '+ allitems);
        System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ date2: '+ date2);
        System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ date1: '+ date1);
        myMapBody.clear();
        if(tempOwner=='All Owners') {
            //myMapBody=allitems;
            for ( Id item : allitems.keySet() ){
                //system.debug('##FF##'+ allitems.get(item)[29] + ' - '  + tempOwner);
                
                //if(allitems.get(item)[0].substring(0,18)==tempOwner) {
                
                    List<String> aux = new List<String>();
                    for(Integer i=0; i<allitems.get(item).size()-1; i++) {
                        aux.add(allitems.get(item)[i]);
                    }
                    myMapBody.put(item, aux);
                
            }
        }
        else {
            for ( Id item : allitems.keySet() ){
                //system.debug('##FF##'+ allitems.get(item)[29] + ' - '  + tempOwner);
                
                //if(allitems.get(item)[0].substring(0,18)==tempOwner) {
                if(allitems.get(item)[allitems.get(item).size()-1]==tempOwner) {
                    List<String> aux = new List<String>();
                    for(Integer i=0; i<allitems.get(item).size()-1; i++) {
                        aux.add(allitems.get(item)[i]);
                    }
                    myMapBody.put(item, aux);
                }
            }
        }
        return null;
    }

    public pageReference ExportToPDF(){
        if(tempOwner=='All Owners'){
            ownerName='All Owners';
        }else{
        	ownerName= [SELECT Name FROM user where id=:tempOwner limit 1].Name;
		}
        if(date1!='' && date1!=null && date2!='' && date2!=null) {
                String yearStart 	= String.valueOf(date1.substring(0,4));
                String monthStart 	= String.valueOf(date1.substring(5,7));
            	String dayStart		= String.valueOf(date1.substring(8,10));
                String yearEnd 		= String.valueOf(date2.substring(0,4));
                String monthEnd 	= String.valueOf(date2.substring(5,7));
            	String dayEnd		= String.valueOf(date2.substring(8,10));
            	date3= monthStart + '-' + dayStart + '-' + yearStart;
            	date4= monthEnd + '-' + dayStart + '-' + yearStart;
        }
        /*
        String dtFormat = 'MM-dd-yyyy';
		DateTime dt = app.Purchase_Date__c;
        String dtStr = dt.format(dtFormat);
        */
		PageReference ExportToPDF = new PageReference('/apex/BAReportTOPDF?ownerName='+ownerName+'&tempOwner='+tempOwner+'&date1='+date1+'&date2='+date2+'&date3='+date3+'&date4='+date4);
        ExportToPDF.setRedirect(true);
		return ExportToPDF;
    }
}