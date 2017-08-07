//
//  AccountCustomCell.h
//  Prasyst
//
//  Created by Sai on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface AccountCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dataNameLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *amountTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *viewBtn;

@end
