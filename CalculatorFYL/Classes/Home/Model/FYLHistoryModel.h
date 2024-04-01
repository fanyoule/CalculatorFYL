//
//  XYStoredDeviceModel.h
//  DayBetter
//
//  Created by 张震 on 2022/8/9.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HistoryTypeStatus) {
    HistoryTypeStatus_nol = 0, // 正常文本
    HistoryTypeStatus_beizhu = 1, // 备注
};
NS_ASSUME_NONNULL_BEGIN
@interface FYLHistoryModel : NSObject

@property(nonatomic, assign)NSInteger ID;
@property(nonatomic, copy)NSString *time;//创建时间
@property(nonatomic, copy)NSString *text;// 内容
@property(nonatomic, copy)NSString *resultStr;// 结果
@property(nonatomic,copy)NSString * userName;//拥有者账号
@property(nonatomic,assign)NSInteger  textHeight;//内容高度

+(void)insert:(FYLHistoryModel *)device;
// 获取所有的数据
+(NSArray *)getAll;
// 根据time获取某个model
+(FYLHistoryModel *)obtainTheModelBasedOnTheTime:(NSString *)time;
+(NSArray *)searchLocalMyWifiDeviceModel;
+(NSArray *)obtainTheModelUserHistory:(NSString *)userName;



@end

NS_ASSUME_NONNULL_END
