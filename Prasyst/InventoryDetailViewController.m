//
//  InventoryDetailViewController.m
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 18/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "InventoryDetailViewController.h"
#import <AFHTTPSessionManager.h>

@interface InventoryDetailViewController ()

@end

@implementation InventoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputViews];
    [self loadDetailWebView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(handleSingleTap:)];
    [tapGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGesture];
}
- (void) loadInputViews {
    [self addProgressIndicator];
    [self hideProgressIndicator];
    if(!self.objUniversalDataModel)
    self.objUniversalDataModel = [UniversalDataModel getUniversalDataModel];
    self.partyNameLbl.text = [[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"]capitalizedString];
    self.amountQuantityLbl.text = [NSString stringWithFormat:@"Qty=%@,Amt=%@",[self.objUniversalDataModel.inventoryDictionary objectForKey:@"qty"],[self.objUniversalDataModel.inventoryDictionary objectForKey:@"amt"]];
    self.inventoryDetailWebView.delegate = self;
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.partyNameLbl.font = BFONT_13;
            self.amountQuantityLbl.font = LFONT_13;
            self.filterByBranchBtn.titleLabel.font = BFONT_13;
            self.filterByCompanyBtn.titleLabel.font = BFONT_13;
            self.sortByDateAscBtn.titleLabel.font = BFONT_13;
            self.sortByDateDescBtn.titleLabel.font = BFONT_13;
            self.sortByCategoryBtn.titleLabel.font = BFONT_13;
            self.sortByPartyNameBtn.titleLabel.font = BFONT_13;
        }
            break;
        case 2:{
            self.partyNameLbl.font = BFONT_15;
            self.amountQuantityLbl.font = LFONT_15;
            self.filterByBranchBtn.titleLabel.font = BFONT_15;
            self.filterByCompanyBtn.titleLabel.font = BFONT_15;
            self.sortByDateAscBtn.titleLabel.font = BFONT_15;
            self.sortByDateDescBtn.titleLabel.font = BFONT_15;
            self.sortByCategoryBtn.titleLabel.font = BFONT_15;
            self.sortByPartyNameBtn.titleLabel.font = BFONT_15;
        }
            break;
        default:{
            self.partyNameLbl.font = BFONT_17;
            self.amountQuantityLbl.font = LFONT_17;
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
    NSString *sqlQuery = [NSString stringWithFormat: INVENTORY_DETAILS_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
    ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
    objServerComm.delegate= self;
    kWebServiceFlag = inventory_details_tag;
    [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:INVENTORY_DETAILS_URL];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    for (UIView *thisView in self.inventoryDetailWebView.scrollView.subviews)
    {
        thisView.userInteractionEnabled = NO;
        [self.sortingView setHidden:YES];
    }
}
//- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
//    CGRect frame = aWebView.frame;
//    frame.size.height = 1;
//    aWebView.frame = frame;
//    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    aWebView.frame = frame;
//    
//    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
//}
#pragma mark - ServerComm Delegate Method
- (void)onWebViewServiceSuccess:(NSString *)resString {
    NSLog(@"Webview Details %@", resString);
    [self showProgressIndicator];
    if(resString != NULL){
        @try {
            switch (kWebServiceFlag) {
                case inventory_details_tag:{
                    [self.inventoryDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                    [self hideProgressIndicator];
                }
                break;
                case sort_by_category_url_tag: {
                    @try {
                        [self.inventoryDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                        [self.inventoryDetailWebView reload];
                        [self hideProgressIndicator];
                    } @catch (NSException *exception) {
                        NSLog(@"Service Error");
                        [self hideProgressIndicator];
                    }
                }
                    break;
                case sort_by_date_asc_url_tag: {
                    @try {
                        [self.inventoryDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                        [self.inventoryDetailWebView reload];
                        [self hideProgressIndicator];
                    } @catch (NSException *exception) {
                        NSLog(@"Service Error");
                        [self hideProgressIndicator];
                    }
                }
                    break;
                case sort_by_date_desc_url_tag: {
                    @try {
                        [self.inventoryDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                        [self.inventoryDetailWebView reload];
                        [self hideProgressIndicator];
                    } @catch (NSException *exception) {
                        NSLog(@"Service Error");
                        [self hideProgressIndicator];
                    }
                }
                    break;
                case sort_by_party_name_url_tag: {
                    @try {
                        [self.inventoryDetailWebView loadHTMLString:resString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//                        [self.inventoryDetailWebView reload];
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

//- (void)webViewDidFinishLoad:(UIWebView *)theWebView
//{
//    CGSize contentSize = theWebView.scrollView.contentSize;
//    CGSize viewSize = theWebView.bounds.size;
//    
//    float rw = viewSize.width / contentSize.width;
//    
//    theWebView.scrollView.minimumZoomScale = rw;
//    theWebView.scrollView.maximumZoomScale = rw;
//    theWebView.scrollView.zoomScale = rw;
////    CGFloat height = theWebView.scrollView.contentSize.height;
//    
//    //[theWebView.scrollView setContentSize: CGSizeMake(theWebView.frame.size.width, theWebView.scrollView.contentSize.height)];
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
//}
#pragma mark - Servercomm
- (void)onServiceSuccess:(id)response {
    NSLog(@"Response %@", response);
    if(response != NULL){
        @try {
            switch (kWebServiceFlag) {
                case sort_by_branch_url_tag: {
                    NSArray *responseArray = (NSArray *)response;
                    if([responseArray count] > 0){
//                        NSArray *responseArray1 = [responseArray objectAtIndex:0];
//                        if([responseArray1 count] > 0){
                            self.objUniversalDataModel.soryByBranchDataArray = responseArray;
                            NSLog(@"Sory by branch response %@", self.objUniversalDataModel.soryByBranchDataArray);
                            [self hideProgressIndicator];
                            [self fnForSortByViewController];
//                        }
                    }
                }
                    break;
                case sort_by_company_url_tag: {
                    @try {
                        NSArray *responseArray = (NSArray *)response;
                        if([responseArray count] > 0){
                            self.objUniversalDataModel.soryByCompanyDataArray = responseArray;
                            NSLog(@"Sory by company response %@", self.objUniversalDataModel.soryByCompanyDataArray);
                            [self hideProgressIndicator];
                            [self fnForSortByViewController];
//                            NSArray *responseArray1 = [responseArray objectAtIndex:0];
//                            if([responseArray1 count] > 0){
//                                self.objUniversalDataModel.soryByCompanyDataArray = responseArray;
//                                NSLog(@"Sory by company response %@", self.objUniversalDataModel.soryByCompanyDataArray);
                            
//                            }
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

- (void)onServiceFailed{
    NSLog(@"service failed");
    [self hideProgressIndicator];
}

- (IBAction)backBtnAction:(id)sender {
    [self fnForMainAsInventoryViewController];
}

- (IBAction)sortBtnAction:(id)sender {
    self.sortingView.hidden = NO;
}
#pragma mark - Sort by button action
- (IBAction)sortingBtnAction:(UIButton *)sender {
    UIButton *sortBtn = (UIButton *)sender;
    [self.sortingView setHidden:YES];
    switch (sortBtn.tag) {
            case 1: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_BRANCH_INVENTORY_QUERY,[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString, (unsigned long)self.objUniversalDataModel.client_id];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_branch_url_tag;
                [objServerComm sendHttpPostRequestWithParam:sqlQuery andServiceName:SORT_BY_BRANCH_URL];
            }
            break;
            case 2: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat:SORT_BY_COMPANY_IVENTORY_QUERY,[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"],(unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString,self.objUniversalDataModel.toDateString,(unsigned long)self.objUniversalDataModel.client_id];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_company_url_tag;
                [objServerComm sendHttpPostRequestWithParam:sqlQuery andServiceName:SORT_BY_COMPANY_URL];
            }
            break;
            case 3: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_CATEGORY_INVENTORY_QUERY,@"%d/%m/%y",[self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_category_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_CATEGORY_URL];
            }
            break;
            case 4: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_DATE_ASC_INVENTORY_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_date_asc_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_DATE_ASC_URL];
            }
            break;
            case 5: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_DATE_DESC_INVENTORY_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
                ClassForServerComm *objServerComm = [[ClassForServerComm alloc]init];
                objServerComm.delegate = self;
                kWebServiceFlag = sort_by_date_desc_url_tag;
                [objServerComm sendHttpRequestWithParam:sqlQuery andServiceName:SORT_BY_DATE_DESC_URL];
            }
            break;
            case 6: {
                [self showProgressIndicator];
                NSString *sqlQuery = [NSString stringWithFormat: SORT_BY_PARTY_NAME_INVENTORY_QUERY, @"%d/%m/%y", [self.objUniversalDataModel.inventoryDictionary objectForKey:@"type"], (unsigned long)self.objUniversalDataModel.client_id,self.objUniversalDataModel.fromDateString, self.objUniversalDataModel.toDateString];
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
