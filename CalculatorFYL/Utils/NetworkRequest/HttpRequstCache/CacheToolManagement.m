//
//  CacheToolManagement.m
//  DayBetter
//
//  Created by 袁林 on 2023/12/26.
//

#import "CacheToolManagement.h"
#import "Reachability.h"
#import "YLRequestCacheManagement.h"

@implementation CacheToolManagement

+ (instancetype)sharedManager{
    
    static CacheToolManagement *toolManagement = nil;
    if (!toolManagement ) {
        toolManagement = [[CacheToolManagement alloc] init];
    }
    return toolManagement;
}

#pragma mark - 数据库 增改查

#pragma mark 存入本地数据，如果有就更新数据
/// 存入本地数据，如果有就更新数据
/// - Parameters:
///   - data: 返回数据
///   - initialURL: 未拼接接口，例：public/app/ota/getOTA
///   - url: 完整接口
///   - parameters: 请求参数
- (void)writeCacheData:(NSDictionary *)data initialURL:(NSString *)initialURL url:(NSString *)url parameters:(NSDictionary *)parameters {
    
    if ([self cacheInterfaceRequired:initialURL]) {//接口是否需要缓存，写入数据
        //存入json，读取时转成dic
        NSString *tableJsonData = [CommonManagement dictionaryToJson:data];
        //url + 版本号
        NSString *tableUrl = [NSString stringWithFormat:@"%@/%@", url, [CommonManagement getAppVersion]];
        //参数，转json
        NSString *tableParameters = [CommonManagement dictionaryToJson:parameters];
        [[YLRequestCacheManagement sharedDBManagement] writeData:tableJsonData url:tableUrl parameters:tableParameters];
    }
}

#pragma mark 获取本地数据 数据库 或 json文件
/// 获取本地数据
/// - Parameter url: 完整接口
/// - Parameter parameters: 参数
/// - Parameter initialURL: 未拼接接口
- (id)getCacheDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters initialURL:(NSString *)initialURL {
    
    if ([self cacheInterfaceRequired:initialURL]) {//接口是否需要读取
        //获取本地数据库数据
        //url + 版本号
        NSString *tableUrl = [NSString stringWithFormat:@"%@/%@", url, [CommonManagement getAppVersion]];
        //参数，转json
        NSString *tableParameters = [CommonManagement dictionaryToJson:parameters];
        id obj = [[YLRequestCacheManagement sharedDBManagement] queryData:tableUrl parameters:tableParameters];
        if ([obj isKindOfClass:NSDictionary.class]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSArray *arrayData = [CommonManagement verData:dic[@"data"] style:2];
            if (arrayData.count == 0) {//本地数据库没拿到数据 就取json里的默认数据
                
                //模式菜单标题、内置模式、场景模式、DIY
                if ([initialURL isEqualToString:GetFullColorClassList] ||
                    [initialURL isEqualToString:GetFullColorList]) {//全彩模式接口,全彩的默认数据使用单例存在YLUserToolManager中
                    
                    NSArray *array = @[];
                    if ([initialURL isEqualToString:GetFullColorClassList]) {//全彩模式菜单接口 title
                        
                        //使用默认数据
//                        array = [[YLUserToolManager sharedManager]getFullColorModeTitleDefaultData];
                        
                    } else {//内置模式、场景模式、DIY
                        
                        NSInteger classNumber = [parameters[@"fullColorClass"] integerValue];
                        if (classNumber == 2) {//内置模式
                            
                            //使用默认数据
//                            array = [[YLUserToolManager sharedManager] getFullColorModeBuiltInDefaultData:[XYBLEManagement sharedInstance].stateModel.fullPulse];
                            
                        } else if (classNumber == 3) {//场景模式
                            
                            //使用默认数据
//                            array = [[YLUserToolManager sharedManager] getFullColorModeChoosePatternDefaultData];
                            //赋值yes，因为场景模式需要判断是否使用了默认数据
//                            [YLUserToolManager sharedManager].fullColorModeChoosePatternIsDefaultData = YES;
                            
                        } else if (classNumber == 4) {//DIY
                            
                            //使用默认数据
//                            array = [[YLUserToolManager sharedManager] getFullColorModeDIYDefaultData:[XYBLEManagement sharedInstance].stateModel.fullPulse];
                        }
                    }
                    
                    NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : array};
                    
                    return dic;
                    
                } else {//幻彩的数据，需要去本地json数据，以json文件形式存储默认数据
                    
                    obj = [self getCacheJsonFileData:initialURL parameters:parameters];
                }
            }
        }
        
        return obj;
    }
    
    return @{};
}

