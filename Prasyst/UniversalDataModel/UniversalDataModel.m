//
//  UniversalDataModel.m
//  Torq
//
//  Created by Rushikesh Kulkarni on 22/11/16.
//  Copyright © 2016 simplicity. All rights reserved.
//

#import "UniversalDataModel.h"

@implementation UniversalDataModel

static UniversalDataModel * sUniversalDataModel = nil;

@synthesize dataArray = mDataArray;
@synthesize dataString = mDataString;
@synthesize dataDictionary = mDataDictionary;
@synthesize inventoryDictionary = mInventoryDictionary;
@synthesize accountDictionary = mAccountDictionary;
@synthesize fromDateString = mFromDateString;
@synthesize toDateString = mTodateString;
@synthesize mainTypeString = mMainTypeString;
@synthesize universalDictionary;
@synthesize generalDataArray = mGeneralDataArray;
@synthesize inventoryDataArray = mInventoryDataArray;
@synthesize accountsDataArray = mAccountsDataArray;

@synthesize soryByBranchDataArray = mSortByBranchDataArray;
@synthesize soryByCompanyDataArray = mSortByCompanyDataArray;

+ (UniversalDataModel *)getUniversalDataModel{
    @synchronized(self)
    {
        if(sUniversalDataModel == nil)
        {
            sUniversalDataModel = [[UniversalDataModel alloc] init];
        }
        return sUniversalDataModel;
    }
}

-(void)clearUniversalDataModel{
    self.dataDictionary = nil;
    self.dataString = nil;
    self.dataArray = nil;
    self.inventoryDictionary = nil;
    self.accountDictionary = nil;
    self.generalDataArray = nil;
    self.inventoryDataArray = nil;
    self.accountsDataArray = nil;
    self.mainTypeString = nil;
    
    self.soryByBranchDataArray = nil;
    self.soryByCompanyDataArray = nil;
}

@end
