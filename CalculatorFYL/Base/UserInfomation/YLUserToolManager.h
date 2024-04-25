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
/**
 * 0 插入备注
 * 1备注
 * 2完成
 * 3存档
 * 4清空
 * 5保存当前记录
 * 6打开本地存档
 * 7取消
 * 8确定
 * 9设置
 * 10恢复
 * 11删除
 * 12升级VIP(无广告+语音报数)
 * 13音效
 * 14主题
 * 15触感
 * 16键盘
 * 17字体大小
 * 18小数位数
 * 19千分位 9,999
 * 20日期
 * 21量级
 * 22语言
 * 23回收站
 * 24帮助反馈
 * 25分享
 * 26赏个好评吧
 */
+(NSString *)getTextTag:(NSInteger)tag;



@end

NS_ASSUME_NONNULL_END
