//
//  FYLThemeCollectionViewCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import "FYLThemeCollectionViewCell.h"

@implementation FYLThemeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.V_bg.layer.cornerRadius = 6.0f;
    self.V_bg.layer.masksToBounds = YES;
    
    // Initialization code
}

@end
