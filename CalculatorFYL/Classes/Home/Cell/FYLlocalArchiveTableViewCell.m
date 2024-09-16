//
//  FYLlocalArchiveTableViewCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/20.
//

#import "FYLlocalArchiveTableViewCell.h"

@implementation FYLlocalArchiveTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = 0;
        [self configeUI];
    }
    return self;
}
-(void)configeUI{
    
    self.backgroundColor = rgba(33, 32, 34, 1);
    [self.contentView addSubview:self.M_right];
    [self.M_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(12, 21));
    }];
    
    
    
    [self.contentView addSubview:self.L_number];
    [self.L_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.M_right.mas_left).mas_offset(-4);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.L_contect];
    [self.L_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.leading.equalTo(self.contentView.mas_leading).offset(20.0);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-50.0);
    }];
    [self.contentView addSubview:self.V_line];
    [self.V_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.L_contect);
        make.bottom.and.right.mas_equalTo(self.contentView);
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
        _L_contect.font = Px34Font;
        _L_contect.numberOfLines = 0;
        _L_contect.textColor = UIColor.whiteColor;
    }
    return _L_contect;
}
-(UIView *)V_line{
    if (!_V_line) {
        _V_line = [[UIView alloc]init];
        _V_line.backgroundColor = LineBackgroundColor;
    }
    return _V_line;
}
-(UILabel *)L_number{
    if (!_L_number) {
        _L_number = [[UILabel alloc]init];
        _L_number.font = Px34Font;
        _L_number.numberOfLines = 1;
        _L_number.textColor = UIColor.groupTableViewBackgroundColor;
    }
    return _L_number;
}
-(UIImageView *)M_right{
    if (!_M_right) {
        _M_right = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"socketRight_icon"]];
       
    }
    return _M_right;
}



@end
