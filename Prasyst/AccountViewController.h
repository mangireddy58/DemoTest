//
//  AccountViewController.h
//  Prasyst
//
//  Created by Sai on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "GlobalViewController.h"
#import "AccountCustomCell.h"

@interface AccountViewController : GlobalViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *headerNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *accountTblView;

@property (strong, nonatomic) NSArray *responseArray;

@end
