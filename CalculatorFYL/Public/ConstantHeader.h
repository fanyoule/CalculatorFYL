//
//  ConstantHeader.h
//  XLDemo
//
//  Created by bilin on 16/8/11.
//  Copyright © 2016年 lixueliang. All rights reserved.
//存放一些尺寸,像屏幕宽度, 高度; 或者一些颜色

#ifndef ConstantHeader_h
#define ConstantHeader_h
// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

//#endif /* PrefixHeader_pch */

//----------------------ABOUT SCREEN & SIZE 屏幕&尺寸 ----------------------------
/**
 iPad Air {{0, 0}, {768, 1024}}
 iphone4s {{0, 0}, {320, 480}}     960*640
 iphone5 5s {{0, 0}, {320, 568}}      1136*640
 iphone6 6s {{0, 0}, {375, 667}}     1334*750
 iphone6Plus 6sPlus {{0, 0}, {414, 736}}  1920*1080
 Apple Watch 1.65inches(英寸) 320*640
 */

#define ScreenBounds ([UIScreen mainScreen].bounds)
#define IPHONE4SHEIGHT [UIScreen mainScreen].bounds.size.height == 480//iphone4s 屏幕高
#define IPHONE5HEIGHT  [UIScreen mainScreen].bounds.size.height == 568//iphone5 屏幕高
#define IPHONE6PHEIGHT [UIScreen mainScreen].bounds.size.height == 736//iphone6p 屏幕高
#define IPHONE6HEIGHT [UIScreen mainScreen].bounds.size.height == 667//iphone6 屏幕高

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)


#define kTabBarH        49.0f
#define kStatusBarH     20.0f
#define kNavigationBarH 44.0f
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#define XFSW(w) ((w)*((float)kScreenWidth/375.f))
#define XFSH(h) ((h)*((float)kScreenHeight/667.f))

#define kScreenWidthRatio  (kScreenWidth / 375.0)
#define kScreenHeightRatio (kScreenHeight / 667.0)
#define AdaptedWidthValue(x)  (ceilf((x) * kScreenWidthRatio))
#define AdaptedHeightValue(x) (ceilf((x) * kScreenHeightRatio))
#define kUHSystemFontWithSize(R)    [UIFont systemFontOfSize:(AdaptedWidthValue(R))]
///keyWindow
#define YX_Keywindow [[UIApplication sharedApplication].windows lastObject]

//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//2436 x 1125    375 812
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)



//----------------------ABOUT SYSTYM & VERSION 系统与版本 ----------------------------
//Get the OS version.       判断操作系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
// 状态栏(statusbar)
#define State_barHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//judge the simulator or hardware device        判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


#ifndef x_weak
#define x_weak(ins) __weak typeof(ins) weak##ins = ins;
#endif

/** 获取系统版本 */
#define iOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)
/** 正好是IOS7*/
#define xlIOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0) ? YES : NO)
/** 是否为iOS7 */
#define iOS73 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

/** 是否为iOS10 */
#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)
#define iOS11 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) ? YES : NO)

#define FontName  iOS9 ? @"PingFang-SC-Light" : @"Heiti SC"


/** 获取当前语言 */
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//----------------------ABOUT COLOR 颜色相关 ----------------------------
//ios10 新颜色属性
#define RGB3COLOR(r,g,b) [UIColor colorWithDisplayP3Red:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define   RGB(r,g,b)          [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorHEXAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define kClearColor [UIColor clearColor]
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0]
/** APP主题色 */
#define MainColorRGBValue 0xF6F6F6
#define DiyBGRGBValue @"#312F33"//diy网格背景色

#define LineBackgroundColor RGBCOLOR(234,239,241)//线的颜色
#define kcaseDetailRGB RGBCOLOR(70, 61, 61)
#define ButtonBackGroudRGB RGBCOLOR(0, 164, 251)
#define BACKCOLOR rgba(238, 243, 248, 1)//所有背景色
#define TEXE_BOLD @"Helvetica-Bold" //加粗
#define MY_BOLD @"DINAlternate-Bold"
#define PINGFANGBOLD @"PingFangSC-Medium"

#define COLOR_BLUE_             UIColorFromRGB(0x41CEF2)
#define COLOR_GRAY_             UIColorFromRGB(0xababab) //171
#define COLOR_333               UIColorFromRGB(0x333333) //51
#define COLOR_666               UIColorFromRGB(0x666666) //102
#define COLOR_888               UIColorFromRGB(0x888888) //136
#define COLOR_999               UIColorFromRGB(0x999999) //153
#define COLOR_PLACEHOLD_        UIColorFromRGB(0xc5c5c5) //197
#define COLOR_RED_              UIColorFromRGB(0xff5400) //红色
#define COLOR_GREEN_            UIColorFromRGB(0x31d8ab)//绿色
#define COLOR_YELLOW_           UIColorFromRGB(0xffa200)//黄色
#define COLOR_SEPARATE_LINE     UIColorFromRGB(0xC8C8C8)//200
#define COLOR_LIGHTGRAY         COLOR(200, 200, 200, 0.4)//淡灰色

