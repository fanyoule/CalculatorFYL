//
//  ZZAlertViewTools.m
//  HIBEX
//
//  Created by zhangzhen on 2018/6/6.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import "ZZAlertViewTools.h"
#import <AVFoundation/AVFoundation.h>
//#import "WBQRCodeVC.h"
#define RootVC  [[UIApplication sharedApplication] keyWindow].rootViewController
@interface ZZAlertViewTools ()

@property (nonatomic, copy) AlertViewBlock block;

@end
@implementation ZZAlertViewTools
#pragma mark - 对外方法
+ (ZZAlertViewTools *)shareInstance {
    static ZZAlertViewTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}




- (void)QRCodeScanVC:(UIViewController *)scanVC selfVc:(UIViewController *)vc {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [vc.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [vc.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [vc presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [vc presentViewController:alertC animated:YES completion:nil];
}


/**
 *  创建提示框
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param confirm      点击确认按钮的回调
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
          confirm:(AlertViewBlock)confirm {
    if([title isEqualToString:@"Tip"]){
        title = @"";
    }
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                    confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
}


/**
 *  创建提示框(可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                   confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
    
}


/**
 *  创建菜单(Sheet)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param confirm      点击确认按钮的回调
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
          confirm:(AlertViewBlock)confirm {
    
    
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray  confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
}

/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle= va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    
    
    // 显示菜单提示框
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
    
}


#pragma mark - ----------------内部方法------------------

//UIAlertController(iOS8及其以后)
- (void)p_showAlertController:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   titleArray:(NSArray *)titleArray
                      confirm:(AlertViewBlock)confirm {
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, nil)
                                                                    message:NSLocalizedString(message,nil)
                                                             preferredStyle:UIAlertControllerStyleAlert];
    // 下面两行代码 是修改 title颜色和字体的代码
    //    NSAttributedString *attributedMessage = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f], NSForegroundColorAttributeName:UIColorFrom16RGB(0x334455)}];
    //    [alert setValue:attributedMessage forKey:@"attributedTitle"];
    if (cancelTitle) {
        // 取消
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(cancelTitle, nil)
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  if (confirm)confirm(cancelIndex);
                                                              }];
        [alert addAction:cancelAction];
    }
    // 确定操作
    if (!titleArray || titleArray.count == 0) {
        UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Make sure",@"确定")
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (confirm)confirm(0);
                                                               }];
        
        [alert addAction:confirmAction];
    } else {
        
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:NSLocalizedString(titleArray[i], nil)
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            // [action setValue:UIColorFrom16RGB(0x00AE08) forKey:@"titleTextColor"]; // 此代码 可以修改按钮颜色
            [alert addAction:action];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController * currectVC = [PublicHelpers lz_getCurrentViewController];
        [currectVC presentViewController:alert animated:YES completion:nil];
    });
    
    
//    UIWindow *alertWindow = [[UIApplication sharedApplication].windows lastObject];;
//    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}


// ActionSheet的封装
- (void)p_showSheetAlertController:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        titleArray:(NSArray *)titleArray
                           confirm:(AlertViewBlock)confirm {
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:IS_VALID_STRING(title)?NSLocalizedString(title, nil):nil
                                                                   message:IS_VALID_STRING(message)?NSLocalizedString(message, nil):nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if (!cancelTitle) cancelTitle = NSLocalizedString(@"Cancel",@"取消");
    // 取消
    UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (confirm)confirm(cancelIndex);
                                                          }];
    [cancelAction setValue:rgba(51, 51, 51, 1) forKey:@"titleTextColor"];
    [sheet addAction:cancelAction];
    
    if (titleArray.count > 0) {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            [action setValue:rgba(51, 51, 51, 1) forKey:@"titleTextColor"];
            [sheet addAction:action];
        }
    }
//    UIWindow *alertWindow = [[UIApplication sharedApplication].windows lastObject];
    UIWindow *alertWindow = [UIApplication sharedApplication].keyWindow;
    [alertWindow.rootViewController presentViewController:sheet animated:YES completion:nil];
    
}


@end
