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
//    self.selectionStyle = 0;
    [self.contentView addSubview:self.L_contect];
    [self.L_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        make.leading.equalTo(self.contentView.mas_leading).offset(10.0);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10.0);
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
