//
//  SortByCompanyViewController.h
//  Prasyst
//
//  Created by Sai on 31/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "GlobalViewController.h"
#import "ClassForServerComm.h"
#import "SortByTableViewCell.h"

@interface SortByCompanyViewController : GlobalViewController<ClassForServerCommDelegate, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSArray *sortingResponseArray;
@property (weak, nonatomic) IBOutlet UILabel *sortingNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *allLbl;
@property (weak, nonatomic) IBOutlet UITableView *sortTblView;

- (IBAction)dismissBtnAction:(id)sender;

@end
