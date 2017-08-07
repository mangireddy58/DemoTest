//
//  AccountDetailViewController.m
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 18/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "AccountDetailViewController.h"

@interface AccountDetailViewController ()

@end

@implementation AccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputViews];
    [self loadDetailWebView];
    self.accountDetailWebView.delegate = self;
}
- (void) loadInputViews {
    [self addProgressIndicator];
    [self hideProgressIndicator];
    
    if(!self.objUniversalDataModel)
    self.objUniversalDataModel = [UniversalDataModel getUniversalDataModel];
    self.typeNameLbl.text = [[self.objUniversalDataModel.accountDictionary objectForKey:@"type"]capitalizedString];
    self.amountQtyLbl.text = [NSString stringWithFormat:@"Qty=%@,Amt=%@",[self.objUniversalDataModel.accountDictionary objectForKey:@"qty"],[self.objUniversalDataModel.accountDictionary objectForKey:@"amt"]];
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.typeNameLbl.font = BFONT_13;
            self.amountQtyLbl.font = LFONT_13;
            self.filterByBranchBtn.titleLabel.font = BFONT_13;
            self.filterByCompanyBtn.titleLabel.font = BFONT_13;
            self.sortByDateAscBtn.titleLabel.font = BFONT_13;
            self.sortByDateDescBtn.titleLabel.font = BFONT_13;
            self.sortByCategoryBtn.titleLabel.font = BFONT_13;
            self.sortByPartyNameBtn.titleLabel.font = BFONT_13;
        }
            break;
        case 2:{
            self.typeNameLbl.font = BFONT_15;
            self.amountQtyLbl.font = LFONT_15;
            self.filterByBranchBtn.titleLabel.font = BFONT_15;
            self.filterByCompanyBtn.titleLabel.font = BFONT_15;
            self.sortByDateAscBtn.titleLabel.font = BFONT_15;
            self.sortByDateDescBtn.titleLabel.font = BFONT_15;
            self.sortByCategoryBtn.titleLabel.font = BFONT_15;
            self.sortByPartyNameBtn.titleLabel.font = BFONT_15;
        }
            break;
        default:{
            self.typeNameLbl.font = BFONT_17;
            self.amountQtyLbl.font = LFONT_17;
            self.filterByBranchBtn.titleLabel.font = BFONT_17;
            self.filterByCompanyBtn.titleLabel.font = BFONT_17;
            self.sortByDateAscBtn.titleLabel.font = BFONT_17;
            self.sortByDateDescBtn.titleLabel.font = BFONT_17;
            self.sortByCategoryBtn.titleLabel.font = BFONT_17;
            self.sortByPartyNameBtn.titleLabel.font = BFONT_17;
            break;
        }
    }
}
- (void)loadDetailWebView {
    [self showProgressIndicator];
    NSString *sqlQuery = [NSString stringWithFormat: ACCOUNT_DETAILS_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.accountDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
    ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
    objServerComm.delegate= self;
    kWebServiceFlag = account_details_tag;
    [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:ACCOUNT_DETAILS_URL];
}

#pragma mark - ServerComm Delegate Method
- (void)onWebViewServiceSuccess:(NSString *)resString {
    NSLog(@"Webview Details %@", resString);
    if(resString != NULL){
        @try {
            switch (kWebServiceFlag) {
                    case account_details_tag:{
                        [self.accountDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                        [self hideProgressIndicator];
                    }
                    break;
                    
                    case sort_by_category_url_tag: {
                        @try {
                            [self.accountDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                            [self.accountDetailWebView reload];
                            [self hideProgressIndicator];
                        } @catch (NSException *exception) {
                            NSLog(@"Service Error");
                            [self hideProgressIndicator];
                        }
                    }
                    break;
                    case sort_by_date_asc_url_tag: {
                        @try {
                            [self.accountDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                            [self.accountDetailWebView reload];
                            [self hideProgressIndicator];
                        } @catch (NSException *exception) {
                            NSLog(@"Service Error");
                            [self hideProgressIndicator];
                        }
                    }
                    break;
                    case sort_by_date_desc_url_tag: {
                        @try {
                            [self.accountDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                            [self.accountDetailWebView reload];
                            [self hideProgressIndicator];
                        } @catch (NSException *exception) {
                            NSLog(@"Service Error");
                            [self hideProgressIndicator];
                        }
                    }
                    break;
                    case sort_by_party_name_url_tag: {
                        @try {
                            [self.accountDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                            [self.accountDetailWebView reload];
                            [self hideProgressIndicator];
                        } @catch (NSException *exception) {
                            NSLog(@"Service Error");
                            [self hideProgressIndicator];
                        }
                    }
                    break;
                default:
                    break;
            }
        } @catch (NSException *exception) {
            NSLog(@"Service Error");
            [self hideProgressIndicator];
        }
    }
}
#pragma mark - Servercomm
- (void)onServiceSuccess:(id)response {
    NSLog(@"Response %@", response);
    if(response != NULL){
        @try {
            switch (kWebServiceFlag) {
                    case sort_by_branch_url_tag: {
                        NSArray *responseArray = (NSArray *)response;
                        if([responseArray count] > 0){
                            NSArray *responseArray1 = [responseArray objectAtIndex:0];
                            if([responseArray1 count] > 0){
                                self.objUniversalDataModel.soryByBranchDataArray = responseArray1;
                                NSLog(@"Sory by branch response %@", self.objUniversalDataModel.soryByBranchDataArray);
                                [self hideProgressIndicator];
                            }
                        }
                    }
                    [self hideProgressIndicator];
                    break;
                    case sort_by_company_url_tag: {
                        @try {
                            NSArray *responseArray = (NSArray *)response;
                            if([responseArray count] > 0){
                                NSArray *responseArray1 = [responseArray objectAtIndex:0];
                                if([responseArray1 count] > 0){
                                    self.objUniversalDataModel.soryByCompanyDataArray = responseArray1;
                                    NSLog(@"Sory by company response %@", self.objUniversalDataModel.soryByCompanyDataArray);
                                    [self hideProgressIndicator];
                                }
                            }
                        } @catch (NSException *exception) {
                            NSLog(@"Server error");
                            [self hideProgressIndicator];
                        }
                    }
                    break;
                default:
                    break;
            }
            NSLog(@"");
        } @catch (NSException *exception) {
            NSLog(@"Service error");
            [self hideProgressIndicator];
        }
    }
    else {
        NSLog(@"Service Error");
        [self hideProgressIndicator];
    }
}
- (IBAction)sortBtnAction:(id)sender {
    self.sortingView.hidden = NO;
}
#pragma mark - Sorting Actions.
- (IBAction)sortingBtnActions:(UIButton *)sender {
    UIButton *sortBtn = (UIButton *)sender;
    [self.sortingView setHidden:YES];
    switch (sortBtn.tag) {
            case 1: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_BRANCH_ACCOUNT_QUERY,[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString, (unsigned long)self.objUniversalDataModel.client_id];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_branch_url_tag;
                [objServerComm sendHttpPostRequestWithParam:sqlQuery andServiceName:SORT_BY_BRANCH_URL];
            }
            break;
            case 2: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat:SORT_BY_COMPANY_ACCOUNT_QUERY,[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"],(unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString,self.objUniversalDataModel.toDateString,(unsigned long)self.objUniversalDataModel.client_id];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_company_url_tag;
                [objServerComm sendHttpPostRequestWithParam:sqlQuery andServiceName:SORT_BY_COMPANY_URL];
            }
            break;
            case 3: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_CATEGORY_ACCOUNT_QUERY,@"%d/%m/%y",[self.objUniversalDataModel.accountDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_category_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_CATEGORY_URL];
            }
            break;
            case 4: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_DATE_ASC_ACCOUNT_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.accountDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_date_asc_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_DATE_ASC_URL];
            }
            break;
            case 5: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_DATE_DESC_ACCOUNT_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.accountDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_date_desc_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_DATE_DESC_URL];
            }
            break;
            case 6: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_PARTY_NAME_ACCOUNT_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.accountDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_party_name_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_PARTY_NAME_URL];
            }
            break;
        default:
            break;
    }
}
@end
