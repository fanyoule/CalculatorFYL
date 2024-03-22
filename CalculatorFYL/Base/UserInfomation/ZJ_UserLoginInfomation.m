//
//  ZJ_UserLoginInfomation.m
//  OceangreateShipOwners
//
//  Created by 樊佑乐 on 2021/11/1.
//

#import "ZJ_UserLoginInfomation.h"

@implementation ZJ_UserLoginInfomation
#pragma mark - 保存数据
+ (void)userInfoWithDict:(NSDictionary *)dict{

    if(dict&&[dict isKindOfClass:[NSDictionary class]]){
        BOOL isLogin = YES;
        
        //用户Id
        NSString *userId = [NSString stringWithFormat:@"%@",dict[@"userGroup"]]; //这个字段代表userId,很奇怪用户ID为啥这样命名
        
        //用户手机号
    //    NSString *phone = [NSString stringWithFormat:@"%@",dict[@"phone"]];
        //用户邮箱
    //    NSString *email = [NSString stringWithFormat:@"%@",dict[@"email"]];
        //用户名
        NSString *username = [NSString stringWithFormat:@"%@",dict[@"userName"]];
        //承运人id
    //    NSString *relevanceId = [NSString stringWithFormat:@"%@",dict[@"relevanceId"]];
    //    //头像
    //    NSString *profilePhoto = [NSString stringWithFormat:@"%@",dict[@"profilePhoto"]];
    //    //认证拒绝理由
    //    NSString *refuseReason = [NSString stringWithFormat:@"%@",dict[@"refuseReason"]];
    //    //认证状态  0-认证中  1-认证通过  2-认证不通过
    //    NSString *state = [NSString stringWithFormat:@"%@",dict[@"state"]];
        NSString *token = [NSString stringWithFormat:@"%@",dict[@"userToken"]];
    //    NSString *userPwd = [NSString stringWithFormat:@"%@",dict[@"userPwd"]];//    integer密码状态 0 无密码 1 有密码
        
        
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:@(isLogin) forKey:@"YX_UserInfo_Login"];
    //    [userInfo setObject:userPwd forKey:@"YX_UserInfo_userPwd"];
        [userInfo setObject:username forKey:@"YX_UserInfo_Username"];
        [userInfo setObject:token forKey:@"YX_UserInfo_token"];
        
        [userInfo setObject:userId forKey:@"YX_UserInfo_Group"];
    //    [userInfo setObject:phone forKey:@"YX_UserInfo_Phone"];
    //    [userInfo setObject:email forKey:@"YX_UserInfo_Email"];
    //    [userInfo setObject:state forKey:@"YX_UserInfo_state"];
    //    [userInfo setObject:relevanceId forKey:@"YX_UserInfo_relevanceId"];
    //    [userInfo setObject:profilePhoto forKey:@"YX_UserInfo_profilePhoto"];
    //    [userInfo setObject:refuseReason forKey:@"YX_UserInfo_refuseReason"];
        
        [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"commonUserInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

    }

}

#pragma mark - 退出登录
+ (void)clearUserInfo{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"commonUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 修改某条数据
+ (void)updateUserInfo:(NSString *)object keyStr:(NSString *)keyStr{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    NSMutableDictionary *theDict = [NSMutableDictionary dictionary];
    [theDict setDictionary:dict];
    [theDict setObject:object forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] setObject:theDict forKey:@"commonUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 获取信息
//是否登录
+ (BOOL)getLogin {
    NSUserDefaults *user =  [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [user objectForKey:@"commonUserInfo"];
    BOOL login = [dic[@"YX_UserInfo_Login"] boolValue];
    return login;
}
//获取token
+ (NSString *)getToken {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_token"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";
}

//获取ID
+ (NSString *)getUserId {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_id"];
        if(!IS_VALID_STRING(xid)){
            return @"";
        }
        return xid;
    }
    return @"";
}

//获取邮箱
+ (NSString *)getEmail {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_Email"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";

}

//获取用户名称
+ (NSString *)getUsername {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_Username"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";
}
///wifi密码
+ (NSString *)getWiFiPwd {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_WiFiPwd"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";
   
}
///wifi名称
+ (NSString *)getWiFiName {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_WiFiName"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";
   
}

///GroupId:用户id
+ (NSString *)getGroupId {
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"commonUserInfo"];
    if (dic) {
        NSString *xid = dic[@"YX_UserInfo_Group"];
        if(!IS_VALID_STRING(xid)){
            return  @"";
        }
        return xid;
    }
    return @"";
   
}

@end
