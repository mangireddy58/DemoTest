//
//  InventoryViewController.h
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"
#import "GlobalViewController.h"
#import "InventoryCustomCell.h"
#import "UniversalDataModel.h"

@interface InventoryViewController : GlobalViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headerNameLbl;
@property (weak, nonatomic) IBOutlet UITableView *inventoryTblView;

@property (strong, nonatomic) NSArray *responseArray;
@end
