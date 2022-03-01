/**
 * Created by kbakos on 3/1/2022.
 */

@IsTest
public with sharing class TestingTriggers {

    @IsTest
    private static void Test_DeleteAccountWithOpportunity() {

        Account testAccount = Test_DataFactory.createTestOpportunity(Test_DataFactory.createTestAccount());

        Test.startTest();
        Database.DeleteResult result = Database.delete(testAccount, false);
        Test.stopTest();


        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', result.getErrors()[0].getMessage());
    }

    @IsTest
    private static void Test_ContactInvalidNameInsert() {

        Contact contact = Test_DataFactory.createTestInvalidContact();

        Test.startTest();
            Database.SaveResult result = Database.insert(contact, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+contact.LastName+'" is not allowed for DML', result.getErrors()[0].getMessage());

    }


    @IsTest
    private static void Test_ContactInvalidNameUpdate() {

        Contact contact = Test_DataFactory.createTestInvalidContact();

        Test.startTest();
        Database.SaveResult result = Database.update(contact, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+contact.LastName+'" is not allowed for DML', result.getErrors()[0].getMessage());

    }


}