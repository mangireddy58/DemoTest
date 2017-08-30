//
//  UserDataModel.h
//  Prasyst
//
//  Created by Sai on 21/08/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "GlobalConstant.h"

@interface UserDataModel : NSObject{
    NSString            *mUserName;
    NSString            *mPassword;
}

@property (strong) NSManagedObject *userDataModelData;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

+ (UserDataModel *)getUserDataModel;
- (void)clearUserDataModel;
- (void)saveUserData:(NSString *)userName password:(NSString *)password;

@end
