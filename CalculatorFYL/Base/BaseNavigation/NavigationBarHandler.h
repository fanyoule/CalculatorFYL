//
//  NavigationBarHandler.h
//  JoyLight
//
//  Created by tianhao on 2023/4/3.
//

#import <Foundation/Foundation.h>
#define NB_BTN_WH 44.0f
NS_ASSUME_NONNULL_BEGIN

@interface NavigationBarHandler : NSObject
+ (UIButton *)backButtonTarget:(id)target action:(SEL)selector;

+ (UIButton *)buttonTarget:(id)target action:(SEL)sel normalImg:(NSString *)normalImg;

+ (UIButton *)buttonTarget:(id)target action:(SEL)sel normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg;

+ (UIButton *)buttonTarget:(id)target action:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonTarget:(id)target action:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg;


@end

NS_ASSUME_NONNULL_END
