public with sharing class CTLocationTracingController {

    public static List<Location_Tracing__c> getVisitors(String location){
        return [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c,
                       Person__r.Health_Status__c
                FROM Location_Tracing__c
                WHERE Id =: location
                ORDER BY Visit_Date__c 
                DESC             
                ];
    }

    public static List<Location_Tracing__c> getLocationsByPersonId(Set<Id> personIds){
        return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Person__c IN :personIds
                AND Visit_Date__c = LAST_N_DAYS:10        
                ];

    }         
        public static List<Location_Tracing__c> getLocationsByLocationId(Set<Id> locationIds){
        return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Location__c IN :locationIds
                AND Person__r.Health_Status__c = 'Green'
                AND Visit_Date__c = LAST_N_DAYS:10        
                ];

    } 

}