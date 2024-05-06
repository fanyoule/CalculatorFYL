//
//  YXHTTPRequst.m
//  JS_Block&Networking
//
//  Created by 向乾操 on 16/2/29.
//  Copyright © 2016年 向乾操. All rights reserved.
//

#import "YXHTTPRequst.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>


#ifdef DEBUG
static CGFloat const KDdefaultTimeOutInteral = 60.0;
#else
static CGFloat const KDdefaultTimeOutInteral = 30.0;
#endif
static NSString * showing_400 = @"2";

@implementation YXHTTPRequst

+ (YXHTTPRequst *)shareInstance {
    static YXHTTPRequst * requst = nil;
    if (!requst) {
        requst = [[YXHTTPRequst alloc] init];
        requst.timeoutInterval = 60;
    }
    return requst;
}
-(AFHTTPSessionManager *)httpSessionManager{
    
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html", nil];
        [_httpSessionManager.requestSerializer setTimeoutInterval:KDdefaultTimeOutInteral];
    }
    return _httpSessionManager;
    
}
- (void)yl_networking:(NSString *)urlString parameters:(NSDictionary *)parame method:(YXRequstMethodType)TYPE showLoadingView:(BOOL)showLoading showLoadingTitle:(NSString *)title showErrorView:(BOOL)isShowView success:(httpResponseSuccess)success  failsure:(httpResponseFailure)failsure{
    
    [self setUserDefineCachePolicy];
    [self handleHttpHeader];
    NSString *initialURL = [urlString copy];//未拼接的地址接口
    NSString * yl_url = [NSString stringWithFormat:@"%@",urlString];
    urlString = [YXHTTPRequst urlAcquisitionPerfectionUrlStr:urlString];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if(showLoading){
        [MBProgressHUD showMessage:IS_VALID_STRING(title) ? title : @"" toView:YX_Keywindow delay:KDdefaultTimeOutInteral];
    }
    if (TYPE == YXRequstMethodTypePOST) {
        
        [self.httpSessionManager POST:urlString parameters:parame headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(showLoading){
                [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
            }
            success(task,responseObject);
            
            if(responseObject && [responseObject isKindOfClass:[NSDictionary class]]){
                BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
                if(model.code.intValue == 200){

                    //存入数据，有就更新
//                    [[CacheToolManagement sharedManager] writeCacheData:responseObject initialURL:initialURL url:urlString parameters:parame];
                    
                } else if (model.code.intValue==401) {//token过期，需要重新登录
                    [self HandleData401];
                } else {
                    if(isShowView){
                        [self showErrorViewModel:model withUrl:urlString withType:0];
                    }
                }
            } else {
                if (isShowView) {
                    [MBProgressHUD showMessage:NSLocalizedString(@"Data acquisition exception, please restart the app later and try again.", nil) toView:YX_Keywindow delay:2];
                }
          
            }
#ifdef DEBUG
            NSLog(@"token---%@\n url---%@，Params--%@,responseObject--%@", [ZJ_UserLoginInfomation getToken],urlString,[PublicHelpers dictionaryToJson:parame],[PublicHelpers dictionaryToJson:responseObject] );
#endif
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(showLoading){
                [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
            }
            //获取本地数据库数据
//            id obj = [[CacheToolManagement sharedManager] getCacheDataWithURL:urlString parameters:parame initialURL:initialURL];
            failsure(task, nil, error);
#ifdef DEBUG
            NSLog(@"token---%@\n url---%@，Params--%@,error--%@", [ZJ_UserLoginInfomation getToken],urlString,[PublicHelpers dictionaryToJson:parame],error );
#endif
            //是否显示toast，若是要缓存的接口，并且有数据，把就不显示toast
//            BOOL isShow = [[CacheToolManagement sharedManager] isThereCachedDataAvailable:(NSDictionary *)obj initialURL:initialURL isShowView:isShowView];
            [self handleFailureWithURL:yl_url Parameters:parame Action:@"POST" Task:task Error:error isShowView:isShowView];
        }];
    } else {
        [self.httpSessionManager GET:urlString parameters:parame headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(showLoading){
                [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
            }
            success(task,responseObject);
            
            if(responseObject && [responseObject isKindOfClass:[NSDictionary class]]){
                BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
                if(model.code.intValue == 200){
                  
                    //存入数据，有就更新
//                    [[CacheToolManagement sharedManager] writeCacheData:responseObject initialURL:initialURL url:urlString parameters:parame];
                  
                } else if (model.code.intValue==401){//token过期，需要重新登录
                    [self HandleData401];
                } else {
                    if (isShowView) {
                        [self showErrorViewModel:model withUrl:urlString withType:0];
                    }
                }
            } else {
                if(isShowView){
                    [MBProgressHUD showMessage:NSLocalizedString(@"Data acquisition exception, please restart the app later and try again.", nil) toView:YX_Keywindow delay:2];
                }
            }
#ifdef DEBUG
            NSLog(@"token---%@\n url---%@，Params--%@,responseObject--%@", [ZJ_UserLoginInfomation getToken],urlString,[PublicHelpers dictionaryToJson:parame],[PublicHelpers dictionaryToJson:responseObject] );
#endif
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(showLoading){
                [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
            }
            //获取本地数据库数据
//            id obj = [[CacheToolManagement sharedManager] getCacheDataWithURL:urlString parameters:parame initialURL:initialURL];
            failsure(task, nil, error);
#ifdef DEBUG
          NSLog(@"token---%@\n url---%@，Params--%@,error--%@", [ZJ_UserLoginInfomation getToken],urlString,[PublicHelpers dictionaryToJson:parame],error );
#endif
            //是否显示toast，若是要缓存的接口，并且有数据，把就不显示toast
//            BOOL isShow = [[CacheToolManagement sharedManager] isThereCachedDataAvailable:(NSDictionary *)obj initialURL:initialURL isShowView:isShowView];
            // 请求失败处理
            [self handleFailureWithURL:urlString Parameters:parame Action:@"GET" Task:task Error:error isShowView:isShowView];
        }];
      
    }
}

- (NSData *)appendingWithParameters:(NSDictionary *)parame {
    NSMutableString * retValue = [NSMutableString string];
    for (NSString * key in parame.allKeys) {
        NSString * value = parame[key];
        [retValue appendFormat:@"%@=%@&",key,value];
    }
    return [retValue dataUsingEncoding:NSUTF8StringEncoding];
}

// post 请求 数据
+ (void)requestPOSTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"charset=UTF-8", nil];
  
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:paramDic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
           finish(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
}

//GET 请求数据
+ (void)requestGETWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic Api_key:(NSString *)api_key finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"charset=UTF-8", nil];
    // 设置请求头
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjI1MzIsInRpbWUiOjE1Mjk5NzkxMDgsImV4cCI6MTg0NTMzOTEwOH0.4bvjpSp_9U-LuE1UbW6kT86XD41cO1BFkPQYkhQK-pk"] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:paramDic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
}



