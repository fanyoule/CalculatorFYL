//
//  FYLHistoricalRecordNewCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/30.
//

#import "FYLHistoricalRecordNewCell.h"

@implementation FYLHistoricalRecordNewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configeUI];
    }
    return self;
}
-(void)configeUI{
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = 0;

    [self.contentView addSubview:self.L_contect];
    self.L_contect.preferredMaxLayoutWidth = 200;
    [self.L_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.mas_greaterThanOrEqualTo(20).priorityHigh();
        make.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UILabel *)L_contect{
    if (!_L_contect) {
        _L_contect = [[UILabel alloc]init];
        _L_contect.font = [YLUserToolManager getAppTitleFont];
        _L_contect.numberOfLines = 0;
        _L_contect.textColor = UIColor.whiteColor;
    }
    return _L_contect;
}
@end
