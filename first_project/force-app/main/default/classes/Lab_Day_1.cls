/**
 * Created by kbakos on 2/25/2022.
 */

public with sharing class Lab_Day_1 {

    public static void updateType() {
        Account[] accounts = [
                SELECT Name
                FROM Account
                WHERE Type = NULL
        ];

        for (Account acc : accounts) {
            acc.Type = 'Other';
        }

        update accounts;
    }

    public static void updateHot() {
        Account[] accounts = [
                SELECT Rating
                FROM Account
                WHERE Rating = 'Warm'
        ];

        for (Account acc : accounts) {
            acc.Rating = 'Hot';
        }

        update accounts;
    }

    public static void changeCountry() {
        Account[] accounts = [
                SELECT BillingCountry, Industry
                FROM Account
                WHERE BillingCountry LIKE 'USA' AND Industry = 'Technology'
        ];
        for(Account acc : accounts) {
            acc.Industry = 'Consulting';
        }
        update accounts;
    }

    public static void RecordTypeChanges(){
        Account customerAccounts = [
                SELECT Name, Type
                FROM Account
                WHERE Type = 'Customer - Direct'
        ];
        
        Account businessAccounts = [
                SELECT Name, Type
                FROM Account
                WHERE Type != 'Customer - Direct'
        ];
    }


}