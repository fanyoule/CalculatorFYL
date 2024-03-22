//
//  FYLForgotPasswordViewController.h
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//
typedef enum {
    ForgotPasswordTypeFromSign = 0,//注册
    ForgotPasswordTypeFromForgot,//忘记密码
}ForgotPasswordType;
#import "FYLLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLForgotPasswordViewController : FYLLoginBaseViewController
@property(nonatomic,assign)ForgotPasswordType type;
@property(nonatomic,copy)NSString * email;


@end

NS_ASSUME_NONNULL_END
