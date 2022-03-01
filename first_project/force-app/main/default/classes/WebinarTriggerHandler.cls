/**
 * Created by kbakos on 2/28/2022.
 */

public with sharing class WebinarTriggerHandler {

    public static void handleBeforeInsert(List<Webinar__c> newList) {
        approveCostBelow100Euros(newList);
        cancelStatusIfRejected(newList);
        maximumNumberOfSeats(newList);
        calculatePricePerPerson(newList);
    }

    public static void handleBeforeUpdate(List<Webinar__c> newList, Map<Id, Webinar__c> oldMap) {
        approveCostBelow100Euros(newList);
        cancelStatusIfRejected(newList);
        //Old map ++
        maximumNumberOfSeats(newList);
        statusValue(newList, oldMap);
        calculatePricePerPerson(newList);

    }

    private static void approveCostBelow100Euros(List<Webinar__c> newList) {
        //logic here
        for (Webinar__c w : newList) {

            if(w.Cost__c < 100) {
                w.Approval_Status__c = 'Approved';
            }

        }
    }

    private static void cancelStatusIfRejected(List<Webinar__c> newList) {
        //logic here
        for (Webinar__c w : newList) {

            if (w.Approval_Status__c == 'Rejected') {
                w.Status__c = 'Canceled';
            }

        }
    }

    private static void maximumNumberOfSeats(List<Webinar__c> newList){
        for(Webinar__c w : newList) {
            if(w.Number_of_Participants__c > w.Total_Number_of_Seats__c) {
                w.addError('The webinar is full');
            }
        }
    }

    private static void calculatePricePerPerson(List<Webinar__c> newList) {
        for(Webinar__c w : newList) {
            if(w.Number_of_Participants__c != 0) {
               w.Price_per_Participant__c = w.Cost__c / w.Number_of_Participants__c;
            }
        }
    }

    private static void statusValue(List<Webinar__c> newList, Map<Id, Webinar__c> oldMap) {
        for(Webinar__c w : newList) {
           if(oldMap.get(w.Id).Status__c == 'New' && w.Status__c != 'New' && w.Status__c != 'Canceled' && w.Status__c == 'Pending') {
            w.addError('Error thrown : Changed from new when it is already canceled or pending.');
           }
        }
    }

}