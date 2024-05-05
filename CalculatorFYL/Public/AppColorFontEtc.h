//
//  AppColorFontEtc.h
//  yueYue
//
//  Created by 张震 on 2020/7/3.
//  Copyright © 2020 张震. All rights reserved.
//

#ifndef AppColorFontEtc_h
#define AppColorFontEtc_h

#define YLTitleCluesAlertViewTag  99994
#define YLCurtainLampTextLetterBgWidth  6
#define YLCellListHeight 45

#define DINBOLD @"DINAlternate-Bold"
#define PFSemibold  @"PingFangSC-Semibold"
// 存储倒计时开启时的当前时间
#define STORECOUNTDOWNTIMEKEY @"STORECOUNTDOWNTIME"
// 存储倒计时应该关闭的时间
#define COUNYDOWNENDTIMEKEY @"COUNTDOWNENDTIME"
// 搜索蓝牙设备的筛选名字
#define BLUETOOTHFILTERNAME @"Magic"         //huancai
// 获取存在本地的模式的版本号 接口用
#define MODESELECTIONVERSION @"THEMAGICMODEINTERFACERETURNSTHECONTENT"
// 存储的model
#define CONTENTSOFTHECACHEDPATTERNBEATS @"THEINSTRUCTIONTOGETTHECACHE"
// 存储用户协议
#define YLGetUrlLanguage @"YLGetUrlLanguage"

// 存储的DIY数组
#define XYSTORETHEDIYARRAY @"XYSTORETHEDIYARRAY"
// 存储设备信息Model
#define STORAGEDEVICEINFORMATION @"STORAGEDEVICEINFORMATION"
// 获取当前网络状态的通知
#define REFRESHHOMEDATA @"refreshHomeData"
// 获取当前所在国家
#define CountriesAddress @"countries"
// 刷新Alexa授权
#define REFRESHALEXAAUTHORIZATION @"REFRESHALEXAAUTHORIZATION"


#define CCPlayStatusDidChangedNotifyKey      @"CCPlayStatusDidChangedNotifyKey"
#define     UpdateNavTitle                   @"UpdateNavTitle"
#define     LightSwitchOn                    @"LightSwitchOn"

#define     STOPMICROPHONE                   @"STOPMICROPHONE"
#define     STOPDEVICEMIC                    @"STOPDEVICEMIC"
// 刷新名称
#define     REFRESHTHENAME                   @"REFRESHTHENAME"

// 烟花音效是否开启
#define   FIREWORKSSOUNDEFFECT               @"FIREWORKSSOUNDEFFECT"

//用户的常用颜色
#define     USERCOMMONCOLORS                  @"USERCOMMONCOLORS"

//当前开发模式
#define     DevelopmentEnvironment            @"DevelopmentEnvironment"
//游客模式账号
#define     TouristAccountName                   @"1479660687@qq.com"
//设备连接方式改变
#define     RefreshDviceConnectionState                   @"RefreshDviceConnectionState"
//设备唯一标识改变
#define     RefreshDviceWifiName                   @"RefreshDviceWifiName"

#define HomePageKey          @"HomePage1.0.3"          // 引导图 移动按钮
#define RealIncomeKey        @"RealIncome1.0.3"        // 引导图 帧
//刷新全彩亮度
#define     YL_refreshFullColorBrightness1                   @"RefreshFullColorBrightness1"
#define     YL_refreshFullColorBrightness2                  @"RefreshFullColorBrightness2"
///登录成功
#define     FYL_LoginSeccessRefreshData                 @"LoginSeccess_refreshData"
///退出登录成功
#define     FYL_LoginOutSeccessRefreshData                 @"LoginOutSeccess_refreshData"

///APP主题色 key
#define     FYL_MainAppColor                @"MainAppColor"
#define     FYL_MainAppColorIndex                @"MainAppColorIndex"

///APP 文字字号
#define     FYL_TitleFont            @"MainAppTitleFont"
///APP  音效
#define     FYL_SoundType           @"soundType"
///APP  角色
#define     FYL_CHARACTERS           @"CHARACTERS"
///APP  触感
#define     FYL_touchState           @"touchState"
///APP  千分位
#define     FYL_thousandsState           @"thousandsState"
///APP  日期
#define     FYL_dataState           @"dataState"
///APP  量级
#define     FYL_orderState           @"orderState"
///APP  小数点个数
#define     FYL_DecimalPlace          @"FYL_DecimalPlace"

#ifdef DEBUG
#define     FlurryAPIKey        @"XTF5F3FJDJB89JPD34HX"
#else
#define     FlurryAPIKey        @"K72TTKZWG532VQG3CVJS"
#endif

#endif /* PrefixHeader_pch */
