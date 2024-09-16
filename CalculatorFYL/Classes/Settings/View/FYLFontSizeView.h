//
//  FYLFontSizeView.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYLFontSizeView : UIView
<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_one;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_two;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_four;
@property (weak, nonatomic) IBOutlet UISlider *V_slider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_five;
@property (weak, nonatomic) IBOutlet UILabel *L_title;
@property (weak, nonatomic) IBOutlet UIView *V_bg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_keyboard_height;

-(void)creatUI;
@end

NS_ASSUME_NONNULL_END
