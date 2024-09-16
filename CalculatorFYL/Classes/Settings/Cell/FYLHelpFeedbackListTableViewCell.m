//
//  FYLHelpFeedbackListTableViewCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/6.
//

#import "FYLHelpFeedbackListTableViewCell.h"

@implementation FYLHelpFeedbackListTableViewCell
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
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-35);
        make.leading.equalTo(self.contentView.mas_leading).offset(10.0);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10.0);
    }];
    
    [self.contentView addSubview:self.L_time];
    [self.L_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.L_contect.mas_bottom).offset(5);
        make.leading.equalTo(self.contentView.mas_leading).offset(10.0);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10.0);
    }];
    UIView * V_line = [[UIView alloc]init];
    V_line.backgroundColor = LineBackgroundColor;
    [self.contentView addSubview:V_line];
    [V_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.5);
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
        _L_contect.font = [UIFont boldSystemFontOfSize:20];
        _L_contect.numberOfLines = 0;
        _L_contect.textColor = UIColor.whiteColor;
    }
    return _L_contect;
}
-(UILabel *)L_time{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        _L_time.font = [UIFont boldSystemFontOfSize:18];
        _L_time.numberOfLines = 1;
        _L_time.textColor = rgba(51, 51, 51, 1);
    }
    return _L_time;
}

@end