#pragma mark 根据接口判断，获取json数据
- (NSDictionary *)getCacheJsonFileData:(NSString *)initialURL parameters:(NSDictionary *)parameters {
    
    if ([initialURL isEqualToString:@"model/multi/app/getDiyModel"]) {//幻彩DIY
        
        NSArray *array = [CommonManagement loadJsonOfBundlePathForResource:@"DreamColorDIY"];
        array = [CommonManagement verData:array style:2];
        
        NSArray *newArray = [self getDreamColorDIYData:array];
        NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : newArray};
        
        return dic;
        
    } else if ([initialURL isEqualToString:@"model/multi/app/getModelClass"]) {//经典 节日 心情 ....标题数据
        
        NSArray *array = [CommonManagement loadJsonOfBundlePathForResource:@"DreamColorModelClass"];
        array = [CommonManagement verData:array style:2];
        
        NSArray *newArray = [self getDreamColorModelClassData:array];
        NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : newArray};
        
        return dic;
        
    } else if ([initialURL isEqualToString:@"model/multi/app/getModelClassicsPage"]) {//经典的列表数据
        
        parameters = [CommonManagement verData:parameters style:3];
        NSInteger page = [parameters[@"page"] integerValue];
        if (page >= 2) {//上拉加载更多，会再次返回所有数据，所以页数大于等于2时，就不返回数据了
            
            return @{@"code" : @1, @"message" : @"success", @"data" : @{}};
        } else {
            
            NSArray *array = [CommonManagement loadJsonOfBundlePathForResource:@"DreamColorModelClassPage"];
            array = [CommonManagement verData:array style:2];
            
            NSDictionary *dict = [self getDreamColorClassicsModelClassData:array];
            NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : dict};
            
            return dic;
        }
    } else if ([initialURL isEqualToString:@"model/multi/app/getRhythmModel"]) {//手机麦和设备麦律动模式数据
        
        NSDictionary *dict = [CommonManagement loadJsonOfBundlePathForResource:@"DreamColorRhythmPhoneAndDevice"];
        dict = [CommonManagement verData:dict style:3];
        
        NSDictionary *newDic = [self getDreamColorRhythmData:dict];
        NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : newDic};
        
        return dic;
        
    } else if ([initialURL isEqualToString:@"model/multi/app/getModelPage"] ||
               [initialURL isEqualToString:@"model/multi/app/getNewModelPage"]) {//节日 心情... 列表数据
        
        parameters = [CommonManagement verData:parameters style:3];
        NSInteger page = [parameters[@"page"] integerValue];
        if (page >= 2) {//上拉加载更多，会再次返回所有数据，所以页数大于等于2时，就不返回数据了
            
            return @{@"code" : @1, @"message" : @"success", @"data" : @{}};
        } else {
            
            NSDictionary *dict = [CommonManagement loadJsonOfBundlePathForResource:@"DreamColorModelPage"];
            dict = [CommonManagement verData:dict style:3];
            
            NSString *type = [NSString stringWithFormat:@"%@", [CommonManagement verData:parameters[@"modelClassId"] style:1]];
            NSDictionary *newDic = [self getDreamColorModelPageData:dict type:type];
            NSDictionary *dic = @{@"code" : @1, @"message" : @"success", @"data" : newDic};
            
            return dic;
        }
        
    }
    
    return @{};
}

#pragma mark - 取数据
#pragma mark 请求失败时，获取缓存数据
// 请求失败时，获取缓存数据
+ (id)getCachedDataOnFailureClassModelString:(NSString *)classModelString cacheData:(id)cacheData {
    
    NSDictionary *dic = cacheData;
    if (dic && dic.count > 0 && [dic isKindOfClass:[NSDictionary class]]) {
        BaseModel *model = [BaseModel loadModelWithDictionary:dic];
        if (model.code.intValue == 1) {
            
            Class DataModel = NSClassFromString(classModelString);
            if (DataModel == [NSDictionary class]) {
                
                NSDictionary *dict = (NSDictionary *)cacheData;
                return dict;
                
            } else {
                
                NSObject *dataModel = [DataModel yy_modelWithJSON:cacheData];
                return dataModel;
            }
        }
    } else {
        return nil;
    }
    
    return nil;
}

