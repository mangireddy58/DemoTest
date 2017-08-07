//
//  LoginViewController.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "GlobalViewController.h"
#import "GlobalConstant.h"
#import "ClassForServerComm.h"

@interface LoginViewController : GlobalViewController<ClassForServerCommDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *topBarHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *topBarHeaderLabelName;
@property (weak, nonatomic) IBOutlet UIImageView *topBarHeaderImageView;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *mobileNoTxtFld;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTxtFld;
- (IBAction)loginBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
