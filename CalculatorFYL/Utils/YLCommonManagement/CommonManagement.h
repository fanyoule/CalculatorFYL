//
//  CommonManagement.h
//  JoyLight
//
//  Created by 袁林 on 2024/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonManagement : NSObject


+ (id)verData:(id)data style:(NSInteger)styleIndex;

/// string 砖data
+ (NSData *)hexToBytes:(NSString *)str;

/// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonData;

/// 字典转json格式字符串：
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/// 获取app版本号
+ (NSString *)getAppVersion;

/// 获取json文件
+ (id)loadJsonOfBundlePathForResource:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