#define MAX_WIDTH_10        (kScreenWidth-20)
#define MAX_WIDTH_15        (kScreenWidth-30)

#define IPhoneXBottomV        30   //距离下部间距


//----------------------ABOUT IMAGE 图片 ----------------------------

//LOAD LOCAL IMAGE FILE     读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]


//DEFINE IMAGE      定义UIImage对象//    imgView.image = IMAGE(@"Default.png");

#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//DEFINE IMAGE      定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//BETTER USER THE FIRST TWO WAY, IT PERFORM WELL. 优先使用前两种宏定义,性能高于后面.


//----------------------SOMETHING ELSE 其他 ----------------------------

#define intToStr(S)    [NSString stringWithFormat:@"%d",S]

//
//#define NotificationWarning(msg) [JDStatusBarNotification showWithStatus:msg dismissAfter:2.0 styleName:JDStatusBarStyleWarning]
//
//#define NotificationError(msg) [JDStatusBarNotification showWithStatus:msg dismissAfter:2.0 styleName:JDStatusBarStyleError]
//
//#define NotificationSuccess(msg) [JDStatusBarNotification showWithStatus:msg dismissAfter:2.0 styleName:JDStatusBarStyleSuccess]


/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}


/**
 *
 * 获取/Documents/data.plist 路径
 */
#define PLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"] //edit the plist

#define TableViewCellDequeueInit(__INDETIFIER__) [tableView dequeueReusableCellWithIdentifier:(__INDETIFIER__)];

#define TableViewCellDequeue(__CELL__,__CELLCLASS__,__INDETIFIER__) \
{\
if (__CELL__ == nil) {\
__CELL__ = [[__CELLCLASS__ alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:__INDETIFIER__];\
}\
}
/**
 *  KEYWindow
 *
 *  @return window
 */
#define KEYWINDOW [UIApplication sharedApplication].keyWindow

//Show Alert, brackets is the parameters.       宏定义一个弹窗方法,括号里面是方法的参数
#define ShowAlert(string)    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning." message:string delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"OK"];[alert show];


/**define an API 定义一个API*/
#define APIURL                @"http://www.google.com"
/**login the API 登陆API*/
#define APILogin              [APIURL stringByAppendingString:@"Login"]


/**全局队列GCD*/
#define GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

/** 主队列GCD*/
#define GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)

/**NSUserDefaults 实例化*/
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/**单例化 一个类*/
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}
/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

//Printing while in the debug model and pop an alert.       模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif
/** print 打印rect,size,point */
#ifdef DEBUG
#define kLogPoint(point)    NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kLogSize(size)      NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kLogRect(rect)      NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif
// 空值判断
#define IsNullObject(obj) (obj == nil || obj == Nil || obj == NULL || [obj isKindOfClass:[NSNull class]] || ![obj isKindOfClass:[NSObject class]])
#define IsNullString(str) (IsNullObject(str) || ![str isKindOfClass:[NSString class]] || [str length] == 0)
#define IsNullData(data) (IsNullObject(data) || ![data isKindOfClass:[NSData class]] || [data length] == 0)
#define IsNullDictionary(dict) (IsNullObject(dict) || ![dict isKindOfClass:[NSDictionary class]] || [dict count] == 0)
#define XLStringSelector(SEL) NSStringFromSelector(@selector(SEL))

//判断数组是否为空
#define IS_VALID_ARRAY(array) (array && [array isKindOfClass:[NSArray class]] && [array count])
//标题栏高度
#define HeightOfTitleBar   [[UIApplication sharedApplication] statusBarFrame].size.height
// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.


#define ISITCHINESE [[InternationalJudgment shareInstance]isSimpleChinese]


#define linViewColor  RGBCOLOR(236, 236, 236)


#define BR_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 等比例适配系数
#define kScaleFit (BR_IS_IPHONE ? ((kScreenWidth < kScreenHeight) ? kScreenWidth / 375.0f : kScreenWidth / 667.0f) : 1.1f)

// 判断是否为X系列机型

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 13.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/*状态栏高度*/
#define SStatusBarHeight (CGFloat)(IPHONE_X?(44.0):(20.0))
/*导航栏高度*/
#define SNavBarHeight (44)
/*TabBar高度*/
#define STabBarHeight (CGFloat)(IPHONE_X?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define STopBarSafeHeight (CGFloat)(IPHONE_X?(44.0):(0))
/*底部安全区域远离高度*/
#define SBottomSafeHeight (CGFloat)(IPHONE_X?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define STopBarDifHeight (CGFloat)(IPHONE_X?(24.0):(0))
/*导航条和Tabbar总高度*/
#define SNavAndTabHeight (SNavBarAndStatusBarHeight + STabBarHeight)

