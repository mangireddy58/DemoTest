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
    [self.mobileNoTxtFld setKeyboardType:UIKeyboardTypeNumberPad];
//    [self.passwordTxtFld setKeyboardType:UIKeyboardTypeNumberPad];
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

#pragma mark - Login Button
- (IBAction)loginBtnAction:(id)sender {
    if ([self.objUniversalDataModel.regUnRegString isEqualToString:@"0"]) {
        if ([self.mobileNoTxtFld.text isEqualToString:self.objUniversalDataModel.mobileNumString]) {
            NSLog(@"register");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Register" message:@"Do you want to register" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *regi = [UIAlertAction actionWithTitle:@"REGISTER" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showProgressIndicator];
                NSString *lLoginParams = [NSString stringWithFormat:LOGIN_QUERY,self.mobileNoTxtFld.text];
                ClassForServerComm *objForServerComm = [[ClassForServerComm alloc] init];
                objForServerComm.delegate = self;
                kWebServiceFlag = login_url_tag;
                [objForServerComm sendHttpPostRequestWithParam:lLoginParams andServiceName:LOGIN_URL];
            }];
            [alert addAction:no];
            [alert addAction:regi];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PGSol" message:@"Invalid credentials" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else {
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
            self.objUniversalDataModel.mobileNumString = self.mobileNoTxtFld.text;
            NSString *lLoginParams = [NSString stringWithFormat:LOGIN_QUERY,self.mobileNoTxtFld.text];
            ClassForServerComm *objForServerComm = [[ClassForServerComm alloc] init];
            objForServerComm.delegate = self;
            kWebServiceFlag = login_url_tag;
            [objForServerComm sendHttpPostRequestWithParam:lLoginParams andServiceName:LOGIN_URL];
        }
    }
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
//                                        self.objUniversalDataModel.loggedString = @"1";
                                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                        [defaults setObject:@"1" forKey:@"userLoggedIn"];
                                        [defaults synchronize];
                                        self.objUniversalDataModel.client_id = [[responseDict objectForKey:@"id"] integerValue];
                                        self.objUniversalDataModel.mainTypeString = [responseDict objectForKey:@"name"];
                                        [self fnForMainDashAsRootViewController];
                                        [self hideProgressIndicator];
                                    }
                                }
                            }
                            else {
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PGSol" message:@"Invalid credentials" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alert addAction:ok];
                                [self presentViewController:alert animated:YES completion:nil];
                            }
                        }
                    }
                }
            }
        }  @catch (NSException *exception) {
            NSLog(@"Service error");
        }
    }
    else {
        
    }
}
- (void)onServiceFailed {
    [self hideProgressIndicator];
    NSLog(@"service failed");
}
- (void) fnForRegisterUser {
    [self showProgressIndicator];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    NSLog(@"imei %@",deviceUUID);
    NSString *params = [NSString stringWithFormat:REGISTRED_QUERY,deviceUUID,self.mobileNoTxtFld.text];
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, REGISTRED_URL];
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
        NSLog(@"registred successfully:%@", str);
        if ([str isEqualToString:@"0"]) {
            [self hideProgressIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Register" message:@"Do you want to register" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *reg = [UIAlertAction actionWithTitle:@"REGISTER" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self loginBtnAction:self];
            }];
            [alert addAction:ok];
            [alert addAction:reg];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failure:%@", error);
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == self.mobileNoTxtFld)
    {
        if(([string rangeOfCharacterFromSet:ALLOWED_CHARACTERS].location == NSNotFound) || ([string rangeOfCharacterFromSet:ALLOWED_NUMBERS].location == NSNotFound)){
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

- (IBAction)showPasswordBtnAction:(id)sender {
    if (self.showPasswordBtn.tag == 0) {
        [self.passwordTxtFld setSecureTextEntry:NO];
        [self.passwordTxtFld resignFirstResponder];
        //        [self.passwordTxtFld setFont:[UIFont fontWithName:@"System-Bold" size:16]];
        self.showPasswordBtn.tag = 1;
    }
    else {
        self.showPasswordBtn.tag = 0;
        [self.passwordTxtFld setSecureTextEntry:YES];
        [self.passwordTxtFld resignFirstResponder];
    }
}
@end
