//
//  NavigationBarHandler.m
//  JoyLight
//
//  Created by tianhao on 2023/4/3.
//

#import "NavigationBarHandler.h"

@implementation NavigationBarHandler
+ (UIButton *)backButtonTarget:(id)target action:(SEL)selector
{
    UIButton *bleft = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NB_BTN_WH, NB_BTN_WH)];
    [bleft setImage:[UIImage imageNamed:@"backImage_white"] forState:UIControlStateNormal];
    [bleft setImage:[UIImage imageNamed:@"backImage_white"] forState:UIControlStateSelected];
    bleft.selected = NO;
    [bleft setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [bleft addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return bleft;
}


+(UIButton *)buttonTarget:(id)target action:(SEL)sel normalImg:(NSString *)normalImg
{
    UIButton *bleft = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NB_BTN_WH, NB_BTN_WH)];
    [bleft setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [bleft addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return bleft;
}

+(UIButton *)buttonTarget:(id)target action:(SEL)sel normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg
{
    UIButton *bleft = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NB_BTN_WH, NB_BTN_WH)];
    [bleft setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [bleft setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
    
    [bleft addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return bleft;
}

+ (UIButton *)buttonTarget:(id)target action:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, NB_BTN_WH, NB_BTN_WH);
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+ (UIButton *)buttonTarget:(id)target action:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, NB_BTN_WH, NB_BTN_WH);
    [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
