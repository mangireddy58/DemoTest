//
//  InventoryCustomCell.h
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface InventoryCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *inventoryNameLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *quantityTxtFld;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *amountTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *viewBtn;

@end
