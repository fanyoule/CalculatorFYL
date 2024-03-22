//
//  MBProgressHUD+XBLoading.h
//  XBLoadingKit
//
//  Created by jianwen ning on 16/04/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//  对MBProgressHUD的一个简单封装，主要是满足常用的显示成功、出错、失败，loading加载提示，与及长文本提示信息

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (XBLoading)
@property(nonatomic,assign)BOOL canceled;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view delay:(NSTimeInterval)delay;
+ (void)showError:(NSString *)error toView:(UIView *)view delay:(NSTimeInterval)delay;
+ (void)showWarning:(NSString *)warning toView:(UIView *)view delay:(NSTimeInterval)delay;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)warning toView:(UIView *)view;


+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay;

//显示长文本信息
//+ (void)showDetailMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay;
//加载进度
+ (void)yl_ProgressDeterminateExampletoView:(UIView *)view;
+ (void)yl_doSomeWorkWithProgresstoView:(UIView *)view withProgress:(float)progress;

/// 自定义显示动画
+ (MBProgressHUD *)showCustomizeLoading:(UIView *)view title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
