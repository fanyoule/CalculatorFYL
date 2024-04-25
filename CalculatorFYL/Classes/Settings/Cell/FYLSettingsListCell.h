//
//  FYLSettingsListCell.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYLSettingsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *L_title;
@property (weak, nonatomic) IBOutlet UILabel *L_hot;

@property (weak, nonatomic) IBOutlet UIImageView *M_ar;

@property (weak, nonatomic) IBOutlet UIImageView *M_right;

@property (weak, nonatomic) IBOutlet UIView *V_right_color;

@property (weak, nonatomic) IBOutlet UISwitch *V_switch;
@property (weak, nonatomic) IBOutlet UILabel *L_right_contect;
@property (weak, nonatomic) IBOutlet UIView *V_line;
@property (weak, nonatomic) IBOutlet UILabel *L_contect;
-(void)changeUIType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
