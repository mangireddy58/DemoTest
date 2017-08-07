//
//  AppDelegate.m
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

#define IS_IPHONE  [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
#define IS_IPAD    [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    if(self.window == nil)
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    if(self.navigationController == nil)
        self.navigationController = [[UINavigationController alloc]init];
    
    if(self.storyboard == nil) {
        if (IS_IPHONE) {
        self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        }
        else{
            self.storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        }
    }
    
    self.navigationController.navigationBarHidden = YES;
    
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    
    
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Application Delegate Method
+ (AppDelegate *)getAppDelegate{
    static AppDelegate* sAppDelegate = nil;
    if(!sAppDelegate)
    {
        UIApplication *lApplication = [UIApplication sharedApplication];
        if([lApplication.delegate isKindOfClass: [AppDelegate class]])
        {
            sAppDelegate = (AppDelegate *)lApplication.delegate;
        }
    }
    return sAppDelegate;
}

@end
