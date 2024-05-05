//
//  ToolManagement.m
//  DayBetter
//
//  Created by zhangzhen on 2022/3/31.
//

#import "ToolManagement.h"
#import "YLHomeViewController.h"
#import "AppDelegate.h"
#import "YLNavigationViewController.h"


@implementation ToolManagement

+ (instancetype)sharedManager
{
    static ToolManagement *toolManagement = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolManagement = [self new];
    });
    return toolManagement;
    
}
+ (BOOL)isIPhoneNotchScreen{
    BOOL result = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return result;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            result = YES;
        }
    }
    return result;
}

+ (CGFloat)getIPhoneNotchScreenHeight{
    /*
     * iPhone8 Plus  UIEdgeInsets: {20, 0, 0, 0}
     * iPhone8       UIEdgeInsets: {20, 0, 0, 0}
     * iPhone XR     UIEdgeInsets: {44, 0, 34, 0}
     * iPhone XS     UIEdgeInsets: {44, 0, 34, 0}
     * iPhone XS Max UIEdgeInsets: {44, 0, 34, 0}
     */
    CGFloat bottomSpace = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets;
        switch (UIApplication.sharedApplication.statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
            {
                bottomSpace = safeAreaInsets.bottom;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:
            {
                bottomSpace = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:
            {
                bottomSpace = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                bottomSpace = safeAreaInsets.top;
            }
                break;
            default:
            {
                bottomSpace = safeAreaInsets.bottom;
            }
                break;
        }
    }
    return bottomSpace;
}
+ (NSString *)appVersion{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取app版本信息
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildNumber{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取app版本信息
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];;
}

- (void)enterTheHomePage{
    UIWindow *window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    window.backgroundColor =[UIColor whiteColor];
    //    if ([[UserManagement sharedManager]isLoad] == YES) {
    YLTabBarViewController *vc = [[YLTabBarViewController alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
}
-(void)enterTheWindowRootVC{
    [self enterTheHomePage];
}



// 返回状态栏高度
- (CGFloat)statusBarHeight{
    
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        // Fallback on earlier versions
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    
    return statusBarHeight;
}

//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)time];
    return timeString;
}
/**
 *时间戳 加减时间
 *messageTime  十三位时间戳（精确到毫秒）
 *index     差值
 */
-(NSString *)fyl_TimeStampPlusOrMinus:(NSString *)messageTime withIndex:(double)index{
    NSTimeInterval time=[messageTime doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    detailDate = [detailDate dateByAddingTimeInterval:index]; //正数是加，负数是减
    NSTimeInterval time_xx=[detailDate timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)time_xx];
    return timeString;
}

//获取当前时间戳(精确秒)
- (NSString *)currentTimeSS_Str{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)time];
    return timeString;
}
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
- (NSString *)yl_getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
// 时间戳转时间
- (NSString *)getTheTimeYouWantBasedOnTheTimestampWithTimeStamp:(NSString *)timeStamp format:(NSString *)format{
    NSTimeInterval time=[timeStamp doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //设定时间的格式
    NSLog(@"dateFormatter == %@",dateFormatter);
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

// 字符串转date
- (NSDate *)theStringToTurnWithString:(NSString *)str{
    NSLog(@"str == %@",str);
     //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date = [formatter dateFromString:str];
    NSLog(@"date == %@",date);
    return date;
}

- (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp{
    // 时间戳转日期
    
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];

    return dateStr;
}
// 时间戳转string
- (NSString *)timestampToStringWithDate:(NSDate *)date{
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
// 获取当前日期字符串
- (NSString *)getsTheCurrentDateString{
    return [[ToolManagement sharedManager]yl_getDateStringWithTimeStr:[[ToolManagement sharedManager]currentTimeStr]];
}
// 日期时间增加 返回一个增加时间的日期
- (NSString *)timeIncreasedWithDateString:(NSString *)DateString Seconds:(NSInteger)seconds{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:DateString];
    NSTimeInterval timeInterval = seconds;
    NSDate *nextDay = [NSDate dateWithTimeInterval:timeInterval sinceDate:date];
    NSTimeInterval time =[nextDay timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return [[ToolManagement sharedManager]timeWithYearMonthDayCountDown:timeString];
}
// 时间差计算
- (NSInteger)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2{
// 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
// 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
// 4.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
//    hour * 3600 + minute * 60 + secound
    NSInteger timeDifference = cmps.hour *3600 + cmps.minute * 60 + cmps.second;
    NSLog(@"时间差 %ld",timeDifference);
    return timeDifference;
}
// 生成一个字节的data
+ (NSData *)generatedByte:(Byte)byte{
    Byte by[1] = {byte};
    return [[NSData alloc]initWithBytes:by length:1];
}
#pragma mark - 设置/获取 播放模式
- (void)setPlayMode:(NSInteger)playMode{
    [[NSUserDefaults standardUserDefaults] setInteger:playMode forKey:@"playMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)getPlayMode{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"playMode"] integerValue];
}


#pragma mark 十进制转二进制
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSInteger)decimal {
    NSInteger num = decimal;
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    NSString * prepare = @"";
    while (true){
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];
        if (divisor == 0){
            break;
        }
    }
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --){
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    while (result.length < 8){
        NSString *zero = @"0";
        result = [zero stringByAppendingString:result];
    }
    NSLog(@"week result == %@",result);
    return result;
}

//获取App名称
+ (NSString *)getTheAppName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}


// 模拟转盘震动
- (void)simulateTheVibrationOfTheTurntable{
    if([self whetherToTurnOnHapticFeedback] == NO){
        return;
    }
    UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
    [generator selectionChanged];
}
// 模拟按钮触觉反馈
- (void)analogButtonTactileFeedback{
    if([self whetherToTurnOnHapticFeedback] == NO){
        return;
    }
    UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
    [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
}
// 是否开启触觉反馈
- (BOOL)whetherToTurnOnHapticFeedback{
    NSString *str = UserDefaultObjectForKey(FYL_touchState);
    if(!IS_VALID_STRING(str)){
        return YES;
    }
    if([str isEqualToString:@"1"]){
        return YES;
    }else{
        return NO;
    }
}



// 获取当前手机系统语言
+ (NSString *)getsTheCurrentPhoneLanguage{
//    NSString *preferredLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    

    NSString *upperStr = [localeLanguageCode uppercaseStringWithLocale:[NSLocale currentLocale]];
    NSLog(@"语言 == %@",upperStr);
    return upperStr;
}
///data转str
+ (NSString *)hexStringFromData:(NSData *)data{
    NSAssert(data.length > 0, @"data.length <= 0");
    NSMutableString *hexString = [[NSMutableString alloc] init];
    const Byte *bytes = data.bytes;
    for (NSUInteger i=0; i<data.length; i++) {
        Byte value = bytes[i];
        Byte high = (value & 0xf0) >> 4;
        Byte low = value & 0xf;
        [hexString appendFormat:@"%x%x", high, low];
    }
    return hexString;
}
+ (NSString*)getzh_CNLocaleWithData:(NSString *)format date:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:format];
       // 指定local,真机调试，转换时间 需要设置 NSLocale
       NSLocale *zh_CNLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//zh_CN  en_US en_GB zh_Hans_CN
       formatter.locale =zh_CNLocale;
       formatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
       formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    return [formatter stringFromDate:date];
    
}
//WIFI的MAC转蓝牙Mac地址
- (NSString *)addWiFiMac:(NSString *)wifiMac{
    NSString *str = [wifiMac substringFromIndex:wifiMac.length-2];
    NSString * cc = [self vmAddr:str offset:2];
    if(cc.length==1){cc = [NSString stringWithFormat:@"0%@",cc];}
    return [NSString stringWithFormat:@"%@%@",[wifiMac substringToIndex:wifiMac.length-2],cc];
}
//蓝牙Mac地址转WIFI的MAC
- (NSString *)yl_addWiFiMac:(NSString *)wifiMac{
    NSString *str = [wifiMac substringFromIndex:wifiMac.length-2];
    NSString * cc = [self yl_vmAddr:str offset:2];
    if(cc.length==1){cc = [NSString stringWithFormat:@"0%@",cc];}
    return [NSString stringWithFormat:@"%@%@",[wifiMac substringToIndex:wifiMac.length-2],cc];
}

