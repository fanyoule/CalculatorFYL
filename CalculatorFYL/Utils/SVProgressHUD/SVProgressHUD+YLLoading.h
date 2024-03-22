//
//  SVProgressHUD+YLLoading.h
//  DayBetter
//
//  Created by tianhao on 2022/11/30.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (YLLoading)
//显示文本信息or加载圈
+ (void)showDetailMessage:(NSString *)message  delay:(NSTimeInterval)delay;
+ (void)showError:(NSString *)error delay:(NSTimeInterval)delay;
+ (void)yl_showSuccess:(NSString *)success  delay:(NSTimeInterval)delay;
//图+文
+ (void)show:(NSString *)text icon:(NSString *)iconName  delay:(NSTimeInterval)delay;
//显示长文本信息+加载圈 + 超时处理
+ (void)showStatus:(NSString *)message delay:(NSTimeInterval)delay;


@end

NS_ASSUME_NONNULL_END
