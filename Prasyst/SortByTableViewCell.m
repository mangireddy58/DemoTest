//
//  SortByTableViewCell.m
//  Prasyst
//
//  Created by Sai on 31/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "SortByTableViewCell.h"

@implementation SortByTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.typeNameLbl.font = LFONT_13;
            self.amountQtyLbl.font = LFONT_13;
        }
            break;
        case 2:{
            self.typeNameLbl.font = LFONT_15;
            self.amountQtyLbl.font = LFONT_15;
        }
            break;
        default:{
            self.typeNameLbl.font = LFONT_17;
            self.amountQtyLbl.font = LFONT_17;
            break;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
