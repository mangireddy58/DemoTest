//
//  UserDataModel.m
//  Prasyst
//
//  Created by Sai on 21/08/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel

static UserDataModel *sUserDataModel = nil;

@synthesize userName = mUserName;
@synthesize password = mPassword;

+ (UserDataModel *)getUserDataModel
{
    @synchronized(self)
    {
        if(sUserDataModel == nil)
        {
            sUserDataModel = [[UserDataModel alloc] init];
            
            sUserDataModel.userName = @"";
            sUserDataModel.password = @"";
            
            NSManagedObjectContext *context = nil;
            id delegate = [[UIApplication sharedApplication] delegate];
            if ([delegate performSelector:@selector(managedObjectContext)]) {
                context = [delegate managedObjectContext];
            }
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:context]];
            NSError *error = nil;
            NSArray *results = [context executeFetchRequest:request error:&error];
            if ([results count] >= 1) {
                NSManagedObject *userDataManagedObject = [results lastObject];
                
                sUserDataModel.userName = [userDataManagedObject valueForKey:@"username"];
                sUserDataModel.password = [userDataManagedObject valueForKey:@"password"];
                
                NSLog(@"Name: %@", sUserDataModel.userName);
                NSLog(@"Password: %@", sUserDataModel.password);
            }
        }
        return sUserDataModel;
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)clearUserDataModel{
    self.userName = @"";
    self.password = @"";
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:context]];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSInteger i = 0;
    while (i < [results count]) {
        [context deleteObject:[results objectAtIndex:0]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"Deleted");
        }
        i++;
    }
}

- (void)saveUserData:(NSString *)userName password:(NSString *)password{
    [self clearUserDataModel];
    
    
    mUserName = userName;
    mPassword = password;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.userDataModelData) {
        // Update existing user
        [self.userDataModelData setValue:mUserName forKey:@"username"];
        [self.userDataModelData setValue:mPassword forKey:@"password"];
    }
    else {
        // Create a new user
        NSManagedObject *newuserDataModelData = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY_NAME inManagedObjectContext:context];
        [newuserDataModelData setValue:mUserName forKey:@"username"];
        [newuserDataModelData setValue:mPassword forKey:@"password"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Data saved.");
    }
}

- (void)printUserData{
    NSLog(@"UserName: %@", mUserName);
    NSLog(@"Password: %@", mPassword);
}


@end
