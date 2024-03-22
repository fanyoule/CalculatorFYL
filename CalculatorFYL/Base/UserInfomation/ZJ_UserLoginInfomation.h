//
//  ZJ_UserLoginInfomation.h
//  OceangreateShipOwners
//
//  Created by 樊佑乐 on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJ_UserLoginInfomation : NSObject
/// 保存用户信息
/// @param dict 用户信息
+ (void)userInfoWithDict:(NSDictionary *)dict;


/// 清除所有保存的用户信息
+ (void)clearUserInfo;

/**
 更改用户某条信息
 
 @param object 数据
 @param keyStr 数据对应的KEY
 */
+ (void)updateUserInfo:(NSString *)object keyStr:(NSString *)keyStr;


/// 用户登录状态  yes登录  no登出
+ (BOOL)getLogin;
/// 获取用户ID
+ (NSString *)getUserId;
/// 获取用户邮箱
+ (NSString *)getEmail;
/// 获取用户名
+ (NSString *)getUsername;
///获取token
+ (NSString *)getToken;
///Group
+ (NSString *)getGroupId;
///wifi密码
+ (NSString *)getWiFiPwd;
///wifi名称
+ (NSString *)getWiFiName;


@end

NS_ASSUME_NONNULL_END
