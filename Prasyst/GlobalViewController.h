//
//  GlobalViewController.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "VKSideMenu.h"
#import "HeaderView.h"
#import "RTSpinKitView.h"
#import "UniversalDataModel.h"

@interface GlobalViewController : UIViewController<UIGestureRecognizerDelegate, UINavigationControllerDelegate, VKSideMenuDataSource, VKSideMenuDelegate, CAAnimationDelegate>
{
    NSInteger            menuCutWidth;
    IBOutlet UIView      *mViewLoading;
    IBOutlet UIImageView *mImageViewLoading;
    IBOutlet UILabel     *mLabelLoading;
    NSInteger            kWebServiceFlag;
    RTSpinKitView *spinner;
    
    NSArray             *inventoryArray;
    NSArray             *accountsArray;
}

@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, retain) UniversalDataModel *objUniversalDataModel;


- (void) fnForLoginAsRootViewController;
- (void) fnForMainDashAsRootViewController;
- (void) fnForMainAsInventoryViewController;
- (void) fnForMainAsAccountViewController;
- (void) fnForinventoryDetailViewController;
- (void) fnForAccountDetailViewController;
- (void) fnForSortByViewController;
- (void) showProgressIndicator;
- (void) addProgressIndicator;
- (void) hideProgressIndicator;
- (void) showProgressIndicatorWithMessage:(NSString*)loadingStr;
- (IBAction)fnForGeneralBackButtonPressed:(id)sender;

@end
