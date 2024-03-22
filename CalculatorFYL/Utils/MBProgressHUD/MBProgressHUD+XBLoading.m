//
//  MBProgressHUD+XBLoading.m
//  XBLoadingKit
//
//  Created by jianwen ning on 16/04/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//

#import "MBProgressHUD+XBLoading.h"
#import "LoadingStyleManager.h"

//来自于SDWebImage，保证任务在主线程执行
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

//static NSTimeInterval const kDelayTime = 2.0; //hud默认显示时长

@implementation MBProgressHUD (XBLoading)

#pragma mark - 显示基本信息

+ (void)show:(NSString *)text icon:(NSString *)iconName view:(UIView *)view delay:(NSTimeInterval)delay {
    
    if(text.length == 0){ return; }
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.layer.cornerRadius = 4.0;
    UIImageRenderingMode renderMode = UIImageRenderingModeAlwaysTemplate;
//    if(gray_background_style == [LoadingStyleManager sharedInstance].hudStyle){
//
//        //灰白色背景+icon和背景同色
//        renderMode = UIImageRenderingModeAlwaysTemplate;
//        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor; //单色背景
//    }
    if(dim_background_style == [LoadingStyleManager sharedInstance].hudStyle){
        
        //老版本样式，带透明度的黑色背景+白色icon
        renderMode = UIImageRenderingModeAlwaysOriginal;
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //黑色背景
        hud.contentColor = [UIColor whiteColor];
    }
    hud.label.text = text;
    
    UIImage *image = [[UIImage imageNamed:iconName] imageWithRenderingMode:renderMode];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    dispatch_main_async_safe(^{
        
        [hud hideAnimated:YES afterDelay:delay];
    });
}

#pragma mark - 显示带icon的信息，自定义时长

+ (void)showSuccess:(NSString *)success toView:(UIView *)view delay:(NSTimeInterval)delay {
    
    [self show:success icon:@"success" view:view delay:delay];
}

+ (void)showError:(NSString *)error toView:(UIView *)view delay:(NSTimeInterval)delay {
    
    [self show:error icon:@"error" view:view delay:delay];
}

+ (void)showWarning:(NSString *)warning toView:(UIView *)view delay:(NSTimeInterval)delay {
    
    [self show:warning icon:@"warning" view:view delay:delay];
}

#pragma mark - 显示带icon的信息，默认时长

+ (void)showError:(NSString *)error toView:(UIView *)view {
    
    [self show:error icon:@"error" view:view delay:[LoadingStyleManager sharedInstance].hudShowTime];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    
    [self show:success icon:@"success" view:view delay:[LoadingStyleManager sharedInstance].hudShowTime];
}

+ (void)showWarning:(NSString *)warning toView:(UIView *)view {
    
    [self show:warning icon:@"warning" view:view delay:[LoadingStyleManager sharedInstance].hudShowTime];
}

#pragma mark - 显示loading状态

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
    dispatch_main_async_safe(^{
        [self hideHUDForView:view animated:YES];
    });
    if(view == nil) view = [UIApplication sharedApplication].keyWindow;
    dispatch_async(dispatch_get_main_queue(), ^{
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.label.text = message;
        //    hud.label.font = [UIFont boldSystemFontOfSize:14];
        hud.label.textColor = UIColor.whiteColor;
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        //    //设置等待框背景色为黑色
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.removeFromSuperViewOnHide = YES;
    });
 
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay {
    
    //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
    dispatch_main_async_safe(^{
        [self hideHUDForView:view animated:YES];
    });
    
    if(view == nil) view = [UIApplication sharedApplication].keyWindow;
    dispatch_async(dispatch_get_main_queue(), ^{
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.label.text = message;
        //    hud.label.font = [UIFont boldSystemFontOfSize:14];
        hud.label.textColor = UIColor.whiteColor;
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        //    //设置等待框背景色为黑色
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.removeFromSuperViewOnHide = YES;
        
        dispatch_main_async_safe(^{
            [hud hideAnimated:YES afterDelay:delay];
        });
    });
}

//显示长文本信息
//+ (void)showDetailMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay {
//    if (!IS_VALID_STRING(message)) {
//        return;
//    }
//    if( message.length == 0){ return; }
//    
//    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.userInteractionEnabled = NO;
//    hud.bezelView.layer.cornerRadius = 4.0;
//    hud.detailsLabel.text = message;
//    hud.mode = MBProgressHUDModeText;
//    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
//    hud.center = view.center;
////    hud.offset = CGPointMake(0.f, [UIScreen mainScreen].bounds.size.height / 2);
//    hud.margin = 10;
//    
////    if(gray_background_style == [LoadingStyleManager sharedInstance].hudStyle){
////
////        //灰白色背景
////        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor; //单色背景
////    }
//    if(dim_background_style == [LoadingStyleManager sharedInstance].hudStyle){
//        
//        //老版本样式，带透明度的黑色背景
//        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //黑色背景
//        hud.contentColor = [UIColor whiteColor];
//    }
//    hud.removeFromSuperViewOnHide = YES;
//    
//    dispatch_main_async_safe(^{
//        
//        [hud hideAnimated:YES afterDelay:delay];
//    });
//}

//自定义
+ (MBProgressHUD *)showCustomizeLoading:(UIView *)view title:(NSString *)title {

    //自定义view
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:YES];
    //取消背景框
//    HUD.color = [UIColor whiteColor];
    HUD.backgroundColor = UIColor.whiteColor;
    
    UIImageView *customImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.68)];
    customImageView.backgroundColor = UIColor.whiteColor;
    customImageView.image = [UIImage imageNamed:@"loadingBGImg"];
    
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(-43, kScreenWidth*0.4-50, kScreenWidth, 50)];
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    [customImageView addSubview:images];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
//    label.backgroundColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [customImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(customImageView);
        make.top.mas_equalTo(images.mas_bottom).offset(10);
    }];
    
    for(int i = 1; i < 12 ; i++){
        NSString *imgName = [NSString stringWithFormat:@"load%d",i];
        [imageArray addObject:[UIImage imageNamed:imgName]];
    }
    
    images.animationDuration = 1.0;
    images.animationImages = imageArray;
    // 开始播放
    [images startAnimating];
    
    //自定义
    HUD.minSize = CGSizeMake(kScreenWidth - 40, kScreenWidth*0.68);
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.animationType = MBProgressHUDAnimationFade;
    HUD.customView = customImageView;
  
    return HUD;
}
+ (void)yl_ProgressDeterminateExampletoView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"Loading...";
    });
    
}
+ (void)yl_doSomeWorkWithProgresstoView:(UIView *)view withProgress:(float)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD HUDForView:view].progress = progress;
    });
}
@end
