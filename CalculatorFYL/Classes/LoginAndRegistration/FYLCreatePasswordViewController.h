//
//  FYLCreatePasswordViewController.h
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLCreatePasswordViewController : FYLLoginBaseViewController
@property(nonatomic,copy)NSString * uuid;
@property(nonatomic,copy)NSString * email;
/// 1注册  2忘记密码
@property(nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