#pragma mark 获取幻彩DIY数据
- (NSArray *)getDreamColorDIYData:(NSArray *)jsonData {

    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = obj;
        NSString *diy_direction = [CommonManagement verData:dic[@"diy_direction"] style:1];
        NSString *diy_extroversion = [CommonManagement verData:dic[@"diy_extroversion"] style:1];
        NSString *diy_forward = [CommonManagement verData:dic[@"diy_forward"] style:1];
        NSString *diy_introvert = [CommonManagement verData:dic[@"diy_introvert"] style:1];
        NSString *diy_reverse = [CommonManagement verData:dic[@"diy_reverse"] style:1];
        NSString *diy_icon = [CommonManagement verData:dic[@"diy_icon"] style:1];
        NSString *diy_id = [CommonManagement verData:dic[@"diy_id"] style:1];
        NSString *diy_number = [CommonManagement verData:dic[@"diy_number"] style:1];
        NSString *diy_number_min = [CommonManagement verData:dic[@"diy_number_min"] style:1];
        NSString *diy_order = [CommonManagement verData:dic[@"diy_order"] style:1];
        //name
        //英语
        //        NSString *diy_name_en = [CommonManagement verData:dic[@"diy_name_en"] style:1];
        //        //中文
        NSString *diy_name_zh = [CommonManagement verData:dic[@"diy_name_zh"] style:1];
        //        //法语
        //        NSString *diy_name_fr = [CommonManagement verData:dic[@"diy_name_fr"] style:1];
        //        //德语
        //        NSString *diy_name_de = [CommonManagement verData:dic[@"diy_name_de"] style:1];
        //        //意大利语
        //        NSString *diy_name_it = [CommonManagement verData:dic[@"diy_name_it"] style:1];
        //        //日语
        //        NSString *diy_name_ja = [CommonManagement verData:dic[@"diy_name_ja"] style:1];
        //        //西班牙语
        //        NSString *diy_name_es = [CommonManagement verData:dic[@"diy_name_es"] style:1];
        //        //阿拉伯语
        //        NSString *diy_name_ka = [CommonManagement verData:dic[@"diy_name_ka"] style:1];
        
        
        NSMutableDictionary *diyDirectionMap = [[NSMutableDictionary alloc]init];
        [diyDirectionMap setObject:diy_extroversion forKey:@"diyExtroversion"];
        [diyDirectionMap setObject:diy_forward forKey:@"diyForward"];
        [diyDirectionMap setObject:diy_introvert forKey:@"diyIntrovert"];
        [diyDirectionMap setObject:diy_reverse forKey:@"diyReverse"];
        
        NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
        [mutDic setObject:diy_direction forKey:@"diyDirection"];
        [mutDic setObject:diyDirectionMap forKey:@"diyDirectionMap"];
        [mutDic setObject:diy_icon forKey:@"diyIcon"];
        [mutDic setObject:diy_id forKey:@"diyId"];
        [mutDic setObject:diy_number forKey:@"diyNumber"];
        [mutDic setObject:diy_number_min forKey:@"diyNumberMin"];
        [mutDic setObject:diy_order forKey:@"diyOrder"];
        
        NSArray *abbreviationArray = [self abbreviationArray];
        //当前手机系统语言
        NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
        //所有大写字母转小写
        language = [language lowercaseString];
        if (IS_VALID_STRING(language)) {
            if (![abbreviationArray containsObject:language]) {//不包含
                
                //没有就默认给中文，若是给空，或许有崩溃的危险
                [mutDic setObject:diy_name_zh forKey:@"diyName"];
            } else {
                
                NSString *spellName = [NSString stringWithFormat:@"diy_name_%@", language];
                //各个国家的名称
                NSString *diy_name = [CommonManagement verData:dic[spellName] style:1];
                [mutDic setObject:IS_VALID_STRING(diy_name) ? diy_name : diy_name_zh forKey:@"diyName"];
            }
            
        } else {
            //没有就默认给中文，若是给空，或许有崩溃的危险
            [mutDic setObject:diy_name_zh forKey:@"diyName"];
        }
        
        [dataArray addObject:mutDic];
    }];
    
    return dataArray;
}

#pragma mark 获取幻彩模式下菜单title数据 --> 经典 节日 心情 ....
- (NSArray *)getDreamColorModelClassData:(NSArray *)jsonData {
    
    //当前连接设备的pid
    NSString *currentDevicePid = [self getCurrentDevicePid];
    
    //遍历数据，改格式
    NSMutableArray *dataSourceArray = [[NSMutableArray alloc]init];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSDictionary *dic = obj;
        NSString *model_class_mold = [CommonManagement verData:dic[@"model_class_mold"] style:1];
        //替换某个字符
        model_class_mold = [model_class_mold stringByReplacingOccurrencesOfString:@" " withString:@""];
        //有空格，先去除空格
        NSArray *pidArray = [model_class_mold componentsSeparatedByString:@","];
        if ([pidArray containsObject:currentDevicePid]) {//包含当前设备pid，存下来
            
            NSString *model_class_time = [CommonManagement verData:dic[@"model_class_time"] style:1];
            NSString *model_class_id = [CommonManagement verData:dic[@"model_class_id"] style:1];
            NSString *model_class_zh = [CommonManagement verData:dic[@"model_class_zh"] style:1];
//            NSString *model_class_name = [CommonManagement verData:dic[@"model_class_name"] style:1];
            NSString *model_class_fireworks = [CommonManagement verData:dic[@"model_class_fireworks"] style:1];
            NSString *model_class_mold = [CommonManagement verData:dic[@"model_class_mold"] style:1];
            
            NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
            [mutDic setObject:model_class_time forKey:@"modelClassTime"];
            [mutDic setObject:model_class_id forKey:@"modelClassId"];
            [mutDic setObject:model_class_fireworks forKey:@"modelClassFireworks"];
            [mutDic setObject:model_class_mold forKey:@"modelTitleMold"];
            
            NSArray *abbreviationArray = [self abbreviationArray];
            //当前手机系统语言
            NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
            //所有大写字母转小写
            language = [language lowercaseString];
            if (IS_VALID_STRING(language)) {
                if (![abbreviationArray containsObject:language]) {//不包含
                    
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [mutDic setObject:model_class_zh forKey:@"modelClassName"];
                } else {
                    
                    NSString *spellName = [NSString stringWithFormat:@"model_class_name_%@", language];
                    //各个国家的名称
                    NSString *className = [CommonManagement verData:dic[spellName] style:1];
                    [mutDic setObject:IS_VALID_STRING(className) ? className : model_class_zh forKey:@"modelClassName"];
                }
                
            } else {
                //没有就默认给中文，若是给空，或许有崩溃的危险
                [mutDic setObject:model_class_zh forKey:@"modelClassName"];
            }
            
            [dataSourceArray addObject:mutDic];
        }
        
    }];
    
    return dataSourceArray;
}

