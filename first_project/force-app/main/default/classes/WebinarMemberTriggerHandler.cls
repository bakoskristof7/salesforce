/**
 * Created by kbakos on 2/28/2022.
 */

public with sharing class WebinarMemberTriggerHandler {
    public static void handleBeforeInsert(List<Webinar_Member__c> newList) {
        onlyAssignExternals(newList);
        UserOrContact(newList);
    }

    public static void handleBeforeUpdate(List<Webinar_Member__c> newList) {
        onlyAssignExternals(newList);
        UserOrContact(newList);
    }

    private static void onlyAssignExternals(List<Webinar_Member__c> newList){
        for(Webinar_Member__c w : newList) {
            if(w.Webinar__r.Type__c != 'External'){
                if(w.Contact__c != NULL){
                    w.addError('A contact can only be internal.');
                }
            }

        }
    }

    private static void UserOrContact(List<Webinar_Member__c> newList) {
        for(Webinar_Member__c w : newList) {
            if(w.Contact__c != NULL && w.User__c != NULL) {
                w.addError('A member can only be a user OR a contact.');
            }
        }
    }



}