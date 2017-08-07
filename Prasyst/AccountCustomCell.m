//
//  AccountCustomCell.m
//  Prasyst
//
//  Created by Sai on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "AccountCustomCell.h"
#import "GlobalConstant.h"

@implementation AccountCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.dataNameLabel.font = LFONT_13;
            self.viewBtn.titleLabel.font = LFONT_13;
        }
            break;
        case 2:{
            self.dataNameLabel.font = LFONT_15;
            self.viewBtn.titleLabel.font = LFONT_15;
        }
            break;
        default:{
            self.dataNameLabel.font = LFONT_17;
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