#pragma mark 获取幻彩模式下菜单数据下经典数据列表
- (NSDictionary *)getDreamColorClassicsModelClassData:(NSArray *)jsonData {
    
    //当前连接设备的pid
    NSString *currentDevicePid = [self getCurrentDevicePid];
    
    //遍历数据，改格式
    NSMutableArray *dataSourceArray = [[NSMutableArray alloc]init];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSDictionary *dic = obj;
        //json中pid
        NSString *model_title_mold = [CommonManagement verData:dic[@"model_title_mold"] style:1];
        //替换字符 有空格，先去除空格
        model_title_mold = [model_title_mold stringByReplacingOccurrencesOfString:@" " withString:@""];
        //字符串转数组
        NSArray *pidArray = [model_title_mold componentsSeparatedByString:@","];
        if ([pidArray containsObject:currentDevicePid]) {//包含当前设备pid，存下来
            
            NSString *model_title_id = [CommonManagement verData:dic[@"model_title_id"] style:1];
            NSString *model_title_icon = [CommonManagement verData:dic[@"model_title_icon"] style:1];
            NSString *model_title_zh = [CommonManagement verData:dic[@"model_title_zh"] style:1];
            NSArray *modelList = [CommonManagement verData:dic[@"modelList"] style:2];
            
            NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
            [mutDic setObject:model_title_id forKey:@"modelTitleId"];
            //https://cloud.v2.dbiot.link/07ae00a9-f652-4173-92f4-e8e0199a5931-8c6bbd88-6f61-43c7-a9b3-3b538296bcfe.png
            //https://cloud.v2.dbiot.link/static/view/modelImg/07ae00a9-f652-4173-92f4-e8e0199a5931-8c6bbd88-6f61-43c7-a9b3-3b538296bcfe.png
            //拼前缀上去也没用，少了文件路径，所有基本用不到，取本地图片
            [mutDic setObject:model_title_icon forKey:@"modelTitleIcon"];
            
            //子模型颜色遍历
            NSMutableArray *modelClassicsAppQoList = [[NSMutableArray alloc]init];
            [modelList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *dict = obj;
                NSString *sound_effects_flag = [CommonManagement verData:dict[@"sound_effects_flag"] style:1];
                NSString *model_order = [CommonManagement verData:dict[@"model_order"] style:1];
                NSString *model_id = [CommonManagement verData:dict[@"model_id"] style:1];
                NSString *model_speed = [CommonManagement verData:dict[@"model_speed"] style:1];
                NSString *model_fireworks = [CommonManagement verData:dict[@"model_fireworks"] style:1];
                NSString *model_collect = [CommonManagement verData:dict[@"model_collect"] style:1];
                NSString *model_name_zh = [CommonManagement verData:dict[@"model_name_zh"] style:1];
                
                NSMutableDictionary *subMutDic = [[NSMutableDictionary alloc]init];
                [subMutDic setObject:sound_effects_flag forKey:@"soundEffectsFlag"];
                [subMutDic setObject:model_order forKey:@"modelOrder"];
                [subMutDic setObject:model_id forKey:@"modelId"];
                [subMutDic setObject:model_speed forKey:@"modelSpeed"];
                [subMutDic setObject:model_fireworks forKey:@"modelFireworks"];
                [subMutDic setObject:model_collect forKey:@"modelCollect"];
                //国家缩写数组
                NSArray *abbreviationArray = [self abbreviationArray];
                //当前手机系统语言
                NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                //所有大写字母转小写
                language = [language lowercaseString];
                if (IS_VALID_STRING(language)) {
                    if (![abbreviationArray containsObject:language]) {//不包含
                        
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [subMutDic setObject:model_name_zh forKey:@"modelName"];
                    } else {
                        
                        NSString *spellName = [NSString stringWithFormat:@"model_name_%@", language];
                        //各个国家的名称
                        NSString *model_title = [CommonManagement verData:dict[spellName] style:1];
                        [subMutDic setObject:IS_VALID_STRING(model_title) ? model_title : model_name_zh forKey:@"modelName"];
                    }
                    
                } else {
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [subMutDic setObject:model_name_zh forKey:@"modelName"];
                }
                
                [modelClassicsAppQoList addObject:subMutDic];
            }];
            
            [mutDic setObject:modelClassicsAppQoList forKey:@"modelClassicsAppQoList"];
            
            //国家缩写数组
            NSArray *abbreviationArray = [self abbreviationArray];
            //当前手机系统语言
            NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
            //所有大写字母转小写
            language = [language lowercaseString];
            if (IS_VALID_STRING(language)) {
                if (![abbreviationArray containsObject:language]) {//不包含
                    
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [mutDic setObject:model_title_zh forKey:@"modelTitleName"];
                } else {
                    
                    NSString *spellName = [NSString stringWithFormat:@"model_class_name_%@", language];
                    //各个国家的名称
                    NSString *model_title = [CommonManagement verData:dic[spellName] style:1];
                    [mutDic setObject:IS_VALID_STRING(model_title) ? model_title : model_title_zh forKey:@"modelTitleName"];
                }
                
            } else {
                //没有就默认给中文，若是给空，或许有崩溃的危险
                [mutDic setObject:model_title_zh forKey:@"modelTitleName"];
            }
            
            [dataSourceArray addObject:mutDic];
        }
        
    }];
    
    NSDictionary *parDic = @{@"list" : dataSourceArray,
                             @"currPage" : @"1",
                             @"version" : @"",
                             @"totalCount" : @"27",
                             @"pageSize" : @"30",
                             @"totalPage" : @"1"};
    
    return parDic;
}

