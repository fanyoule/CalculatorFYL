//
//  NetworkRequestAPI.h
//  HIBEX
//
//  Created by zhangzhen on 2018/5/30.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestAPI : NSObject

#ifdef DEBUG

#define APIHEAD_Foreign @"https://joylight.dbiot.link/" // 外网  线上
//#define APIHEAD_Foreign @"https://cloud.v2.dbiot.link/" // 国网  线下
#define APIHEAD_local @"http://192.168.0.77:34415/" // 本地 联调

//#define APIHEAD_Foreign @"https://joylight.dbiot.org/" // 外网  线上
//#define APIHEAD_local @"http://192.168.2.223:34415/" // 本地 联调

#else

#define APIHEAD_Foreign @"https://joylight.dbiot.org/" // 外网  线上
#define APIHEAD_local @"http://192.168.2.223:34415/" // 本地 联调


#endif

// 获取OTA
#define APPGETOTA [NSString stringWithFormat:@"%@",@"public/app/ota/getOTA"]
#define GETAPPMODELAPI [NSString stringWithFormat:@"%@",@"model/multi/app/getAppModel"]
#define GETBANNERS [NSString stringWithFormat:@"%@",@"banner/multi/app/getBanners"]
// 获取设备的配置
#define GETAPPDEVICE [NSString stringWithFormat:@"%@",@"devicemold/multi/app/getAppDevice"]
// 查询DIY
///model/multi/app/getDiyModel
#define GETDIYMODEL [NSString stringWithFormat:@"%@",@"model/multi/app/getDiyModel"]
//model/multi/app/getRhythmModel
// 查询手机麦设备麦音乐模式
#define GETRHYTHMMODEL [NSString stringWithFormat:@"%@",@"model/multi/app/getRhythmModel"]
//查询图库分类
//gallery/multi/app/getGalleryClass
#define GETGALLERYCLASS [NSString stringWithFormat:@"%@",@"gallery/multi/app/getGalleryClass"]
// 查询图库信息
//gallery/multi/app/getGalleryPage
#define GETGALLERYPAGE [NSString stringWithFormat:@"%@",@"gallery/multi/app/getGalleryPage"]



///修改设备名称 (设备名称)
#define UpdDeviceName [NSString stringWithFormat:@"%@",@"device/app/updDeviceName"]
///查询设备列表
#define GetDeviceList [NSString stringWithFormat:@"%@",@"device/app/getDevice"]
///APP用户登陆  account账户  password密码
#define WIFI_UserLogin [NSString stringWithFormat:@"%@",@"public/app/user/login"]
///邮箱登陆  account账户  code
#define WIFI_LoginEmail [NSString stringWithFormat:@"%@",@"public/app/user/login/email"]

