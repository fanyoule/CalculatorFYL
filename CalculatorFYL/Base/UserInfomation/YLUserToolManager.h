//
//  YLUserToolManager.h
//  yaoxinzjty
//
//  Created by 樊佑乐 on 2021/7/14.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@protocol YLUserToolManagerDelegate <NSObject>

-(void)refreshIphoneConnectionState;


@end
@interface YLUserToolManager : NSObject
+(instancetype)sharedManager;
@property(nonatomic,weak)id<YLUserToolManagerDelegate>delegate;

//手机数据 开启情况 0未开启  1移动数据 2wifi数据 3未知数据
@property(nonatomic,assign)NSInteger networkState;
@property(nonatomic,assign)NSInteger networkOldState;
//手机蓝牙 开启情况 no关 yes开
@property(nonatomic,assign)BOOL isOnBLEState;




//获取当前视图
+ (UIViewController *)lz_getCurrentViewController;
+ (UIViewController *)lz_getRootViewController;

///未登录 跳转至登录也
+(BOOL)pushTologioVC;
//退出登录清空本地数据
-(void)detaleUserModelAndDeviceModel;
///获取当前主题色
+(UIColor *)getAppMainColor;
///获取当前字号
+(UIFont *)getAppTitleFont;




@end

NS_ASSUME_NONNULL_END
