//
//  FYLSettingListMolde.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLSettingListMolde : BaseModel
///音效
@property(nonatomic,copy)NSString * soundType;
///主题颜色
@property(nonatomic,copy)NSString * themeColor;
///触感 0关  1开
@property(nonatomic,copy)NSString * touchSwitchState;
///千分位开关 0关  1开
@property(nonatomic,copy)NSString * thousandsState;
///日期开关 0关  1开
@property(nonatomic,copy)NSString * dataState;
///量级开关 0关  1开
@property(nonatomic,copy)NSString * orderState;
///小数点位数
@property(nonatomic,copy)NSString * decimalPlace;
///语言 
@property(nonatomic,copy)NSString * LanguageType;

@end

NS_ASSUME_NONNULL_END
