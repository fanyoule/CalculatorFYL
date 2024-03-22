//
//  YLLoginViewController.h
//  DayBetter
//
//  Created by tianhao on 2022/11/30.
//
typedef enum {
    LoginViewTypeFrompassword = 0,//密码登录
    LoginViewTypeFromVerificationCode,//验证码登录
    LoginViewTypeFromToken400//token过期
}LoginType;
#import "FYLLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLLoginViewController : FYLLoginBaseViewController
@property(nonatomic,assign)LoginType type;

@property(nonatomic, strong)  UIImageView * protocolImgView;
@property(nonatomic, strong)  UIButton * agreementBtn ;

@end

NS_ASSUME_NONNULL_END
