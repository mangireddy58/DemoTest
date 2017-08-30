//
//  UniversalDataModel.h
//  Torq
//
//  Created by Rushikesh Kulkarni on 22/11/16.
//  Copyright © 2016 simplicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UniversalDataModel : NSObject
{
    NSDictionary             *mDataDictionary;
    NSArray                 *mDataArray;
    NSString                *mDataString;
    NSString                *mFromDateString;
    NSString                *mTodateString;
    NSUInteger              *mClient_id;
    NSString                *mMainTypeString;
    NSString                *msortingString;
    NSString                *mMobileNumString;
    NSString                *mLoggedString;
    NSDictionary             *mInventoryDictionary;
    NSDictionary             *mAccountDictionary;
    
    NSArray                 *mGeneralDataArray;
    NSArray                 *mInventoryDataArray;
    NSArray                 *mAccountsDataArray;
    
    NSArray                 *mSortByBranchDataArray;
    NSArray                 *mSortByCompanyDataArray;
}

@property (strong, nonatomic) NSDictionary *universalDictionary;
@property (nonatomic, copy) NSDictionary *dataDictionary;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSString *dataString;
@property (nonatomic, copy) NSDictionary *inventoryDictionary;
@property (nonatomic, copy) NSDictionary *accountDictionary;
@property (nonatomic) NSUInteger client_id;
@property (nonatomic, copy) NSString *mainTypeString;
@property (nonatomic, copy) NSString *fromDateString;
@property (nonatomic, copy) NSString *toDateString;
@property (nonatomic, copy) NSString *sortingString;
@property (nonatomic, copy) NSString *mobileNumString;
@property (nonatomic, copy) NSString *loggedString;
//General Data Array
@property (nonatomic, copy) NSArray *generalDataArray;
@property (nonatomic, copy) NSArray *inventoryDataArray;
@property (nonatomic, copy) NSArray *accountsDataArray;

//Sorting arrays
@property (nonatomic, copy) NSArray *soryByBranchDataArray;
@property (nonatomic, copy) NSArray *soryByCompanyDataArray;

+(UniversalDataModel *)getUniversalDataModel;

- (void)clearUniversalDataModel;

@end
