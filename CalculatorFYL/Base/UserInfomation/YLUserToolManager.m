//
//  YLUserToolManager.m
//  yaoxinzjty
//
//  Created by 樊佑乐 on 2021/7/14.
//

#import "YLUserToolManager.h"
#import "YLNavigationViewController.h"



#define SearchTime 1
#define SearchDevicelocalTime 300
@interface YLUserToolManager()
//跑秒
@property(nonatomic,strong)dispatch_source_t timer;



@end
@implementation YLUserToolManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static YLUserToolManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YLUserToolManager alloc] init];
        
    });
    return instance;
}
+(BOOL)pushTologioVC{
    if (!ZJ_UserLoginInfomation.getLogin) {
        YLLoginViewController * vc = [[YLLoginViewController alloc]init];
        vc.type = LoginViewTypeFrompassword;
        YLNavigationViewController * nav = [[YLNavigationViewController alloc]initWithRootViewController:vc];
        nav.navigationBarHidden = YES;
        UIViewController * currectVC = [YLUserToolManager lz_getCurrentViewController];
        [currectVC.navigationController presentViewController:nav animated:YES completion:^{

        }];
        return YES;
    }
    return NO;
    
}
+ (UIViewController *)lz_getCurrentViewController{
    UIViewController* currentViewController = [self lz_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
+ (UIViewController *)lz_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    if ([window.rootViewController isKindOfClass:[YLTabBarViewController class]]) {
        YLTabBarViewController * tabbarVC = (YLTabBarViewController *)window.rootViewController;
        return tabbarVC.childViewControllers[tabbarVC.selectedIndex];
    }
    return window.rootViewController;

}
+(UIColor *)getAppMainColor{
    NSString * color_str = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColor];
    if (IS_VALID_STRING(color_str)) {
        UIColor * curretColor = [UIColor jk_colorWithHexString:color_str];
        return curretColor;
    }
    return UIColor.greenColor;
}
+(UIFont *)getAppTitleFont{
    NSString * title_font = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_TitleFont];
    if (IS_VALID_STRING(title_font)) {
        UIFont * font = [UIFont boldSystemFontOfSize:title_font.intValue];
        return font;
    }
    return [UIFont boldSystemFontOfSize:20];
}



@end
