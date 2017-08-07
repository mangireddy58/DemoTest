//
//  MainDashViewController.m
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "MainDashViewController.h"
#import "InventoryViewController.h"

@interface MainDashViewController ()

@end

@implementation MainDashViewController

- (void)viewDidAppear:(BOOL)animated{
    if([self.objUniversalDataModel.inventoryDataArray count] > 0){
        self.inventoryBtn.hidden = NO;
    }
    
    if([self.objUniversalDataModel.accountsDataArray count] > 0){
        self.accountBtn.hidden = NO;
    }
    
    if(self.objUniversalDataModel.fromDateString.length > 0)
        self.fromDateTxtFld.text = self.objUniversalDataModel.fromDateString;
    
    if(self.objUniversalDataModel.toDateString.length > 0)
        self.toDateTextFld.text = self.objUniversalDataModel.toDateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputViews];
}

- (void) loadInputViews {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    UIColor *color = [UIColor blackColor];
    self.fromDateTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"From" attributes:@{NSForegroundColorAttributeName: color}];
    self.toDateTextFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"To" attributes:@{NSForegroundColorAttributeName: color}];
    self.countLbl.layer.masksToBounds = YES;
    self.countLbl.layer.cornerRadius = 8.0;
    self.typeNameLbl.text = self.objUniversalDataModel.mainTypeString;
    self.idNameLbl.text = [NSString stringWithFormat:@"id: %lu",(unsigned long)self.objUniversalDataModel.client_id];
    self.fromDateTxtFld.text = @"2017-04-01";
    self.toDateTextFld.text = @"2017-07-14";
    self.objUniversalDataModel.fromDateString = @"2017-04-01";
    self.objUniversalDataModel.toDateString = @"2017-07-14";
    
    self.inventoryBtn.hidden = YES;
    self.accountBtn.hidden = YES;
    self.countLbl.hidden = YES;
    
    [self addProgressIndicator];
    [self hideProgressIndicator];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
            case 1:{
                self.getDataBtn.titleLabel.font = LFONT_13;
                self.inventoryBtn.titleLabel.font = LFONT_13;
                self.accountBtn.titleLabel.font = LFONT_13;
                self.fromDateTxtFld.font = LFONT_13;
                self.toDateTextFld.font = LFONT_13;
                self.typeNameLbl.font = BFONT_13;
                self.idNameLbl.font = LFONT_13;
            }
            break;
            case 2:{
                self.getDataBtn.titleLabel.font = LFONT_15;
                self.inventoryBtn.titleLabel.font = LFONT_15;
                self.accountBtn.titleLabel.font = LFONT_15;
                self.fromDateTxtFld.font = LFONT_15;
                self.toDateTextFld.font = LFONT_15;
                self.typeNameLbl.font = BFONT_15;
                self.idNameLbl.font = LFONT_15;
            }
            break;
        default:{
            self.getDataBtn.titleLabel.font = LFONT_17;
            self.inventoryBtn.titleLabel.font = LFONT_17;
            self.accountBtn.titleLabel.font = LFONT_17;
            self.fromDateTxtFld.font = LFONT_17;
            self.toDateTextFld.font = LFONT_17;
            self.typeNameLbl.font = BFONT_17;
            self.idNameLbl.font = LFONT_17;
        }
            break;
    }
}

- (IBAction)getDataBtnAction:(id)sender {
    [self showProgressIndicator];
    NSString *params = [NSString stringWithFormat:INVENTORY_QUERY, (unsigned long)self.objUniversalDataModel.client_id, self.fromDateTxtFld.text, self.toDateTextFld.text];
    ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
    objServerComm.delegate= self;
    kWebServiceFlag = inventory_url_tag;
    [objServerComm sendHttpPostRequestWithParam:params andServiceName:INVENTORY_URL];
}

#pragma mark - Inventory Method.
- (IBAction)inventoryBtnAction:(id)sender {
    [self fnForMainAsInventoryViewController];
}

