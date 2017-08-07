//
//  LoginViewController.m
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputViews];
}
- (void) loadInputViews {
    self.mobileNoTxtFld.selectedPlaceHolderColor = [UIColor colorWithRed:252.0/255.0 green:69.0/255.0 blue:130.0/255.0 alpha:1.0];
    self.passwordTxtFld.selectedPlaceHolderColor = [UIColor colorWithRed:252.0/255.0 green:69.0/255.0 blue:130.0/255.0 alpha:1.0];
    self.mobileNoTxtFld.selectedLineColor = [UIColor colorWithRed:252.0/255.0 green:69.0/255.0 blue:130.0/255.0 alpha:1.0];
    self.passwordTxtFld.selectedLineColor = [UIColor colorWithRed:252.0/255.0 green:69.0/255.0 blue:130.0/255.0 alpha:1.0];
    self.passwordTxtFld.secureTextEntry = YES;
    self.mobileNoTxtFld.lineColor = [UIColor grayColor];
    self.passwordTxtFld.lineColor = [UIColor grayColor];
    
    [self addProgressIndicator];
    [self hideProgressIndicator];
    
    self.mobileNoTxtFld.text = @"8779163857";
    self.passwordTxtFld.text = @"2017";
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.loginBtn.titleLabel.font = LFONT_13;
            self.topBarHeaderLabelName.font = BFONT_13;
        }
            break;
        case 2:{
            self.loginBtn.titleLabel.font = LFONT_15;
            self.topBarHeaderLabelName.font = BFONT_15;
        }
            break;
        default:{
            self.loginBtn.titleLabel.font = LFONT_17;
            self.topBarHeaderLabelName.font = BFONT_17;
        }
            break;
    }
}
- (IBAction)loginBtnAction:(id)sender {
    if ((self.mobileNoTxtFld.text.length < 10 )) {
        [self.mobileNoTxtFld becomeFirstResponder];
    }
    else if (self.passwordTxtFld.text.length == 0) {
        [self.passwordTxtFld becomeFirstResponder];
    }
    else {
        [self showProgressIndicator];
        NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
        NSLog(@"imei %@",deviceUUID);
        NSString *lLoginParams = [NSString stringWithFormat:LOGIN_QUERY,self.mobileNoTxtFld.text];
        ClassForServerComm *objForServerComm = [[ClassForServerComm alloc] init];
        objForServerComm.delegate = self;
        kWebServiceFlag = login_url_tag;
        [objForServerComm sendHttpPostRequestWithParam:lLoginParams andServiceName:LOGIN_URL];
    }
    //[self fnForMainDashAsRootViewController];
}
#pragma mark - Server communication delegate methods
-(void)onServiceSuccess:(id)response{
    [self hideProgressIndicator];
    NSLog(@"reponse is %@",response);
    if(response != NULL){
        @try {
            switch (kWebServiceFlag) {
                case login_url_tag:{
                    if([response isKindOfClass:[NSArray class]]){
                        NSArray *responseArray = (NSArray *)response;
                        if([responseArray count] > 0){
                            NSArray *responseArray1 = [responseArray objectAtIndex:0];
                            if([responseArray1 count] > 0){
                                NSDictionary *responseDict = [responseArray1 objectAtIndex:0];
                                if([responseDict count] > 0){
                                    if([responseDict objectForKey:@"id"] != NULL){
                                        NSLog(@"client_id: %ld", [[responseDict objectForKey:@"id"] integerValue]);
                                        self.objUniversalDataModel.client_id = [[responseDict objectForKey:@"id"] integerValue];
                                        self.objUniversalDataModel.mainTypeString = [responseDict objectForKey:@"name"];
                                        [self fnForMainDashAsRootViewController];
                                        [self hideProgressIndicator];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }  @catch (NSException *exception) {
            NSLog(@"Service error");
        }
    }
}
- (void)onServiceFailed {
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == self.mobileNoTxtFld)
    {
        if(([string rangeOfCharacterFromSet:ALLOWED_CHARACTERS].location == NSNotFound) || ([string rangeOfCharacterFromSet:ALLOWED_NUMBERS].location == NSNotFound)){
            //            return YES;
            NSUInteger oldLength = [textField.text length];
            NSUInteger replacementLength = [string length];
            NSUInteger rangeLength = range.length;
            NSUInteger newLength = oldLength - rangeLength + replacementLength;
            BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
            return newLength <= kMobileNumberLimit || returnKey;
        }
        else{
            return NO;
        }
    }
    return YES;
}
#pragma mark - TextField Delegate Methods.
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
