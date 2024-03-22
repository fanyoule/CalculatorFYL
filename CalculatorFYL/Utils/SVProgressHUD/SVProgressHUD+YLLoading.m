//
//  SVProgressHUD+YLLoading.m
//  DayBetter
//
//  Created by tianhao on 2022/11/30.
//

#import "SVProgressHUD+YLLoading.h"
//任务在主线程执行
#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif


@implementation SVProgressHUD (YLLoading)

+ (void)show:(NSString *)text icon:(NSString *)iconName  delay:(NSTimeInterval)delay {
    if(text.length == 0){ return; }
    [SVProgressHUD peizhi];
    [SVProgressHUD showImage:[UIImage imageNamed:iconName] status:text];
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithDelay:delay completion:^{
        }];
    });
}
+ (void)yl_showSuccess:(NSString *)success  delay:(NSTimeInterval)delay {
    [SVProgressHUD peizhi];
    [SVProgressHUD showSuccessWithStatus:success];
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithDelay:delay completion:^{
        }];
    });
}

+ (void)showError:(NSString *)error delay:(NSTimeInterval)delay {
    [SVProgressHUD peizhi];
    [SVProgressHUD showErrorWithStatus:error];
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithDelay:delay completion:^{
        }];
    });
}

#pragma mark - 显示loading状态

//显示长文本信息
+ (void)showDetailMessage:(NSString *)message  delay:(NSTimeInterval)delay {
    [SVProgressHUD peizhi];

    if (!IS_VALID_STRING(message)) {
        [SVProgressHUD show];//单纯的加载圈
    }else{
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:message];
    }
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithDelay:delay completion:^{
        }];
    });
}
//显示长文本信息+加载圈 + 超时处理
+ (void)showStatus:(NSString *)message delay:(NSTimeInterval)delay {
    [SVProgressHUD peizhi];

    if (!IS_VALID_STRING(message)) {
        return;
    }
    [SVProgressHUD showWithStatus:message];
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithDelay:delay completion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
//                [SVProgressHUD showDetailMessage:NSLocalizedString(@"There is an error in the current operation, please try again later", nil) delay:2];
            });
           
        }];
       
    });
}

+(void)peizhi{
    [SVProgressHUD dismiss];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}

@end