///电池条高度
#define YX_StatusBarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
///导航栏高度
#define YX_NavViewHeight (YX_StatusBarHeight + 44.0f)
///tabBar安全区域
#define YX_TabbarSafetyZone ((kIsBangsScreen == YES) ? 34.0f : 0.0f)
///是否是齐刘海机型
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})


#define ZZMainWindow  [UIApplication sharedApplication].keyWindow
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;



#define Font(f)         [UIFont systemFontOfSize:f]//跟着系统字体走

//判断字符串是否为空
#define IS_VALID_STRING(string) !((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@"<null>"]|| [string isEqualToString:@"(null)"]|| [string isEqualToString:@"null"]|| [string isEqualToString:@"nil"] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)


/** 常用字体 */
#define Px110Font [UIFont fontWithName:@"PingFang-SC-Regular" size:55.0f]
#define Px86Font [UIFont fontWithName:@"PingFang-SC-Regular" size:43.0f]
#define Px60Font [UIFont fontWithName:@"PingFang-SC-Regular" size:30.0f]
#define Px48Font [UIFont fontWithName:@"PingFang-SC-Regular" size:24.0f]
#define Px46Font [UIFont fontWithName:@"PingFang-SC-Regular" size:23.0f]
#define Px44Font [UIFont fontWithName:@"PingFang-SC-Regular" size:22.0f]
#define Px40Font [UIFont fontWithName:@"PingFang-SC-Regular" size:20.0f]
#define Px38Font [UIFont fontWithName:@"PingFang-SC-Regular" size:19.0f]
#define Px36Font [UIFont fontWithName:@"PingFang-SC-Regular" size:18.0f]
#define Px34Font [UIFont fontWithName:@"PingFang-SC-Regular" size:17.0f]
#define Px32Font [UIFont fontWithName:@"PingFang-SC-Regular" size:16.0f]
#define Px30Font [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f]
#define Px28Font [UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f]
#define Px26Font [UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f]
#define Px24Font [UIFont fontWithName:@"PingFang-SC-Regular" size:12.0f]
#define Px22Font [UIFont fontWithName:@"PingFang-SC-Regular" size:11.0f]
#define Px20Font [UIFont fontWithName:@"PingFang-SC-Regular" size:10.0f]
#define Px18Font [UIFont fontWithName:@"PingFang-SC-Regular" size:9.0f]

#define PxM22Font [UIFont fontWithName:@"PingFang-SC-Medium" size:11.0f]
#define PxM24Font [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f]
#define PxM26Font [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f]
#define PxM28Font [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f]
#define PxM30Font [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0f]
#define PxM32Font [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
#define PxM34Font [UIFont fontWithName:@"PingFang-SC-Medium" size:17.0f]
#define PxM36Font [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f]
#define PxM40Font [UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f]
#define PxM48Font [UIFont fontWithName:@"PingFang-SC-Medium" size:24.0f]
#define PxM56Font [UIFont fontWithName:@"PingFang-SC-Medium" size:28.0f]
#define PxM60Font [UIFont fontWithName:@"PingFang-SC-Medium" size:30.0f]


#define PxMB22Font [UIFont boldSystemFontOfSize:11.0f]
#define PxMB24Font [UIFont boldSystemFontOfSize:12.0f]
#define PxMB26Font [UIFont boldSystemFontOfSize:13.0f]
#define PxMB28Font [UIFont boldSystemFontOfSize:14.0f]
#define PxMB30Font [UIFont boldSystemFontOfSize:15.0f]
#define PxMB32Font [UIFont boldSystemFontOfSize:16.0f]
#define PxMB34Font [UIFont boldSystemFontOfSize:17.0f]
#define PxMB36Font [UIFont boldSystemFontOfSize:18.0f]
#define PxMB40Font [UIFont boldSystemFontOfSize:20.0f]
#define PxMB48Font [UIFont boldSystemFontOfSize:24.0f]
#define PxMB56Font [UIFont boldSystemFontOfSize:28.0f]
#define PxMB60Font [UIFont boldSystemFontOfSize:30.0f]
#define PxMB80Font [UIFont boldSystemFontOfSize:40.0f]

#ifdef DEBUG
#define NSLog(formater,...) printf("log🧶 class: <%p %s:(%d) > method: %s \n%s\n", formater, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(formater), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(format, ...)
#endif

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* ConstantHeader_h */

