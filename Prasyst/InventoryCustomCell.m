//
//  InventoryCustomCell.m
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "InventoryCustomCell.h"
#import "GlobalConstant.h"

@implementation InventoryCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.inventoryNameLabel.font = LFONT_13;
            self.quantityTxtFld.font = LFONT_13;
            self.amountTxtFld.font = LFONT_13;
            self.viewBtn.titleLabel.font = LFONT_13;
        }
            break;
        case 2:{
            self.inventoryNameLabel.font = LFONT_15;
            self.quantityTxtFld.font = LFONT_15;
            self.amountTxtFld.font = LFONT_15;
            self.viewBtn.titleLabel.font = LFONT_15;
        }
            break;
        default:{
            self.inventoryNameLabel.font = LFONT_17;
            self.quantityTxtFld.font = LFONT_17;
            self.amountTxtFld.font = LFONT_17;
            self.viewBtn.titleLabel.font = LFONT_17;
            break;
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