// 十六进制算数运算，加法
- (NSString *)vmAddr:(NSString *)base offset:(int)offset {
    uint64_t addr = 0;
    [[NSScanner scannerWithString:base] scanHexLongLong:&addr];
    uint64_t newAddr = addr + offset;
    return [NSString stringWithFormat:@"%llx", newAddr];
}
// 十六进制算数运算，减法
- (NSString *)yl_vmAddr:(NSString *)base offset:(int)offset {
    uint64_t addr = 0;
    [[NSScanner scannerWithString:base] scanHexLongLong:&addr];
    uint64_t newAddr = addr - offset;
    return [NSString stringWithFormat:@"%llx", newAddr];
}

- (NSString *)getParamByName:(NSString *)name URLString:(NSString *)url {

    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)", name];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
     
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}

///展示时间 （11:00）
+(NSString *)displayTimeAccordingToSystemFormat:(NSString *)time_24{
    if(!IS_VALID_STRING(time_24)){return @"00:00";}
    NSString * timeType = [[NSUserDefaults standardUserDefaults]objectForKey:@"timeType"];
    if(timeType.intValue==0){//12小时制
        NSArray * time_arr = [time_24 componentsSeparatedByString:@":"];
        NSString * H_star = time_arr.firstObject;
        NSString * M_star = time_arr.lastObject;
        NSString * starTime_AM = H_star.intValue>=12? NSLocalizedString(@"PM", nil):NSLocalizedString(@"AM", nil);
        if(H_star.intValue>12){
            H_star = [NSString stringWithFormat:@"%d",H_star.intValue-12];
        }
        return  [NSString stringWithFormat:@"%02d:%02d %@",H_star.intValue,M_star.intValue,starTime_AM];
    }
    return time_24;
}

// 获取手机型号
-(NSString  *)iphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE(2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE (3rd generation)";
    if ([platform isEqualToString:@"iPhone14,7"]) return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone14,8"]) return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,2"]) return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,3"]) return @"iPhone 14 Pro Max";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
 }

// 获取系统版本
- (NSString *)getTheSystemVersion{
    NSString * phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
@end
