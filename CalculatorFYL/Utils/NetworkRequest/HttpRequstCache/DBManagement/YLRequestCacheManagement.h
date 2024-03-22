//
//  YLRequestCacheManagement.h
//  DayBetter
//
//  Created by 袁林 on 2023/12/15.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLRequestCacheManagement : NSObject

/// 单例
+ (YLRequestCacheManagement *)sharedDBManagement;

/// 写入数据  当url存在时，更新数据
- (void)writeData:(NSString *)data url:(NSString *)url parameters:(NSString *)parameters;

/// 查询数据
- (NSDictionary *)queryData:(NSString *)url parameters:(NSString *)parameters;

/// 删除某条数据
- (BOOL)deleteData:(NSString *)url;

/// 删除所有数据
- (BOOL)deleteAllData;

@end

NS_ASSUME_NONNULL_END
