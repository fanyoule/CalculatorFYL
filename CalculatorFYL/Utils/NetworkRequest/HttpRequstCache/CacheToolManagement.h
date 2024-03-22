//
//  CacheToolManagement.h
//  DayBetter
//
//  Created by 袁林 on 2023/12/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheToolManagement : NSObject

+ (instancetype)sharedManager;

/// 当使用json文件数据时，判断页面是否上拉加载更多了，若是，不返回数据
@property (nonatomic, assign) BOOL isJsonDataRefresh;


/// 存入本地数据，如果有就更新数据
/// - Parameters:
///   - data: 返回数据
///   - initialURL: 未拼接接口，例：public/app/ota/getOTA
///   - url: 完整接口
///   - parameters: 请求参数
- (void)writeCacheData:(NSDictionary *)data initialURL:(NSString *)initialURL url:(NSString *)url parameters:(NSDictionary *)parameters;

/// 获取本地数据
/// - Parameters:
///   - url: 完整接口
///   - parameters: 接口参数
///   - initialURL: 未拼接接口
- (id)getCacheDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters initialURL:(NSString *)initialURL;

/// 是否显示toast，在无网络时，根据是否有缓存数据决定，有缓存数据就不显示toast，反之没有就显示
/// - Parameters:
///   - cache: 缓存数据
///   - initialURL: 未拼接接口
///   - isShowView: InterfaceManagement类中方法传进来的参数，若缓存数据为空，以isShowView决定toast是否显示
- (BOOL)isThereCachedDataAvailable:(NSDictionary *)cache initialURL:(NSString *)initialURL isShowView:(BOOL)isShowView;

/// 请求失败时，获取缓存数据
/// - Parameters:
///   - classModelString: 接口存储model的字符串，类字符串
///   - cacheData: 缓存数据
+ (id)getCachedDataOnFailureClassModelString:(NSString *)classModelString cacheData:(id)cacheData;


/// 获取当前网络状态 -1=不明网络 0=没有网络 1=蜂窝网络 2=WIFI
+ (NSInteger)getTheCurrentNetworkStatus;

+ (BOOL)internetStatus;

@end

NS_ASSUME_NONNULL_END