// PUT 请求 数据
+ (void)requestPUTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic Api_key:(NSString *)api_key finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    [manager PUT:urlStr parameters:paramDic headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
    
    
}
// 文件上传
+ (void)requestAddImgPOSTWithURLStr:(NSString *)url paramDic:(NSDictionary *)paramDic image:(UIImage *)image name:(NSString *)name success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    // 1.创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    //请求图片,请求网页时需要加入这句,因为AFN默认的请求的是json
      [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 2.发送请求(字典只能放非文件参数)
    [manager POST:url parameters:paramDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);//进行图片压缩
        // 使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        // 上传图片，以文件流的格式
        // 任意的二进制数据MIMEType application/octet-stream
        // 特别注意，这里的图片的名字不要写错，必须是接口的图片的参数名字如我这里是file
        if (imageData!=nil) { // 图片数据不为空才传递
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


// 监听网络状态
- (void)monitoringNetworkStatus{
    
    //创建
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    //设置回调
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"不明网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                NSLog(@"蜂窝网络");
               
                self.isNoNetwork = YES;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi");
               
                self.isNoNetwork = YES;
            }
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}
#pragma mark -- 升级弹框
-(void)showAlertUpgradeViewAndVisitorButton{
//    NSString * versionEnvironment = [[NSUserDefaults standardUserDefaults]objectForKey:@"versionEnvironment"];
//    if(!IS_VALID_STRING(versionEnvironment)){
//        UIViewController * currectVC = [YLUserToolManager lz_getCurrentViewController];
//        if([currectVC isKindOfClass:[YLLoginViewController class]]){
//            [YLWiFiToolManagement showObtainAppUpgrade];
//        }else{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [YLWiFiToolManagement showObtainAppUpgrade];
//            });
//        }
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"versionEnvironment"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
    
    
    
}

// 文件下载
- (void)downloadingAFileWithURLStr:(NSString *)url progress:(void(^)(NSProgress *downloadProgress))progress completionHandler:(void(^)(NSURLResponse * response,NSURL * filePath,BOOL  success))completionHandler{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 写文件
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"文件下载至 : %@", filePath);
        NSLog(@"error == %@",error);
        if(error){
//            [[ZZAlertViewTools shareInstance]showAlert:@"tip" message:@"The file is corrupted, please try to download again" cancelTitle:nil titleArray:nil confirm:nil];
            completionHandler(nil,nil,NO);
        }else{
            completionHandler(response,filePath,YES);

        }
    }];
    [downloadTask resume];
}
-(void)setUserDefineTimeoutInterval{
    
    if (self.timeoutInterval) {
        self.httpSessionManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    }
    
}
-(void)setUserDefineCachePolicy{
    if (self.cachePolicy) {
        self.httpSessionManager.requestSerializer.cachePolicy = self.cachePolicy;
    }
    
}
//请求头
-(void)handleHttpHeader{
    if (ZJ_UserLoginInfomation.getLogin) {
        NSString * token = ZJ_UserLoginInfomation.getToken;
        if (IS_VALID_STRING(token)) {
            [self.httpSessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
        }
    }
    [self.httpSessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"systemModel"];
//    [self.httpSessionManager.requestSerializer setValue:@"Apple" forHTTPHeaderField:@"deviceBrand"];
//    [self.httpSessionManager.requestSerializer setValue:[self getIphoneType] forHTTPHeaderField:@"systemModel"];
//    [self.httpSessionManager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"systemVersion"];
//    [self.httpSessionManager.requestSerializer setValue:[KeychainIDFA IDFA] forHTTPHeaderField:@"deviceId"];
   
}

 

-(void)handleHttpHeader:(NSString *)key value:(id)value{
    [self.httpSessionManager.requestSerializer setValue:value forHTTPHeaderField:key];
}
#pragma mark -- 切换域名（默认国外）
+(NSString *)urlAcquisitionPerfectionUrlStr:(NSString *)url{

    NSString * address = [[NSUserDefaults standardUserDefaults]objectForKey:CountriesAddress];
    if(IS_VALID_STRING(address)&&[address isEqualToString:@"CN"]){//国内
        url = [NSString stringWithFormat:@"%@%@",APIHEAD_Foreign,url];
    }else{//国外
        url = [NSString stringWithFormat:@"%@%@",APIHEAD_Foreign,url];
    }
//    url = [NSString stringWithFormat:@"%@%@",APIHEAD_local,url];
    return url;
}

#pragma mark -- 处理 401情况
-(void)HandleData401{
    
   
    
    
}


#pragma mark - 处理请求失败
-(void)showErrorViewModel:(BaseModel *)model withUrl:(NSString *)url withType:(NSInteger)type{
   
//        switch (model.code.intValue) {
//            
//            default:
//            {
//
//            }
//                break;
//        }
    
}
#pragma mark -- 获取当前手机型号
- (NSString *)jk_platformString{
//    [UIDevice jk_systemVersion];
    NSString *platform = [self jk_platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max CN";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"])   return @"iPhone SE 2";
    if ([platform isEqualToString:@"iPhone13,1"])   return  @"iPhone 12 Mini";
    if ([platform isEqualToString:@"iPhone13,2"])   return  @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])   return  @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])   return  @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"])    return @"iPhone 13 Mini";
    if ([platform isEqualToString:@"iPhone14,5"])    return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"])    return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"])    return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE (3rd generation)";
    if ([platform isEqualToString:@"iPhone14,7"]) return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone14,8"]) return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,2"]) return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,3"]) return @"iPhone 14 Pro Max";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod Touch 7G";
    
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])      return @"iPad 6 (WiFi)";
    if ([platform isEqualToString:@"iPad7,6"])      return @"iPad 6 (Cellular)";
    if ([platform isEqualToString:@"iPad7,11"])     return @"iPad 7 (WiFi)";
    if ([platform isEqualToString:@"iPad7,12"])     return @"iPad 7 (Cellular)";
    if ([platform isEqualToString:@"iPad8,1"])      return @"iPad Pro 11-inch (WiFi)";
    if ([platform isEqualToString:@"iPad8,2"])      return @"iPad Pro 11-inch (WiFi, 1TB)";
    if ([platform isEqualToString:@"iPad8,3"])      return @"iPad Pro 11-inch (Cellular)";
    if ([platform isEqualToString:@"iPad8,4"])      return @"iPad Pro 11-inch (Cellular, 1TB)";
    if ([platform isEqualToString:@"iPad8,5"])      return @"iPad Pro 12.9-inch 3 (WiFi)";
    if ([platform isEqualToString:@"iPad8,6"])      return @"iPad Pro 12.9-inch 3 (WiFi, 1TB)";
    if ([platform isEqualToString:@"iPad8,7"])      return @"iPad Pro 12.9-inch 3 (Cellular)";
    if ([platform isEqualToString:@"iPad8,8"])      return @"iPad Pro 12.9-inch 3 (Cellular, 1TB)";
    if ([platform isEqualToString:@"iPad8,9"])      return @"iPad Pro 11-inch 2 (WiFi)";
    if ([platform isEqualToString:@"iPad8,10"])     return @"iPad Pro 11-inch 2 (Cellular)";
    if ([platform isEqualToString:@"iPad8,11"])     return @"iPad Pro 12.9-inch 4 (WiFi)";
    if ([platform isEqualToString:@"iPad8,12"])     return @"iPad Pro 12.9-inch 4 (Cellular)";
    if ([platform isEqualToString:@"iPad11,1"])     return @"iPad Mini 5 (WiFi)";
    if ([platform isEqualToString:@"iPad11,2"])     return @"iPad Mini 5 (Cellular)";
    if ([platform isEqualToString:@"iPad11,3"])     return @"iPad Air 3 (WiFi)";
    if ([platform isEqualToString:@"iPad11,4"])     return @"iPad Air 3 (Cellular)";
    if ([platform isEqualToString:@"iPad11,6"])     return @"iPad 8 (WiFi)";
    if ([platform isEqualToString:@"iPad11,7"])     return @"iPad 8 (Cellular)";
    if ([platform isEqualToString:@"iPad13,1"])     return @"iPad Air 4 (WiFi)";
    if ([platform isEqualToString:@"iPad13,2"])     return @"iPad Air 4 (Cellular)";
    if ([platform isEqualToString:@"iPad12,1"])     return @"iPad 9";
    if ([platform isEqualToString:@"iPad12,2"])     return @"iPad 9";
    if ([platform isEqualToString:@"iPad14,1"])     return @"iPad Mini 6";
    if ([platform isEqualToString:@"iPad14,2"])     return @"iPad Mini 6";

    
    if ([platform isEqualToString:@"AirPods1,1"])      return @"AirPods";
    if ([platform isEqualToString:@"AirPods2,1"])      return @"AirPods 2";
    if ([platform isEqualToString:@"AirPods8,1"])      return @"AirPods Pro";

    
    if ([platform isEqualToString:@"AudioAccessory1,1"])      return @"HomePod";
    if ([platform isEqualToString:@"AudioAccessory1,2"])      return @"HomePod";
    if ([platform isEqualToString:@"AudioAccessory5,1"])      return @"HomePod mini";

    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}
- (NSString *)jk_platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}
/**
 *  处理请求失败
 *
 *  @param url        请求URL
 *  @param parameters 请求参数
 *  @param task       请求任务
 *  @param error      错误信息
 */
- (void)handleFailureWithURL:(NSString *) url Parameters:(NSDictionary *)parameters Action:(NSString *) action Task:(NSURLSessionDataTask *) task Error:(NSError *) error isShowView:(BOOL)isShow
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;
    NSInteger statusCode = response.statusCode;
    
    
}

@end