#pragma mark - Server communication delegate methods
-(void)onServiceSuccess:(id)response{
    [self hideProgressIndicator];
    NSLog(@"reponse is %@",response);
    if(response != NULL){
        @try {
            switch (kWebServiceFlag) {
                case get_data_url_tag:{
                    if([response isKindOfClass:[NSArray class]]){
                        NSArray *responseArray = (NSArray *)response;
                        if([responseArray count] > 0){
                            NSArray *responseArray1 = [responseArray objectAtIndex:0];
                            if([responseArray1 count] > 0){
                                NSDictionary *responseDict = [responseArray1 objectAtIndex:0];
                                if([responseDict count] > 0){
                                    if([responseDict objectForKey:@"count"] != NULL){
                                        NSLog(@"Count: %d", [[responseDict objectForKey:@"count"] intValue]);
                                        self.inventoryBtn.hidden = NO;
                                        self.accountBtn.hidden = NO;
                                        self.countLbl.hidden = NO;
                                        self.countLbl.text = [NSString stringWithFormat:@"Count: %d",[[responseDict objectForKey:@"count"] intValue]];
                                        [self hideProgressIndicator];
                                    }
                                }
                            }
                        }
                    }
                }//end of get_data_url_tag
                    break;
                case inventory_url_tag:{
                    @try {
                        [self hideProgressIndicator];
                        NSArray *responseArray = (NSArray *)response;
                        NSLog(@"Inventory response: %@", responseArray);
                        if(responseArray.count > 0) {
                            NSArray *responseArray1 = [responseArray objectAtIndex:0];
                            if([responseArray1 count] > 0){
                                self.objUniversalDataModel.generalDataArray = responseArray1;
                                NSMutableArray *inventoryListArray = [NSMutableArray array];
                                NSMutableArray *accountsListArray = [NSMutableArray array];
                                for (NSDictionary *dict in responseArray1) {
                                    BOOL isInventory = NO;
                                    for (NSString *inventoryStr in inventoryArray) {
                                        if([[[[dict objectForKey:@"type"] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString] isEqualToString:[[inventoryStr stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString]]){
                                            isInventory = YES;
                                            [inventoryListArray addObject:dict];
                                        }
                                    }
                                    
                                    if(!isInventory){
                                        [accountsListArray addObject:dict];
                                    }
                                    
                                }
                                
                                if([inventoryListArray count] > 0){
                                    self.objUniversalDataModel.inventoryDataArray = [NSArray arrayWithArray:inventoryListArray];
                                    self.inventoryBtn.hidden = NO;
                                }
                                else{
                                    self.inventoryBtn.hidden = YES;
                                }
                                
                                if([accountsListArray count] > 0){
                                    self.objUniversalDataModel.accountsDataArray = [NSArray arrayWithArray:accountsListArray];
                                    self.accountBtn.hidden = NO;
                                }
                                else{
                                    self.accountBtn.hidden = YES;
                                }
                            }
                            else{
                                NSLog(@"Data not available.");
                            }
                        }
                        else{
                            NSLog(@"Data not available.");
                        }
                        
                    } @catch (NSException *exception) {
                        NSLog(@"Service error");
                    }
                }
                    break;
                case account_url_tag: {
                    @try {
                        [self hideProgressIndicator];
                        NSArray *responseArray = (NSArray *)response;
                        NSLog(@"Inventory response: %@", responseArray);
                    } @catch (NSException *exception) {
                        NSLog(@"Service Error");
                    }
                }
                default:
                    break;
            }
            
        } @catch (NSException *exception) {
            NSLog(@"Service error");
        }
        
    }
    else {
        NSLog(@"Service error");
    }
}
- (void)onServiceFailed {
    
}


- (IBAction)accountBtnAction:(id)sender {
    [self fnForMainAsAccountViewController];
}

- (IBAction)logOutAction:(id)sender {
}

- (IBAction)fromToDateBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            __weak MainDashViewController *weakSelf = self;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
            AIDatePickerController *datePickerViewController = [AIDatePickerController pickerWithDate:date selectedBlock:^(NSDate *selectedDate) {
                __strong MainDashViewController *strongSelf = weakSelf;
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                self.fromDateTxtFld.text = [dateFormatter stringFromDate:selectedDate];
                self.objUniversalDataModel.fromDateString = [dateFormatter stringFromDate:selectedDate];
            }cancelBlock:^{
                __strong MainDashViewController *strongSelf = weakSelf;
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [self presentViewController:datePickerViewController animated:YES completion:nil];
        }
            break;
        case 2: {
            __weak MainDashViewController *weakSelf = self;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *toStr = [NSString stringWithFormat:@"%@",self.fromDateTxtFld.text];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateOne = [dateFormatter dateFromString:toStr];
            AIDatePickerController *datePickerViewController = [AIDatePickerController pickerWithDate:dateOne selectedBlock:^(NSDate *selectedDate) {
                __strong MainDashViewController *strongSelf = weakSelf;
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                self.toDateTextFld.text = [dateFormatter stringFromDate:selectedDate];
                self.objUniversalDataModel.toDateString = [dateFormatter stringFromDate:selectedDate];
            }cancelBlock:^{
                __strong MainDashViewController *strongSelf = weakSelf;
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            datePickerViewController.datePicker.minimumDate = dateOne;
            [self presentViewController:datePickerViewController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
@end
