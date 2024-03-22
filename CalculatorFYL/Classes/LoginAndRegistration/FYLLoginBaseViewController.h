//
//  FYLLoginBaseViewController.h
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLLoginBaseViewController : BaseViewController

@property (nonatomic, strong)UIView * V_bg_contect;

/**
 * 获取 当前是国内 or 国外
 * 1国内  0国外
 */
-(NSInteger)fyl_getLocalAddressType;
///更改标题
-(void)changeTitle:(NSString *)title;
///创建的按钮被点击了
-(void)didSelectedBaseButtonClicked:(UIButton *)btn;
-(NSArray *)creatTextFieldHolderText:(NSString *_Nullable)holderText withTextFont:(UIFont *_Nullable)font withTextColor:(UIColor *_Nullable)textColor withTag:(NSInteger)tag;
-(UIButton *)creatButtonTitle:(NSString *_Nullable)title withFont:(UIFont *_Nullable)font withTitleColor:(UIColor *_Nullable)color withImageName:(NSString *_Nullable)imageName withBackGroundColor:(UIColor *_Nullable)bgColor withTag:(NSInteger)tag;
-(void)openSocketUrl;

@end

NS_ASSUME_NONNULL_END
