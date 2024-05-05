//
//  AppDelegate.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/21.
//

#import "AppDelegate.h"
#import "LSSafeProtector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#ifdef DEBUG
    [LSSafeProtector openSafeProtectorWithIsDebug:YES block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
        NSLog(@"崩溃类型:%@ ---%@ ",exception.name,[NSString stringWithFormat:@"崩溃原因:%@  崩溃位置:%@",exception.reason,exception.userInfo[@"location"]]);
    }];
#else
    [LSSafeProtector openSafeProtectorWithIsDebug:NO block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
//        [YLWiFiToolManagement yl_UploadCrashLogsShowLoading:NO withCrashType:[NSString stringWithFormat:@"%@",exception.name] withCrashLocation:[NSString stringWithFormat:@"%@",exception.userInfo[@"location"]] withCrashCause:[NSString stringWithFormat:@"%@",exception.reason]];
    }];
#endif
    [[YXHTTPRequst shareInstance]monitoringNetworkStatus];// 检查网络状态
    [[ToolManagement sharedManager]enterTheWindowRootVC];// 进入app界面
    if (!IS_VALID_STRING(UserDefaultObjectForKey(FYL_TitleFont))) {
        UserDefaultSetObjectForKey(@"20", FYL_TitleFont)
    }
    if (!IS_VALID_STRING(UserDefaultObjectForKey(FYL_DecimalPlace))) {
        UserDefaultSetObjectForKey(@"8", FYL_DecimalPlace)
    }
    
    
    
    return YES;
}



@end