///发送验证码-找回密码  userEmail
//#define WIFI_CaptchaEmailPasswordCode [NSString stringWithFormat:@"%@",@"public/app/captcha/emailPasswordCode"]
///邮箱找回密码 -2    confirmPwd确认密码  email   newPwd  uuid
#define WIFI_EmailPassword [NSString stringWithFormat:@"%@",@"user/app/emailPassword"]
///邮箱找回密码 -1   code   email
#define WIFI_IsEmailPassword [NSString stringWithFormat:@"%@",@"user/app/isEmailPassword"]
///用户退出登陆
#define WIFI_Out [NSString stringWithFormat:@"%@",@"user/app/out"]
///用户注销
#define WIFI_OutUser [NSString stringWithFormat:@"%@",@"user/app/outUser"]
///更新用户相关 WiFi密码    userWiFiName名称    userWiFiPwd密码
#define WIFI_UpdUserWiFi [NSString stringWithFormat:@"%@",@"user/app/updUserWiFi"]
///查询扫描到的设备信息 根据 device_mac 字段查询当前设备的状态    deviceMac
#define WIFI_getDeviceMac [NSString stringWithFormat:@"%@",@"device/app/getDeviceMac"]
///设备初始化修改 （设备名称，设备模型ID）deviceGroupName设备名称  deviceModelId模型ID  deviceName设备唯一标识
#define WIFI_InitDevice [NSString stringWithFormat:@"%@",@"device/app/initDevice"]
///设备重置 APP 获取到设备时操作  deviceMac
#define WIFI_ResetDeviceMac [NSString stringWithFormat:@"%@",@"device/app/resetDeviceMac"]
///删除设备 组控移除 默认分组删除（单个设备by关联表ID<device_group_id>）deviceGroupId
#define WIFI_RomeGroupDevice [NSString stringWithFormat:@"%@",@"device/app/romeGroupDevice"]
///修改设备m (设备名称) deviceAndroidName设备名称(android使用)  deviceGroupName设备名称  deviceName设备唯一标识
#define WIFI_UpdDeviceName [NSString stringWithFormat:@"%@",@"device/app/updDeviceName"]
///APP 校验是否需要强制更新  appNameAPP名称     appType1=Android；2=iOS     appVersionAPP版本    appLanguage本地语言
#define WIFI_CheckUpdate [NSString stringWithFormat:@"%@",@"public/app/update/checkUpdate"]
///更新用户相关 WiFi密码       userWiFiName    userWiFiPwd
#define WIFI_updUserWiFi [NSString stringWithFormat:@"%@",@"user/ota/setOtaUrl"]
///发送OTA升级指令到设备
#define WIFI_otaSetOtaUrl [NSString stringWithFormat:@"%@",@"public/app/ota/setOtaUrl"]
// 分组操作 操作组控添加修改
#define GROUPADDGROUP [NSString stringWithFormat:@"%@",@"group/app/addGroup"]
//// 分组操作 移除分组
#define GROUPDELGROUP [NSString stringWithFormat:@"%@",@"group/app/delGroup"]
// 分组操作 查询我的分组列表
#define GROUPLIST [NSString stringWithFormat:@"%@",@"group/app/groupList"]
// 获取设备证书链接
#define GetDeviceCert [NSString stringWithFormat:@"%@",@"device/app/getDeviceCert"]
// APP用户创建一键执行
#define TapRunCreate [NSString stringWithFormat:@"%@",@"smart/tapRun/create"]
// APP用户获取一键执行列表
#define TapRunList [NSString stringWithFormat:@"%@",@"smart/tapRun/list"]
// 获取一键执行设备部分数据
#define TapRunPartByRunId [NSString stringWithFormat:@"%@",@"smart/tapRun/partByRunId"]
// 删除一键执行
#define TapRunRemove [NSString stringWithFormat:@"%@",@"smart/tapRun/remove"]
// 一键执行调用
#define TapRunRun [NSString stringWithFormat:@"%@",@"smart/tapRun/run"]
// 更新一键执行
#define TapRunUpdate [NSString stringWithFormat:@"%@",@"smart/tapRun/update"]
// 获取alexaURL
///alexa/app/getRedirectUrl
#define GETREDIRECTURL [NSString stringWithFormat:@"%@",@"alexa/app/getRedirectUrl"]
// 提交获取的AlexaURL code
// /alexa/app/submitCode
#define SUBMITCODE [NSString stringWithFormat:@"%@",@"alexa/app/submitCode"]
// 获取当前Alexa绑定状态
//alexa/app/voiceBingStatus
#define VOICEBINGSTATUS [NSString stringWithFormat:@"%@",@"alexa/app/voiceBingStatus"]
// 解除绑定Alexa
//alexa/app/unbindSkill
#define UNBINDSKILL [NSString stringWithFormat:@"%@",@"alexa/app/unbindSkill"]

//-----------------------JoyLight --------------------------------//
//model/multi/app/getModelClass // 获取模式分类
#define GETMODELCLASS [NSString stringWithFormat:@"%@",@"model/multi/app/getModelClass"]
//model/multi/app/getModelPage // 查询模式分类信息
#define GETMODELPAGE [NSString stringWithFormat:@"%@",@"model/multi/app/getModelPage"]
///获取隐私政策、用户协议
#define GetUrlLanguage [NSString stringWithFormat:@"%@",@"model/multi/app/getUrlLanguage"]
//获取窗帘灯律动模式
#define GETRHYTHMCURTAIN [NSString stringWithFormat:@"%@",@"model/multi/app/getRhythmCurtain"]
// 安装数据统计 /userStatistics/app/submit
#define INSTALLEDCAPCCITY [NSString stringWithFormat:@"%@",@"userStatistics/app/submit"]
// 查询窗帘律动分类
#define GetRhythmCurtainClassList [NSString stringWithFormat:@"%@",@"model/multi/app/getRhythmCurtainClassList"]
// 查询窗帘律动List
#define GetRhythmCurtainList [NSString stringWithFormat:@"%@",@"model/multi/app/getRhythmCurtainList"]
///全彩模式分类
#define GetFullColorClassList [NSString stringWithFormat:@"%@",@"fullcolor/multi/app/getFullColorClassList"]
///全彩模式分类下列表数据
#define GetFullColorList [NSString stringWithFormat:@"%@",@"fullcolor/multi/app/getFullColorList"]



