#pragma mark 获取幻彩模式下律动模式手机麦和设备麦数据
- (NSDictionary *)getDreamColorRhythmData:(NSDictionary *)jsonData {
    
    //当前连接设备的pid
    NSString *currentDevicePid = [self getCurrentDevicePid];
    
    jsonData = [CommonManagement verData:jsonData style:3];
    NSArray *allKey = jsonData.allKeys;
    NSMutableArray *deviceListArray = [[NSMutableArray alloc]init];
    if ([allKey containsObject:@"deviceList"]) {//包含设备麦数据
        
        NSArray *deviceList = [CommonManagement verData:jsonData[@"deviceList"] style:2];
        [deviceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSDictionary *dic = obj;
            //json中pid
            NSString *rhythm_device_mold = [CommonManagement verData:dic[@"rhythm_device_mold"] style:1];
            //替换字符 有空格，先去除空格
            rhythm_device_mold = [rhythm_device_mold stringByReplacingOccurrencesOfString:@" " withString:@""];
            //字符串转数组
            NSArray *pidArray = [rhythm_device_mold componentsSeparatedByString:@","];
            if ([pidArray containsObject:currentDevicePid]) {//包含当前设备pid，存下来
                
                NSString *rhythm_id = [CommonManagement verData:dic[@"rhythm_id"] style:1];
                NSString *rhythm_type = [CommonManagement verData:dic[@"rhythm_type"] style:1];
                NSString *rhythm_order = [CommonManagement verData:dic[@"rhythm_order"] style:1];
                NSString *rhythm_speed = [CommonManagement verData:dic[@"rhythm_speed"] style:1];
                NSString *rhythm_name_zh = [CommonManagement verData:dic[@"rhythm_name_zh"] style:1];
                NSArray *rhythmModel = [CommonManagement verData:dic[@"rhythmModel"] style:2];
                
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
                [mutDic setObject:rhythm_id forKey:@"rhythmId"];
                [mutDic setObject:rhythm_type forKey:@"rhythmType"];
                [mutDic setObject:rhythm_order forKey:@"rhythmOrder"];
                [mutDic setObject:rhythm_speed forKey:@"rhythmSpeed"];
                
                //子模型律动遍历
                NSMutableArray *rhythmModelQos = [[NSMutableArray alloc]init];
                [rhythmModel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    NSDictionary *dict = obj;
                    NSString *rhythm_id = [CommonManagement verData:dict[@"rhythm_id"] style:1];
                    NSString *rhythm_name_zh = [CommonManagement verData:dict[@"rhythm_name_zh"] style:1];
                    NSString *rhythm_type = [CommonManagement verData:dict[@"rhythm_type"] style:1];
                    NSString *rhythm_order = [CommonManagement verData:dict[@"rhythm_order"] style:1];
                    
                    NSMutableDictionary *subMutDic = [[NSMutableDictionary alloc]init];
                    [subMutDic setObject:rhythm_id forKey:@"rhythmId"];
                    [subMutDic setObject:rhythm_type forKey:@"rhythmType"];
                    [subMutDic setObject:rhythm_order forKey:@"rhythmOrder"];
                    
                    //国家缩写数组
                    NSArray *abbreviationArray = [self abbreviationArray];
                    //当前手机系统语言
                    NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                    //所有大写字母转小写
                    language = [language lowercaseString];
                    if (IS_VALID_STRING(language)) {
                        if (![abbreviationArray containsObject:language]) {//不包含
                            
                            //没有就默认给中文，若是给空，或许有崩溃的危险
                            [subMutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                        } else {
                            
                            NSString *spellName = [NSString stringWithFormat:@"rhythm_name_%@", language];
                            //各个国家的名称
                            NSString *model_title = [CommonManagement verData:dict[spellName] style:1];
                            [subMutDic setObject:IS_VALID_STRING(model_title) ? model_title : rhythm_name_zh forKey:@"rhythmName"];
                        }
                        
                    } else {
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [subMutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                    }
                    
                    [rhythmModelQos addObject:subMutDic];
                }];
                [mutDic setObject:rhythmModelQos forKey:@"rhythmModelQos"];
                
                //国家缩写数组
                NSArray *abbreviationArray = [self abbreviationArray];
                //当前手机系统语言
                NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                //所有大写字母转小写
                language = [language lowercaseString];
                if (IS_VALID_STRING(language)) {
                    if (![abbreviationArray containsObject:language]) {//不包含
                        
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [mutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                    } else {
                        
                        NSString *spellName = [NSString stringWithFormat:@"rhythm_name_%@", language];
                        //各个国家的名称
                        NSString *model_title = [CommonManagement verData:dic[spellName] style:1];
                        [mutDic setObject:IS_VALID_STRING(model_title) ? model_title : rhythm_name_zh forKey:@"rhythmName"];
                    }
                    
                } else {
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [mutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                }
                
                [deviceListArray addObject:mutDic];
            }
            
        }];
        
    }
    
    NSMutableArray *phoneListArray = [[NSMutableArray alloc]init];
    if ([allKey containsObject:@"phoneList"]) {//包含手机麦数据
        
        NSArray *phoneList = [CommonManagement verData:jsonData[@"phoneList"] style:2];
        [phoneList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSDictionary *dic = obj;
            //json中pid
            NSString *rhythm_device_mold = [CommonManagement verData:dic[@"rhythm_device_mold"] style:1];
            //替换字符 有空格，先去除空格
            rhythm_device_mold = [rhythm_device_mold stringByReplacingOccurrencesOfString:@" " withString:@""];
            //字符串转数组
            NSArray *pidArray = [rhythm_device_mold componentsSeparatedByString:@","];
            if ([pidArray containsObject:currentDevicePid]) {//包含当前设备pid，存下来
                
                NSString *rhythm_id = [CommonManagement verData:dic[@"rhythm_id"] style:1];
                NSString *rhythm_type = [CommonManagement verData:dic[@"rhythm_type"] style:1];
                NSString *rhythm_order = [CommonManagement verData:dic[@"rhythm_order"] style:1];
                NSString *rhythm_speed = [CommonManagement verData:dic[@"rhythm_speed"] style:1];
                NSString *rhythm_name_zh = [CommonManagement verData:dic[@"rhythm_name_zh"] style:1];
                NSArray *rhythmModel = [CommonManagement verData:dic[@"rhythmModel"] style:2];
                
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
                [mutDic setObject:rhythm_id forKey:@"rhythmId"];
                [mutDic setObject:rhythm_type forKey:@"rhythmType"];
                [mutDic setObject:rhythm_order forKey:@"rhythmOrder"];
                [mutDic setObject:rhythm_speed forKey:@"rhythmSpeed"];
                
                //子模型律动遍历
                NSMutableArray *rhythmModelQos = [[NSMutableArray alloc]init];
                [rhythmModel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    NSDictionary *dict = obj;
                    NSString *rhythm_id = [CommonManagement verData:dict[@"rhythm_id"] style:1];
                    NSString *rhythm_name_zh = [CommonManagement verData:dict[@"rhythm_name_zh"] style:1];
                    NSString *rhythm_type = [CommonManagement verData:dict[@"rhythm_type"] style:1];
                    NSString *rhythm_order = [CommonManagement verData:dict[@"rhythm_order"] style:1];
                    
                    NSMutableDictionary *subMutDic = [[NSMutableDictionary alloc]init];
                    [subMutDic setObject:rhythm_id forKey:@"rhythmId"];
                    [subMutDic setObject:rhythm_type forKey:@"rhythmType"];
                    [subMutDic setObject:rhythm_order forKey:@"rhythmOrder"];
                    
                    //国家缩写数组
                    NSArray *abbreviationArray = [self abbreviationArray];
                    //当前手机系统语言
                    NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                    //所有大写字母转小写
                    language = [language lowercaseString];
                    if (IS_VALID_STRING(language)) {
                        if (![abbreviationArray containsObject:language]) {//不包含
                            
                            //没有就默认给中文，若是给空，或许有崩溃的危险
                            [subMutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                        } else {
                            
                            NSString *spellName = [NSString stringWithFormat:@"rhythm_name_%@", language];
                            //各个国家的名称
                            NSString *model_title = [CommonManagement verData:dict[spellName] style:1];
                            [subMutDic setObject:IS_VALID_STRING(model_title) ? model_title : rhythm_name_zh forKey:@"rhythmName"];
                        }
                        
                    } else {
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [subMutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                    }
                    
                    [rhythmModelQos addObject:subMutDic];
                }];
                [mutDic setObject:rhythmModelQos forKey:@"rhythmModelQos"];
                
                //国家缩写数组
                NSArray *abbreviationArray = [self abbreviationArray];
                //当前手机系统语言
                NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                //所有大写字母转小写
                language = [language lowercaseString];
                if (IS_VALID_STRING(language)) {
                    if (![abbreviationArray containsObject:language]) {//不包含
                        
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [mutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                    } else {
                        
                        NSString *spellName = [NSString stringWithFormat:@"rhythm_name_%@", language];
                        //各个国家的名称
                        NSString *model_title = [CommonManagement verData:dic[spellName] style:1];
                        [mutDic setObject:IS_VALID_STRING(model_title) ? model_title : rhythm_name_zh forKey:@"rhythmName"];
                    }
                    
                } else {
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [mutDic setObject:rhythm_name_zh forKey:@"rhythmName"];
                }
                
                [phoneListArray addObject:mutDic];
            }
            
        }];
    }
    
    NSDictionary *sourceDic = @{@"phoneList" : phoneListArray, @"deviceList" : deviceListArray};
    
    return sourceDic;
}

#pragma mark 获取幻彩模式下节日、心情等列表数据
- (NSDictionary *)getDreamColorModelPageData:(NSDictionary *)jsonData type:(NSString *)type {
    
    if (!IS_VALID_STRING(type)) {
        return @{};
    }
    
    //当前连接设备的pid
    NSString *currentDevicePid = [self getCurrentDevicePid];
    
    jsonData = [CommonManagement verData:jsonData style:3];
    NSArray *allKey = jsonData.allKeys;
    NSMutableArray *dataSourceArray = [[NSMutableArray alloc]init];
    if ([allKey containsObject:type]) {//包含类型的数据
        
        NSArray *array = [CommonManagement verData:jsonData[type] style:2];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = obj;
//            NSString *model_title_mold = [CommonManagement verData:dic[@"device_mold"] style:1];
//            //替换某个字符
//            model_title_mold = [model_title_mold stringByReplacingOccurrencesOfString:@" " withString:@""];
//            //有空格，先去除空格
//            NSArray *pidArray = [model_title_mold componentsSeparatedByString:@","];
//            if ([pidArray containsObject:currentDevicePid]) {//包含当前设备pid，存下来
                
                NSString *service_version = [CommonManagement verData:dic[@"service_version"] style:1];
                NSString *model_class = [CommonManagement verData:dic[@"model_class"] style:1];
                NSString *sound_effects_flag = [CommonManagement verData:dic[@"sound_effects_flag"] style:1];
                NSString *model_id = [CommonManagement verData:dic[@"model_id"] style:1];
                NSString *model_order = [CommonManagement verData:dic[@"model_order"] style:1];
                NSString *modelGif = [CommonManagement verData:dic[@"modelGif"] style:1];
                NSString *model_fireworks = [CommonManagement verData:dic[@"model_fireworks"] style:1];
                NSString *model_icon = [CommonManagement verData:dic[@"model_icon"] style:1];
                NSString *model_speed = [CommonManagement verData:dic[@"model_speed"] style:1];
                NSString *model_name_zh = [CommonManagement verData:dic[@"model_name_zh"] style:1];
                
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
                [mutDic setObject:service_version forKey:@"serviceVersion"];
                [mutDic setObject:model_class forKey:@"modelClass"];
                [mutDic setObject:sound_effects_flag forKey:@"soundEffectsFlag"];
                [mutDic setObject:model_id forKey:@"modelId"];
                [mutDic setObject:model_order forKey:@"modelOrder"];
                [mutDic setObject:modelGif forKey:@"modelGif"];
                [mutDic setObject:model_fireworks forKey:@"modelFireworks"];
                [mutDic setObject:model_icon forKey:@"modelIcon"];
                [mutDic setObject:model_speed forKey:@"modelSpeed"];
                
                
                NSArray *abbreviationArray = [self abbreviationArray];
                //当前手机系统语言
                NSString *language = [ToolManagement getsTheCurrentPhoneLanguage];
                //所有大写字母转小写
                language = [language lowercaseString];
                if (IS_VALID_STRING(language)) {
                    if (![abbreviationArray containsObject:language]) {//不包含
                        
                        //没有就默认给中文，若是给空，或许有崩溃的危险
                        [mutDic setObject:model_name_zh forKey:@"modelName"];
                    } else {
                        
                        NSString *spellName = [NSString stringWithFormat:@"model_name_%@", language];
                        //各个国家的名称
                        NSString *className = [CommonManagement verData:dic[spellName] style:1];
                        [mutDic setObject:IS_VALID_STRING(className) ? className : model_name_zh forKey:@"modelName"];
                    }
                    
                } else {
                    //没有就默认给中文，若是给空，或许有崩溃的危险
                    [mutDic setObject:model_name_zh forKey:@"modelName"];
                }
                
                [dataSourceArray addObject:mutDic];
//            }
            
        }];
    }
    
    NSDictionary *parDic = @{@"currPage" : @"1",
                             @"version" : @"",
                             @"list" : dataSourceArray,
                             @"totalCount" : @"",
                             @"pageSize" : @"",
                             @"totalPage" : @""};
    
    return parDic;
}

#pragma mark - Other
#pragma mark 需要缓存的接口
/// 需要缓存的接口
/// - Parameter url: 未拼接接口，例：public/app/ota/getOTA
- (BOOL)cacheInterfaceRequired:(NSString *)url {
    
//    NSArray *array = @[@"model/multi/app/getModelClass",//获取模式分类
//                       @"model/multi/app/getModelClassicsPage",//获取经典模式接口数据
//                       @"model/multi/app/getModelPage",//获取节日、心情、风景、生活接口数据
//                       @"model/multi/app/getNewModelPage",//获取节日、心情、风景、生活的列表数据接口 收藏用，1.2.1添加，24/01/09
//                       @"model/multi/app/getRhythmModel",//查询手机麦设备麦音乐模式
//                       @"model/multi/app/getDiyModel",//查询DIY
//                       @"collect/app/collectModelPage",//收藏列表--1.2.1以后应该不用了，老版本使用
//                       @"collect/app/collectModelTable",//收藏头部标题
//                       @"collect/app/collectModelPage",//收藏头部列表数据
//                    ];
    
    NSArray *array = @[@"fullcolor/multi/app/getFullColorClassList",//获取全彩模式分类 title
                       @"fullcolor/multi/app/getFullColorList",//获取全彩模式下数据 内置数据/DIY数据/场景数据
    ];
    
    return [array containsObject:url];
}

#pragma mark 获取当前连接设备pid
- (NSString *)getCurrentDevicePid {
    
    //当前连接设备的pid
//    XYStoredDeviceModel *localModel = [CommonManagement getCurrentlyConnectedModel];
//    NSString *currentDevicePid = [CommonManagement verData:localModel.deviceMoldPid style:1];
//    
//    if (IS_VALID_STRING(currentDevicePid)) {
//        return currentDevicePid;
//    }
    
    return @"";
}

#pragma mark 是否显示toast
- (BOOL)isThereCachedDataAvailable:(NSDictionary *)cache initialURL:(NSString *)initialURL isShowView:(BOOL)isShowView {
    
    if ([self cacheInterfaceRequired:initialURL]) {//接口是否需要读取
        NSDictionary *dic1 = [CommonManagement verData:cache style:3];
        if (dic1.count > 0) {//数据库里有数据
            
            return NO;
        } else {
            if (IsNullDictionary(dic1)) {//没拿到就取json里的默认数据
                
                return NO;
            }
        }
    }
    return isShowView;
}


#pragma mark 获取当前网络状态
+ (NSInteger)getTheCurrentNetworkStatus {
    
    //创建
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    __block NSInteger num;
    //设置回调
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"不明网络");
                num = -1;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"没有网络");
                num = 0;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"蜂窝网络");
                num = 1;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi");
                num = 2;
            }
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
    
    return num;
}

