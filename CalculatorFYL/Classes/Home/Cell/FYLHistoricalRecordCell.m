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
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
