//
//  AppDelegate.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIStoryboard *storyboard;
@property (strong, nonatomic) UINavigationController *navigationController;

+ (AppDelegate *)getAppDelegate;

@end

