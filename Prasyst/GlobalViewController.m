//
//  GlobalViewController.m
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "GlobalViewController.h"
#import "UniversalDataModel.h"
#import "LoginViewController.h"
#import "MainDashViewController.h"
#import "InventoryViewController.h"
#import "InventoryDetailViewController.h"
#import "AccountViewController.h"
#import "AccountDetailViewController.h"
#import "SortByCompanyViewController.h"

@interface GlobalViewController ()

@end

@implementation GlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Menu
    menuCutWidth = 120;
    self.menuLeft = [[VKSideMenu alloc] initWithSize:(VIEWWIDTH - menuCutWidth) andDirection:VKSideMenuDirectionFromLeft];
    
    if(!self.objUniversalDataModel)
        self.objUniversalDataModel = [UniversalDataModel getUniversalDataModel];
    
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    
    inventoryArray = @[@"FG Stock", @"Sales Order", @"Packing", @"Finish Inward", @"Finish PO", @"Job Card", @"Fabric Inward", @"Fabric Issue", @"Fabric PO", @"Stores Inward", @"Stores Issue", @"Stores PO"];
    
    accountsArray = @[@"Collection", @"Payments", @"UnClg Chq PD", @"UnClg Chq Rcd"];
}

- (IBAction)fnForGeneralBackButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Login ViewController
- (void) fnForLoginAsRootViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *loginMainVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.45;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:loginMainVC animated:NO];
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        LoginViewController *loginMainVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.45;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:loginMainVC animated:NO];
    }
    
    
}
#pragma mark - MainDash
- (void) fnForMainDashAsRootViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        MainDashViewController *mainDashVC = [storyboard instantiateViewControllerWithIdentifier:@"MainDashViewController"];
        [self.navigationController pushViewController:mainDashVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        MainDashViewController *mainDashVC = [storyboard instantiateViewControllerWithIdentifier:@"MainDashViewController"];
        [self.navigationController pushViewController:mainDashVC animated:YES];
    }
    
}
#pragma mark - Inventory
- (void) fnForMainAsInventoryViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        InventoryViewController *inventoryVC = [storyboard instantiateViewControllerWithIdentifier:@"InventoryViewController"];
        [self.navigationController pushViewController:inventoryVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        InventoryViewController *inventoryVC = [storyboard instantiateViewControllerWithIdentifier:@"InventoryViewController"];
        [self.navigationController pushViewController:inventoryVC animated:YES];
    }
    
}
#pragma mark - Account
- (void) fnForMainAsAccountViewController; {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        AccountViewController *accountVC = [storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        InventoryViewController *accountVC = [storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
}
#pragma mark - Inventory Details.
- (void) fnForinventoryDetailViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        InventoryDetailViewController *inventoryVC = [storyboard instantiateViewControllerWithIdentifier:@"InventoryDetailViewController"];
        [self.navigationController pushViewController:inventoryVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        InventoryDetailViewController *inventoryVC = [storyboard instantiateViewControllerWithIdentifier:@"InventoryDetailViewController"];
        [self.navigationController pushViewController:inventoryVC animated:YES];
    }
}
#pragma mark - Account Details
- (void) fnForAccountDetailViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        AccountDetailViewController *accountDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"AccountDetailViewController"];
        [self.navigationController pushViewController:accountDetailVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        AccountDetailViewController *accountDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"AccountDetailViewController"];
        [self.navigationController pushViewController:accountDetailVC animated:YES];
    }
}
#pragma mark - SortBy VC
- (void) fnForSortByViewController {
    if (IS_IPHONE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SortByCompanyViewController *sortVC = [storyboard instantiateViewControllerWithIdentifier:@"SortByCompanyViewController"];
        [self.navigationController presentViewController:sortVC animated:YES completion:nil];//:sortVC animated:YES];
        //[self.navigationController pushViewController:sortVC animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        SortByCompanyViewController *sortVC = [storyboard instantiateViewControllerWithIdentifier:@"SortByCompanyViewController"];
        [self.navigationController pushViewController:sortVC animated:YES];
        //[self.navigationController pushViewController:sortVC animated:YES];
    }
}
#pragma mark - UnRegister Method
- (void) fnForUnregisterethodViewController {
    [self showProgressIndicator];
    NSString *params = [NSString stringWithFormat:UNREGISTRED_QUERY,self.objUniversalDataModel.mobileNumString];
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, UNREGISTRED_URL];
    NSString *paramString = [NSString stringWithFormat:SERVICE_PARAMS, params, DB_NAME];
    NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *parametersDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[data length]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setTimeoutInterval:SERVICE_TIMEOUT];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:serviceUrl parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Unregistred successfully:%@", str);
        self.objUniversalDataModel.regUnRegString = str;
        if ([str isEqualToString:@"0"]) {
            [self hideProgressIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PGSol" message:@"Unregistred successfully" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self fnForLoginAsRootViewController];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            [self fnForLoginAsRootViewController];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failure:%@", error);
    }];
}
#pragma mark - Show Progressindicator
- (void) showProgressIndicator {
    mViewLoading.hidden = NO;
    mImageViewLoading.hidden = NO;
    mLabelLoading.hidden = NO;
    [spinner startAnimating];
    [self.view bringSubviewToFront:mViewLoading];
    [self.view bringSubviewToFront:mImageViewLoading];
    [self.view bringSubviewToFront:mLabelLoading];
    [self.view bringSubviewToFront:spinner];
    self.view.userInteractionEnabled = NO;
}
#pragma mark - Addprogressindicator
- (void) addProgressIndicator {
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleFadingCircleAlt color:[UIColor whiteColor]];
    mViewLoading  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mImageViewLoading = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2)-(156/2), ([UIScreen mainScreen].bounds.size.height/2)-(124/2), 156, 124)];
    mLabelLoading = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2) - (127/2), ([UIScreen mainScreen].bounds.size.height/2) + 5, 127, 50)];
    mViewLoading.alpha = 0.5;
    mViewLoading.backgroundColor = [UIColor blackColor];
    [self.view addSubview:mViewLoading];
    mImageViewLoading.image = [UIImage imageNamed:@"bg_loading.png"];
    [self.view addSubview:mImageViewLoading];
    [self.view addSubview:mLabelLoading];
    [self.view addSubview:spinner];
    
    mLabelLoading.numberOfLines = 2;
    mLabelLoading.textAlignment = NSTextAlignmentCenter;
    mLabelLoading.backgroundColor = [UIColor clearColor];
    mLabelLoading.textColor = [UIColor whiteColor];
    mLabelLoading.font = LFONT_15;
    mLabelLoading.text = @"Processing";
}
#pragma mark - Hide Progressindicator
- (void) hideProgressIndicator {
    mViewLoading.hidden = YES;
    mImageViewLoading.hidden = YES;
    mLabelLoading.hidden = YES;
    [spinner stopAnimating];
    self.view.userInteractionEnabled = YES;
}
#pragma mark - ProgressWith Message
- (void)showProgressIndicatorWithMessage:(NSString*)loadingStr{
    mViewLoading.hidden = NO;
    mImageViewLoading.hidden = NO;
    mLabelLoading.hidden = NO;
    mLabelLoading.text = loadingStr;
    [spinner startAnimating];
    [self.view bringSubviewToFront:mViewLoading];
    [self.view bringSubviewToFront:mImageViewLoading];
    [self.view bringSubviewToFront:mLabelLoading];
    [self.view bringSubviewToFront:spinner];
    self.view.userInteractionEnabled = NO;
}
#pragma mark - Logout Action
- (void) fnForLogOutBtnAction {
    UniversalDataModel *objUniversalDataModel = [UniversalDataModel getUniversalDataModel];
    self.objUniversalDataModel.loggedString = @"0";
    [objUniversalDataModel clearUniversalDataModel];
}
#pragma mark - VKSideMenu Datasource & Delegate Methods.
- (IBAction)fnForMenuButtonPressed:(id)sender{
    [self.view endEditing:YES];
    [self.menuLeft show];
}

- (void)fnForMenuValueInitialise{
    [self.menuLeft addSwipeGestureRecognition:self.view];
}
- (NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu{
    return 1;
}

- (NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    return (LogOut + 1);
}

- (UIView*)sideMenu:(VKSideMenu *)sideMenu viewForHeaderInSection:(NSInteger)section{
    HeaderView *headerViewObj = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] firstObject];
    [headerViewObj.headerNamelabel setFont:LFONT_20];
    [headerViewObj.headerEmailLabel setFont:LFONT_20];
//    headerViewObj.headerNamelabel.text = self.objUniversalDataModel.mainTypeString;
//    headerViewObj.headerEmailLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.objUniversalDataModel.client_id];
    return headerViewObj;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKSideMenuItem *item = [VKSideMenuItem new];
    switch (indexPath.row)
    {
        case Unregister:
            item.title = @"Unregistred";
            break;
        case LogOut:
            item.title = @"Log Out";
            break;
        default:
            break;
    }
    return item;
}

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row)
    {
        case Unregister:
            [self fnForUnregisterethodViewController];
            break;
        case LogOut:
            [self fnForLogOutBtnAction];
            [self fnForLoginAsRootViewController];
            break;
        default:
            break;
    }
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu{
    
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu{
    
}


@end
