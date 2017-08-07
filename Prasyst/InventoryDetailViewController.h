//
//  InventoryDetailViewController.h
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 18/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "GlobalViewController.h"
#import "ClassForServerComm.h"
#import "UniversalDataModel.h"


@interface InventoryDetailViewController : GlobalViewController<ClassForServerCommDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *inventoryDetailWebView;
@property (weak, nonatomic) IBOutlet UIView *sortingView;
@property (weak, nonatomic) IBOutlet UIButton *filterByBranchBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterByCompanyBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortByCategoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortByDateAscBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortByDateDescBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortByPartyNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *partyNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *amountQuantityLbl;


- (IBAction)sortBtnAction:(id)sender;
- (IBAction)sortingBtnAction:(id)sender;

@end
