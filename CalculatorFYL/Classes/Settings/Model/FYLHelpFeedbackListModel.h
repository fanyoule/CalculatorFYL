//
//  FYLHelpFeedbackListModel.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/6.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLHelpFeedbackListModel : BaseModel
///内容
@property(nonatomic,copy)NSString * content;
///创建时间 时间戳
@property(nonatomic,copy)NSString * create_time;
///创建时间 年月日
@property(nonatomic,copy)NSString * create_time_text;


@end

NS_ASSUME_NONNULL_END
