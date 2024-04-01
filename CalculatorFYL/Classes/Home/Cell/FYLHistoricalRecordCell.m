//
//  FYLHistoricalRecordCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/22.
//

#import "FYLHistoricalRecordCell.h"

@implementation FYLHistoricalRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.L_contect.font = [YLUserToolManager getAppTitleFont];
    self.L_contect.numberOfLines = 0;
    self.L_contect.preferredMaxLayoutWidth = 200;
    [self.L_contect mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(8);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.mas_greaterThanOrEqualTo(20).priorityHigh();
        make.bottom.mas_equalTo(self.contentView).offset(-16);
    }];
    
//    self.L_contect.adjustsFontSizeToFitWidth = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