#pragma mark 国家缩写，存的小写字符串是因为json文件中的是小写，json是后台给的
- (NSArray *)abbreviationArray {
    
    return @[@"en", @"zh", @"fr", @"de", @"it", @"ja", @"es", @"ka"];
}

#pragma mark 完整url，目前icon用
- (NSString *)completeRequestAddress:(NSString *)url {
    
    NSString * address = [[NSUserDefaults standardUserDefaults]objectForKey:CountriesAddress];
    if(IS_VALID_STRING(address)&&[address isEqualToString:@"CN"]){//国内
        url = [NSString stringWithFormat:@"%@%@",APIHEAD_Foreign,url];
    }else{//国外
        url = [NSString stringWithFormat:@"%@%@",APIHEAD_Foreign,url];
    }
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return url;
}

+ (BOOL)internetStatus {
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"WIFI";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"WIFI";
            break;
            
        case ReachableViaWWAN:
            net = @"蜂窝数据";
            //net = [self getNetType ];   //判断具体类型
            break;
            
        case NotReachable:
            net = @"当前无网路连接";
            
        default:
            break;
    }
    
    if ([net isEqualToString:@"WIFI"] || [net isEqualToString:@"蜂窝数据"]) {
        
        return YES;
    } else {
        return NO;
    }
}

@end
