//
//  YXHTTPRequst.h
//  JS_Block&Networking
//
//  Created by 向乾操 on 16/2/29.
//  Copyright © 2016年 向乾操. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, YXRequstMethodType) {
    YXRequstMethodTypeGET   = 0,
    YXRequstMethodTypePOST  = 1
};
/**
*  网络请求成功回调
*
*  @param task           操作信息
*  @param responseObject 成功信息
*/
typedef void(^httpResponseSuccess) (NSURLSessionDataTask * task,id responseObject);
/**
*  网络请求失败回调
*
*  @param task  操作信息
*  @param error 失败信息
*/
typedef void(^httpResponseFailure)(NSURLSessionDataTask *task, id cacheData, NSError * error);

@interface YXHTTPRequst : NSObject
/**
*  网络请求对象
*/
@property(nonatomic,strong)AFHTTPSessionManager * httpSessionManager;
/**
*  设置缓存策略  默认缓存策略
*/
@property(nonatomic,assign)NSURLRequestCachePolicy cachePolicy;
/**
*  设置超时时间  系统默认5秒
*/
@property(nonatomic,assign)NSTimeInterval timeoutInterval;

@property(nonatomic, assign)BOOL isNoNetwork;

+ (YXHTTPRequst *)shareInstance;

-(void)handleHttpHeader:(NSString *)key value:(id)value;

- (void)networking:(NSString *)urlString
        parameters:(NSDictionary *)parame
            method:(YXRequstMethodType)TYPE
            showErrorView:(BOOL)isShowView
           success:(httpResponseSuccess)success
          failsure:(httpResponseFailure)failsure;

- (void)yl_networking:(NSString *)urlString
        parameters:(NSDictionary *)parame
            method:(YXRequstMethodType)TYPE
            showLoadingView:(BOOL)showLoading
            showLoadingTitle:(NSString *)title
            showErrorView:(BOOL)isShowView
            success:(httpResponseSuccess)success
            failsure:(httpResponseFailure)failsure;



// post 请求 数据
+ (void)requestPOSTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError;

//GET 请求数据
+ (void)requestGETWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic Api_key:(NSString *)api_key finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError;
// PUT 请求 数据
+ (void)requestPUTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic Api_key:(NSString *)api_key finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError;

// 文件上传
+ (void)requestAddImgPOSTWithURLStr:(NSString *)url paramDic:(NSDictionary *)paramDic image:(UIImage *)image name:(NSString *)name success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


// 监听网络状态
- (void)monitoringNetworkStatus;


// 文件下载
- (void)downloadingAFileWithURLStr:(NSString *)url progress:(void(^)(NSProgress *downloadProgress))progress completionHandler:(void(^)(NSURLResponse * response,NSURL * filePath,BOOL  success))completionHandler;


/**
 *code相关报错提示
 *type 1（websocket返回）  0（http返回）
 */
-(void)showErrorViewModel:(BaseModel *)model withUrl:(NSString *)url withType:(NSInteger)type;
#pragma mark -- 获取当前手机型号
- (NSString *)jk_platformString;
#pragma mark -- 处理 401情况
-(void)HandleData401;

+ (NSString *)urlAcquisitionPerfectionUrlStr:(NSString *)url;

@end
