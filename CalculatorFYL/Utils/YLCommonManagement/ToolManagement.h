//
//  ToolManagement.h
//  DayBetter
//
//  Created by zhangzhen on 2022/3/31.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
NS_ASSUME_NONNULL_BEGIN
// 工具类
@interface ToolManagement : NSObject

+ (instancetype)sharedManager;



// 判断是否是刘海屏
+(BOOL)isIPhoneNotchScreen;
// 获取刘海屏高度
+(CGFloat)getIPhoneNotchScreenHeight;
// 获取版本号
+ (NSString *)appVersion;
// 获取Build号
+ (NSString *)appBuildNumber;
// 进入首页
- (void)enterTheHomePage;
//进入app
-(void)enterTheWindowRootVC;
// 返回状态栏高度
- (CGFloat)statusBarHeight;
//获取当前时间戳字符串
- (NSString *)currentTimeStr;
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str;
//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString:(NSString *)str;
- (NSString *)yl_getDateStringWithTimeStr:(NSString *)str;
// 字符串转date
- (NSDate *)theStringToTurnWithString:(NSString *)str;
// 时间戳转日期
- (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp;
// 时间戳转string
- (NSString *)timestampToStringWithDate:(NSDate *)date;
// 获取当前日期字符串
- (NSString *)getsTheCurrentDateString;
- (NSString *)yl_getsTheCurrentDateString;

// 日期时间增加 返回一个增加时间的日期
- (NSString *)timeIncreasedWithDateString:(NSString *)DateString Seconds:(NSInteger)seconds;
// 时间差计算
- (NSInteger)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2;
/**
 *时间戳 加减时间
 *messageTime  十三位时间戳（精确到毫秒）
 *index     差值
 */
-(NSString *)fyl_TimeStampPlusOrMinus:(NSString *)messageTime withIndex:(double)index;

// 模拟转盘震动
- (void)simulateTheVibrationOfTheTurntable;


//获取App名称
+ (NSString *)getTheAppName;

// 模拟按钮触觉反馈
- (void)analogButtonTactileFeedback;
///data转str
+ (NSString *)hexStringFromData:(NSData *)data;

#pragma mark - 获取当前语言
// 获取当前手机系统语言
+ (NSString *)getsTheCurrentPhoneLanguage;
// 获取手机型号
-(NSString  *)iphoneType;
// 获取系统版本
- (NSString *)getTheSystemVersion;
@end

NS_ASSUME_NONNULL_END
