//
//  FYLVerificationCodeLoginViewController.h
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//
typedef enum {
    VerificationCodeTypeFromLogin = 0,//验证码登录
    VerificationCodeFromSign,//账号注册
    VerificationCodeFromForgotPassword//忘记密码
}VerificationCodeType;

#import "FYLLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLVerificationCodeLoginViewController : FYLLoginBaseViewController
@property(nonatomic,assign)VerificationCodeType type;
@property(nonatomic,copy)NSString * eamal;
@property(nonatomic,copy)NSString * uuid;//验证码uuid


@end

NS_ASSUME_NONNULL_END
