//
//  FYLSettingsListCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/25.
//

#import "FYLSettingsListCell.h"

@implementation FYLSettingsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.L_hot.layer.cornerRadius = 16/2;
    self.L_hot.layer.masksToBounds = YES;
    
    
    // Initialization code
}
- (IBAction)didSelectedSwitchClicked:(UISwitch *)sender {
    
    
}

-(void)changeUIType:(NSInteger)type{
    self.M_sel.hidden = YES;
    
    switch (type) {
        case 0://标题+右侧内容+右侧icon
            {
                self.L_title.hidden = NO;
                self.M_right.hidden = NO;
                self.L_right_contect.hidden = NO;

                self.L_hot.hidden = YES;
                self.M_ar.hidden = YES;
                self.V_right_color.hidden = YES;
                self.V_switch.hidden = YES;
                self.L_contect.hidden = YES;
            }
            break;
        case 1://标题+hot+右侧icon
            {
                self.L_title.hidden = NO;
                self.M_right.hidden = NO;
                self.L_hot.hidden = NO;
                
                self.M_ar.hidden = YES;
                self.L_right_contect.hidden = YES;
                self.V_right_color.hidden = YES;
                self.V_switch.hidden = YES;
                self.L_contect.hidden = YES;
            }
            break;
        case 2://标题+ar+右侧内容+右侧icon
            {
                self.L_title.hidden = NO;
                self.M_right.hidden = NO;
                self.M_ar.hidden = NO;
                self.L_right_contect.hidden = NO;
                
                self.L_hot.hidden = YES;
                self.V_right_color.hidden = YES;
                self.V_switch.hidden = YES;
                self.L_contect.hidden = YES;
            }
            break;
        case 3://标题+右侧color+右侧icon
            {
                self.L_title.hidden = NO;
                self.M_right.hidden = NO;
                self.V_right_color.hidden = NO;

                self.L_right_contect.hidden = YES;
                self.M_ar.hidden = YES;
                self.L_hot.hidden = YES;
                self.V_switch.hidden = YES;
                self.L_contect.hidden = YES;
            }
            break;
        case 4://标题+右侧开关
            {
                self.L_title.hidden = NO;
                self.V_switch.hidden = NO;
                
                self.M_right.hidden = YES;
                self.V_right_color.hidden = YES;
                self.L_right_contect.hidden = YES;
                self.M_ar.hidden = YES;
                self.L_hot.hidden = YES;
                self.L_contect.hidden = YES;
                
            }
            break;
        case 5://内容
            {
                self.L_contect.hidden = NO;
                self.L_title.hidden = YES;
                self.V_switch.hidden = YES;
                self.M_right.hidden = YES;
                self.V_right_color.hidden = YES;
                self.L_right_contect.hidden = YES;
                self.M_ar.hidden = YES;
                self.L_hot.hidden = YES;
                
                
            }
            break;
        case 6://选中按钮 + 标题
            {
                self.L_contect.hidden = YES;
                self.L_title.hidden = NO;
                self.V_switch.hidden = YES;
                self.M_right.hidden = YES;
                self.V_right_color.hidden = YES;
                self.L_right_contect.hidden = YES;
                self.M_ar.hidden = YES;
                self.L_hot.hidden = YES;
                
                
            }
            break;
        default:
            break;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