//查询设备信号阈值
#define RssithresholdGet [NSString stringWithFormat:@"%@",@"system/app/rssithreshold/get"]
///注册 --- 邮箱校验验验证码  传参code、email
#define API_CaptchaValidateRegisterEmail [NSString stringWithFormat:@"%@",@"public/app/captcha/validateRegisterEmail"]
///注册 --- 注册 uuid、email、password、passwordConfirm  (返回 userToken、userName、userIcon、userPwd、userGroup)
#define API_UserRegister [NSString stringWithFormat:@"%@",@"public/app/user/register"]
///忘记密码 --- 验证验证码 传参code、email
#define API_CaptchaValidateEmailPassword [NSString stringWithFormat:@"%@",@"public/app/captcha/validateEmailPassword"]
///忘记密码 --- 最后一步确认  传参uuid、email、password、passwordConfirm
#define API_UserUpdPassword [NSString stringWithFormat:@"%@",@"public/app/user/updPassword"]
///邮箱账号---验证码登录
#define API_LoginNewEmail [NSString stringWithFormat:@"%@",@"public/app/user/login/newEmail"]
///验证账户  account、type（查询条件 0 登录  1 注册）
#define API_UserIsUserAccount [NSString stringWithFormat:@"%@",@"public/app/user/isUserAccount"]
///账号登录发送验证码  userEmail
#define API_CaptchaEmailNewCode [NSString stringWithFormat:@"%@",@"public/app/captcha/emailNewCode"]
///注册 --- 输入邮箱点击获取验证码
#define API_CaptchaEmailRegister [NSString stringWithFormat:@"%@",@"public/app/captcha/emailRegister"]
///未登录状态下  忘记密码 --- 输入邮箱点击获取验证码
#define API_CaptchaEmailPassword [NSString stringWithFormat:@"%@",@"public/app/captcha/emailPassword"]
///登录状态下 --- 忘记密码发送验证码  userEmail
#define WIFI_CaptchaEmailCode [NSString stringWithFormat:@"%@",@"public/app/captcha/emailCode"]

///注册  --- 发送手机注册验证码    codeType验证码类型 1：注册 2：忘记密码(integer)          userPhoneNumber手机号码(string)
#define API_SmsCodeRegister [NSString stringWithFormat:@"%@",@"public/app/captcha/smsCodeRegister"]
///注册  --- 校验手机验证码    code         phoneNumber手机号码(string)
#define API_ValidateSmsCode [NSString stringWithFormat:@"%@",@"public/app/captcha/validateSmsCode"]
///注册  --- 手机号码注册（国内）   account账户     password密码   passwordConfirm确认密码       uuid
#define API_PhoneRegister [NSString stringWithFormat:@"%@",@"public/app/user/phoneRegister"]
///忘记密码  --- 手机号 未登录状态下）                account账户     password密码   passwordConfirm确认密码       uuid
#define API_PhoneUpdPassword [NSString stringWithFormat:@"%@",@"public/app/user/phoneUpdPassword"]
///忘记密码  --- 手机号 登录状态下）                account账户     password密码   passwordConfirm确认密码       uuid
#define API_PhoneUpdPasswordLogin [NSString stringWithFormat:@"%@",@"public/app/user/phoneUpdPasswordLogin"]


///修改密码  ---             account账户     password密码   passwordNew确认密码
#define API_ChangePassword [NSString stringWithFormat:@"%@",@"public/app/user/changePassword"]




@end

