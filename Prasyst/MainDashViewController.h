//
//  MainDashViewController.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "GlobalViewController.h"
#import "AIDatePickerController.h"
#import "ClassForServerComm.h"
#import "AFHTTPSessionManager.h"
#import <QuartzCore/QuartzCore.h>

@interface MainDashViewController : GlobalViewController<ClassForServerCommDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fromDateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *toDateTextFld;
@property (weak, nonatomic) IBOutlet UIButton *fromDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *toDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *getDataBtn;
@property (weak, nonatomic) IBOutlet UIButton *inventoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *idNameLbl;

- (IBAction)fromToDateBtnAction:(id)sender;
- (IBAction)getDataBtnAction:(id)sender;
- (IBAction)inventoryBtnAction:(id)sender;
- (IBAction)accountBtnAction:(id)sender;
- (IBAction)logOutAction:(id)sender;



@end
